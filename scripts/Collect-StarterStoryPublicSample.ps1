[CmdletBinding()]
param(
  [string]$OutputDirectory = (Join-Path ([IO.Path]::GetTempPath()) ("starter-story-public-sample-{0}" -f (Get-Date -Format 'yyyyMMdd-HHmmss'))),
  [string]$InputCacheDirectory,
  [ValidateRange(2, 30)]
  [int]$DelaySeconds = 4
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$baseUrl = 'https://www.starterstory.com'
$userAgent = 'ResearchAuditBot/1.0 (+https://research.onovich.com/about.html)'
$utf8NoBom = New-Object Text.UTF8Encoding($false)

$categories = @(
  [pscustomobject]@{ Slug = 'micro-saas-ideas'; Label = 'Micro SaaS'; CardTitle = 'Micro SaaS Ideas' },
  [pscustomobject]@{ Slug = 'no-code-ideas'; Label = 'No-code'; CardTitle = 'No Code SaaS' },
  [pscustomobject]@{ Slug = 'apps-so-simple'; Label = 'Simple apps'; CardTitle = 'Apps So Simple Yet So Profitable' },
  [pscustomobject]@{ Slug = 'solo-developer-ideas'; Label = 'Solo developers'; CardTitle = 'Ideas for Solo Developers' },
  [pscustomobject]@{ Slug = 'gpt-wrapper-ideas'; Label = 'GPT wrappers'; CardTitle = 'GPT Wrapper Ideas' },
  [pscustomobject]@{ Slug = 'weekend-projects'; Label = 'Weekend projects'; CardTitle = 'Weekend Projects' },
  [pscustomobject]@{ Slug = '1m-apis'; Label = 'APIs'; CardTitle = '$1M APIs' },
  [pscustomobject]@{ Slug = 'plugins'; Label = 'Plugins'; CardTitle = '$100k Plugins' },
  [pscustomobject]@{ Slug = 'marketplaces'; Label = 'Marketplaces'; CardTitle = 'Marketplaces' },
  [pscustomobject]@{ Slug = 'productized-services'; Label = 'Productized services'; CardTitle = 'Productized Services' }
)

function ConvertTo-PlainText {
  param([AllowEmptyString()][string]$Html)

  if ([string]::IsNullOrWhiteSpace($Html)) { return '' }
  $withoutTags = [regex]::Replace($Html, '<script[\s\S]*?</script>|<style[\s\S]*?</style>|<[^>]+>', ' ', 'IgnoreCase')
  $decoded = [Net.WebUtility]::HtmlDecode($withoutTags)
  return ([regex]::Replace($decoded, '\s+', ' ')).Trim()
}

function ConvertTo-MonthlyRevenueUsd {
  param([AllowEmptyString()][string]$Raw)

  if ([string]::IsNullOrWhiteSpace($Raw) -or $Raw -notmatch '/mo') { return $null }
  $normalized = $Raw.Replace(',', '').Trim()
  $match = [regex]::Match($normalized, '\$([0-9]+(?:\.[0-9]+)?)([KMB]?)\s*/mo', 'IgnoreCase')
  if (-not $match.Success) { return $null }

  $value = [double]$match.Groups[1].Value
  switch ($match.Groups[2].Value.ToUpperInvariant()) {
    'K' { return [math]::Round($value * 1000, 2) }
    'M' { return [math]::Round($value * 1000000, 2) }
    'B' { return [math]::Round($value * 1000000000, 2) }
    default { return [math]::Round($value, 2) }
  }
}

function Get-Percentile {
  param(
    [double[]]$Values,
    [ValidateRange(0, 1)][double]$Percentile
  )

  if (-not $Values -or $Values.Count -eq 0) { return $null }
  $sorted = @($Values | Sort-Object)
  if ($sorted.Count -eq 1) { return [double]$sorted[0] }

  $position = ($sorted.Count - 1) * $Percentile
  $lower = [math]::Floor($position)
  $upper = [math]::Ceiling($position)
  if ($lower -eq $upper) { return [double]$sorted[$lower] }

  $weight = $position - $lower
  return [double]$sorted[$lower] + (([double]$sorted[$upper] - [double]$sorted[$lower]) * $weight)
}

function Get-RoundedPercentile {
  param(
    [double[]]$Values,
    [ValidateRange(0, 1)][double]$Percentile
  )

  $value = Get-Percentile -Values $Values -Percentile $Percentile
  if ($null -eq $value) { return $null }
  return [math]::Round($value, 0)
}

function Get-PublicPage {
  param([Parameter(Mandatory)][string]$Url)

  try {
    $response = Invoke-WebRequest -UseBasicParsing -Uri $Url -Headers @{ 'User-Agent' = $userAgent } -TimeoutSec 60
  }
  catch {
    $status = $null
    if ($_.Exception.Response) { $status = [int]$_.Exception.Response.StatusCode }
    if ($status -in @(403, 429)) {
      throw "Starter Story returned HTTP $status. Collection stopped without retrying or bypassing the response."
    }
    throw
  }

  if ($response.StatusCode -ne 200) {
    throw "Unexpected HTTP $($response.StatusCode) for $Url"
  }
  return $response.Content
}

function Get-PageContent {
  param(
    [Parameter(Mandatory)][string]$Url,
    [Parameter(Mandatory)][string]$CacheFileName
  )

  if (-not [string]::IsNullOrWhiteSpace($InputCacheDirectory)) {
    $inputPath = Join-Path $InputCacheDirectory $CacheFileName
    if (-not (Test-Path -LiteralPath $inputPath -PathType Leaf)) {
      throw "Cached input not found: $inputPath"
    }
    return Get-Content -LiteralPath $inputPath -Raw
  }

  return Get-PublicPage $Url
}

function Get-HomepageAggregate {
  param(
    [Parameter(Mandatory)][string]$HomepageHtml,
    [Parameter(Mandatory)][string]$CardTitle
  )

  $index = $HomepageHtml.IndexOf($CardTitle, [StringComparison]::OrdinalIgnoreCase)
  if ($index -lt 0) {
    return [pscustomobject]@{ Count = $null; MedianMonthlyRevenueUsd = $null }
  }

  $beforeStart = [math]::Max(0, $index - 450)
  $before = $HomepageHtml.Substring($beforeStart, $index - $beforeStart)
  $countMatches = [regex]::Matches($before, '([0-9,]+)\s+ideas', 'IgnoreCase')
  $count = if ($countMatches.Count -gt 0) {
    [int](($countMatches[$countMatches.Count - 1].Groups[1].Value).Replace(',', ''))
  } else { $null }

  $afterLength = [math]::Min(700, $HomepageHtml.Length - $index)
  $after = $HomepageHtml.Substring($index, $afterLength)
  $medianMatch = [regex]::Match($after, '\$([0-9]+(?:\.[0-9]+)?)([KMB]?)</span>\s*<span[^>]*>/mo median', 'IgnoreCase')
  $median = if ($medianMatch.Success) {
    ConvertTo-MonthlyRevenueUsd ('$' + $medianMatch.Groups[1].Value + $medianMatch.Groups[2].Value + ' /mo')
  } else { $null }

  return [pscustomobject]@{ Count = $count; MedianMonthlyRevenueUsd = $median }
}

function Get-PublicRows {
  param(
    [Parameter(Mandatory)][string]$Html,
    [Parameter(Mandatory)][pscustomobject]$Category
  )

  $rows = New-Object Collections.Generic.List[object]
  $seenRecords = New-Object Collections.Generic.HashSet[string]

  foreach ($cardMatch in [regex]::Matches($Html, '<a\b(?=[^>]*data-posthog-action="view_case_study")(?=[^>]*href="(/(?:stories|businesses)/[^"?#]+)")[\s\S]*?</a>', 'IgnoreCase')) {
    $cardHtml = $cardMatch.Value
    $recordPath = $cardMatch.Groups[1].Value
    if (-not $seenRecords.Add($recordPath.ToLowerInvariant())) { continue }

    $titleMatch = [regex]::Match($cardHtml, '<div class="[^"]*font-semibold[^"]*">([\s\S]*?)</div>', 'IgnoreCase')
    $domainMatch = [regex]::Match($cardHtml, '<span class="[^"]*font-mono[^"]*"[^>]*>([\s\S]*?)</span>', 'IgnoreCase')
    if (-not $titleMatch.Success) { continue }

    $plainCard = ConvertTo-PlainText $cardHtml
    $revenueMatch = [regex]::Match($plainCard, '\$[0-9]+(?:\.[0-9]+)?[KMB]?\s*/mo', 'IgnoreCase')
    $scoreMatch = [regex]::Match($plainCard, 'Solopreneur\s+([0-9]+(?:\.[0-9]+)?)', 'IgnoreCase')
    $revenueRaw = if ($revenueMatch.Success) { $revenueMatch.Value } else { '' }

    $rows.Add([pscustomobject]@{
      Category = $Category.Label
      CategorySlug = $Category.Slug
      Title = ConvertTo-PlainText $titleMatch.Groups[1].Value
      Domain = if ($domainMatch.Success) { ConvertTo-PlainText $domainMatch.Groups[1].Value } else { '' }
      RecordUrl = "$baseUrl$recordPath"
      Description = ''
      RevenueRaw = $revenueRaw
      MonthlyRevenueUsd = ConvertTo-MonthlyRevenueUsd $revenueRaw
      TrafficRaw = ''
      RevenuePerVisitorRaw = ''
      SolopreneurScoreRaw = if ($scoreMatch.Success) { $scoreMatch.Groups[1].Value } else { '' }
    })
  }

  if ($rows.Count -gt 0) { return $rows }

  foreach ($rowMatch in [regex]::Matches($Html, '<tr\b[\s\S]*?</tr>', 'IgnoreCase')) {
    $rowHtml = $rowMatch.Value
    if ($rowHtml -match 'class="[^"]*\bblur-row\b') { continue }

    $cells = @([regex]::Matches($rowHtml, '<td\b[\s\S]*?</td>', 'IgnoreCase'))
    if ($cells.Count -lt 6) { continue }

    $storyMatch = [regex]::Match($cells[0].Value, 'href="(/(?:stories|businesses)/[^"?#]+)"', 'IgnoreCase')
    $titleMatch = [regex]::Match($cells[0].Value, '<span class="text-sm font-bold">([\s\S]*?)</span>', 'IgnoreCase')
    if (-not $storyMatch.Success -or -not $titleMatch.Success) { continue }

    $domainMatches = [regex]::Matches($cells[0].Value, '<span class="[^"]*font-mono[^"]*">([\s\S]*?)</span>', 'IgnoreCase')
    $domain = if ($domainMatches.Count -gt 0) { ConvertTo-PlainText $domainMatches[$domainMatches.Count - 1].Groups[1].Value } else { '' }
    $storyPath = $storyMatch.Groups[1].Value
    $revenueRaw = ConvertTo-PlainText $cells[2].Value

    $rows.Add([pscustomobject]@{
      Category = $Category.Label
      CategorySlug = $Category.Slug
      Title = ConvertTo-PlainText $titleMatch.Groups[1].Value
      Domain = $domain
      RecordUrl = "$baseUrl$storyPath"
      Description = ConvertTo-PlainText $cells[1].Value
      RevenueRaw = $revenueRaw
      MonthlyRevenueUsd = ConvertTo-MonthlyRevenueUsd $revenueRaw
      TrafficRaw = ConvertTo-PlainText $cells[3].Value
      RevenuePerVisitorRaw = ConvertTo-PlainText $cells[4].Value
      SolopreneurScoreRaw = ConvertTo-PlainText $cells[5].Value
    })
  }
  return $rows
}

New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
$cacheDirectory = Join-Path $OutputDirectory 'cache'
New-Item -ItemType Directory -Path $cacheDirectory -Force | Out-Null

Write-Host 'Reading public homepage aggregate cards...'
$homepage = Get-PageContent -Url "$baseUrl/" -CacheFileName 'homepage.html'
[IO.File]::WriteAllText((Join-Path $cacheDirectory 'homepage.html'), $homepage, $utf8NoBom)

$allRows = New-Object Collections.Generic.List[object]
$categoryMeta = @{}

foreach ($category in $categories) {
  $url = "$baseUrl/data/$($category.Slug)"
  if ([string]::IsNullOrWhiteSpace($InputCacheDirectory)) { Start-Sleep -Seconds $DelaySeconds }
  Write-Host "Reading $($category.Label): $url"
  $html = Get-PageContent -Url $url -CacheFileName ("{0}.html" -f $category.Slug)
  [IO.File]::WriteAllText((Join-Path $cacheDirectory ("{0}.html" -f $category.Slug)), $html, $utf8NoBom)

  $aggregate = Get-HomepageAggregate -HomepageHtml $homepage -CardTitle $category.CardTitle
  $categoryMeta[$category.Slug] = $aggregate
  foreach ($row in (Get-PublicRows -Html $html -Category $category)) { $allRows.Add($row) }
}

if ($allRows.Count -eq 0) { throw 'No public rows were parsed.' }

$rawCsv = Join-Path $OutputDirectory 'public-excerpt-rows.csv'
$allRows | Export-Csv -LiteralPath $rawCsv -NoTypeInformation -Encoding UTF8

$groups = $allRows | Group-Object {
  if (-not [string]::IsNullOrWhiteSpace($_.Domain)) { $_.Domain.Trim().ToLowerInvariant() }
  else { $_.RecordUrl.Trim().ToLowerInvariant() }
}

$uniqueRows = foreach ($group in $groups) {
  $first = $group.Group | Select-Object -First 1
  $revenueValues = @($group.Group | Where-Object { $null -ne $_.MonthlyRevenueUsd } | Select-Object -ExpandProperty MonthlyRevenueUsd -Unique)
  [pscustomobject]@{
    Key = $group.Name
    Title = $first.Title
    Domain = $first.Domain
    RecordUrl = $first.RecordUrl
    Categories = (($group.Group.Category | Sort-Object -Unique) -join '; ')
    CategoryCount = @($group.Group.Category | Sort-Object -Unique).Count
    RevenueRaw = $first.RevenueRaw
    MonthlyRevenueUsd = if ($revenueValues.Count -gt 0) { [double]$revenueValues[0] } else { $null }
    RevenueConflict = $revenueValues.Count -gt 1
  }
}

$uniqueCsv = Join-Path $OutputDirectory 'unique-public-excerpt.csv'
$uniqueRows | Export-Csv -LiteralPath $uniqueCsv -NoTypeInformation -Encoding UTF8

$categorySummary = foreach ($category in $categories) {
  $rows = @($allRows | Where-Object { $_.CategorySlug -eq $category.Slug })
  $revenues = [double[]]@($rows | Where-Object { $null -ne $_.MonthlyRevenueUsd } | Select-Object -ExpandProperty MonthlyRevenueUsd)
  $meta = $categoryMeta[$category.Slug]
  [pscustomobject]@{
    Category = $category.Label
    CategoryUrl = "$baseUrl/data/$($category.Slug)"
    PlatformDisplayedCount = $meta.Count
    PlatformDisplayedMedianMonthlyRevenueUsd = $meta.MedianMonthlyRevenueUsd
    PublicRowsParsed = $rows.Count
    RevenueRows = $revenues.Count
    RevenueCoveragePercent = if ($rows.Count -gt 0) { [math]::Round(100 * $revenues.Count / $rows.Count, 1) } else { 0 }
    PublicExcerptP25MonthlyRevenueUsd = Get-RoundedPercentile -Values $revenues -Percentile 0.25
    PublicExcerptMedianMonthlyRevenueUsd = Get-RoundedPercentile -Values $revenues -Percentile 0.5
    PublicExcerptP75MonthlyRevenueUsd = Get-RoundedPercentile -Values $revenues -Percentile 0.75
  }
}

$categoryCsv = Join-Path $OutputDirectory 'category-summary.csv'
$categorySummary | Export-Csv -LiteralPath $categoryCsv -NoTypeInformation -Encoding UTF8

$uniqueRevenues = [double[]]@($uniqueRows | Where-Object { $null -ne $_.MonthlyRevenueUsd } | Select-Object -ExpandProperty MonthlyRevenueUsd)
$overlapRows = $allRows.Count - $uniqueRows.Count
$summary = [ordered]@{
  observedAt = (Get-Date).ToString('yyyy-MM-ddTHH:mm:sszzz')
  source = "$baseUrl/"
  categoryPages = $categories.Count
  publicRowOccurrences = $allRows.Count
  uniquePublicItems = $uniqueRows.Count
  duplicateRowOccurrences = $overlapRows
  duplicateRowPercent = [math]::Round(100 * $overlapRows / $allRows.Count, 1)
  multiCategoryItems = @($uniqueRows | Where-Object { $_.CategoryCount -gt 1 }).Count
  multiCategoryItemPercent = [math]::Round(100 * @($uniqueRows | Where-Object { $_.CategoryCount -gt 1 }).Count / $uniqueRows.Count, 1)
  uniqueRevenueItems = $uniqueRevenues.Count
  uniqueRevenueCoveragePercent = [math]::Round(100 * $uniqueRevenues.Count / $uniqueRows.Count, 1)
  uniqueRevenueP25UsdPerMonth = Get-RoundedPercentile -Values $uniqueRevenues -Percentile 0.25
  uniqueRevenueMedianUsdPerMonth = Get-RoundedPercentile -Values $uniqueRevenues -Percentile 0.5
  uniqueRevenueP75UsdPerMonth = Get-RoundedPercentile -Values $uniqueRevenues -Percentile 0.75
  uniqueRevenueAtLeast10k = @($uniqueRevenues | Where-Object { $_ -ge 10000 }).Count
  uniqueRevenueAtLeast10kPercent = [math]::Round(100 * @($uniqueRevenues | Where-Object { $_ -ge 10000 }).Count / $uniqueRevenues.Count, 1)
  uniqueRevenueAtLeast30k = @($uniqueRevenues | Where-Object { $_ -ge 30000 }).Count
  uniqueRevenueAtLeast30kPercent = [math]::Round(100 * @($uniqueRevenues | Where-Object { $_ -ge 30000 }).Count / $uniqueRevenues.Count, 1)
  uniqueRevenueAtLeast100k = @($uniqueRevenues | Where-Object { $_ -ge 100000 }).Count
  uniqueRevenueAtLeast100kPercent = [math]::Round(100 * @($uniqueRevenues | Where-Object { $_ -ge 100000 }).Count / $uniqueRevenues.Count, 1)
  revenueConflicts = @($uniqueRows | Where-Object { $_.RevenueConflict }).Count
  caveat = 'Logged-out default public excerpts from overlapping, winner-only Starter Story collections. This is not a probability sample and cannot estimate startup success.'
}

$summaryPath = Join-Path $OutputDirectory 'summary.json'
[IO.File]::WriteAllText($summaryPath, ($summary | ConvertTo-Json -Depth 5), $utf8NoBom)

Write-Host ''
Write-Host "Collection complete: $OutputDirectory"
$summary | Format-List
Write-Host 'Category summary:'
$categorySummary | Format-Table -AutoSize

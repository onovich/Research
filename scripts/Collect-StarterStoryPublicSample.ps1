[CmdletBinding()]
param(
  [string]$OutputDirectory = (Join-Path ([IO.Path]::GetTempPath()) ("starter-story-public-sample-{0}" -f (Get-Date -Format 'yyyyMMdd-HHmmss'))),
  [string]$InputCacheDirectory,
  [switch]$AllPublicDataPages,
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

function Get-PearsonCorrelation {
  param([object[]]$Pairs)

  if (-not $Pairs -or $Pairs.Count -lt 3) { return $null }
  $xMean = ($Pairs | Measure-Object -Property X -Average).Average
  $yMean = ($Pairs | Measure-Object -Property Y -Average).Average
  $numerator = 0.0
  $xSquares = 0.0
  $ySquares = 0.0
  foreach ($pair in $Pairs) {
    $xDelta = [double]$pair.X - [double]$xMean
    $yDelta = [double]$pair.Y - [double]$yMean
    $numerator += $xDelta * $yDelta
    $xSquares += $xDelta * $xDelta
    $ySquares += $yDelta * $yDelta
  }
  if ($xSquares -eq 0 -or $ySquares -eq 0) { return $null }
  return [math]::Round($numerator / [math]::Sqrt($xSquares * $ySquares), 3)
}

function Test-CategoryMembership {
  param(
    [Parameter(Mandatory)]$Row,
    [Parameter(Mandatory)][string[]]$Slugs
  )

  $rowSlugs = @([string]$Row.CategorySlugs -split '; ')
  return @($rowSlugs | Where-Object { $_ -in $Slugs }).Count -gt 0
}

function Get-ProxyGroupSummary {
  param([object[]]$Rows)

  $groupRows = @($Rows)
  $revenues = [double[]]@($groupRows | Where-Object { $null -ne $_.MonthlyRevenueUsd } | Select-Object -ExpandProperty MonthlyRevenueUsd)
  $scores = [double[]]@($groupRows | Where-Object { $null -ne $_.SolopreneurScore } | Select-Object -ExpandProperty SolopreneurScore)
  $scoreMedian = Get-Percentile -Values $scores -Percentile 0.5
  return [pscustomobject]@{
    UniqueItems = $groupRows.Count
    RevenueItems = $revenues.Count
    RevenueCoveragePercent = if ($groupRows.Count -gt 0) { [math]::Round(100 * $revenues.Count / $groupRows.Count, 1) } else { 0 }
    RevenueP25UsdPerMonth = Get-RoundedPercentile -Values $revenues -Percentile 0.25
    RevenueMedianUsdPerMonth = Get-RoundedPercentile -Values $revenues -Percentile 0.5
    RevenueP75UsdPerMonth = Get-RoundedPercentile -Values $revenues -Percentile 0.75
    RevenueAtLeast10k = @($revenues | Where-Object { $_ -ge 10000 }).Count
    RevenueAtLeast10kPercent = if ($revenues.Count -gt 0) { [math]::Round(100 * @($revenues | Where-Object { $_ -ge 10000 }).Count / $revenues.Count, 1) } else { 0 }
    RevenueAtLeast100k = @($revenues | Where-Object { $_ -ge 100000 }).Count
    RevenueAtLeast100kPercent = if ($revenues.Count -gt 0) { [math]::Round(100 * @($revenues | Where-Object { $_ -ge 100000 }).Count / $revenues.Count, 1) } else { 0 }
    MedianSolopreneurScore = if ($null -ne $scoreMedian) { [math]::Round($scoreMedian, 1) } else { $null }
  }
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
  if ($response.Content -match '(?i)cf-chl-|captcha|verify you are human|checking your browser') {
    throw "A challenge page was detected for $Url. Collection stopped without retrying or bypassing it."
  }
  return $response.Content
}

function Get-SitemapXml {
  param(
    [Parameter(Mandatory)][string]$CacheDirectory,
    [Parameter(Mandatory)][string]$SitemapUrl
  )

  $cachePath = Join-Path $CacheDirectory 'sitemap.gz'
  if (-not [string]::IsNullOrWhiteSpace($InputCacheDirectory)) {
    $inputPath = Join-Path $InputCacheDirectory 'sitemap.gz'
    if (-not (Test-Path -LiteralPath $inputPath -PathType Leaf)) {
      throw "Cached sitemap not found: $inputPath"
    }
    Copy-Item -LiteralPath $inputPath -Destination $cachePath -Force
  }
  else {
    Invoke-WebRequest -UseBasicParsing -Uri $SitemapUrl -Headers @{ 'User-Agent' = $userAgent } -OutFile $cachePath -TimeoutSec 60
  }

  $fileStream = [IO.File]::OpenRead($cachePath)
  try {
    $gzipStream = [IO.Compression.GZipStream]::new($fileStream, [IO.Compression.CompressionMode]::Decompress)
    $reader = [IO.StreamReader]::new($gzipStream, [Text.Encoding]::UTF8)
    try { return $reader.ReadToEnd() }
    finally { $reader.Dispose() }
  }
  finally { $fileStream.Dispose() }
}

function Get-CategoryTitle {
  param(
    [Parameter(Mandatory)][string]$Html,
    [Parameter(Mandatory)][string]$FallbackSlug
  )

  $headingMatch = [regex]::Match($Html, '<span class="truncate max-w-\[14rem\]">([\s\S]*?)</span>', 'IgnoreCase')
  if ($headingMatch.Success) {
    $heading = ConvertTo-PlainText $headingMatch.Groups[1].Value
    if (-not [string]::IsNullOrWhiteSpace($heading)) { return $heading }
  }

  $titleMatch = [regex]::Match($Html, '<title>([\s\S]*?)</title>', 'IgnoreCase')
  if ($titleMatch.Success) {
    $title = (ConvertTo-PlainText $titleMatch.Groups[1].Value) -replace '\s+-\s+Starter Story\s*$', ''
    if (-not [string]::IsNullOrWhiteSpace($title) -and $title -notmatch '^Explore Successful Businesses$') { return $title }
  }
  return (($FallbackSlug -split '-') | ForEach-Object {
    if ($_.Length -gt 0) { $_.Substring(0, 1).ToUpperInvariant() + $_.Substring(1) }
  }) -join ' '
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

  foreach ($cardMatch in [regex]::Matches($Html, '<a\b(?=[^>]*data-posthog-action="view_case_study")(?=[^>]*href="(/[^"?#]+)")[\s\S]*?</a>', 'IgnoreCase')) {
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

$sitemapUrl = "$baseUrl/sitemap"
$sitemapUrlCount = $null
if ($AllPublicDataPages) {
  Write-Host 'Reading the public sitemap to enumerate data pages...'
  $sitemapXml = Get-SitemapXml -CacheDirectory $cacheDirectory -SitemapUrl $sitemapUrl
  $sitemapUrls = @([regex]::Matches($sitemapXml, '<loc>(.*?)</loc>') | ForEach-Object { [Net.WebUtility]::HtmlDecode($_.Groups[1].Value) })
  $sitemapUrlCount = $sitemapUrls.Count
  $dataUrls = @($sitemapUrls | Where-Object { $_ -match '^https://www\.starterstory\.com/data/[^/?#]+/?$' } | Sort-Object -Unique)
  if ($dataUrls.Count -eq 0) { throw 'No public data pages were found in the sitemap.' }
  $categories = @($dataUrls | ForEach-Object {
    $slug = ([Uri]$_).AbsolutePath.Trim('/').Substring(5)
    [pscustomobject]@{ Slug = $slug; Label = $slug; CardTitle = $slug }
  })
  if ([string]::IsNullOrWhiteSpace($InputCacheDirectory)) { Start-Sleep -Seconds $DelaySeconds }
}

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

  if ($AllPublicDataPages) {
    $categoryTitle = Get-CategoryTitle -Html $html -FallbackSlug $category.Slug
    $category.Label = $categoryTitle
    $category.CardTitle = $categoryTitle
  }

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
  $scoreValues = @($group.Group | Where-Object { -not [string]::IsNullOrWhiteSpace($_.SolopreneurScoreRaw) } | ForEach-Object { [double]$_.SolopreneurScoreRaw } | Select-Object -Unique)
  [pscustomobject]@{
    Key = $group.Name
    Title = $first.Title
    Domain = $first.Domain
    RecordUrl = $first.RecordUrl
    Categories = (($group.Group.Category | Sort-Object -Unique) -join '; ')
    CategorySlugs = (($group.Group.CategorySlug | Sort-Object -Unique) -join '; ')
    CategoryCount = @($group.Group.CategorySlug | Sort-Object -Unique).Count
    RevenueRaw = $first.RevenueRaw
    MonthlyRevenueUsd = if ($revenueValues.Count -gt 0) { [double]$revenueValues[0] } else { $null }
    RevenueConflict = $revenueValues.Count -gt 1
    SolopreneurScore = if ($scoreValues.Count -gt 0) { [double]$scoreValues[0] } else { $null }
    SolopreneurScoreConflict = $scoreValues.Count -gt 1
  }
}

$uniqueCsv = Join-Path $OutputDirectory 'unique-public-excerpt.csv'
$uniqueRows | Export-Csv -LiteralPath $uniqueCsv -NoTypeInformation -Encoding UTF8

$categorySummary = foreach ($category in $categories) {
  $rows = @($allRows | Where-Object { $_.CategorySlug -eq $category.Slug })
  $revenues = [double[]]@($rows | Where-Object { $null -ne $_.MonthlyRevenueUsd } | Select-Object -ExpandProperty MonthlyRevenueUsd)
  $scores = [double[]]@($rows | Where-Object { -not [string]::IsNullOrWhiteSpace($_.SolopreneurScoreRaw) } | ForEach-Object { [double]$_.SolopreneurScoreRaw })
  $meta = $categoryMeta[$category.Slug]
  [pscustomobject]@{
    Category = $category.Label
    CategoryUrl = "$baseUrl/data/$($category.Slug)"
    PlatformDisplayedCount = $meta.Count
    PlatformDisplayedMedianMonthlyRevenueUsd = $meta.MedianMonthlyRevenueUsd
    PublicRowsParsed = $rows.Count
    RevenueRows = $revenues.Count
    RevenueCoveragePercent = if ($rows.Count -gt 0) { [math]::Round(100 * $revenues.Count / $rows.Count, 1) } else { 0 }
    SolopreneurScoreRows = $scores.Count
    PublicExcerptMedianSolopreneurScore = Get-RoundedPercentile -Values $scores -Percentile 0.5
    PublicExcerptP25MonthlyRevenueUsd = Get-RoundedPercentile -Values $revenues -Percentile 0.25
    PublicExcerptMedianMonthlyRevenueUsd = Get-RoundedPercentile -Values $revenues -Percentile 0.5
    PublicExcerptP75MonthlyRevenueUsd = Get-RoundedPercentile -Values $revenues -Percentile 0.75
  }
}

$categoryCsv = Join-Path $OutputDirectory 'category-summary.csv'
$categorySummary | Export-Csv -LiteralPath $categoryCsv -NoTypeInformation -Encoding UTF8

$softwareDeliveryProxySlugs = @(
  'micro-saas-ideas', 'no-code-ideas', 'apps-so-simple', 'solo-developer-ideas', 'gpt-wrapper-ideas',
  'weekend-projects', '1m-apis', '1m-chrome-extensions', 'plugins', 'consumer-ios-apps',
  'freemium-and-open-source-ideas', 'automation-ideas', 'one-page-websites'
)
$lowComplexityProxySlugs = @(
  'no-code-ideas', 'apps-so-simple', 'gpt-wrapper-ideas', 'weekend-projects',
  '1m-chrome-extensions', 'plugins', 'one-page-websites'
)
$coordinationLaborProxySlugs = @('marketplaces', 'productized-services')
$softwareDeliveryProxyRows = @($uniqueRows | Where-Object { Test-CategoryMembership -Row $_ -Slugs $softwareDeliveryProxySlugs })
$lowComplexityProxyRows = @($uniqueRows | Where-Object { Test-CategoryMembership -Row $_ -Slugs $lowComplexityProxySlugs })
$coordinationLaborProxyRows = @($uniqueRows | Where-Object { Test-CategoryMembership -Row $_ -Slugs $coordinationLaborProxySlugs })
$softwareDeliveryProxy = Get-ProxyGroupSummary -Rows $softwareDeliveryProxyRows
$lowComplexityProxy = Get-ProxyGroupSummary -Rows $lowComplexityProxyRows
$coordinationLaborProxy = Get-ProxyGroupSummary -Rows $coordinationLaborProxyRows
$softwareCoordinationOverlap = @($uniqueRows | Where-Object {
  (Test-CategoryMembership -Row $_ -Slugs $softwareDeliveryProxySlugs) -and
  (Test-CategoryMembership -Row $_ -Slugs $coordinationLaborProxySlugs)
}).Count
$lowComplexityCoordinationOverlap = @($uniqueRows | Where-Object {
  (Test-CategoryMembership -Row $_ -Slugs $lowComplexityProxySlugs) -and
  (Test-CategoryMembership -Row $_ -Slugs $coordinationLaborProxySlugs)
}).Count

$uniqueRevenues = [double[]]@($uniqueRows | Where-Object { $null -ne $_.MonthlyRevenueUsd } | Select-Object -ExpandProperty MonthlyRevenueUsd)
$uniqueScores = [double[]]@($uniqueRows | Where-Object { $null -ne $_.SolopreneurScore } | Select-Object -ExpandProperty SolopreneurScore)
$revenueScorePairs = @($uniqueRows | Where-Object { $null -ne $_.MonthlyRevenueUsd -and $null -ne $_.SolopreneurScore -and $_.MonthlyRevenueUsd -gt 0 } | ForEach-Object {
  [pscustomobject]@{ X = [double]$_.SolopreneurScore; Y = [math]::Log10([double]$_.MonthlyRevenueUsd) }
})
$scoreRevenueRows = @($uniqueRows | Where-Object { $null -ne $_.MonthlyRevenueUsd -and $null -ne $_.SolopreneurScore -and $_.MonthlyRevenueUsd -gt 0 })
$scoreBandUnder60Revenues = [double[]]@($scoreRevenueRows | Where-Object { $_.SolopreneurScore -lt 60 } | Select-Object -ExpandProperty MonthlyRevenueUsd)
$scoreBand60sRevenues = [double[]]@($scoreRevenueRows | Where-Object { $_.SolopreneurScore -ge 60 -and $_.SolopreneurScore -lt 70 } | Select-Object -ExpandProperty MonthlyRevenueUsd)
$scoreBand70sRevenues = [double[]]@($scoreRevenueRows | Where-Object { $_.SolopreneurScore -ge 70 -and $_.SolopreneurScore -lt 80 } | Select-Object -ExpandProperty MonthlyRevenueUsd)
$scoreBand80PlusRevenues = [double[]]@($scoreRevenueRows | Where-Object { $_.SolopreneurScore -ge 80 } | Select-Object -ExpandProperty MonthlyRevenueUsd)
$categoryMemberships = [double[]]@($uniqueRows | Select-Object -ExpandProperty CategoryCount)
$overlapRows = $allRows.Count - $uniqueRows.Count
$summary = [ordered]@{
  observedAt = (Get-Date).ToString('yyyy-MM-ddTHH:mm:sszzz')
  source = "$baseUrl/"
  sitemap = if ($AllPublicDataPages) { $sitemapUrl } else { $null }
  sitemapUrlCount = $sitemapUrlCount
  requestCount = if ([string]::IsNullOrWhiteSpace($InputCacheDirectory)) { $categories.Count + 1 + [int]$AllPublicDataPages.IsPresent } else { 0 }
  delaySeconds = if ([string]::IsNullOrWhiteSpace($InputCacheDirectory)) { $DelaySeconds } else { 0 }
  categoryPages = $categories.Count
  publicRowOccurrences = $allRows.Count
  uniquePublicItems = $uniqueRows.Count
  duplicateRowOccurrences = $overlapRows
  duplicateRowPercent = [math]::Round(100 * $overlapRows / $allRows.Count, 1)
  averageCategoryMembershipsPerItem = [math]::Round($allRows.Count / $uniqueRows.Count, 2)
  medianCategoryMembershipsPerItem = Get-RoundedPercentile -Values $categoryMemberships -Percentile 0.5
  p75CategoryMembershipsPerItem = Get-RoundedPercentile -Values $categoryMemberships -Percentile 0.75
  maxCategoryMembershipsPerItem = ($categoryMemberships | Measure-Object -Maximum).Maximum
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
  uniqueRevenueAtLeast1m = @($uniqueRevenues | Where-Object { $_ -ge 1000000 }).Count
  uniqueRevenueAtLeast1mPercent = [math]::Round(100 * @($uniqueRevenues | Where-Object { $_ -ge 1000000 }).Count / $uniqueRevenues.Count, 1)
  revenueConflicts = @($uniqueRows | Where-Object { $_.RevenueConflict }).Count
  uniqueSolopreneurScoreItems = $uniqueScores.Count
  uniqueSolopreneurScoreCoveragePercent = [math]::Round(100 * $uniqueScores.Count / $uniqueRows.Count, 1)
  uniqueSolopreneurScoreMedian = Get-RoundedPercentile -Values $uniqueScores -Percentile 0.5
  revenueScorePairs = $revenueScorePairs.Count
  solopreneurScoreLogRevenuePearsonR = Get-PearsonCorrelation -Pairs $revenueScorePairs
  scoreBandUnder60RevenueItems = $scoreBandUnder60Revenues.Count
  scoreBandUnder60MedianRevenueUsdPerMonth = Get-RoundedPercentile -Values $scoreBandUnder60Revenues -Percentile 0.5
  scoreBand60sRevenueItems = $scoreBand60sRevenues.Count
  scoreBand60sMedianRevenueUsdPerMonth = Get-RoundedPercentile -Values $scoreBand60sRevenues -Percentile 0.5
  scoreBand70sRevenueItems = $scoreBand70sRevenues.Count
  scoreBand70sMedianRevenueUsdPerMonth = Get-RoundedPercentile -Values $scoreBand70sRevenues -Percentile 0.5
  scoreBand80PlusRevenueItems = $scoreBand80PlusRevenues.Count
  scoreBand80PlusMedianRevenueUsdPerMonth = Get-RoundedPercentile -Values $scoreBand80PlusRevenues -Percentile 0.5
  solopreneurScoreConflicts = @($uniqueRows | Where-Object { $_.SolopreneurScoreConflict }).Count
  softwareDeliveryProxyPages = $softwareDeliveryProxySlugs.Count
  softwareDeliveryProxyUniqueItems = $softwareDeliveryProxy.UniqueItems
  softwareDeliveryProxyRevenueItems = $softwareDeliveryProxy.RevenueItems
  softwareDeliveryProxyRevenueCoveragePercent = $softwareDeliveryProxy.RevenueCoveragePercent
  softwareDeliveryProxyRevenueMedianUsdPerMonth = $softwareDeliveryProxy.RevenueMedianUsdPerMonth
  softwareDeliveryProxyRevenueP25UsdPerMonth = $softwareDeliveryProxy.RevenueP25UsdPerMonth
  softwareDeliveryProxyRevenueP75UsdPerMonth = $softwareDeliveryProxy.RevenueP75UsdPerMonth
  softwareDeliveryProxyRevenueAtLeast10k = $softwareDeliveryProxy.RevenueAtLeast10k
  softwareDeliveryProxyRevenueAtLeast10kPercent = $softwareDeliveryProxy.RevenueAtLeast10kPercent
  softwareDeliveryProxyRevenueAtLeast100k = $softwareDeliveryProxy.RevenueAtLeast100k
  softwareDeliveryProxyRevenueAtLeast100kPercent = $softwareDeliveryProxy.RevenueAtLeast100kPercent
  softwareDeliveryProxyMedianSolopreneurScore = $softwareDeliveryProxy.MedianSolopreneurScore
  lowComplexityProxyPages = $lowComplexityProxySlugs.Count
  lowComplexityProxyUniqueItems = $lowComplexityProxy.UniqueItems
  lowComplexityProxyRevenueItems = $lowComplexityProxy.RevenueItems
  lowComplexityProxyRevenueCoveragePercent = $lowComplexityProxy.RevenueCoveragePercent
  lowComplexityProxyRevenueMedianUsdPerMonth = $lowComplexityProxy.RevenueMedianUsdPerMonth
  lowComplexityProxyRevenueP25UsdPerMonth = $lowComplexityProxy.RevenueP25UsdPerMonth
  lowComplexityProxyRevenueP75UsdPerMonth = $lowComplexityProxy.RevenueP75UsdPerMonth
  lowComplexityProxyRevenueAtLeast10k = $lowComplexityProxy.RevenueAtLeast10k
  lowComplexityProxyRevenueAtLeast10kPercent = $lowComplexityProxy.RevenueAtLeast10kPercent
  lowComplexityProxyRevenueAtLeast100k = $lowComplexityProxy.RevenueAtLeast100k
  lowComplexityProxyRevenueAtLeast100kPercent = $lowComplexityProxy.RevenueAtLeast100kPercent
  lowComplexityProxyMedianSolopreneurScore = $lowComplexityProxy.MedianSolopreneurScore
  coordinationLaborProxyPages = $coordinationLaborProxySlugs.Count
  coordinationLaborProxyUniqueItems = $coordinationLaborProxy.UniqueItems
  coordinationLaborProxyRevenueItems = $coordinationLaborProxy.RevenueItems
  coordinationLaborProxyRevenueCoveragePercent = $coordinationLaborProxy.RevenueCoveragePercent
  coordinationLaborProxyRevenueMedianUsdPerMonth = $coordinationLaborProxy.RevenueMedianUsdPerMonth
  coordinationLaborProxyRevenueP25UsdPerMonth = $coordinationLaborProxy.RevenueP25UsdPerMonth
  coordinationLaborProxyRevenueP75UsdPerMonth = $coordinationLaborProxy.RevenueP75UsdPerMonth
  coordinationLaborProxyRevenueAtLeast10k = $coordinationLaborProxy.RevenueAtLeast10k
  coordinationLaborProxyRevenueAtLeast10kPercent = $coordinationLaborProxy.RevenueAtLeast10kPercent
  coordinationLaborProxyRevenueAtLeast100k = $coordinationLaborProxy.RevenueAtLeast100k
  coordinationLaborProxyRevenueAtLeast100kPercent = $coordinationLaborProxy.RevenueAtLeast100kPercent
  coordinationLaborProxyMedianSolopreneurScore = $coordinationLaborProxy.MedianSolopreneurScore
  softwareCoordinationProxyOverlapItems = $softwareCoordinationOverlap
  lowComplexityCoordinationProxyOverlapItems = $lowComplexityCoordinationOverlap
  caveat = 'Logged-out default public excerpts from overlapping, winner-only Starter Story collections. This is not a probability sample and cannot estimate startup success.'
}

$summaryPath = Join-Path $OutputDirectory 'summary.json'
[IO.File]::WriteAllText($summaryPath, ($summary | ConvertTo-Json -Depth 5), $utf8NoBom)

Write-Host ''
Write-Host "Collection complete: $OutputDirectory"
$summary | Format-List
Write-Host 'Category summary:'
$categorySummary | Format-Table -AutoSize

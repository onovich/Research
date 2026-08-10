[CmdletBinding()]
param(
  [switch]$CheckHistory
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = [System.IO.Path]::GetFullPath((Split-Path -Parent $scriptDir))
$utf8 = [System.Text.UTF8Encoding]::new($false)
$errors = New-Object System.Collections.Generic.List[string]
$expectedSystemVersion = "1.3.0"

function Add-ValidationError {
  param([string]$Message)
  $errors.Add($Message)
}

function Get-RelativeDisplayPath {
  param([string]$Path)
  return $Path.Substring($repoRoot.Length).TrimStart("\", "/").Replace("\", "/")
}

function Read-TextFile {
  param([string]$Path)
  return [System.IO.File]::ReadAllText($Path, $utf8)
}

function Test-Regex {
  param([string]$Text, [string]$Pattern)
  return [regex]::IsMatch($Text, $Pattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
}

$requiredFiles = @(
  ".gitignore",
  ".github/workflows/deploy-pages.yml",
  "README.md",
  "README.zh-CN.md",
  "public-site.json",
  "index.html",
  "index.zh-CN.html",
  "about.html",
  "about.zh-CN.html",
  "404.html",
  "sitemap.xml",
  "assets/research.css",
  "assets/i18n.js",
  "assets/research.js",
  "assets/favicon.svg",
  "assets/og/research-library-en.png",
  "assets/og/research-library-zh-CN.png",
  "assets/og/crowdfunding-indie-games-en.png",
  "assets/og/crowdfunding-indie-games-zh-CN.png",
  "assets/og/research-to-html-en.png",
  "assets/og/research-to-html-zh-CN.png",
  "crowdfunding-and-indie-games-research/README.md",
  "crowdfunding-and-indie-games-research/README.zh-CN.md",
  "crowdfunding-and-indie-games-research/index.html",
  "crowdfunding-and-indie-games-research/index.zh-CN.html",
  "tools/research-to-html/index.html",
  "tools/research-to-html/index.zh-CN.html",
  "docs/research-to-html-workflow.md",
  "docs/research-to-html-workflow.zh-CN.md",
  "docs/visual-system.md",
  "docs/visual-system.zh-CN.md",
  "research-template/README.md",
  "research-template/README.zh-CN.md",
  "research-template/USAGE.md",
  "research-template/USAGE.zh-CN.md",
  "research-template/index.html",
  "research-template/index.zh-CN.html",
  "scripts/Build-PublicResearchSite.ps1",
  "scripts/Generate-ShareImages.cjs",
  "scripts/Smoke-ResearchSite.cjs",
  ".agents/skills/research-to-html/SKILL.md",
  ".agents/skills/research-to-html/agents/openai.yaml",
  ".agents/skills/research-to-html/references/master-prompt.md",
  ".agents/skills/research-to-html/references/research-protocol.md",
  ".agents/skills/research-to-html/references/html-contract.md",
  ".agents/skills/research-to-github-pages/SKILL.md",
  ".agents/skills/research-to-github-pages/agents/openai.yaml",
  ".agents/skills/research-to-github-pages/assets/deploy-pages.yml",
  ".agents/skills/research-to-github-pages/assets/Build-PublicResearchSite.ps1",
  ".agents/skills/research-to-github-pages/assets/public-site.example.json"
)

foreach ($relativePath in $requiredFiles) {
  if (-not (Test-Path -LiteralPath (Join-Path $repoRoot $relativePath) -PathType Leaf)) {
    Add-ValidationError "Missing required file: $relativePath"
  }
}

$candidatePaths = New-Object System.Collections.Generic.HashSet[string]([System.StringComparer]::OrdinalIgnoreCase)
& git -C $repoRoot ls-files | ForEach-Object { if ($_ -and (Test-Path -LiteralPath (Join-Path $repoRoot $_) -PathType Leaf)) { [void]$candidatePaths.Add($_) } }
foreach ($relativePath in $requiredFiles) {
  if (Test-Path -LiteralPath (Join-Path $repoRoot $relativePath) -PathType Leaf) { [void]$candidatePaths.Add($relativePath) }
}

$textExtensions = @(".html", ".css", ".js", ".cjs", ".md", ".json", ".ps1", ".yaml", ".yml", ".xml", ".svg", ".gitignore")
$textFiles = New-Object System.Collections.Generic.List[System.IO.FileInfo]
foreach ($relativePath in $candidatePaths) {
  $fullPath = Join-Path $repoRoot $relativePath
  $extension = [System.IO.Path]::GetExtension($fullPath).ToLowerInvariant()
  if ($relativePath -eq ".gitignore" -or $extension -in $textExtensions) {
    $textFiles.Add((Get-Item -LiteralPath $fullPath -Force))
  }
}

$sensitivePatterns = @(
  @{ Label = "Windows user path"; Pattern = '(?i)(?:[A-Z]:\\(?:Users|Documents and Settings)\\[^\\\s"''<>]+)' },
  @{ Label = "Unix home path"; Pattern = '(?i)(?:/Users/[^/\s"''<>]+/|/home/[^/\s"''<>]+/)' },
  @{ Label = "local file URL"; Pattern = '(?i)file:///' },
  @{ Label = "email address"; Pattern = '(?i)\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b' },
  @{ Label = "GitHub token"; Pattern = '(?i)\b(?:ghp|gho|ghu|ghs|ghr)_[A-Za-z0-9]{30,}\b|\bgithub_pat_[A-Za-z0-9_]{40,}\b' },
  @{ Label = "OpenAI key"; Pattern = '\bsk-[A-Za-z0-9_-]{20,}\b' },
  @{ Label = "AWS access key"; Pattern = '\bAKIA[0-9A-Z]{16}\b' },
  @{ Label = "Slack token"; Pattern = '\bxox[baprs]-[A-Za-z0-9-]{20,}\b' },
  @{ Label = "private key block"; Pattern = '-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----' }
)

foreach ($file in $textFiles) {
  $relative = Get-RelativeDisplayPath $file.FullName
  $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
  if ($bytes.Length -ge 3 -and $bytes[0] -eq 239 -and $bytes[1] -eq 187 -and $bytes[2] -eq 191) {
    Add-ValidationError "UTF-8 BOM is not allowed: $relative"
  }

  $text = Read-TextFile $file.FullName
  foreach ($rule in $sensitivePatterns) {
    if ($relative -eq "scripts/Validate-ResearchSite.ps1" -and $rule.Label -in @("Unix home path", "local file URL")) {
      continue
    }
    if ($rule.Label -eq "email address") {
      $matches = [regex]::Matches($text, $rule.Pattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
      foreach ($match in $matches) {
        if ($match.Value -notmatch '(?i)@users\.noreply\.github\.com$|^noreply@github\.com$') {
          Add-ValidationError "${relative}: contains a public-content email address"
          break
        }
      }
    } elseif (Test-Regex $text $rule.Pattern) {
      Add-ValidationError "${relative}: contains a possible $($rule.Label)"
    }
  }
}

$manifestPath = Join-Path $repoRoot "public-site.json"
$manifest = $null
$publicEntries = @()
if (Test-Path -LiteralPath $manifestPath -PathType Leaf) {
  try {
    $manifest = Read-TextFile $manifestPath | ConvertFrom-Json
    $publicEntries = @($manifest.files | ForEach-Object { ([string]$_).Replace("\", "/").TrimStart("/") })
  } catch {
    Add-ValidationError "public-site.json is not valid JSON: $($_.Exception.Message)"
  }
}

$forbiddenPublicPatterns = @(
  '(^|/)\.',
  '^(?:docs|skills|scripts|research-template)/',
  '(^|/)README(?:\.[^/]+)?\.md$',
  '^public-site\.json$'
)

if ($manifest) {
  if ($manifest.version -ne 1 -or [string]::IsNullOrWhiteSpace([string]$manifest.output)) {
    Add-ValidationError "public-site.json must declare version 1 and an output directory."
  }
  $duplicates = $publicEntries | Group-Object | Where-Object { $_.Count -gt 1 }
  foreach ($duplicate in $duplicates) { Add-ValidationError "Duplicate public manifest entry: $($duplicate.Name)" }

  foreach ($entry in $publicEntries) {
    if ([string]::IsNullOrWhiteSpace($entry) -or $entry -match '(^|/)\.\.(/|$)' -or [System.IO.Path]::IsPathRooted($entry)) {
      Add-ValidationError "Unsafe public manifest entry: $entry"
      continue
    }
    if (-not (Test-Path -LiteralPath (Join-Path $repoRoot $entry) -PathType Leaf)) {
      Add-ValidationError "Public manifest entry does not exist: $entry"
    }
    foreach ($pattern in $forbiddenPublicPatterns) {
      if ($entry -match $pattern) { Add-ValidationError "Development-only file is present in the public manifest: $entry"; break }
    }
  }
}

$publicHtmlEntries = @($publicEntries | Where-Object { $_ -like "*.html" })
$indexableHtmlEntries = @($publicHtmlEntries | Where-Object { $_ -ne "404.html" })
$canonicalUrls = New-Object System.Collections.Generic.List[string]

foreach ($relative in $publicHtmlEntries) {
  $fullPath = Join-Path $repoRoot $relative
  if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) { continue }
  $html = Read-TextFile $fullPath

  if ($html -notmatch '(?i)<!doctype html>') { Add-ValidationError "${relative}: missing HTML5 doctype" }
  if ($html -notmatch '(?i)<html[^>]+lang="[^"]+"') { Add-ValidationError "${relative}: missing html lang" }
  if ($html -notmatch ('(?i)<html[^>]+data-system-version="{0}"' -f [regex]::Escape($expectedSystemVersion))) { Add-ValidationError "${relative}: expected Visual System $expectedSystemVersion" }
  if (([regex]::Matches($html, '(?i)<h1\b')).Count -ne 1) { Add-ValidationError "${relative}: expected exactly one h1" }
  if (([regex]::Matches($html, '(?i)<main\b')).Count -ne 1) { Add-ValidationError "${relative}: expected exactly one main" }

  $ids = [regex]::Matches($html, '\bid="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
  foreach ($duplicate in ($ids | Group-Object | Where-Object { $_.Count -gt 1 })) {
    Add-ValidationError "${relative}: duplicate id '$($duplicate.Name)'"
  }
  $idSet = @{}
  foreach ($id in $ids) { $idSet[$id] = $true }
  foreach ($match in [regex]::Matches($html, 'href="#([^"]+)"')) {
    if (-not $idSet.ContainsKey($match.Groups[1].Value)) { Add-ValidationError "${relative}: missing internal target '#$($match.Groups[1].Value)'" }
  }

  foreach ($match in [regex]::Matches($html, '(?:href|src)="([^"]+)"')) {
    $reference = $match.Groups[1].Value
    if ($reference -match '^(?:https?:|mailto:|tel:|data:|#)') { continue }
    $cleanReference = ($reference -split '[?#]', 2)[0]
    if ([string]::IsNullOrWhiteSpace($cleanReference)) { continue }
    $resolved = [System.IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $fullPath) $cleanReference))
    if (-not (Test-Path -LiteralPath $resolved)) { Add-ValidationError "${relative}: missing local asset '$reference'" }
  }

  if ($relative -eq "404.html") {
    if ($html -notmatch '(?i)<meta\b(?=[^>]*\bname="robots")(?=[^>]*\bcontent="[^"]*noindex)') {
      Add-ValidationError "404.html: missing noindex robots directive"
    }
    continue
  }

  if ($html -match '(?i)data-language-auto|window\.location\.replace') { Add-ValidationError "${relative}: automatic locale redirects are not allowed on indexable pages" }
  if ($html -match '(?i)\shref="(?:\.\./)*index\.html"' -or $html -match '(?i)\shref="(?:\.\./)*crowdfunding-and-indie-games-research/index\.html"') {
    Add-ValidationError "${relative}: internal links must use canonical directory URLs for default-English index pages"
  }
  if ($html -notmatch '(?i)data-language-option="en"' -or $html -notmatch '(?i)data-language-option="zh-CN"') { Add-ValidationError "${relative}: missing explicit English/Chinese language links" }
  if ($html -notmatch '(?i)<meta\b(?=[^>]*\bname="description")(?=[^>]*\bcontent="[^"]{40,}")') { Add-ValidationError "${relative}: missing useful meta description" }
  if ($html -notmatch '(?i)<meta\b(?=[^>]*\bname="robots")(?=[^>]*\bcontent="[^"]*index[^"]*follow)') { Add-ValidationError "${relative}: missing index,follow robots directive" }
  if ($html -notmatch '(?i)<link\b(?=[^>]*\brel="icon")(?=[^>]*\bhref="[^"]+")') { Add-ValidationError "${relative}: missing favicon" }

  $canonicalMatch = [regex]::Match($html, '(?i)<link\b(?=[^>]*\brel="canonical")(?=[^>]*\bhref="(https://[^"]+)")[^>]*>')
  if (-not $canonicalMatch.Success) {
    Add-ValidationError "${relative}: missing absolute HTTPS canonical URL"
  } else {
    $canonical = $canonicalMatch.Groups[1].Value
    if (-not $canonical.StartsWith("https://blog.onovich.com/Research/", [System.StringComparison]::Ordinal)) { Add-ValidationError "${relative}: canonical is outside the public research site" }
    $canonicalUrls.Add($canonical)
  }

  foreach ($language in @("en", "zh-CN", "x-default")) {
    $escapedLanguage = [regex]::Escape($language)
    $alternatePattern = '(?i)<link\b(?=[^>]*\brel="alternate")(?=[^>]*\bhreflang="{0}")(?=[^>]*\bhref="(https://[^"]+)")[^>]*>' -f $escapedLanguage
    $alternate = [regex]::Match($html, $alternatePattern)
    if (-not $alternate.Success) { Add-ValidationError "${relative}: missing absolute hreflang '$language'" }
  }

  foreach ($property in @("og:type", "og:site_name", "og:title", "og:description", "og:url", "og:image", "og:image:width", "og:image:height", "og:image:alt")) {
    $escaped = [regex]::Escape($property)
    $propertyPattern = '(?i)<meta\b(?=[^>]*\bproperty="{0}")(?=[^>]*\bcontent="[^"]+")' -f $escaped
    if ($html -notmatch $propertyPattern) { Add-ValidationError "${relative}: missing $property" }
  }
  foreach ($name in @("twitter:card", "twitter:title", "twitter:description", "twitter:image")) {
    $escaped = [regex]::Escape($name)
    $namePattern = '(?i)<meta\b(?=[^>]*\bname="{0}")(?=[^>]*\bcontent="[^"]+")' -f $escaped
    if ($html -notmatch $namePattern) { Add-ValidationError "${relative}: missing $name" }
  }

  $jsonLdMatches = [regex]::Matches($html, '(?is)<script[^>]+type=["'']application/ld\+json["''][^>]*>(.*?)</script>')
  if ($jsonLdMatches.Count -eq 0) {
    Add-ValidationError "${relative}: missing JSON-LD"
  } else {
    foreach ($jsonLdMatch in $jsonLdMatches) {
      try { $null = $jsonLdMatch.Groups[1].Value | ConvertFrom-Json } catch { Add-ValidationError "${relative}: invalid JSON-LD: $($_.Exception.Message)" }
    }
  }
}

foreach ($duplicate in ($canonicalUrls | Group-Object | Where-Object { $_.Count -gt 1 })) {
  Add-ValidationError "Canonical URL is reused by multiple pages: $($duplicate.Name)"
}

$localePairs = @(
  @{ En = "index.html"; Zh = "index.zh-CN.html" },
  @{ En = "about.html"; Zh = "about.zh-CN.html" },
  @{ En = "crowdfunding-and-indie-games-research/index.html"; Zh = "crowdfunding-and-indie-games-research/index.zh-CN.html" },
  @{ En = "tools/research-to-html/index.html"; Zh = "tools/research-to-html/index.zh-CN.html" }
)

foreach ($pair in $localePairs) {
  $enPath = Join-Path $repoRoot $pair.En
  $zhPath = Join-Path $repoRoot $pair.Zh
  if (-not (Test-Path -LiteralPath $enPath) -or -not (Test-Path -LiteralPath $zhPath)) { continue }
  $enHtml = Read-TextFile $enPath
  $zhHtml = Read-TextFile $zhPath
  if ($enHtml -notmatch '(?i)<html[^>]+lang="en"') { Add-ValidationError "$($pair.En): English page must use lang='en'" }
  if ($zhHtml -notmatch '(?i)<html[^>]+lang="zh-CN"') { Add-ValidationError "$($pair.Zh): Chinese page must use lang='zh-CN'" }

  $enIds = @([regex]::Matches($enHtml, '\bid="([^"]+)"') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
  $zhIds = @([regex]::Matches($zhHtml, '\bid="([^"]+)"') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
  if (@(Compare-Object $enIds $zhIds).Count -gt 0) { Add-ValidationError "$($pair.En) and $($pair.Zh): element ID sets differ" }

  $enLinks = @([regex]::Matches($enHtml, '(?i)<a[^>]+href="(https?://[^"]+)"') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
  $zhLinks = @([regex]::Matches($zhHtml, '(?i)<a[^>]+href="(https?://[^"]+)"') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
  if (@(Compare-Object $enLinks $zhLinks).Count -gt 0) { Add-ValidationError "$($pair.En) and $($pair.Zh): external content-link sets differ" }
}

$sitemapPath = Join-Path $repoRoot "sitemap.xml"
if (Test-Path -LiteralPath $sitemapPath -PathType Leaf) {
  try {
    [xml]$sitemap = Read-TextFile $sitemapPath
    $namespaceManager = New-Object System.Xml.XmlNamespaceManager($sitemap.NameTable)
    $namespaceManager.AddNamespace("sm", "http://www.sitemaps.org/schemas/sitemap/0.9")
    $namespaceManager.AddNamespace("xhtml", "http://www.w3.org/1999/xhtml")
    $sitemapUrls = @($sitemap.SelectNodes("//sm:url/sm:loc", $namespaceManager) | ForEach-Object { $_.InnerText } | Sort-Object -Unique)
    $expectedUrls = @($canonicalUrls | Sort-Object -Unique)
    if (@(Compare-Object $sitemapUrls $expectedUrls).Count -gt 0) { Add-ValidationError "sitemap.xml URLs do not exactly match public canonical URLs" }
    foreach ($urlNode in $sitemap.SelectNodes("//sm:url", $namespaceManager)) {
      if ($urlNode.SelectNodes("xhtml:link", $namespaceManager).Count -ne 3) { Add-ValidationError "sitemap.xml entry '$($urlNode.loc)' must have en, zh-CN, and x-default alternates" }
    }
  } catch {
    Add-ValidationError "sitemap.xml is invalid: $($_.Exception.Message)"
  }
}

foreach ($relative in @("assets/og/research-library-en.png", "assets/og/research-library-zh-CN.png", "assets/og/crowdfunding-indie-games-en.png", "assets/og/crowdfunding-indie-games-zh-CN.png", "assets/og/research-to-html-en.png", "assets/og/research-to-html-zh-CN.png")) {
  $path = Join-Path $repoRoot $relative
  if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { continue }
  $bytes = [System.IO.File]::ReadAllBytes($path)
  if ($bytes.Length -lt 24 -or $bytes[0] -ne 137 -or $bytes[1] -ne 80 -or $bytes[2] -ne 78 -or $bytes[3] -ne 71) {
    Add-ValidationError "${relative}: invalid PNG signature"
    continue
  }
  $width = [System.Net.IPAddress]::NetworkToHostOrder([BitConverter]::ToInt32($bytes, 16))
  $height = [System.Net.IPAddress]::NetworkToHostOrder([BitConverter]::ToInt32($bytes, 20))
  if ($width -ne 1200 -or $height -ne 630) { Add-ValidationError "${relative}: expected 1200x630, got ${width}x${height}" }
}

$markdownFiles = @($textFiles | Where-Object { $_.Extension -eq ".md" })
foreach ($file in $markdownFiles) {
  $relative = Get-RelativeDisplayPath $file.FullName
  $markdown = Read-TextFile $file.FullName
  foreach ($match in [regex]::Matches($markdown, '\[[^\]]*\]\(([^)]+)\)')) {
    $reference = $match.Groups[1].Value.Trim().Trim("<", ">")
    if ($reference -match '^(?:https?:|mailto:|tel:|data:|#)') { continue }
    $cleanReference = ($reference -split '[?#]', 2)[0]
    if ([string]::IsNullOrWhiteSpace($cleanReference)) { continue }
    $resolved = [System.IO.Path]::GetFullPath((Join-Path $file.DirectoryName $cleanReference))
    if (-not (Test-Path -LiteralPath $resolved)) { Add-ValidationError "${relative}: missing local Markdown target '$reference'" }
  }
}

$node = Get-Command node -ErrorAction SilentlyContinue
if (-not $node) {
  Add-ValidationError "Node.js is required to syntax-check JavaScript."
} else {
  foreach ($relative in @("assets/i18n.js", "assets/research.js", "scripts/Generate-ShareImages.cjs", "scripts/Smoke-ResearchSite.cjs")) {
    $path = Join-Path $repoRoot $relative
    if (-not (Test-Path -LiteralPath $path)) { continue }
    & $node.Source --check $path
    if ($LASTEXITCODE -ne 0) { Add-ValidationError "JavaScript syntax check failed: $relative" }
  }
}

$buildScript = Join-Path $repoRoot "scripts/Build-PublicResearchSite.ps1"
if ((Test-Path -LiteralPath $buildScript -PathType Leaf) -and $manifest) {
  try {
    & $buildScript
    $outputRoot = Join-Path $repoRoot ([string]$manifest.output)
    $actualFiles = @(Get-ChildItem -LiteralPath $outputRoot -Recurse -File -Force | ForEach-Object { $_.FullName.Substring($outputRoot.Length).TrimStart("\", "/").Replace("\", "/") } | Sort-Object)
    $expectedFiles = @($publicEntries + ".nojekyll" | Sort-Object)
    if (@(Compare-Object $actualFiles $expectedFiles).Count -gt 0) { Add-ValidationError "Built Pages artifact does not exactly match the public allowlist" }
    foreach ($actual in $actualFiles) {
      foreach ($pattern in $forbiddenPublicPatterns) {
        if ($actual -match $pattern -and $actual -ne ".nojekyll") { Add-ValidationError "Development-only file leaked into Pages artifact: $actual"; break }
      }
    }
  } catch {
    Add-ValidationError "Public site build failed: $($_.Exception.Message)"
  }
}

if ($CheckHistory) {
  $forbiddenHistoryPaths = @(".codex/project-git-workflow.json", "docs/codex-git-workflow.md")
  $historyPaths = @(& git -C $repoRoot log --all --name-only --pretty=format: | Where-Object { $_ })
  foreach ($forbidden in $forbiddenHistoryPaths) {
    if ($historyPaths -contains $forbidden) { Add-ValidationError "Git history still contains sensitive path: $forbidden" }
  }

  $historyEmails = @(& git -C $repoRoot log --all --format='%ae%n%ce' | Where-Object { $_ } | Sort-Object -Unique)
  foreach ($email in $historyEmails) {
    if ($email -notmatch '(?i)(?:@users\.noreply\.github\.com|^noreply@github\.com)$') { Add-ValidationError "Git history contains a non-noreply author or committer email"; break }
  }
}

if ($errors.Count -gt 0) {
  Write-Host "Research site validation failed with $($errors.Count) issue(s):" -ForegroundColor Red
  foreach ($errorMessage in $errors) { Write-Host " - $errorMessage" -ForegroundColor Red }
  exit 1
}

Write-Host "Research site validation passed." -ForegroundColor Green
Write-Host "Checked privacy patterns, $($indexableHtmlEntries.Count) indexable pages, bilingual pairs, SEO metadata, sitemap parity, JavaScript syntax, and the exact Pages allowlist artifact."
if ($CheckHistory) { Write-Host "Git history path and noreply-email checks also passed." }

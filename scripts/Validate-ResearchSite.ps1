[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptDir
$errors = New-Object System.Collections.Generic.List[string]

function Add-ValidationError {
  param([string]$Message)
  $errors.Add($Message)
}

function Get-RelativeDisplayPath {
  param([string]$Path)
  return $Path.Substring($repoRoot.Length).TrimStart("\").Replace("\", "/")
}

$requiredFiles = @(
  ".github/workflows/deploy-pages.yml",
  "README.md",
  "README.zh-CN.md",
  "index.html",
  "index.zh-CN.html",
  "assets/research.css",
  "assets/i18n.js",
  "assets/research.js",
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
  "crowdfunding-and-indie-games-research/README.md",
  "crowdfunding-and-indie-games-research/README.zh-CN.md",
  "crowdfunding-and-indie-games-research/index.html",
  "crowdfunding-and-indie-games-research/index.zh-CN.html",
  "skills/research-to-html/SKILL.md",
  "skills/research-to-html/agents/openai.yaml",
  "skills/research-to-html/references/master-prompt.md",
  "skills/research-to-html/references/research-protocol.md",
  "skills/research-to-html/references/html-contract.md",
  "skills/research-to-github-pages/SKILL.md",
  "skills/research-to-github-pages/agents/openai.yaml",
  "skills/research-to-github-pages/assets/deploy-pages.yml",
  "scripts/Smoke-ResearchSite.cjs"
)

foreach ($relativePath in $requiredFiles) {
  $fullPath = Join-Path $repoRoot $relativePath
  if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
    Add-ValidationError "Missing required file: $relativePath"
  }
}

$validationRoots = @(
  "README.md",
  "README.zh-CN.md",
  "index.html",
  "index.zh-CN.html",
  "assets",
  "docs",
  "docs/codex-git-workflow.md",
  "research-template",
  "crowdfunding-and-indie-games-research",
  "skills/research-to-html",
  "skills/research-to-github-pages",
  ".github/workflows/deploy-pages.yml",
  "scripts/Validate-ResearchSite.ps1",
  ".codex/project-git-workflow.json"
)

$textFiles = New-Object System.Collections.Generic.List[System.IO.FileInfo]
foreach ($relativeRoot in $validationRoots) {
  $fullRoot = Join-Path $repoRoot $relativeRoot
  if (-not (Test-Path -LiteralPath $fullRoot)) { continue }
  $item = Get-Item -LiteralPath $fullRoot
  if ($item.PSIsContainer) {
    Get-ChildItem -LiteralPath $item.FullName -Recurse -File |
      Where-Object { $_.Extension -in @(".html", ".css", ".js", ".cjs", ".md", ".json", ".ps1", ".yaml", ".yml") } |
      ForEach-Object { $textFiles.Add($_) }
  } else {
    $textFiles.Add($item)
  }
}

foreach ($file in $textFiles) {
  $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
  if ($bytes.Length -ge 3 -and $bytes[0] -eq 239 -and $bytes[1] -eq 187 -and $bytes[2] -eq 191) {
    Add-ValidationError "UTF-8 BOM is not allowed: $(Get-RelativeDisplayPath $file.FullName)"
  }
}

$htmlFiles = @($textFiles | Where-Object { $_.Extension -eq ".html" })

foreach ($file in $htmlFiles) {
  $relative = Get-RelativeDisplayPath $file.FullName
  $html = [System.IO.File]::ReadAllText($file.FullName, [System.Text.UTF8Encoding]::new($false))

  if ($html -notmatch "(?i)<!doctype html>") {
    Add-ValidationError ("{0}: missing HTML5 doctype" -f $relative)
  }
  if ($html -notmatch "(?i)<html[^>]+lang=") {
    Add-ValidationError ("{0}: missing html lang" -f $relative)
  }
  if ($html -notmatch "(?i)data-language-option=""en""" -or $html -notmatch "(?i)data-language-option=""zh-CN""") {
    Add-ValidationError ("{0}: missing top English/Chinese language options" -f $relative)
  }
  if ($html -notmatch "(?i)hreflang=""x-default""") {
    Add-ValidationError ("{0}: missing x-default hreflang" -f $relative)
  }
  if ($html -notmatch "(?i)(?:src=""(?:\.\./)?assets/i18n\.js""|src=""assets/i18n\.js"")") {
    Add-ValidationError ("{0}: missing shared locale router" -f $relative)
  }
  if (([regex]::Matches($html, "(?i)<h1\b")).Count -ne 1) {
    Add-ValidationError ("{0}: expected exactly one h1" -f $relative)
  }
  if (([regex]::Matches($html, "(?i)<main\b")).Count -ne 1) {
    Add-ValidationError ("{0}: expected exactly one main" -f $relative)
  }

  $ids = [regex]::Matches($html, "\bid=""([^""]+)""") | ForEach-Object { $_.Groups[1].Value }
  $duplicateIds = $ids | Group-Object | Where-Object { $_.Count -gt 1 }
  foreach ($duplicate in $duplicateIds) {
    Add-ValidationError ("{0}: duplicate id '{1}'" -f $relative, $duplicate.Name)
  }
  $idSet = @{}
  foreach ($id in $ids) { $idSet[$id] = $true }

  foreach ($match in [regex]::Matches($html, "href=""#([^""]+)""")) {
    $target = $match.Groups[1].Value
    if (-not $idSet.ContainsKey($target)) {
      Add-ValidationError ("{0}: missing internal target '#{1}'" -f $relative, $target)
    }
  }

  foreach ($match in [regex]::Matches($html, "(?:href|src)=""([^""]+)""")) {
    $reference = $match.Groups[1].Value
    if ($reference -match "^(?:https?:|mailto:|tel:|data:|#)") { continue }
    $cleanReference = ($reference -split "[?#]", 2)[0]
    if ([string]::IsNullOrWhiteSpace($cleanReference)) { continue }
    $resolved = [System.IO.Path]::GetFullPath((Join-Path $file.DirectoryName $cleanReference))
    if (-not (Test-Path -LiteralPath $resolved)) {
      Add-ValidationError ("{0}: missing local asset '{1}'" -f $relative, $reference)
    }
  }

  foreach ($match in [regex]::Matches($html, "href=""(https?://[^""]+)""")) {
    $uri = $null
    if (-not [System.Uri]::TryCreate($match.Groups[1].Value, [System.UriKind]::Absolute, [ref]$uri)) {
      Add-ValidationError ("{0}: malformed URL '{1}'" -f $relative, $match.Groups[1].Value)
    }
  }
}

$markdownFiles = @($textFiles | Where-Object { $_.Extension -eq ".md" })
foreach ($file in $markdownFiles) {
  $relative = Get-RelativeDisplayPath $file.FullName
  $markdown = [System.IO.File]::ReadAllText($file.FullName, [System.Text.UTF8Encoding]::new($false))
  foreach ($match in [regex]::Matches($markdown, "\[[^\]]*\]\(([^)]+)\)")) {
    $reference = $match.Groups[1].Value.Trim().Trim("<", ">")
    if ($reference -match "^(?:https?:|mailto:|tel:|data:|#)") { continue }
    $cleanReference = ($reference -split "[?#]", 2)[0]
    if ([string]::IsNullOrWhiteSpace($cleanReference)) { continue }
    $resolved = [System.IO.Path]::GetFullPath((Join-Path $file.DirectoryName $cleanReference))
    if (-not (Test-Path -LiteralPath $resolved)) {
      Add-ValidationError ("{0}: missing local Markdown target '{1}'" -f $relative, $reference)
    }
  }
}

$canonicalFiles = @($htmlFiles | Where-Object { $_.Name -eq "index.html" })
foreach ($englishFile in $canonicalFiles) {
  $englishRelative = Get-RelativeDisplayPath $englishFile.FullName
  $chinesePath = Join-Path $englishFile.DirectoryName "index.zh-CN.html"
  if (-not (Test-Path -LiteralPath $chinesePath -PathType Leaf)) {
    Add-ValidationError ("{0}: missing Simplified-Chinese counterpart" -f $englishRelative)
    continue
  }

  $englishHtml = [System.IO.File]::ReadAllText($englishFile.FullName, [System.Text.UTF8Encoding]::new($false))
  $chineseHtml = [System.IO.File]::ReadAllText($chinesePath, [System.Text.UTF8Encoding]::new($false))
  $chineseRelative = Get-RelativeDisplayPath $chinesePath

  if ($englishHtml -notmatch "(?i)<html[^>]+lang=""en""") {
    Add-ValidationError ("{0}: canonical page must use lang='en'" -f $englishRelative)
  }
  if ($englishHtml -notmatch "(?i)data-language-auto=""true""") {
    Add-ValidationError ("{0}: canonical page must enable locale auto-detection" -f $englishRelative)
  }
  if ($chineseHtml -notmatch "(?i)<html[^>]+lang=""zh-CN""") {
    Add-ValidationError ("{0}: Chinese counterpart must use lang='zh-CN'" -f $chineseRelative)
  }

  $englishIds = @([regex]::Matches($englishHtml, "\bid=""([^""]+)""") | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
  $chineseIds = @([regex]::Matches($chineseHtml, "\bid=""([^""]+)""") | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
  if (@(Compare-Object $englishIds $chineseIds).Count -gt 0) {
    Add-ValidationError ("{0} and {1}: element ID sets differ" -f $englishRelative, $chineseRelative)
  }

  $englishUrls = @([regex]::Matches($englishHtml, "href=""(https?://[^""]+)""") | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
  $chineseUrls = @([regex]::Matches($chineseHtml, "href=""(https?://[^""]+)""") | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
  if (@(Compare-Object $englishUrls $chineseUrls).Count -gt 0) {
    Add-ValidationError ("{0} and {1}: external source-link sets differ" -f $englishRelative, $chineseRelative)
  }

  $englishVersion = [regex]::Match($englishHtml, "data-system-version=""([^""]+)""").Groups[1].Value
  $chineseVersion = [regex]::Match($chineseHtml, "data-system-version=""([^""]+)""").Groups[1].Value
  if ([string]::IsNullOrWhiteSpace($englishVersion) -or $englishVersion -ne $chineseVersion) {
    Add-ValidationError ("{0} and {1}: visual-system versions differ" -f $englishRelative, $chineseRelative)
  }
}

$node = Get-Command node -ErrorAction SilentlyContinue
if (-not $node) {
  Add-ValidationError "Node.js is required to syntax-check shared JavaScript."
} else {
  $jsFiles = @(
    Get-ChildItem -LiteralPath (Join-Path $repoRoot "assets") -Filter *.js -File
    Get-Item -LiteralPath (Join-Path $repoRoot "scripts/Smoke-ResearchSite.cjs")
  )
  foreach ($file in $jsFiles) {
    & $node.Source --check $file.FullName
    if ($LASTEXITCODE -ne 0) {
      Add-ValidationError "JavaScript syntax check failed: $(Get-RelativeDisplayPath $file.FullName)"
    }
  }
}

if ($errors.Count -gt 0) {
  Write-Host "Research site validation failed with $($errors.Count) issue(s):" -ForegroundColor Red
  foreach ($errorMessage in $errors) {
    Write-Host " - $errorMessage" -ForegroundColor Red
  }
  exit 1
}

Write-Host "Research site validation passed." -ForegroundColor Green
Write-Host "Checked $(@($htmlFiles).Count) bilingual HTML page(s), locale pairs, and shared JavaScript syntax."

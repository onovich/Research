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
  "README.md",
  "index.html",
  "assets/research.css",
  "assets/research.js",
  "docs/research-to-html-workflow.md",
  "docs/visual-system.md",
  "research-template/README.md",
  "research-template/index.html",
  "crowdfunding-and-indie-games-research/README.md",
  "crowdfunding-and-indie-games-research/index.html"
)

foreach ($relativePath in $requiredFiles) {
  $fullPath = Join-Path $repoRoot $relativePath
  if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
    Add-ValidationError "Missing required file: $relativePath"
  }
}

$validationRoots = @(
  "README.md",
  "index.html",
  "assets",
  "docs/research-to-html-workflow.md",
  "docs/visual-system.md",
  "docs/codex-git-workflow.md",
  "research-template",
  "crowdfunding-and-indie-games-research",
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
      Where-Object { $_.Extension -in @(".html", ".css", ".js", ".md", ".json", ".ps1") } |
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

$htmlFiles = @($textFiles | Where-Object { $_.Name -eq "index.html" })

foreach ($file in $htmlFiles) {
  $relative = Get-RelativeDisplayPath $file.FullName
  $html = [System.IO.File]::ReadAllText($file.FullName, [System.Text.UTF8Encoding]::new($false))

  if ($html -notmatch "(?i)<!doctype html>") {
    Add-ValidationError ("{0}: missing HTML5 doctype" -f $relative)
  }
  if ($html -notmatch "(?i)<html[^>]+lang=") {
    Add-ValidationError ("{0}: missing html lang" -f $relative)
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

$node = Get-Command node -ErrorAction SilentlyContinue
if (-not $node) {
  Add-ValidationError "Node.js is required to syntax-check shared JavaScript."
} else {
  $jsFiles = Get-ChildItem -LiteralPath (Join-Path $repoRoot "assets") -Filter *.js -File
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
Write-Host "Checked $(@($htmlFiles).Count) HTML page(s) and shared JavaScript syntax."

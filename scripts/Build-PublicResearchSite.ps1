[CmdletBinding()]
param(
  [string]$OutputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = [System.IO.Path]::GetFullPath((Split-Path -Parent $scriptDir))
$manifestPath = Join-Path $repoRoot "public-site.json"

if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
  throw "Missing public-site.json. The Pages artifact must be built from an explicit allowlist."
}

$manifest = Get-Content -LiteralPath $manifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
if ($manifest.version -notin @(1, 2) -or -not $manifest.files -or $manifest.files.Count -eq 0) {
  throw "public-site.json is missing a supported version or a non-empty files list."
}

$sourceSetting = if ($manifest.PSObject.Properties.Name -contains "source" -and -not [string]::IsNullOrWhiteSpace([string]$manifest.source)) {
  [string]$manifest.source
} else {
  "."
}

$sourceRoot = if ([System.IO.Path]::IsPathRooted($sourceSetting)) {
  [System.IO.Path]::GetFullPath($sourceSetting)
} else {
  [System.IO.Path]::GetFullPath((Join-Path $repoRoot $sourceSetting))
}

if ([string]::IsNullOrWhiteSpace($OutputPath)) {
  $OutputPath = [string]$manifest.output
}

$outputRoot = if ([System.IO.Path]::IsPathRooted($OutputPath)) {
  [System.IO.Path]::GetFullPath($OutputPath)
} else {
  [System.IO.Path]::GetFullPath((Join-Path $repoRoot $OutputPath))
}

$repoPrefix = $repoRoot.TrimEnd([System.IO.Path]::DirectorySeparatorChar) + [System.IO.Path]::DirectorySeparatorChar
if ($outputRoot -eq $repoRoot -or -not $outputRoot.StartsWith($repoPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
  throw "Refusing to build outside the repository or into its root: $outputRoot"
}
if ($sourceRoot -ne $repoRoot -and -not $sourceRoot.StartsWith($repoPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
  throw "Public source directory must stay inside the repository: $sourceRoot"
}
if (-not (Test-Path -LiteralPath $sourceRoot -PathType Container)) {
  throw "Missing public source directory: $sourceSetting"
}
if ($outputRoot -eq $sourceRoot) {
  throw "Public source and output directories must be different: $outputRoot"
}

$sourcePrefix = $sourceRoot.TrimEnd([System.IO.Path]::DirectorySeparatorChar) + [System.IO.Path]::DirectorySeparatorChar

$seen = New-Object System.Collections.Generic.HashSet[string]([System.StringComparer]::OrdinalIgnoreCase)
$resolvedFiles = New-Object System.Collections.Generic.List[object]

foreach ($entryValue in $manifest.files) {
  $entry = ([string]$entryValue).Replace("\", "/").TrimStart("/")
  if ([string]::IsNullOrWhiteSpace($entry) -or $entry -match "(^|/)\.\.(/|$)" -or [System.IO.Path]::IsPathRooted($entry)) {
    throw "Unsafe public manifest entry: $entryValue"
  }
  if (-not $seen.Add($entry)) {
    throw "Duplicate public manifest entry: $entry"
  }

  $source = [System.IO.Path]::GetFullPath((Join-Path $sourceRoot $entry))
  if (-not $source.StartsWith($sourcePrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Public manifest entry escapes the source directory: $entry"
  }
  if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
    throw "Missing public file: $entry"
  }

  $resolvedFiles.Add([pscustomobject]@{ Entry = $entry; Source = $source })
}

if (Test-Path -LiteralPath $outputRoot) {
  Remove-Item -LiteralPath $outputRoot -Recurse -Force
}
New-Item -ItemType Directory -Path $outputRoot | Out-Null

foreach ($file in $resolvedFiles) {
  $destination = Join-Path $outputRoot $file.Entry
  $destinationDirectory = Split-Path -Parent $destination
  if (-not (Test-Path -LiteralPath $destinationDirectory)) {
    New-Item -ItemType Directory -Path $destinationDirectory -Force | Out-Null
  }
  Copy-Item -LiteralPath $file.Source -Destination $destination
}

[System.IO.File]::WriteAllText((Join-Path $outputRoot ".nojekyll"), "", [System.Text.UTF8Encoding]::new($false))

Write-Host "Built public research site from $($resolvedFiles.Count) allowlisted files in ${sourceSetting}: $outputRoot" -ForegroundColor Green

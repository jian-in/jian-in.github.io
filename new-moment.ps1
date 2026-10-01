# 发一条动态：追加到 data/moments.yaml
# 用法：
#   ./new-moment.ps1 "今天想说的话"
#   ./new-moment.ps1 "配图的一句话" -Image "https://...r2.dev/xxx.jpg" -Mood "晴"
param(
  [Parameter(Mandatory = $true, Position = 0)][string]$Text,
  [string]$Image,
  [string]$Mood
)

$ErrorActionPreference = 'Stop'
$file = Join-Path $PSScriptRoot 'data/moments.yaml'

# YAML 双引号字符串：转义反斜杠和双引号，换行写成 \n
function Quote([string]$s) {
  '"' + ($s -replace '\\', '\\' -replace '"', '\"' -replace "`r?`n", '\n') + '"'
}

$entry = @("", "- date: $(Quote (Get-Date -Format 'yyyy-MM-ddTHH:mm:sszzz'))", "  text: $(Quote $Text)")
if ($Image) { $entry += "  image: $(Quote $Image)" }
if ($Mood)  { $entry += "  mood: $(Quote $Mood)" }

$utf8 = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::AppendAllText($file, ($entry -join "`n") + "`n", $utf8)

Write-Host "已添加到 data/moments.yaml："
$entry | Select-Object -Skip 1 | ForEach-Object { Write-Host "  $_" }
Write-Host "本地预览 hugo server，确认后提交推送即可发布。"

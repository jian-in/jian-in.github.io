# Forgiving Blog - 简化版部署脚本
# 现在使用 GitHub Actions 自动部署，这个脚本仅用于本地测试

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$env:PYTHONIOENCODING='utf-8'

Write-Host "=== Forgiving Blog 本地构建 ===" -ForegroundColor Cyan

$blogDir = 'c:\Users\jianbo\Desktop\my-blog'
Set-Location $blogDir
$env:TEMP='c:\Users\jianbo\hugo-cache'
$env:TMP='c:\Users\jianbo\hugo-cache'

# 1. 构建 Hugo
Write-Host "`n[1/2] 构建 Hugo..." -ForegroundColor Yellow
& hugo --minify 2>&1 | Select-String -Pattern 'Pages|Built|error'

# 2. 启动本地服务器
Write-Host "[2/2] 启动本地预览服务器..." -ForegroundColor Yellow
Write-Host "`n✅ 本地预览地址: http://localhost:1313" -ForegroundColor Green
Write-Host "按 Ctrl+C 停止服务器`n" -ForegroundColor Gray
& hugo server -D

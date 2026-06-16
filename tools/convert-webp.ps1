$cwebpPath = Join-Path $PSScriptRoot "webp\libwebp-1.4.0-windows-x64\bin\cwebp.exe"
$imgDir = Join-Path $PSScriptRoot "..\assets\img"

if (-not (Test-Path $cwebpPath)) {
    Write-Error "cwebp not found at: $cwebpPath"
    exit 1
}

$images = Get-ChildItem -Path $imgDir -Include "*.jpg","*.jpeg","*.png" -Recurse

foreach ($img in $images) {
    $webpPath = $img.FullName -replace '\.(jpg|jpeg|png)$', '.webp'
    
    if (Test-Path $webpPath) {
        Write-Host "Skipping (exists): $($img.Name)"
        continue
    }
    
    Write-Host "Converting: $($img.Name) -> $($img.BaseName).webp"
    
    & $cwebpPath -q 80 "$($img.FullName)" -o "$webpPath"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Success: $($img.Name)" -ForegroundColor Green
    } else {
        Write-Host "Failed: $($img.Name)" -ForegroundColor Red
    }
}

Write-Host "`nConversion complete!" -ForegroundColor Cyan
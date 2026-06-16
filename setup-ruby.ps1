# PowerShell Profile for Ruby/Jekyll Development
# Add this to your $PROFILE file: $env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

# Ruby 3.4.9 installed to user directory
$env:Path = "$env:USERPROFILE\Ruby34\bin;$env:Path"

# Set gem home to user directory (avoid permission issues)
$env:GEM_HOME = "$env:USERPROFILE\.gem"
$env:GEM_PATH = "$env:USERPROFILE\.gem"
$env:Path = "$env:GEM_HOME\bin;$env:Path"

# Show version on shell start
Write-Host "Ruby: $(ruby --version 2>$null)" -ForegroundColor Green
Write-Host "Jekyll: $(jekyll --version 2>$null)" -ForegroundColor Green
Write-Host "Bundler: $(bundler --version 2>$null)" -ForegroundColor Green

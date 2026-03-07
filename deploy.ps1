$sourcePath = $PSScriptRoot
$modName = "FS25_AnalyticFarmingPack"
$gamePath = "$HOME/Documents/My Games/FarmingSimulator2025"
$modDest = "$gamePath/mods/$modName"
$logFile = "$gamePath/log.txt"

Write-Host "--- Priprava modu ---" -ForegroundColor Cyan

# 1. Odstraníme starý mod, pokud existuje
if (Test-Path $modDest) { 
    Remove-Item -Recurse -Force $modDest 
}

# 2. ZKOPÍRUJEME CELOU SLOŽKU PROJEKTU NAJEDNOU
# Tímto se zaručeně přenese i složka l10n se vším všudy
Copy-Item -Path "$sourcePath" -Destination $modDest -Recurse -Force

# 3. VYČISTÍME CÍLOVOU SLOŽKU OD SMETÍ
# Smažeme věci, které ve hře nechceme (git, vscode, skripty)
$trash = @(".git", ".vscode", "deploy.ps1", ".gitignore")
foreach ($item in $trash) {
    $pathToRemove = Join-Path $modDest $item
    if (Test-Path $pathToRemove) {
        Remove-Item -Recurse -Force $pathToRemove
    }
}

Write-Host "--- Struktura i se slozkou l10n je nyni v: $modDest ---" -ForegroundColor White

# 4. Cisteni logu
Write-Host "--- Cisteni logu ---" -ForegroundColor Yellow
if (Test-Path $logFile) { 
    Remove-Item $logFile -ErrorAction SilentlyContinue 
}

# 5. Start hry (Opravil jsem ti ID na 2301650 pro plnou verzi)
Write-Host "--- Spoustim Farming Simulator 25 ---" -ForegroundColor Green
Start-Process "steam://rungameid/2300320"
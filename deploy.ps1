# Nastavení kódování pro správné zobrazení diakritiky v terminálu
[System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# --- Konfigurace ---
$modName = "FS25_AnalyticFarmingPack"
$gameModsPath = "$HOME/Documents/My Games/FarmingSimulator2025/mods"
$steamAppId = "2300320" # ID pro spuštění hry (upraveno dle uživatele)

# --- Cesty ---
$sourcePath = $PSScriptRoot
$destinationPath = Join-Path $gameModsPath $modName
$logFile = "$HOME/Documents/My Games/FarmingSimulator2025/log.txt"

# --- Seznam souborů a složek modu ---
# Zde definujeme, co patří do modu. Vše ostatní bude ignorováno.
$modFiles = @(
    "modDesc.xml",
    "icon.dds",
    "AnalyticMain.lua",
    "l10n" # Celá složka
    # "icon.png" # Příklad: odkomentuj, až budeš mít ikonu
)

# --- Průběh skriptu ---
Write-Host "--- Startuji nasazení modu: $modName ---" -ForegroundColor Cyan

# 1. Příprava cílové složky
Write-Host "1. Čistím a připravuji cílovou složku: $destinationPath"
if (Test-Path $destinationPath) {
    Remove-Item -Recurse -Force $destinationPath
}
New-Item -ItemType Directory -Path $destinationPath | Out-Null

# 2. Kopírování souborů modu
Write-Host "2. Kopíruji pouze potřebné soubory modu..."
foreach ($item in $modFiles) {
    $itemPath = Join-Path $sourcePath $item
    if (Test-Path $itemPath) {
        Write-Host "   - Kopíruji: $item"
        Copy-Item -Path $itemPath -Destination $destinationPath -Recurse
    } else {
        Write-Host "   - POZOR: Soubor/složka '$item' nenalezen, přeskakuji." -ForegroundColor Yellow
    }
}
Write-Host "Kopírování dokončeno." -ForegroundColor Green

# 3. Čištění logu (volitelné)
Write-Host "3. Čistím starý log soubor."
if (Test-Path $logFile) {
    Remove-Item $logFile -ErrorAction SilentlyContinue
}

# 4. Spuštění hry
Write-Host "4. Spouštím Farming Simulator 25 (ID: $steamAppId)..."
Start-Process "steam://rungameid/$steamAppId"

Write-Host "--- Nasazení dokončeno. Přeji příjemné testování! ---" -ForegroundColor Cyan

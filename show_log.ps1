# Nastavení kódování
[System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

# Cesta k log souboru
$logFile = "$HOME/Documents/My Games/FarmingSimulator2025/log.txt"
# Název tvého modu pro filtraci (musí odpovídat tvému AnalyticMain.name)
$modName = "AnalyticFarmingPack"

Write-Host "--- Sleduji log.txt (Filtr: $modName a Error) ---" -ForegroundColor Cyan
Write-Host "Stiskni Ctrl+C pro ukončení sledování." -ForegroundColor Yellow

if (Test-Path $logFile) {
    # Sleduje soubor v reálném čase (-Wait)
    # Vypisuje jen řádky obsahující tvůj mod NEBO Error
    Get-Content $logFile -Tail 20 -Wait | Select-String -Pattern "$modName", "Error"
} else {
    Write-Host "Soubor log.txt nebyl nalezen na cestě: $logFile" -ForegroundColor Red
}
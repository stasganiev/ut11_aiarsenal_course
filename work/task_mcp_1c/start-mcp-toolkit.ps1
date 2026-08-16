# Запуск базы УТ 11.5 с открытой обработкой MCP_Toolkit.epf
# После старта в форме обработки: режим "Встроенный сервер" -> "Запустить сервер"

$ErrorActionPreference = 'Stop'

$Exe  = 'C:\Program Files\1cv8\8.3.27.2074\bin\1cv8.exe'
$Base = 'C:\dev\bases1c\ut11aiarsenal_course'
$Epf  = Join-Path $PSScriptRoot 'bin\MCP_Toolkit.epf'
$User = 'Администратор (ФедоровБМ)'

foreach ($p in @($Exe, $Base, $Epf)) {
    if (-not (Test-Path $p)) { throw "Не найдено: $p" }
}

# Порт 6003 должен быть свободен, иначе встроенный сервер не поднимется
$busy = Get-NetTCPConnection -LocalPort 6003 -State Listen -ErrorAction SilentlyContinue
if ($busy) {
    Write-Warning 'Порт 6003 уже занят. Возможно, сервер уже запущен в другом сеансе 1С.'
}

$argList = @(
    'ENTERPRISE'
    "/F`"$Base`""
    "/N`"$User`""
    "/Execute`"$Epf`""
)

Write-Host 'Запуск 1С с обработкой MCP_Toolkit...' -ForegroundColor Cyan
Start-Process -FilePath $Exe -ArgumentList $argList

Write-Host ''
Write-Host 'Дальше в открывшейся форме обработки:' -ForegroundColor Yellow
Write-Host '  1. Режим -> "Встроенный сервер"'
Write-Host '  2. Задать токен доступа (любая строка)'
Write-Host '  3. "Запустить сервер"'
Write-Host ''
Write-Host 'Проверка готовности:  .\test-connection.ps1'

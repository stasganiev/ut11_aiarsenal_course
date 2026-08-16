# Проверка, что встроенный MCP-сервер в 1С отвечает.
# Запускать ПОСЛЕ нажатия "Запустить сервер" в форме обработки.

$Url = 'http://127.0.0.1:6003/mcp'

$listen = Get-NetTCPConnection -LocalPort 6003 -State Listen -ErrorAction SilentlyContinue
if (-not $listen) {
    Write-Host 'Порт 6003 не слушается.' -ForegroundColor Red
    Write-Host 'Обработка запущена? Нажата кнопка "Запустить сервер"?'
    exit 1
}
Write-Host 'Порт 6003 слушается.' -ForegroundColor Green

# MCP initialize по JSON-RPC
$body = @{
    jsonrpc = '2.0'
    id      = 1
    method  = 'initialize'
    params  = @{
        protocolVersion = '2024-11-05'
        capabilities    = @{}
        clientInfo      = @{ name = 'setup-check'; version = '1.0' }
    }
} | ConvertTo-Json -Depth 10

$headers = @{ 'Content-Type' = 'application/json'; 'Accept' = 'application/json, text/event-stream' }
if ($env:ONEC_TOOLKIT_TOKEN) {
    $headers['Authorization'] = "Bearer $env:ONEC_TOOLKIT_TOKEN"
    Write-Host 'Использую токен из $env:ONEC_TOOLKIT_TOKEN'
}

try {
    $resp = Invoke-WebRequest -Uri $Url -Method Post -Body $body -Headers $headers -UseBasicParsing -TimeoutSec 15
    Write-Host "HTTP $($resp.StatusCode) - сервер ответил." -ForegroundColor Green
    Write-Host $resp.Content
} catch {
    Write-Host 'Ошибка запроса:' -ForegroundColor Red
    Write-Host $_.Exception.Message
    if ($_.Exception.Response.StatusCode.value__ -eq 401) {
        Write-Host 'Похоже на токен. Задайте: $env:ONEC_TOOLKIT_TOKEN = "<токен из формы>"' -ForegroundColor Yellow
    }
    exit 1
}

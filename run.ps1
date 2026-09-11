# Arranca SearXNG con uvicorn en Windows (sin Docker).
#   .\run.ps1                 -> http://127.0.0.1:8888
#   .\run.ps1 -Port 8080
#   .\run.ps1 -Reload         -> recarga automática al editar código
param(
    [string]$BindHost = "127.0.0.1",
    [int]$Port = 8888,
    [switch]$Reload
)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$env:SEARXNG_SETTINGS_PATH = Join-Path $PSScriptRoot "local\settings.yml"

$uvicornArgs = @("asgi:app", "--host", $BindHost, "--port", $Port, "--proxy-headers")
if ($Reload) { $uvicornArgs += @("--reload", "--reload-dir", "searx", "--reload-dir", "local") }

& "$PSScriptRoot\.venv\Scripts\python.exe" -m uvicorn @uvicornArgs

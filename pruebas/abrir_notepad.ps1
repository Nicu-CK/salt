<#
.SYNOPSIS
  Lanza notepad.exe en la sesión RDP activa de un usuario como SYSTEM, volcándolo todo en un log.
.PARAMETER User
  Nombre de usuario RDP (solo para detectar la sesión).
.PARAMETER LogFile
  Ruta al fichero de log.
#>
param(
    [string]$User    = 'prueba',
    [string]$LogFile = 'C:\salt\logs\abrir_notepad.log'
)

# Asegura carpeta de logs
$logDir = Split-Path $LogFile
if (!(Test-Path $logDir)) { New-Item -Path $logDir -ItemType Directory | Out-Null }

function Log {
    param($msg)
    "$((Get-Date).ToString('s')) - $msg" | Out-File -FilePath $LogFile -Append
}

Log "=== INICIO abrir_notepad.ps1 ==="

try {
    # 1) Leer todas las sesiones
    $all = & 'C:\Windows\System32\quser.exe' 2>&1
    Log "Salida de quser:`n$all"

    # 2) Filtrar la línea del usuario activo
    $line = $all | Where-Object { $_ -match "^\s*$User\s" -and $_ -match 'Active' }
    if (-not $line) { throw "No hay sesión Active para '$User'" }
    Log "Línea filtrada de quser: $line"

    # 3) Extraer ID de sesión con regex
    if ($line -match '\s+(\d+)\s+Active') {
        $sessionId = $Matches[1]
    } else {
        throw "No pude extraer ID de sesión de: $line"
    }
    Log "ID de sesión detectada: $sessionId"

    # 4) Verificar PsExec
    $psexec = 'C:\Windows\System32\PsExec.exe'
    if (!(Test-Path $psexec)) { throw "No existe PsExec en $psexec" }
    Log "PsExec localizado en: $psexec"

    # 5) Ejecutar Notepad en la sesión como SYSTEM
    Log "Ejecutando PsExec con: -accepteula -i $sessionId -s -d notepad.exe"
    & $psexec -accepteula -i $sessionId -s -d notepad.exe
    $code = $LASTEXITCODE
    if ($code -ne 0) { throw "PsExec devolvió código $code" }
    Log "Notepad lanzado con éxito en sesión $sessionId como SYSTEM."

} catch {
    Log "ERROR: $($_.Exception.Message)"
    exit 1
}

Log "=== FIN abrir_notepad.ps1 ==="

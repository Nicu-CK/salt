# Comprobar si PsExec.exe está instalado en la ruta de System32
$psExecPath = "C:\Windows\System32\PsExec.exe"

if (-Not (Test-Path $psExecPath)) {
    Write-Host "PsExec no está instalado. Instalando..."

    # Descargar PsExec desde Sysinternals (si es necesario)
    $url = "https://download.sysinternals.com/files/PSTools.zip"
    $zipFile = "$env:TEMP\PSTools.zip"
    $extractFolder = "$env:TEMP\PSTools"

    # Descargar y extraer PsExec
    Invoke-WebRequest -Uri $url -OutFile $zipFile
    Expand-Archive -Path $zipFile -DestinationPath $extractFolder

    # Mover PsExec.exe a System32
    $psExecPath = Join-Path -Path $extractFolder -ChildPath "PsExec.exe"
    Move-Item -Path $psExecPath -Destination "C:\Windows\System32\PsExec.exe"
    Write-Host "PsExec instalado en C:\Windows\System32\PsExec.exe"
}


# Obtener el ID de sesión del usuario
$session = query user nicu | Select-String -Pattern '(\d+)\s+Activo' 
if ($session) {
    $session_id = $session.Matches[0].Groups[1].Value

    # Ejecutar mstsc en la sesión activa usando PsExec
    & PsExec.exe -accepteula -i $session_id -d mstsc.exe "C:\salt\scripts\mirdp.rdp"
}
else {
    Write-Host "No se encontró sesión activa para el usuario "
}

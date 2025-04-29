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
# Solicitar el nombre de usuario y contraseña del usuario que va a ejecutar el proceso
$userName = "prueba"  # Reemplazar con el nombre de usuario deseado
$password = ConvertTo-SecureString "Usuario!" -AsPlainText -Force

# Obtener el session_id
$session_id = (query user prueba | Select-String -Pattern '(\d+)\s+Active').Matches[0].Groups[1].Value

# Ejecutar PsExec con las credenciales del usuario especificado
Start-Process -FilePath "C:\Windows\System32\PsExec.exe" -ArgumentList "-accepteula", "-i", $session_id, "-u", $userName, "-p", $password, "-d", "notepad.exe"

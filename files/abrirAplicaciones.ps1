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
# Ruta al CSV
$csvPath = "C:\salt\scripts\datos.csv"

# Cargar los datos del CSV
$datos = Import-Csv -Path $csvPath

# Ruta a PsExec (ya estÃ¡ en System32, se puede invocar directamente)
$psexec = "PsExec.exe"

foreach ($fila in $datos) {
    if ($fila.ShouldRun -match "^(?i)yes|true$") {
        $usuario = $fila.UserName
        $password = $fila.Password
        $servidor = $fila.ServerName
        $programa = $fila.Path
        $argumentos = $fila.Arguments
        $workingDir = $fila.WorkingDirectory

        # Obtener la sesiÃ³n del usuario (asume que estÃ¡ conectada localmente)
        $sessionId = (query user $usuario | Select-String -Pattern '(\d+)\s+Active').Matches[0].Groups[1].Value
	write-host "$sessionId $usuario"

        if ($sessionId -ne $null) {
            Write-Host "Ejecutando para usuario $usuario en sesiÃ³n $sessionId : $programa $argumentos"

            # Construir comando completo
            $comando = "`"$programa`" $argumentos"

            # Ejecutar con PsExec como el propio usuario, en su sesiÃ³n grÃ¡fica
            Start-Process -FilePath $psexec -ArgumentList @(
                "-i", "$sessionId",
                "-u", "$usuario",
                "-p", "$password",
                "-w", "`"$workingDir`"",
                "$comando"
            ) -WindowStyle Hidden
        } else {
            Write-Warning "No se encontrÃ³ una sesiÃ³n activa para el usuario $usuario"
        }
    }
}

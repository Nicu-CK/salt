# Ruta del archivo CSV
$csvPath = "C:\salt\scripts\datos.csv"

# Leer datos del CSV
$datos = Import-Csv -Path $csvPath

# Nombre del servidor y contraseña comunes
# $servidorFijo = "10.34.1.98"
# $contrasenaFija = "12345678"

# Recorrer cada fila
foreach ($fila in $datos) {
    $usuario = $fila.UserName
    $shouldRun = $fila.ShouldRun
    $password = $fila.Password
    $domain = $fila.Environment
    $server = $fila.ServerName
    # Solo ejecutar si ShouldRun está en 'true' o 'yes'
    if ($shouldRun -match "^(?i)true|yes$") {
        Write-Host "Conectando a $usuario@$servidorFijo"

        # Guardar credenciales (esto almacena las credenciales para RDP)
        cmdkey /generic:"$server" /user:$usuario /pass:$password

        # Crear un archivo .rdp temporal
        $rdpPath = "$env:TEMP\$usuario.rdp"
        @"
full address:s:$server
username:s:$domain\$usuario
authentication level:i:2
prompt for credentials:i:0
enablecredsspsupport:i:1
"@ | Out-File -Encoding ASCII $rdpPath

        # Iniciar RDP
        Start-Process "mstsc.exe" -ArgumentList $rdpPath

        Start-Sleep -Seconds 3  # Esperar un poco entre conexiones
    }
}

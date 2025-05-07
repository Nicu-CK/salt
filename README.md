LinuxGroup ----> Archivo donde se guardaran los equipos Linux con sus credenciales para instalar salt-minion mediante salt-ssh.

InstallMinionLinux-----> SLS para la instalacion de del salt-minion.

zabbixlinux/win------> SLS para la instalacion de los agentes zabbix una vez que tengamos los minions preparados.

iniciarRdp------> SLS para iniciar las sesiones RDP que se requieran mediante el script /files/abrirRdp.ps1 y el archivo csv proporcionado.

iniciarAplicacion--------->SLS para inciar las aplicaciones una vez realizadas las conexiones RDP mediante el script /files/abrirAplicaciones.ps1 y el archivo csv proporcionado

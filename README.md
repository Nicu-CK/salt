# 🔧 SaltStack Automation for RDP and Minion Deployment

Este repositorio contiene un conjunto de scripts y estados SLS diseñados para automatizar:

- La instalación de agentes `salt-minion` y `zabbix` en equipos Linux y Windows.
- La conexión automática a sesiones RDP.
- La ejecución automática de aplicaciones gráficas tras la conexión RDP.

—
##  Uso del programa 
### Windows 
### Modo de funcionamiento

-Ejecutar el script apprdp.sh que deberia de estar en la carpeta de donde estan los programas de salt 

-Para modificar cualquiera los programas que se quieran iniciar se tiene que cambiar el archivo /files/datos.csv siguiendo su estructura


—
---

## 📂 Estructura Programa RDP

### 📄 `iniciarRdp.sls`
Estado SLS que inicia sesiones RDP necesarias usando el script `/files/abrirRdp.ps1` y un archivo CSV proporcionado.

### 📄 `iniciarAplicacion.sls`
Estado SLS para lanzar aplicaciones automáticamente tras la conexión RDP, mediante `/files/abrirAplicaciones.ps1` y el archivo CSV correspondiente.

### 🖥️ `apprdp.sh`
Script Bash que ejecuta en secuencia las conexiones RDP y la apertura de aplicaciones, combinando ambos SLS.

### 🐧 `minionLinux.sh`
Script Bash que añade automáticamente los hosts Linux desde un archivo CSV al `LinuxGroup.yml`.

### 📄 `/files/dato.csv`
Donde estan los datos de todas las aplicaciones que se quieran abrir en una maquina  

### 📄 `/files/abrirAplicaciones.ps1`
Programa ps1 que abre las aplicaciones que halla en el csv en un equipo como admin 

### 📄 `/files/abrirRdp.ps1`
Co0

—

## 📂 Estructura Instalación Minions Linux

### 📄 `LinuxGroup.yml`
Archivo donde se almacenan los equipos Linux junto con sus credenciales necesarias para instalar `salt-minion` mediante `salt-ssh`.

### 📄 `InstallMinionLinux.sls`
Estado SLS para la instalación automática del `salt-minion` en equipos Linux.

## 📂 Estructura Instalación Minions Linux

### 📄 `zabbixlinux.sls` / `zabbixwin.sls`
Estados SLS para instalar los agentes Zabbix en sistemas Linux o Windows, una vez configurados los minions.


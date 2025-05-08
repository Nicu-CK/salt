# 🔧 SaltStack Automation for RDP and Minion Deployment

Este repositorio contiene un conjunto de scripts y estados SLS diseñados para automatizar:

- La instalación de agentes `salt-minion` y `zabbix` en equipos Linux y Windows.
- La conexión automática a sesiones RDP.
- La ejecución automática de aplicaciones gráficas tras la conexión RDP.

---
##  Uso del programa 
### Windows 
### Modo de funcionamiento

-Ejecutar el script `apprdp.sh` que deberia de estar en la carpeta de donde estan los programas de salt . Hace falta que estén los minions en los equipos instalados y conectados al master para que funcione.

-Para modificar cualquiera los programas que se quieran iniciar se tiene que cambiar el archivo /files/datos.csv siguiendo su estructura

---

## 📂 Estructura Programa RDP

### 📄 `iniciarRdp.sls`
Estado SLS que inicia sesiones RDP necesarias usando el script `/files/abrirRdp.ps1` y un archivo CSV proporcionado.

### 📄 `iniciarAplicacion.sls`
Estado SLS para lanzar aplicaciones automáticamente tras la conexión RDP, mediante `/files/abrirAplicaciones.ps1` y el archivo CSV correspondiente.

### 🖥️ `apprdp.sh`
Script Bash que ejecuta en secuencia las conexiones RDP y la apertura de aplicaciones, combinando ambos SLS.


### 📄 `/files/dato.csv`
Donde estan los datos de todas las aplicaciones que se quieran abrir en una máquina  

### 📄 `/files/abrirAplicaciones.ps1`
Programa ps1 que abre las aplicaciones que halla en el csv en un equipo como admin 

### 📄 `/files/abrirRdp.ps1`
Con el archivo csv se abren todas la conexiones rdp desde un equipo externo (admin) al servidor para abrir los usuarios activos necesarios para el funcionamiento de las aplicaciones 

---

# 🔧 Instalar minion salt con salt ssh y csv

Para la instalación de los minions tenemos un csv en `/files/hostsLinux.csv` en el que estarán los equipos a los que se le quiera instalar el minion de salt , y solo hay que ejecutar `minionLinux.sh` (Si el archivo `LinuxGroup.yml` no existe se crea solo)

## 📂 Estructura Instalación Minions Linux

### 🐧 `minionLinux.sh`
Script Bash que añade automáticamente los hosts Linux desde un archivo CSV al `LinuxGroup.yml`. 

### 📄 `LinuxGroup.yml`
Archivo donde se almacenan los equipos Linux junto con sus credenciales necesarias para instalar `salt-minion` mediante `salt-ssh`.

### 📄 `InstallMinionLinux.sls`
Estado SLS para la instalación automática del `salt-minion` en equipos Linux.

### 📄 `InstallMinionLinux.sls`
Estado SLS para la instalación automática del `salt-minion` en equipos Linux.

---

# 🔧 Instalar zabbix con salt

Para instalar zabbix con salt solo hay que ejecutar `zabbixlinux.sls`(Hecho para sistemas Debian, modificar para otra distro) o `zabbixwin.sls` dependiendo si es la para linux o windows con el nombre de la máquina a la que se le quiera aplicar 

## 📂 Estructura Instalación Minions Linux

### 📄 `zabbixlinux.sls` / `zabbixwin.sls`
Estados SLS para instalar los agentes Zabbix en sistemas Linux o Windows, una vez configurados los minions.


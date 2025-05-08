# 🔧 Automatización con SaltStack: RDP y Despliegue de Minions

Este repositorio contiene scripts y estados SLS diseñados para automatizar:

- La instalación de los agentes `salt-minion` y `zabbix` en sistemas Linux y Windows.
- La conexión automática a sesiones RDP.
- La ejecución de aplicaciones gráficas tras la conexión RDP.

> ⚠️ **Importante**: Los archivos `.sls` deben colocarse en el directorio `/srv/salt`, que es la ubicación por defecto utilizada por SaltStack. Si deseas usar otro directorio, recuerda modificar los scripts `.sh` y especificar la nueva ruta.

---

## 🚀 Uso del Programa

### 🪟 Windows – Automatización de RDP y Aplicaciones

#### 🔄 Funcionamiento

1. Ejecuta el script `apprdp.sh` desde el directorio donde se encuentran los programas de Salt.
2. Asegúrate de que los minions estén instalados en los equipos y conectados al master.
3. Para definir qué aplicaciones se abrirán automáticamente, edita el archivo `/files/datos.csv` siguiendo su estructura.

---

## 📁 Estructura del Proyecto

### 📂 Automatización RDP

- **`iniciarRdp.sls`**  
  Ejecuta sesiones RDP usando el script PowerShell `abrirRdp.ps1` y un archivo CSV de configuración.

- **`iniciarAplicacion.sls`**  
  Lanza automáticamente aplicaciones gráficas tras conectarse por RDP, utilizando `abrirAplicaciones.ps1`.

- **`apprdp.sh`**  
  Script Bash que ejecuta ambos estados SLS en secuencia: conexión RDP y apertura de aplicaciones.

- **`/files/datos.csv`**  
  Archivo CSV con los datos de las máquinas y aplicaciones a iniciar.

- **`/files/abrirRdp.ps1`**  
  Script PowerShell que, a partir del CSV, abre sesiones RDP desde una máquina administrativa externa.

- **`/files/abrirAplicaciones.ps1`**  
  Script PowerShell que abre las aplicaciones definidas en el CSV como administrador en la máquina destino.

---

## 🧩 Instalación de Minions Salt (Linux)

### 📦 Instalación vía `salt-ssh` y CSV

- Utiliza el archivo `/files/hostsLinux.csv` para definir los equipos donde instalar `salt-minion`.
- Ejecuta el script `minionLinux.sh`. Si no existe `LinuxGroup.yml`, se generará automáticamente.

### 📁 Archivos Relevantes

- **`minionLinux.sh`**  
  Script que agrega los hosts definidos en el CSV a `LinuxGroup.yml` y lanza la instalación del minion.

- **`LinuxGroup.yml`**  
  Contiene la lista de hosts Linux y sus credenciales para realizar la instalación por `salt-ssh`.

- **`InstallMinionLinux.sls`**  
  Estado SLS para la instalación automatizada del agente `salt-minion` en sistemas Linux.

---

## 📡 Instalación de Agentes Zabbix

### ⚙️ Estados SLS para Zabbix

- Ejecuta `zabbixlinux.sls` (para sistemas Debian) o `zabbixwin.sls` (para Windows), indicando el ID del minion destino.

### 📁 Archivos Relevantes

- **`zabbixlinux.sls`** / **`zabbixwin.sls`**  
  Estados SLS que instalan los agentes Zabbix en sistemas Linux o Windows. *Nota: el archivo para Linux está diseñado para distribuciones basadas en Debian. Modifícalo según tu distribución si es necesario.*

---

¿Quieres que también cree una tabla resumen con los scripts y su función?



# Paso1 descargar zabbix desde el repositorio

zabbix_repo_package:
  cmd.run:
    - name: wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.0+ubuntu22.04_all.deb
    - creates: /tmp/zabbix-release_latest_7.0+ubuntu22.04_all.deb

zabbix_repo_install:
  cmd.run:
    - name: dpkg -i zabbix-release_latest_7.0+ubuntu22.04_all.deb
    - require:
      - cmd: zabbix_repo_package

apt_update:
  cmd.run:
    - name: apt update
    - require:
      - cmd: zabbix_repo_install

# Paso2 Instalar el paquete de zabbix

zabbix_agent2_package:
  pkg.installed:
    - name: zabbix-agent2
    - require:
      - cmd: apt_update

# Paso3 Configurar los archivos para conectar con Server

set_zabbix_server:
  file.replace:
    - name: /etc/zabbix/zabbix_agent2.conf
    - pattern: '^Server=.*'
    - repl: 'Server=10.34.1.90'

set_zabbix_serveractive:
  file.replace:
    - name: /etc/zabbix/zabbix_agent2.conf
    - pattern: '^ServerActive=.*'
    - repl: 'ServerActive=10.34.1.90'

set_zabbix_hostname:
  file.replace:
    - name: /etc/zabbix/zabbix_agent2.conf
    - pattern: '^Hostname=.*'
    - repl: 'Hostname={{ grains["id"] }}'

# Paso4 Instalar plugins si hiciera falta

zabbix_agent2_plugins1:
  pkg.installed:
    - name: zabbix-agent2-plugin-mongodb

zabbix_agent2_plugins2:
  pkg.installed:
    - name: zabbix-agent2-plugin-mssql

zabbix_agent2_plugins3:
  pkg.installed:
    - name: zabbix-agent2-plugin-postgresql

# Paso5 Reiniciar y habilitar servicio

zabbix_agent2_service_restart:
  cmd.run:
    - name: systemctl restart zabbix-agent2

zabbix_agent2_service_enable:
  cmd.run:
    - name: systemctl enable zabbix-agent2
    - require:
      - cmd: zabbix_agent2_service_restart

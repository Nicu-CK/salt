zabbix_agent2_package:
  pkg.installed:
    - name: zabbix-agent2
set_zabbix_server:
  file.replace:
    - name: /etc/zabbix/zabbix_agent2.conf
    - pattern: '^Server=127\.0\.0\.1'
    - repl: 'Server={{ salt['grains.get']('master') }}'  # O usa una IP fija si lo prefieres

set_zabbix_serveractive:
  file.replace:
    - name: /etc/zabbix/zabbix_agent2.conf
    - pattern: '^ServerActive=127\.0\.0\.1'
    - repl: 'ServerActive={{ salt['grains.get']('master') }}'

zabbix_agent2_service:
  service.running:
    - name: zabbix-agent2
    - enable: true
    - watch:
      - pkg: zabbix_agent2_package

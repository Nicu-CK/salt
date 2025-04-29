zabbix_agent_package:
  pkg.installed:
    - name: zabbix-agent
set_zabbix_server:
  file.replace:
    - name: /etc/zabbix/zabbix_agentd.conf
    - pattern: '^Server=127\.0\.0\.1'
    - repl: 'Server={{ salt['grains.get']('master') }}'  # O usa una IP fija si lo prefieres

set_zabbix_serveractive:
  file.replace:
    - name: /etc/zabbix/zabbix_agentd.conf
    - pattern: '^ServerActive=127\.0\.0\.1'
    - repl: 'ServerActive={{ salt['grains.get']('master') }}'

zabbix_agent_service:
  service.running:
    - name: zabbix-agent
    - enable: true
    - watch:
      - pkg: zabbix_agent_package

zabbix_agent_instalador:
  file.managed:
    - name: C:\zabbix_agent.msi
    - source: salt://files/zabbix_agent2-7.0.11-windows-amd64-openssl.msi

zabbix_plugins_instalador:
  file.managed:
    - name: C:\zabbix_plugins.msi
    - source: salt://files/zabbix_agent2_plugins-7.0.11-windows-amd64.msi

zabbix_agent_instalacion:
  cmd.run:
    - name: >-
        msiexec /i C:\zabbix_agent.msi /qn ^
        SERVER=10.34.1.90 ^
        HOSTNAME={{ grains['id'] }} ^
        INSTALLFOLDER="C:\Program Files\Zabbix Agent"
    - shell: cmd
    - require:
      - file: zabbix_agent_instalador

zabbix_plugins_instalacion:
  cmd.run:
    - name: >-
        msiexec /i C:\zabbix_plugins.msi /qn
    - shell: cmd
    - require:
      - cmd: zabbix_agent_instalacion
      - file: zabbix_plugins_instalador

zabbix_agent_service:
  service.running:
    - name: Zabbix Agent 2
    - enable: True
    - require:
      - cmd: zabbix_plugins_instalacion

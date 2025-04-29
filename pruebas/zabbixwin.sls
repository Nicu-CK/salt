zabbix_agent_instalador:
  file.managed:
    - name: C:\zabbix_agent.msi  # Nombre simplificado
    - source: salt://files/zabbix_agent-7.2.5-windows-amd64-openssl.msi

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

zabbix_agent_service:
  service.running:
    - name: Zabbix Agent
    - require:
      - cmd: zabbix_agent_instalacion

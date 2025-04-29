{% set minion = salt['pillar.get']('minion_id') %}
{% set grains = salt['salt.execute'](minion, 'grains.items') %}
{% set os_family = grains[minion]['os_family'] %}

deploy_zabbix:
  salt.state:
    - tgt: {{ minion }}
    - sls:
      - zabbix_windows if os_family == 'Windows' else 'zabbix_linux'

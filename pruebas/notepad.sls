{% set script = 'C:\\salt\\scripts\\abrir_notepad.ps1' %}
{% set logdir = 'C:\\salt\\logs' %}

copiar_script:
  file.managed:
    - name: {{ script }}
    - source: salt://abrir_notepad.ps1
    - makedirs: True

crear_log_dir:
  file.directory:
    - name: {{ logdir }}
    - makedirs: True

ejecutar_notepad:
  cmd.run:
    - name: >-
        powershell.exe -NoProfile -ExecutionPolicy Bypass -File {{ script }}
    - shell: powershell
    - require:
      - file: copiar_script
      - file: crear_log_dir

# Paso 1: Copiar el script PowerShell
copiar_script:
  file.managed:
    - name: C:\salt\scripts\abrirRdp.ps1
    - source: salt://files/abrirRdp.ps1
    - makedirs: True
# Paso 2: Copiar CSV
copiar_csv:
  file.managed:
    - name: C:\salt\scripts\datos.csv
    - source: salt://files/datos.csv
    - makedirs: True
# Paso 3: Ejecutar el script PowerShell
ejecutar_script_ps1:
  cmd.run:
    - name: powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:\salt\scripts\abrirRdp.ps1
    - shell: powershell
    - require:
        - file: copiar_script
# Paso 4: Borrar los archivos
borrar_archivos:
  cmd.run:
    - name: Remove-Item -Path C:\salt\scripts\abrirRdp.ps1, C:\salt\scripts\datos.csv -Force
    - shell: powershell

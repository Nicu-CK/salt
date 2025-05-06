# Paso 1:Copiar el script ejecucion programa
copiar_ps1:
  file.managed:
    - name: C:\salt\scripts\abrirAplicaciones.ps1
    - source: salt://files/abrirAplicaciones.ps1
    - makedirs: True
# Paso 2:Copiar el CSV
copiar_csv:
  file.managed:
    - name: C:\salt\scripts\datos.csv
    - source: salt://files/datos.csv
    - makedirs: True

# Paso 3: Ejecutar el archivo PS1 usando PowerShell
ejecutar_ps1:
  cmd.run:
    - name: powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:\salt\scripts\abrirAplicaciones.ps1
    - shell: powershell
    - require:
      - file: copiar_ps1
# Paso 4: Borrar los archivos después de ejecutar el script
borrar_archivos:
  cmd.run:
    - name: Remove-Item -Path C:\salt\scripts\abrirAplicaciones.ps1, C:\salt\scripts\datos.csv -Force
    - shell: powershell
    - require:
      - cmd: ejecutar_ps1

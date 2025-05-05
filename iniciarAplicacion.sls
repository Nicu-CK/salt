# Paso 1:Copiar el script ejecucion programa
copiar_ps1:
  file.managed:
    - name: C:\salt\scripts\abrirAplicacion.ps1
    - source: salt://files/abrirAplicacion.ps1
    - makedirs: True

# Paso 2: Ejecutar el archivo PS1 usando PowerShell
ejecutar_ps1:
  cmd.run:
    - name: powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:\salt\scripts\abrirAplicacion.ps1
    - shell: powershell
    - require:
      - file: copiar_ps1

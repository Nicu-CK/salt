# Paso 1: Guardar las credenciales con cmdkey
guardar_credenciales:
  cmd.run:
    - name: cmdkey /generic:10.34.1.98 /user:PRUEBA\prueba /pass:Usuario!
    - shell: powershell

# Paso 2: Copiar el archivo RDP al directorio de scripts en el servidor Windows
copiar_rdp:
  file.managed:
    - name: C:\salt\scripts\mirdp.rdp
    - source: salt://files/mirdp.rdp
    - makedirs: True

# Paso 3: Copiar el script PowerShell
copiar_script:
  file.managed:
    - name: C:\salt\scripts\scriptrdp.ps1
    - source: salt://files/scriptrdp.ps1
    - makedirs: True

# Paso 4: Ejecutar el script PowerShell
ejecutar_script_ps1:
  cmd.run:
    - name: powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:\salt\scripts\scriptrdp.ps1
    - shell: powershell
    - require:
        - file: copiar_script
        - file: copiar_rdp

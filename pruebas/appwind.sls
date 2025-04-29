abrir_bloc_notas_auto:
  cmd.run:
    - name: |
        $session = (query user prueba | Select-String -Pattern '(\d+)\s+Active').Matches[0].Groups[1].Value
        PsExec.exe -accepteula -i $session -u prueba -p "Usuario!" notepad.exe
    - shell: powershell
    - cwd: C:\Windows\System32

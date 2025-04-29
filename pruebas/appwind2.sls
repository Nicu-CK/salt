ejecutar_notepad:
  cmd.run:
    - name: 'cmd.exe /c "for /f \"tokens=3\" %%a in (\'quser | findstr prueba\') do psexec -accepteula -i %%a -u prueba -p Usuario! -s notepad.exe"'
    - shell: cmd

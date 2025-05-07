install_salt_minion:
  cmd.run:
    - name: |
        mkdir -p /etc/apt/keyrings && \
        curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | tee /etc/apt/keyrings/salt-archive-keyring.pgp && \
        curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | tee /etc/apt/sources.list.d/salt.sources
update_salt_minion:
  cmd.run:
    - name: apt update
salt_minion_package:
  pkg.installed:
    - name: salt-minion
    - require:
      - cmd: update_salt_minion
set_master_server:
  file.replace:
    - name: /etc/salt/minion
    - pattern: '^#master:.*'
    - repl: 'master: 10.34.1.90'
set_id_minion:
  file.replace:
    - name: /etc/salt/minion
    - pattern: '^#id:.*'
    - repl: 'id: {{ grains['id'] }}'
salt_minion_service_restart:
  cmd.run:
    - name: systemctl restart salt-minion

salt_minion_service_enable:
  cmd.run:
    - name: systemctl enable salt-minion
    - require:
      - cmd: salt_minion_service_restart

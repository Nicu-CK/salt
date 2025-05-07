#!/bin/bash
CSV_FILE="/srv/salt/files/hostsLinux.csv"
YAML_FILE="/srv/salt/LinuxGroup.yml"

# Comprobamos que los archivos existen
if [[ ! -f "$CSV_FILE" ]]; then
    echo "CSV file not found: $CSV_FILE"
    exit 1
fi

if [[ ! -f "$YAML_FILE" ]]; then
    echo "YAML file not found: $YAML_FILE"
    touch $YAML_FILE
    echo "YAML file created"
fi

while IFS=',' read -r host user passwd hostname
do
    # Saltamos la cabecera si la hay
    if [[ "$host" == "host" ]]; then
        continue
    fi

    # Comprobamos si ya existe el hostname en el YAML
    if grep -q "^  host: $host\$" "$YAML_FILE"; then
        echo "Entry for $hostname ($host) already exists, skipping."
    else
        echo "Adding $hostname ($host) to $YAML_FILE..."
        {
            echo "$hostname:"
            echo "  host: $host"
            echo "  user: $user"
            echo "  passwd: $passwd"
            echo "  sudo: True"
            echo "  tty: True"
            echo ""
        } >> "$YAML_FILE"
    fi

done < "$CSV_FILE"

echo "Done."

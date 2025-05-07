#!/bin/bash
CSV_FILE="/srv/salt/files/hostsLinux.csv"
YAML_FILE="/srv/salt/LinuxGroup.yml"

# Check if the CSV file exists
if [[ ! -f "$CSV_FILE" ]]; then
    echo "CSV file not found: $CSV_FILE"
    exit 1
fi

# Check if the YAML file exists
if [[ ! -f "$YAML_FILE" ]]; then
    echo "YAML file not found: $YAML_FILE"
    touch "$YAML_FILE"
    echo "YAML file created"
fi

# Read each line from the CSV file
while IFS=',' read -r host user passwd hostname
do
    # Skip the header if present
    if [[ "$host" == "host" ]]; then
        continue
    fi

    # Check if the host already exists in the YAML file
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

echo "Starting SaltStack minion installation with salt-ssh..."

# Run the SLS state to install the minion
salt-ssh -i '*' --roster-file="$YAML_FILE" state.apply installMinionLinux
if [ $? -eq 0 ]; then
    echo "SaltStack minion installation succeded."
else
    echo "Error running the SaltStack minion installation"
    exit 1
fi
echo "Done."

#!/bin/bash
$serverRdp="win-11"
$serverAplicaciones="win-srv"
echo "Running SLS for RDP on the Windows 11 PC..."
salt '$serverRdp' state.apply iniciarRdp

# Check if the execution of the RDP SLS was successful
if [ $? -eq 0 ]; then
    echo "RDP on the Windows 11 PC configured successfully."
else
    echo "Error running the RDP SLS on the Windows 11 PC. Aborting."
    exit 1
fi

# Wait a moment to ensure the RDP configuration is ready
echo "Waiting 10 seconds to ensure RDP configuration is ready..."
sleep 10

# Execute the SLS to open applications on the Windows server
echo "Running SLS to open applications on the Windows server..."
salt '$serverAplicaciones' state.apply iniciarAplicacion

# Check if the execution of the open applications SLS was successful
if [ $? -eq 0 ]; then
    echo "Applications opened successfully on the Windows server."
else
    echo "Error running the open applications SLS on the Windows server."
    exit 1
fi

echo "Process completed successfully."

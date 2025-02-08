#!/bin/bash

FILE="/home/neov/Documents/sshData2500.txt"

if [ -f "$FILE" ];
then
  xdg-open "$FILE"
else
    echo "Filen ble ikke funnet: $FILE"
fi

#!/bin/bash
# ============================================
# HOW TO MAKE THIS SCRIPT GLOBAL
# ============================================

# 1. Move to your script folder (if not already there):
#    cd ~/Documents/MinCodingLinuxV/UtviklingAreaV/ShellScripts

# 2. Make sure the script is executable:
#    chmod +x myscript.sh

# 3. Ensure the script folder is in PATH (only needed once):
#    echo 'export PATH="$PATH:/home/neov/Documents/MinCodingLinuxV/UtviklingAreaV/ShellScripts"' >> ~/.bashrc
#    source ~/.bashrc

# 4. Now you can run the script from any directory:
#    myscript.sh

# 5. (Optional) Remove the .sh extension for cleaner execution:
#    mv myscript.sh myscript
#    Now, just run:
#    myscript

# ============================================
# YOUR SCRIPT STARTS BELOW
# ============================================

# echo "Hello! This is a global script."

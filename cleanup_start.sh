#!/bin/bash

log_file="/c/Users/mafuwape/tmx/log/cleanup_start.log"  # Define the path to the log file
tmp_dir="/c/Users/mafuwape/tmx/app/jadmin/proxyvoting/jboss-eap-7.2/standalone/tmp/"  # Define the temporary directory path
APPNAME=proxyvoting.service  # Define the application name

# Function to log messages with timestamps
function logMessage() {
  local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  local message="$1"
  echo "$timestamp - $message" >> "$log_file"
}

logMessage "Beginning of the script $(basename $0)" # Log the beginning of the script
logMessage "Removing files and folders in $tmp_dir" # Log a message indicating cleanup files/folders in the tmp directory.

# Loop through files and folders in the temporary directory and delete them, logging their names
for item in "$tmp_dir"/*; do                      # Loop through items in tmp_dir
  if [ -e "$item" ]; then                         # Check if the item exists
    item_name=$(basename "$item")                 # Extract the item's name
    rm -rf "$item"                                # Delete the item 
    RC=$?                                         # Get the return code of the 'rm' command
    if [[ $RC -eq 0 ]]; then                      # Check if the return code indicates success (0)
      logMessage "Deleted '$item_name' successfully from tmp"   # Log successful deletion
      echo "0"                                    # Print '0' to indicate success (optional)
    else
      logMessage "Failed to delete '$item_name' from tmp"    # Log deletion failure
      echo "1"                                   # Print '1' to indicate failure (optional)
      exit $RC                                   # Exit the script with the 'rm' command's return code
    fi
  fi
done

# Log a message indicating the start of the JBoss service
logMessage "Starting $APPNAME (JBoss) service"

# Start the JBoss service using systemctl and capture the return code
sudo /usr/bin/systemctl start $APPNAME
RC=$?

# Check the return code and log the status of the service start
if [[ $RC -eq 0 ]]; then
  logMessage "Service $APPNAME (JBoss) has been started"
else
  logMessage "Service $APPNAME (JBoss) has NOT been started"
  exit $RC
fi

logMessage "End of the script $(basename $0)" # Log the end of the script

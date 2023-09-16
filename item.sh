#clean up
#!/bin/bash

log_file="/c/Users/afuwa/tmx/log/cleanup.log"
tmp_dir="/c/Users/afuwa/tmx/app/jadmin/proxyvoting/jboss-eap-7.2/standalone/tmp/"

# Function to log messages
function logMessage() {
  local timestamp=$(date +"%Y-%m-%d %H:%M:%S")   # Get the current timestamp
  local message="$1"                           # Extract the message parameter
  echo "$timestamp - $message" >> "$log_file"  # Append the timestamped message to the log file
}

logMessage "Beginning of the script $(basename $0)"

logMessage "Removing files and folders in $tmp_dir"

# Loop through files_folders in tmp dir and delete them, logging their names
for item in "$tmp_dir"/*; do
  if [ -e "$item" ]; then
    item_name=$(basename "$item")
    rm -rf "$item"
    RC=$?
    if [[ $RC -eq 0 ]]; then
      logMessage "Deleted '$item_name' successfully from tmp"
      echo "0"
    else
      logMessage "Failed to delete '$item_name' from tmp"
      echo "1"
      exit $RC
    fi
  fi
done

logMessage "End of the script $(basename $0)"

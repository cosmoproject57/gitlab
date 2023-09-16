#!/bin/bash


log_file="/c/Users/afuwa/tmx/log/cleanup.log"  # Define the path to the log file
tmp_dir="/c/Users/afuwa/tmx/app/jadmin/proxyvoting/jboss-eap-7.2/standalone/tmp/" # Define the temporary directory to clean up

# Function to log messages
function logMessage() {
  local timestamp=$(date +"%Y-%m-%d %H:%M:%S")   # Get the current timestamp
  local message="$1"                           # Extract the message parameter
  echo "$timestamp - $message" >> "$log_file"  # Append the timestamped message to the log file
}

logMessage "Beginning of the script $(basename $0)" # Log the start of the script with its name

logMessage "Removing files and folders in $tmp_dir" # Log a message indicating which directory will be cleaned up

# Loop through files and folders in the tmp directory and delete them, logging their names
for item in "$tmp_dir"/*; do                    # Loop through items in tmp_dir
  if [ -e "$item" ]; then                      # Check if the item exists
    item_name=$(basename "$item")              # Extract the item's name
    rm -rf "$item"                             # Delete the item recursively and forcefully
    RC=$?                                      # Get the return code of the 'rm' command
    if [[ $RC -eq 0 ]]; then                   # Check if the return code indicates success (0)
      logMessage "Deleted '$item_name' successfully from tmp"  # Log successful deletion
      echo "0"                                 # Print '0' to indicate success (optional)
    else
      logMessage "Failed to delete '$item_name' from tmp"     # Log deletion failure
      echo "1"                                 # Print '1' to indicate failure (optional)
      exit $RC                                # Exit the script with the 'rm' command's return code
    fi
  fi
done

logMessage "End of the script $(basename $0)" # Log the end of the script with its name

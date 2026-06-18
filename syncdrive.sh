#!/bin/bash

# Define where you want to save the log file
LOGFILE="$HOME/.rclone_backup.log"

# Print the start time to the log
echo "Starting cloud backup at $(date)" >>"$LOGFILE"

# Run the syncs using the absolute path to rclone (cron prefers absolute paths)
# We removed the -P flag and redirect all output (>> "$LOGFILE" 2>&1) into the log
/usr/bin/rclone sync ~/Documents gdrive:Backup/Documents >>"$LOGFILE" 2>&1
/usr/bin/rclone sync ~/Pictures gdrive:Backup/Pictures >>"$LOGFILE" 2>&1

# Print the end time and a separator
echo "Backup finished at $(date)" >>"$LOGFILE"
echo "----------------------------------------" >>"$LOGFILE"

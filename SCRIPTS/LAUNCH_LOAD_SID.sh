#!/bin/bash

# -------------------------------------------------------
#                  VARIABLES
# -------------------------------------------------------

BASE_DIR="/media/sf_UTC-NF26/DATA"
CHECKPOINT_FILE="/opt/teradata/client/20.00/tbuild/checkpoint/rootLVCP"
MAX_FOLDERS=10
counter=0
LOGFILE="LAUNCH_LOAD_SID.log"
HOST="localhost"
DB_USER="dbc"
DB_PASS="dbc"

#--------------------------------------------------------
#                  FUNCTIONS
#--------------------------------------------------------
log() {
    # Add a timestamp to the log message
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

run_sql_script() {
  # Run SQL script using BTEQ
    local script=$1
    bteq <<EOF >> $LOGFILE
.LOGON $HOST/$DB_USER,$DB_PASS;
.RUN FILE=$script;
.LOGOFF;
.QUIT;
EOF
  wait $!
}


# -------------------------------------------------------
#                  MAIN
# -------------------------------------------------------
if [ ! -d "$BASE_DIR" ]; then
  # Check if the base directory exists
  log "Error: Base directory $BASE_DIR does not exist."
  exit 1
fi

# Loop through all BDD_HOSPITAL* directories
find "$BASE_DIR" -type d -name 'BDD_HOSPITAL*' | while read -r dir; do
  if [ "$counter" -ge "$MAX_FOLDERS" ]; then
    # Maximum number of folders reached
    break
  fi

  log "Processing directory: $dir"

  if [ -f "$CHECKPOINT_FILE" ]; then
    rm -f "$CHECKPOINT_FILE"
    log "Removed checkpoint file: $CHECKPOINT_FILE"
  else
    log "Checkpoint file not found: $CHECKPOINT_FILE"
  fi

  # TXT -> STG : TPT
  run_sql_script "./create_exec_run_id.sql"
  ./run_tpt.sh "$dir"

  if [ $? -ne 0 ]; then
    log "run_tpt.sh failed for directory: $dir"
    run_sql_script "./update_exec_id_ko.sql"
    continue
  else
    run_sql_script "./update_exec_id_ok.sql"
  fi
  
  # STG -> WRK : SQL
  run_sql_script "./insert_to_wrk_from_stg.sql"
  
  if [ $? -ne 0 ]; then
    log "run_tpt.sh failed for directory: $dir"
    run_sql_script "./update_exec_id_ko.sql"
    continue
  else
    run_sql_script "./update_exec_id_ok.sql"
  fi
  
  # WRK -> SOC : SQL
  run_sql_script "./insert_to_soc_from_wrk.sql"

  if [ $? -ne 0 ]; then
    log "run_tpt.sh failed for directory: $dir"
    run_sql_script "./update_exec_id_ko.sql"
    continue
  else
    run_sql_script "./update_exec_id_ok.sql"
  fi

  # Check if any errors occurred during the process else update the RUN_ID
  if [ $? -ne 0 ]; then
    log "Error occurred during the process for directory: $dir"
    run_sql_script "./update_run_id_ko.sql"
    continue
  else
    run_sql_script "./update_run_id_ok.sql"
  fi

  counter=$((counter + 1))
done


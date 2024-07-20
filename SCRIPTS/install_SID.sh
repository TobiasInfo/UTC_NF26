#!/bin/bash

LOGFILE="install_SID.log"
HOST="localhost"
DB_USER="dbc"
DB_PASS="dbc"

# Fonction pour ajouter un message avec horodatage au fichier de log
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

# Fonction pour exécuter un script SQL via BTEQ
run_sql_script() {
    local script=$1
    bteq <<EOF >> $LOGFILE
.LOGON $HOST/$DB_USER,$DB_PASS;
.RUN FILE=$script;
.LOGOFF;
.QUIT;
EOF
}

log "Début de l'installation du SID"

# Création des bases de données
log "Création des bases de données..."
run_sql_script "./create_db.sql"


# Delete already exists stg tables
log "Suppression des tables STG existantes..."
run_sql_script "./delete_table_stg.sql"

# Création des tables STG (toujours recréées)
log "Création des tables STG..."
run_sql_script "./create_table_stg.sql"

# Delete already exists WRK tables
log "Suppression des tables WRK..."
run_sql_script "./delete_table_wrk.sql"

# Création des tables WRK (toujours recréées)
log "Création des tables WRK..."
run_sql_script "./create_table_wrk.sql"

# Création des tables TCH (ne recrée pas si elles existent)
log "Création des tables TCH..."
run_sql_script "./create_table_tch.sql"

# Création des tables SOC (ne recrée pas si elles existent)
log "Création des tables SOC..."
run_sql_script "./create_table_soc.sql"


if grep -q "Error" $LOGFILE; then
    echo "Une erreur est survenue lors de l'installation du SID. Veuillez vérifier le fichier $LOGFILE pour plus de détails."
    exit 1
else
    log "Installation du SID terminée"
fi

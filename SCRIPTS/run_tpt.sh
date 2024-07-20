#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

DIR=$1
RUN_TPT_LOGFILE=run_tpt.log

# Define file paths dynamically
CONSULTATION_FILE=$(find "$DIR" -type f -name 'CONSULTATION*.txt' | sort | tail -n 1)
HOSPITALISATION_FILE=$(find "$DIR" -type f -name 'HOSPITALISATION*.txt' | sort | tail -n 1)
TRAITEMENT_FILE=$(find "$DIR" -type f -name 'TRAITEMENT*.txt' | sort | tail -n 1)
CHAMBRE_FILE=$(find "$DIR" -type f -name 'CHAMBRE*.txt' | sort | tail -n 1)
MEDICAMENT_FILE=$(find "$DIR" -type f -name 'MEDICAMENT*.txt' | sort | tail -n 1)
PATIENT_FILE=$(find "$DIR" -type f -name 'PATIENT*.txt' | sort | tail -n 1)
PERSONNEL_FILE=$(find "$DIR" -type f -name 'PERSONNEL*.txt' | sort | tail -n 1)

# Check if all files are found
if [ -z "$CONSULTATION_FILE" ] || [ -z "$HOSPITALISATION_FILE" ] || [ -z "$TRAITEMENT_FILE" ] || [ -z "$CHAMBRE_FILE" ] || [ -z "$MEDICAMENT_FILE" ] || [ -z "$PATIENT_FILE" ] || [ -z "$PERSONNEL_FILE" ]; then
  echo "Error: One or more files not found in $DIR."
  exit 1
fi

# Load chambre
tbuild -f load_chambre.tpt -u "FileName='$CHAMBRE_FILE'" | tee -a $RUN_TPT_LOGFILE

# Load medicament
tbuild -f load_medicament.tpt -u "FileName='$MEDICAMENT_FILE'" | tee -a $RUN_TPT_LOGFILE

# Load personnel
tbuild -f load_personnel.tpt -u "FileName='$PERSONNEL_FILE'" | tee -a $RUN_TPT_LOGFILE

# Load patient
tbuild -f load_patient.tpt -u "FileName='$PATIENT_FILE'" | tee -a $RUN_TPT_LOGFILE

# Load traitement and consultation
tbuild -f load_traitement.tpt -u "FileName='$TRAITEMENT_FILE'" | tee -a $RUN_TPT_LOGFILE
tbuild -f load_consultation.tpt -u "FileName='$CONSULTATION_FILE'" | tee -a $RUN_TPT_LOGFILE

# Load hospitalisation
tbuild -f load_hospitalisation.tpt -u "FileName='$HOSPITALISATION_FILE'" | tee -a $RUN_TPT_LOGFILE

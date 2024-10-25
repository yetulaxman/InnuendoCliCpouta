#!/bin/bash
#
# Script to read contents of AMR_reports.tab file to DB.
# Typically called by icli-add-reports to add all reports
# from a directory.
#
# Syntax:
#  icli-insert-log_reports <run_id> <file>

dbuser=$DBUSER
dbpassword=$DBPASSWORD


# Remove header
tail -n +2 $1 > $1.tmp

# Make sure tmp file is empty
echo "" > report-tmp.csv

run_date=$(date -r $1 "+%F %H:%M:%S %:z")

# Add run_date and active to each line
while read -r "LINE"
do
    echo -e ${run_date}"\t""true""\t""${LINE}" >> report-tmp.csv
done < $1.tmp

# Add to DB
PGPASSWORD=${dbpassword} psql -U ${dbuser} -d 'i2' -t -c "COPY log_report FROM STDIN  DELIMITER E'	' CSV;" <report-tmp.tmp


# Clean the tmp files
rm report-tmp.csv
rm $1.tmp
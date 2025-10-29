#!/bin/bash
#
# Script to read contents of AMR_reports.tab file to DB.
# Typically called by icli-add-reports to add all reports
# from a directory.
#
# Syntax:
#  icli_insert_typing_reports <run_id> <file>

dbuser=$DBUSER
dbpassword=$DBPASSWORD

# Preprocess file
## Remove header
tail -n +2 $1 |grep -v "_assembly" > $1.tmp
## Remove linefeeds from data fields
sed -i s/"\\\n"// $1.tmp

# Make sure tmp file is empty
echo -n "" > report-tmp.csv

# Get run date from file time stamp
run_date=$(date -r $1 "+%F %H:%M:%S %:z")

# Columns 1-15 go to table typing_report_ecoli
while read -r "LINE"
do
  # Get primary identifier
  primary_identifier=$(echo $LINE | cut -d _ -f 1)
  # Add run_date, active and primary_identifier    
  echo -n -e ${run_date}"\t""true""\t"${primary_identifier}"\t" >> report-tmp.csv
  # Add columns 2-15
  echo $LINE | cut -f 2-15 >> report-tmp.csv
done < $1.tmp

# Add to DB
PGPASSWORD=$dbpassword psql -U $DBUSER -d 'i2' -t -c "COPY typing_report_ecoli FROM STDIN  DELIMITER E' ' CSV HEADER;" < report.tmp.csv

# Rest of the columns are Virulencefinder results and go to table virulencefinder_ecoli
# Make sure tmp file is empty
echo -n "" > report-tmp.csv

# Read the name from the header into an array
read -a header <<< $(sed -n 1p $1 | cut -f 18-)

# Iterate through lines
while read -r "LINE"
do
  # Get common values
  primary_identifier=$(echo $LINE | cut -d _ -f 1)
  min_coverage=$(echo $LINE | cut -f 16)
  min_treshold=$(echo $LINE | cut -f 17)

  # Read the line into an array
  read -a sample <<< $(echo $LINE | cut -f 18-)
  # Iterate through the array
  arraylength=${#sample[@]}
  for (( i=0; i<${arraylength}; i++ ));
  do
    if [[ "${sample[$i]}" != "ND" ]] 
    then
      PGPASSWORD=$dbpassword psql -U $DBUSER -d 'i2' -t -c "INSERT INTO virulencefinder_ecoli VALUES ('$run_date', '$primary_identifier', '$min_coverage', '$min_treshold', '${header[$i]}', '${sample[$i]}')"
    fi   
  done
done


# Clean the tmp files
rm report-tmp.csv
rm $1.tmp.1
rm $1.tmp

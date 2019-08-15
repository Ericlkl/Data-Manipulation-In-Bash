# CAB220 Portfolio 1
# Developed By: KA LONG LEE 
# Student ID: N9845097

# File Name: bq3.sh
# Purpose : Find out How much box office earnings do biopsies generate in each year ?
# Required: Please enter the file in the parameter one
#  example: ./bq3.sh data/biopics.csv

clear
# Parameters Checker
if [ -z "$1" ];
  then 
    echo "This file is designed to seperate data from code" 
    echo "Please insert biopics.csv as parameter 1"
    echo "example: ./sq3.sh data/biopics.csv"
else
  # Save Cleaned dataset as cleaned_biopics.csv
  ./clean.sh $1 > ./data/cleaned_biopics.csv
  # Convert Cleaned dataset to sqlite script
  python3 ./data/csv2sqlite.py --table-name biopics --input ./data/cleaned_biopics.csv --output ./data/biopics.sqlite
  
  # Generate Result
  echo "Generating Report as sa3.html ..."
  # Generate HTML Body
  echo '<html lang="en"><head></head><body><table><tr><th>Year</th><th>Total Amount</th></tr>' > output/sa3.html

  # SQL Query
  sqlite3 data/biopics.sqlite ' SELECT year_release , SUM(box_office) FROM (SELECT DISTINCT title, year_release, box_office from biopics) GROUP BY year_release' |
  sed 's/^/<tr><td>/g' |
  sed 's/|/<\/td><td>$/g' |
  sed 's/$/<\/td><\/tr>/g' >> output/sa3.html

  # Generate HTML END Tag
  echo '</table></body></html>' >> output/sa3.html
  echo "sa3.html file generated complete! Please check output/sa3.html"
fi
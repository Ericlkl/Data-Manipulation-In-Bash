# CAB220 Portfolio 1
# Developed By: KA LONG LEE 
# Student ID: N9845097

# File Name: bq3.sh
# Purpose : Find out How much box office earnings do biopsies generate in each year ?
# Required: Please enter the file in the parameter one
#  example: ./bq3.sh data/biopics.csv

clear
echo "Converting dataset to biopics.sqlite ..."

./clean.sh $1 > ./data/cleaned_biopics.csv

python3 ./data/csv2sqlite.py --table-name biopics --input ./data/cleaned_biopics.csv --output ./data/biopics.sqlite
echo "Convert Completed!"
echo "---------------------------------------------- \n"

echo "Generating Report as sa3.html ..."

# Generate HTML Body
echo '<html lang="en"><head></head><body><table><tr><th>Year</th><th>Total Amount</th></tr>' > output/sa3.html

sqlite3 data/biopics.sqlite ' SELECT year_release , SUM(box_office) FROM (SELECT DISTINCT title, year_release, box_office from biopics) GROUP BY year_release' |
sed 's/^/<tr><td>/g' |
sed 's/|/<\/td><td>$/g' |
sed 's/$/<\/td><\/tr>/g' >> output/sa3.html

# Generate HTML END Tag
echo '</table></body></html>' >> output/sa3.html

echo "sa3.html file generated complete! Please check output/sa3.html"

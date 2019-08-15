# CAB220 Portfolio 1
# Developed By: KA LONG LEE 
# Student ID: N9845097

# File Name: sq1.sh
# Purpose : Find out How many movies has a director made
# Required: Please enter the file in the parameter one
#  example: ./sq1.sh data/biopics.csv
clear
echo "Converting dataset to biopics.sqlite ..."

./clean.sh $1 > ./data/cleaned_biopics.csv

python3 ./data/csv2sqlite.py --table-name biopics --input ./data/cleaned_biopics.csv --output ./data/biopics.sqlite
echo "Convert Completed!"
echo "---------------------------------------------- \n"

echo "Generating Report as sa1.txt ..."
sqlite3 data/biopics.sqlite -separator ','  ' SELECT director, COUNT(*) FROM (SELECT DISTINCT title, director from biopics) GROUP BY director' > output/sa1.txt
echo "sa1.txt file generated complete! Please check output/sa1.txt"
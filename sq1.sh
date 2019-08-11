echo "SQL Question 1: How many movies has a director made \n"

echo "----------------------------------------------"
echo "Converting biopics.csv to biopics.sqlite ..."
python3 ./data/csv2sqlite.py --table-name biopics --input ./data/biopics.csv --output ./data/biopics.sqlite
echo "Convert Completed! \n"

echo "---------------------------------------------- "
echo "Generating Report as sa1.txt ..."
sqlite3 data/biopics.sqlite -separator ','  ' SELECT director, COUNT(*) FROM biopics GROUP BY director' > output/sa1.txt
echo "sa1.txt file generated complete! Please check output/sa1.txt"
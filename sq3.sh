echo "SQL Question 3: How much box office earnings do biopsies generate in each year ? \n"

echo "----------------------------------------------"
echo "Converting biopics.csv to biopics.sqlite ..."
python3 ./data/csv2sqlite.py --table-name biopics --input ./data/biopics.csv --output ./data/biopics.sqlite
echo "Convert Completed! \n"

echo "---------------------------------------------- "
echo "Generating Report as sa3.html ..."
sqlite3 data/biopics.sqlite -separator ','  ' SELECT year_release as Year, SUM(box_office) as total_amount FROM biopics GROUP BY Year' 
echo "sa1.txt file generated complete! Please check output/sa1.html"

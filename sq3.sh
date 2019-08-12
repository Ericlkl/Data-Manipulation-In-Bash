echo "SQL Q3: How much box office earnings do biopsies generate in each year ? \n"

echo "----------------------------------------------"
echo "Converting biopics.csv to biopics.sqlite ..."
python3 ./data/csv2sqlite.py --table-name biopics --input ./data/biopics.csv --output ./data/biopics.sqlite
echo "Convert Completed! \n"

echo "---------------------------------------------- "

echo "Generating Report as sa3.html ..."

# Generate HTML Body
echo '<html lang="en"><head></head><body><table><tr><th>Year</th><th>Average Gross</th></tr>' > output/sa3.html

sqlite3 data/biopics.sqlite ' SELECT year_release as Year, SUM(box_office) as total_amount FROM biopics GROUP BY Year' |
sed 's/^/<tr><td>/g' |
sed 's/|/<\/td><td>$/g' |
sed 's/$/<\/td><\/tr>/g' >> output/sa3.html

# Generate HTML END Tag
echo '</table></body></html>' >> output/sa2.html

echo "sa3.html file generated complete! Please check output/sa3.html"

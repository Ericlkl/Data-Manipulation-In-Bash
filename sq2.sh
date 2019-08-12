echo "SQL Question 2: Does gender influence how much a movie earns at the box office ? \n"

echo "----------------------------------------------"
echo "Converting biopics.csv to biopics.sqlite ..."
python3 ./data/csv2sqlite.py --table-name biopics --input ./data/biopics.csv --output ./data/biopics.sqlite
echo "Convert Completed! \n"

echo "---------------------------------------------- "
echo "Generating Report as sa2.html ..."

# Generate HTML Body
echo '<html lang="en"><head></head><body><table><tr><th>Gender</th><th>Total Amount</th></tr>' > output/sa2.html

# Male Query Cmd
# Step 1: Query Distinct Movie title which subject sex = Male
# Step 2: SUM the box office by subject sex
sqlite3 data/biopics.sqlite ' SELECT subject_sex as gender, SUM(box_office) FROM (SELECT DISTINCT title, box_office, subject_sex from biopics WHERE subject_sex = "Male" ) GROUP BY gender' |
sed 's/^/<tr><td>/g'|
sed 's/|/<\/td><td>$/g'|
sed 's/$/<\/td><\/tr>/g' >> output/sa2.html

# Female Query Cmd
# Step 1: Query Distinct Movie title which subject sex = Female
# Step 2: SUM the box office by subject sex
sqlite3 data/biopics.sqlite ' SELECT subject_sex as gender, SUM(box_office) FROM (SELECT DISTINCT title, box_office, subject_sex from biopics WHERE subject_sex = "Female" ) GROUP BY gender' | 
sed 's/^/<tr><td>/g' |
sed 's/|/<\/td><td>$/g' |
sed 's/$/<\/td><\/tr>/g'>> output/sa2.html

# Generate HTML END Tag
echo '</table></body></html>' >> output/sa2.html

echo "sa2.html file generated complete! Please check output/sa2.html"

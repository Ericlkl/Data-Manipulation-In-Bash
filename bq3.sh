echo "Bash Q3: How much box office earnings do biopsies generate in each year ? \n"

echo "---------------------------------------------- "
echo "Generating Report as ba3.html ..."

# Generate HTML Body
echo '<html lang="en"><head></head><body><table><tr><th>Year</th><th>Average Gross</th></tr>' > output/ba3.html

# Male Query

grep Male data/biopics.csv | cut -f 1,5,13 -d , | uniq | cut -f 2,3 -d, | sed 's/-/0/g' | awk ' BEGIN { OFS = ","; FS="," } {a += $1} END{print $2, a}' 
# | sed 's/^/<tr><td>/g'  |sed 's/,/<\/td><td>$/g' | sed 's/$/<\/td><\/tr>/g' >> output/ba3.html

# Female Query
# STEP 1: Search Only Male Result
# STEP 2: Get only title, box_office, Female Column
# STEP 3: GET The unique title (Because some of the movie record is duplicated)
# STEP 4: Remove Title Column (It is useless for our result)
# STEP 5: Change all the Unknown box office record to 0 (- to 0)
# STEP 6: AWK cmd to summarise the result
grep Female data/biopics.csv | cut -f 1,5,13 -d , | uniq | cut -f 2,3 -d, | sed 's/-/0/g' | awk ' BEGIN { OFS = ","; FS="," } {a += $1} END{print $2, a}'
# | sed 's/^/<tr><td>/g'  |sed 's/,/<\/td><td>$/g' | sed 's/$/<\/td><\/tr>/g' >> output/ba3.html

# Generate HTML END Tag
echo '</table></body></html>' >> output/ba3.html

echo "ba3.html file generated complete! Please check output/ba3.html"

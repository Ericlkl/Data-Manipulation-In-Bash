echo "Bash Q2: Does gender influence how much a movie earns at the box office ? \n"

echo "---------------------------------------------- "
echo "Generating Report as ba2.html ..."

# Generate HTML Body
echo '<html lang="en"><head></head><body><table><tr><th>Gender</th><th>Total Amount</th></tr>' > output/ba2.html

# Male Query
# STEP 1: Search Only Male Result
# STEP 2: Get only title, box_office, Male Column
# STEP 3: GET The unique title (Because some of the movie record is duplicated)
# STEP 4: Remove Title Column (It is useless for our result)
# STEP 5: Change all the Unknown box office record to 0 (- to 0)
# STEP 6: AWK cmd to summarise the result

grep Male data/biopics.csv | 
cut -f 1,5,13 -d , | 
uniq | 
cut -f 2,3 -d, | 
sed 's/-/0/g' | 
awk ' BEGIN { OFS = ","; FS="," } {a += $1} END{print $2, a}' |
sed 's/^/<tr><td>/g'|
sed 's/,/<\/td><td>$/g'|
sed 's/$/<\/td><\/tr>/g' >> output/ba2.html

# Female Query
# STEP 1: Search Only Male Result
# STEP 2: Get only title, box_office, Female Column
# STEP 3: GET The unique title (Because some of the movie record is duplicated)
# STEP 4: Remove Title Column (It is useless for our result)
# STEP 5: Change all the Unknown box office record to 0 (- to 0)
# STEP 6: AWK cmd to summarise the result

grep Female data/biopics.csv |
cut -f 1,5,13 -d , |
uniq | 
cut -f 2,3 -d, | 
sed 's/-/0/g' | 
awk ' BEGIN { OFS = ","; FS="," } {a += $1} END{print $2, a}' |
sed 's/^/<tr><td>/g'|
sed 's/,/<\/td><td>$/g'|
sed 's/$/<\/td><\/tr>/g' >> output/ba2.html

# Generate HTML END Tag
echo '</table></body></html>' >> output/ba2.html

echo "ba2.html file generated complete! Please check output/ba2.html"

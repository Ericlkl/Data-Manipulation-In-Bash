echo "Bash Q3: How much box office earnings do biopsies generate in each year ? \n"

echo "---------------------------------------------- "
echo "Generating Report as ba3.html ..."

# Generate HTML Body
echo '<html lang="en"><head></head><body><table><tr><th>Year</th><th>Average Gross</th></tr>' > output/ba3.html

# Query
cut -f 1,4,5 -d , data/biopics.csv |
uniq |
cut -f 2,3 -d , |
sed 's/-/0/g' |
grep -v year_release,box_office |
sort |
uniq |
awk '

BEGIN { 
  OFS = ","; FS="," 
}

{
  if ($2 != 0.0){
    Years[$1] = $1
    SUM[$1] += $2
    COUNT[$1] += 1
  }
}

END {
  for (year in Years){
    print Years[year], int(SUM[year] / COUNT[year])
  }
}

' |
sort -r |
sed 's/^/<tr><td>/g' |
sed 's/,/<\/td><td>$/g' |
sed 's/$/<\/td><\/tr>/g' >> output/ba3.html


# Generate HTML END Tag
echo '</table></body></html>' >> output/ba3.html

echo "ba3.html file generated complete! Please check output/ba3.html"

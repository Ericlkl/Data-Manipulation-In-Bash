# echo "Bash Q3: How much box office earnings do biopsies generate in each year ? \n"

# echo "---------------------------------------------- "
# echo "Generating Report as ba3.html ..."

# # Generate HTML Body
# echo '<html lang="en"><head></head><body><table><tr><th>Year</th><th>Average Gross</th></tr>' > output/ba3.html

# Query
cut -f 1,4,5 -d , data/biopics.csv |
uniq |
cut -f 2,3 -d , |
sed 's/-/0/g' |
sort |
uniq |
awk '

BEGIN { 
  OFS = ","; FS="," 
  year = 0
}

{
  if($1 == year){
    Years[year] = year
    Result[year] += $2
  }
  else {
    Result[$1] += $2
  }

  year = $1
}

END {
  for (year in Years)
    print year, Result[year]
}

' |
sort


# Generate HTML END Tag
# echo '</table></body></html>' >> output/ba3.html

# echo "ba3.html file generated complete! Please check output/ba3.html"

echo "Bash Q3: How much box office earnings do biopsies generate in each year ? \n"

echo "---------------------------------------------- "
echo "Generating Report as ba3.html ..."

# Generate HTML Body
echo '<html lang="en"><head></head><body><table><tr><th>Year</th><th>Average Gross</th></tr>' > output/ba3.html

# Query

# Step 1: Select Title, box office, year
# Step 2: Remove Duplicate record
# Step 3: Select Only Box Office and year
# Step 4: Remove all unknown box office record change it to zero
# Step 5: Remove year_release,box_office label on the top
# Step 6: Sort 
# Step 7: Remove Duplicate
# Step 8: If the record is not 0, Count + 1 / Sum + previous 
# At the end print the result
# Step 9: Sort records Reverse
# Step 10 - 12: Add HTML Table Tag
cut -f 1,4,5 -d , data/biopics.csv |
uniq |
cut -f 2,3 -d , |
grep -v - |
grep -v year_release,box_office |
awk '

  BEGIN { 
    OFS = ","; FS="," 
  }

  {
    Years[$1] = $1
    SUM[$1] += $2
    COUNT[$1] += 1
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

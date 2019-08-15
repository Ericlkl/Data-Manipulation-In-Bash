# CAB220 Portfolio 1
# Developed By: KA LONG LEE 
# Student ID: N9845097

# File Name: bq3.sh
# Purpose : Find out How much box office earnings do biopsies generate in each year ?
# Required: Please enter the file in the parameter one
#  example: ./bq3.sh data/biopics.csv
echo "Generating Report as ba3.html ..."

# Generate HTML Body
echo '<html lang="en"><head></head><body><table><tr><th>Year</th><th>Average Gross</th></tr>' > output/ba3.html

# Query
# Step 0: Clean biopics.csv data but not save to the file
# Step 1: Select Title, box office, year
# Step 2: Remove Duplicate record
# Step 3: Select Only Box Office and year
# Step 4: Remove year_release,box_office label on the top
# Step 5: Sort 
# Step 6: Calculate AVG by year via AWK
# Step 7: Sort records Reverse
# Step 8 - 10: Add HTML Table Tag
./clean.sh data/biopics.csv |
cut -f 1,4,5 -d , |
uniq |
cut -f 2,3 -d , |
tail -n +2 |
sort |
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

# CAB220 Portfolio 1
# Developed By: KA LONG LEE 
# Student ID: N9845097

# File Name: bq2.sh
# Purpose : Find out Does gender influence how much a movie earns at the box office ?
# Required: Please enter the file in the parameter one
#  example: ./bq2.sh data/biopics.csv
echo "Generating Report as ba2.html ..."

# Generate HTML Body
echo '<html lang="en"><head></head><body><table><tr><th>Gender</th><th>Total Amount</th></tr>' > output/ba2.html

# Query Function
# What it does : Query how much does gender earns at the box office
genderQueryAndSave(){
  # STEP 1: Clean biopics.csv data but not save to the file
  # STEP 2: Search Only Male Result
  # STEP 3: Get only title, box_office, Gender
  # STEP 4: GET The unique title (Because some of the movie record is duplicated)
  # STEP 5: Remove Title Column (It is useless for our result)
  # STEP 6: AWK cmd to summarise the result

  ./clean.sh $1 |
  grep $2 |
  cut -f 1,5,13 -d , |
  uniq | 
  cut -f 2,3 -d, | 
  awk ' BEGIN { OFS = ","; FS="," } {a += $1} END{print $2, a}' |
  sed 's/^/<tr><td>/g'|
  sed 's/,/<\/td><td>$/g'|
  sed 's/$/<\/td><\/tr>/g' >> output/ba2.html
}

# Call Query function Params1 = filename, Params2 = gender
genderQueryAndSave $1 Male
genderQueryAndSave $1 Female

# Generate HTML END Tag
echo '</table></body></html>' >> output/ba2.html

echo "ba2.html file generated complete! Please check output/ba2.html"

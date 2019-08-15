echo "Bash Question 1: How many movies has a director made \n"

echo "Generating Result.... \n"

# Steps
# 1: Get Director column
# 2: Remove the first director text label
# 3: sort the result
# 4: unique command to remove duplicate names and count how many times
#    it appears
# 5: add ',' to seperate the columns 
# 6: use awk to change the position
# 7: save it to file
cut -f 6 -d, data/biopics.csv |
  grep -v director | 
  sort | 
  uniq -c | 
  sed -e 's/^ *//;s/ /,/' | 
  awk 'BEGIN { OFS = ","; FS="," } {print $2, $1}' > output/ba1.txt

echo "Result Generated ! Please check output/ba1.txt"

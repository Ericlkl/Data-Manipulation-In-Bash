# CAB220 Portfolio 1
# Developed By: KA LONG LEE 
# Student ID: N9845097

# File Name: bq1.sh
# Purpose : Find out How many movies has a director made
# Required: Please enter the file in the parameter one
#  example: ./clean.sh data/biopics.csv

clear
# Parameters Checker
if [ -z "$1" ];
  then 
    echo "This file is designed to seperate data from code" 
    echo "Please insert biopics.csv as parameter 1"
    echo "example: ./bq1.sh data/biopics.csv"
else
  # Steps
  # 1:  Clean biopics.csv data but not save to the file
  # 2:  Get title,Director column
  # 3:  Remove the column text label on the top
  # 4:  sort the result
  # 5:  unique cmd to remove duplicate title , director name 
  #     make sure the same movie provided by same director 
  #     will not count more than one time
  # 6:  Remove movie title, only get director name
  # 7:  sort the director name
  # 8:  Calculate how many times the name appear means he/she made how many movies
  # 9:  Add ',' between the number of movies and director name
  # 10: reverse the order first column as director name , secord for movie
  #     and save it to output/ba1.txt file

  echo "Generating Result.... \n"

  ./clean.sh $1 |
  cut -f 1,6 -d, |
  tail -n +2 |
  sort |
  uniq |
  cut -d ',' -f 2 |
  sort |
  uniq -c |
  sed -e 's/^ *//;s/ /,/' | 
  awk 'BEGIN { OFS = ","; FS="," } {print $2, $1}' > output/ba1.txt

  echo "Result Generated ! Please check output/ba1.txt"

fi
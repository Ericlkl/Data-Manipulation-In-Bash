# CAB220 Portfolio 1
# Developed By: KA LONG LEE 
# Student ID: N9845097

# File Name: clean.sh
# Purpose : This file is to perform data cleaning on the biopics.csv file
# Assumption: Box Office - We assume the missing box office value in the dataset
#             will be the average box office of all movie
# 
#             subject race - We assume the missing subject race in the dataset
#             will be the most probably subject race (occur most)

# Read the CSV file and save it as file variable
file=$1

# Variable that calculate and save the average box office
# Idea : Loop through the dataset if the data is not empty 
#        Add it to the SUM variable and plus one to COUNTER 
#        At the end, Return integer type of (SUM divided by COUNTER)
avg=$(awk '
  BEGIN { 
    OFS = ","; FS="," 
    SUM = 0
    COUNTER = 0
  }

  {
    if ($5 != "-"){
      SUM += $5
      COUNTER += 1
    }
  }

  END{
    print int(SUM / COUNTER)
  }

' $file) 

# Variable that find out the most probably subject race (occur most)
# Step1 : get all the subject race values if it is not empty
# Step2 : remove the title of the column
# Step3 : Remove Duplicate value and calculate how many time those value occur
# Step4 : Sort the result in reverse order (The largest number on the top)
# Step5 : Get the top result
# Step6 : Get only the name of the subject race (remove the number)
popular_race=$(
  awk -F "," '{ if (length($11) != 0){ print $11 } }' $file |
  tail -n +2 |
  uniq -c |
  sort -r |
  head -n 1 |
  awk '{print $2}'
)

echo ${avg}
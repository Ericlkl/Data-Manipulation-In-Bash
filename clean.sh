file=$1

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

popular_race=$(
  awk '{print $11}' $file |
  tail -n +2 |
  uniq -c
)



awk -F "," '{ if (length($11) != 0){ print $11 } }' $file |
  tail -n +2 |
  uniq -c |
  sort -r |
  head -n 1 |
  awk '{print $2}'
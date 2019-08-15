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
    print SUM, COUNTER
  }

' $file) 



echo $avg
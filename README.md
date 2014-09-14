getdata-007-project
===================

The script (run_analysis.r) downloads archive from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
extracts it and creates aggregated_data.txt file as a result.
Data transformations are covered in CodeBook.md.
Archive data is extracted within same folder. The archive is not downloaded again if data is downloaded already
(from previous script executions or manually).

Use the following commands in terminal to run the script (unix):
```(bash)
chmod +x run_analysis.r
./run_analysis.R
```
For windows machines the following command is supposed to work:
```
Rscript run_analysis.r
```

The script was tested on Mac OS 10.9.4 with R version 3.1.1
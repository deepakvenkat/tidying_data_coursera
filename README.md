# Getting and Cleaning Data
Course Project for [Course 3](https://www.coursera.org/course/getdata) of [Coursera's](https://www.coursera.org/) Data Specialization track. 
The Data Used for this project comes from UCI Machine Learning Repo.
Information regarding the data can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#).

## Scripts Used in the Project : 

### run_analysis.R
This script conatains all the code required for getting and cleaning the data for this course project. 

The script  makes the following assumptions:

1. That you have the **plyr**, **dplyr** and **tidyr** packages installed in your R environment. 
2. You have downloaded the data and extracted it into a folder called **data**

The entire data folder is part of the .gitignore and is not version controlled. (Because of size considerations)

#### xData
This script contains a function called `readAndMergeData`. This function is called if the `xData` variable is null. This is because the X (X_test.txt and X_train.txt) data sets are large. in order to save time, this function allows you to use a cached version of the xData variable. 

#### Valid Columns
According to requirements for the project, we need to use only the columns which are either a mean or standard deviation. In order to select only those columns, the script includes a function called `selectCols`. This function reads the features.txt file which contains the names of all the **561** columns. The script then uses `filter` method from the `dplyr` package to select only those rows which have either mean or std in their names. The script, then uses the `select` function (once again from dplyr) to select only those valid columns from the xData. This function also applies the names of these columns as the column names in the xData variable. This function is called and the value is stored in the `cleanData` variable. 

#### Activity and Subject
The script creates a column called the **activity_type** by reading and combining *y_test.txt* and *y_train.txt* files. It adds this column to the cleanData object, using the `bind_cols`  function. Similarly, by reading *subject_test.txt* and *subject_train.txt*, the script adds a column called *subject* to the beginning of the cleanData object.

The above three steps cover the first two requirements. 


#### Activity Labels
In order to provide descriptive activity labels, the script first reads the *activity_labels.txt* file. It names the two columns as type and activity. It then uses the `merge` function, to merge this with the cleanData object by matching the **activity
_type** and **type** in cleanData and activity_labels respectively. This adds two new columns called activity, which contain the activity labels and type which is a duplicate of activity_type. The script uses the select method and the `-column_name` syntax to remove the activity_type and type columns from the cleanData object. This leaves only the activity labels in the object and covers requirement 3 of the project. 


#### Descriptive names
The script uses the `make.names` function and the `gsub` function to take the names applied in the valid columns step and make them more human readable. Following is an example of how this is done : 

```
> a <- make.names("tBodyAcc-mean()-X")
> a
[1] "tBodyAcc.mean...X"
> gsub("\\.", "", a)
[1] "tBodyAccmeanX"
```
This makes each of the labels more readable and understandable. 
This covers requirement 4 of the project. 

#### Mean measure and Mean measure long. 
The script uses the `ddply` function (from the `plyr` package) to split the data via the **subject** and **activity** columns and uses the `numcolwise` and `mean` function to find out the mean of each of the columns in the cleanData object. This returns a wide data frame which 
contains the mean of each signal in a column. The script then uses the `gather` function from the `tidyr` package to create a long table where each observation is in a column. This is then written to a txt file which covers the 5th requriment of the project. 

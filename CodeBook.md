# CodeBook for tidying data

### Data 
The data was obtained from the UCI Human Activity Data set. The files which were used for the purpose of this project are : 

1. test/ : Folder containing the test data set.
	1. test/X_test.txt : This contained the signals caluculated per subject per activity.
	2. test/y_test.txt : File identifying the activity by a type (number)
	3. test/subject_test.txt : File identifying the subjects. 
2. train/ : Folder containing the training data set
	1. train/X_train.txt : This contained the signals caluculated per subject per activity.
	2. train/y_train.txt : File identifying the activity by a type (number)
	3. train/subject_train.txt : File identifying the subjects. 
3. features.txt : A file mapping the cols in the X_* files to the name of the signals which were calculated. 
4. activity_labels.txt : A file providing labels for the activities identified as numbers in the  y_* files. 


### Packages 
The script uses the following packages : 

1. [plyr](http://cran.r-project.org/web/packages/plyr/index.html)
2. [dplyr](http://cran.r-project.org/web/packages/dplyr/index.html)
3. [tidyr](http://cran.r-project.org/web/packages/tidyr/index.html)


### Object 
When the script is run it creates the following objects.

1. xData

	Data Frame of type tbl_df for storing the combined test and train  X data set.
	
	Dimensions : (10299, 561)
	
	colnames : V1 to V561
	
2. features

	Data frame for storing the features. Stores the names of the signals in column 2
	
	Dimensions : (561, 2)
	
	colnames : (V1, V2)
	
3. validCols

	tbl_df for storing the columns which contain mean and std. Subset of features. 
	
	Dimensions : (79, 1)
	
	colnames : (V1)
	
4. ydata 

	Data frame for storing the combined test and train activity types.
	
	Dimensions : (10299, 1)
	
	colnames : (V1)
	
5. subData 

	Data frame for storing the combined test and train subject types.
	
	Dimensions : (10299, 1)
	
	colnames : (V1)
	
	
6. activity_labels
	
	Data frame storing the labels for each activity. 
	
	Dimensions : (6, 2)
	
	colnames : (type, activity)
	
7. cols

	Character vector containing the cleaned up names for the cleanData object
	
	Size : 81
	
8. cleanData 
	
	Data frame (tbl_df) containing the cleaned up data. It is formed by using select on xData. 
	Following that, bind_cols are used to add the activity_type and subject. 
	merge is used to add activity_labels and type. 
	select is used to remove type and activity_type.
	names is used to provide clean names to the columns. 
	
	Dimensions : (61794, 81)





	
# GettingAndCleaningDataProjects
The analysis scripts assumes that the zip file has been downloaded separately and unzipped to a local drive.

It takes the data set for train and test and initially gives the new neams for the columns.

It appends the sets together, the limits to only columns where "mean" or "std" are present. It makes sure that the "subject", which subject the obseration was on, and the "activity", so what was the subject doing, remain in the datset.

Finally, it averages the results to create a tidy data set were each row refers to a unique subject doing an activity, i.e. subject 1 will do WALKING only once.


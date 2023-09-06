# steps & explanation to run or understand the python code. this code acts as the main file to download file from source(Kaggle) and upload to HDFS.

script Explanation:
1)line 3,4,5 we are simply importing the libraries we are about to use for the epurpose of our project.

2) line 8-11 we are authenticating our kaggle account through python and downloading the required student data(file) to the specified path in our local system.

3) line 16-23 the python code reads the downloaded file, cleans, creates correlation removes headers as we have to use hive to creates tables & hive doesnt like headers in a file. and finally we overwrite the file with the changes.

4) line 26-27 we are creating a list of hadoop commands to load the file onto hdfs.

5) line 29-32 we are simply looping on the list of hadoop commands and running them one at a time on the linux shell with the help of python subprocess module.

Execution:

To run this script we simply have to run "python3 apiToHadoop.py" command on linux shell, it executes and completes the above steps, we can then simply execute the hive_data_analysis.hql script manually or automate in the same script, for the timimg the hive execution code is commented out for the sake of explanation.
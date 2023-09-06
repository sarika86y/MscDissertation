# importing all necessary libraries

import kaggle
import pandas as pd
import subprocess

#Authenticating with kaggle API for downloading the data
kaggle.api.authenticate()
download_file = 'balavashan/students-performance-dataset'
download_path = '/home/hduser/student_data'
kaggle.api.dataset_download_files(download_file, path=download_path, unzip=True)
print(f"File Downloaded to {download_path}....")

# cleaning the files

df1 = pd.read_csv('/home/hduser/student_data/student-mat.csv',sep=';')
df1['avg_grade'] = round((df1.G1 + df1.G2 + df1.G3)/3)
df1.corr().to_csv('/home/hduser/student_data/student-mat-correlation.csv')
df1.to_csv('/home/hduser/student_data/student-mat.csv',sep =';',header=False, index=False)
df2 = pd.read_csv('/home/hduser/student_data/student-por.csv',sep=';')
df2['avg_grade'] = round((df2.G1 + df2.G2 + df2.G3)/3)
df2.corr().to_csv('/home/hduser/student_data/student-por-correlation.csv')
df2.to_csv('/home/hduser/student_data/student-por.csv',sep =';',header=False, index=False)

# upload file from local system to HDFS
commands = ['hdfs dfs -put /home/hduser/student_data/student-mat.csv /projectData/mathStudents',
'hdfs dfs -put /home/hduser/student_data/student-por.csv /projectData/porStudents']

for cmd in commands:
	sp = subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
	rc = sp.wait()
	out,err = sp.communicate()
print("Files uploaded to Hadoop....\n")

# executing the hive script
print("starting hive script...")
hive_exec = "hive -f /home/hduser/hive_data_analysis.hql"
sub = subprocess.Popen(hive_exec,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
res_code = sub.wait()
output,error = sub.communicate()
print("\njob successful...")



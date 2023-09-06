create database if not exists BeckettProject;

use BeckettProject;
DROP TABLE IF EXISTS mergedtable;

/*creating external table for Maths Students*/

create external table if not exists math_students(
school string,sex string,age int,address string,famsize string,Pstatus string,Medu int,Fedu int,Mjob string,Fjob string,reason string,
guardian string,traveltime int,studytime int,failures int,schoolsup string,famsup string,paid string,activities string,nursery string,
higher string,internet string,romantic string,famrel int,freetime int,goout int,Dalc int,Walc int,health int,absences int,G1 int,
G2 int,G3 int,avg_grade float)
row format delimited
fields terminated by ';'  
location '/projectData/mathStudents';

/*creating external table for Maths Students*/

create external table if not exists por_students(
school string,sex string,age int,address string,famsize string,Pstatus string,Medu int,Fedu int,Mjob string,Fjob string,reason string,
guardian string,traveltime int,studytime int,failures int,schoolsup string,famsup string,paid string,activities string,nursery string,
higher string,internet string,romantic string,famrel int,freetime int,goout int,Dalc int,Walc int,health int,absences int,G1 int,
G2 int,G3 int,avg_grade float)
row format delimited
fields terminated by ';'  
location '/projectData/porStudents';

/*creating external table and merging both tables in one*/

create table mergedtable as select * from math_students union all select * from por_students;

/* Starting Data Analysis for Math Students */


/*Assuming 75% will be passing marks*/

/*1. Total number of students passed in all grade?50*/

create table Pass_All_Grades as 
select * from math_students where G1>=15 AND G2>=15 AND G3>=15; 
     

/*2. Total number of pass students in grade 1 and grade 2? 1*/ 

create table Pass_Two as
select * from math_students where G1>=15 AND G2>=15 AND G3<=14;

/*3. Total number of  pass students in grade 1 only? 10*/

create table Pass_One as
select * from math_students where G1>=15 and G2<=14 AND G3<=14;

/*4 check comparison of students performance in previous grade.*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,sex,age,g1,g2,g3 from (select * from math_students where G1>=15 and G2<=14 AND G3<=14) as t;



/*5) All grade pass students address Wise*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,address,g1,g2,g3 from (select * from math_students where G1>=15 AND G2>=15 AND G3>=15) as t;


/*6 All grade pass students traveltime */

INSERT OVERWRITE DIRECTORY '/AnalysisResult/3'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,traveltime,g1,g2,g3 from (select * from math_students where G1>=15 AND G2>=15 AND G3>=15) as t;


/*7 All grade pass students mother and father education*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/4'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,medu,fedu,g1,g2,g3 from (select * from math_students where G1>=15 AND G2>=15 AND G3>=15) as t;

/*8 G1 and G2 grade pass students address*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/5'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,address,g1,g2,g3 from (select * from math_students where G1>=15 AND G2>=15 AND G3<=14) as t;

/*9 G1 grade pass students address*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/6'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,address,g1,g2,g3 from (select * from math_students where G1>=15 and G2<=14 AND G3<=14) as t;


/*10 G1 grade pass students traveltime*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/7'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,traveltime,g1,g2,g3 from (select * from math_students where G1>=15 and G2<=14 AND G3<=14) as t;

/*11 G1 grade pass students mother and father education*/
INSERT OVERWRITE DIRECTORY '/AnalysisResult/8'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,medu,fedu,g1,g2,g3 from (select * from math_students where G1>=15 and G2<=14 AND G3<=14) as t;


/*12 students who fail the famsize is gt3*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/9'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,famsize,g1,g2,g3 from (select * from math_students where G1>=15 and G2<=14 AND G3<=14) as t;

/*All pass students famsize is */

INSERT OVERWRITE DIRECTORY '/AnalysisResult/24'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,famsize,g1,g2,g3 from (select * from math_students where G1>=15 and G2>=15 AND G3>=15) as t;


/* Starting Data Analysis for Portugese Students */

create table Pass_All_Grades_por as 
select * from por_students where G1>=15 AND G2>=15 AND G3>=15; 
     

/*2. Total number of pass students in grade 1 and grade 2? 1*/ 

create table Pass_Two_por as
select * from por_students where G1>=15 AND G2>=15 AND G3<=14;

/*3. Total number of  pass students in grade 1 only? 10*/

create table Pass_One_por as
select * from por_students where G1>=15 and G2<=14 AND G3<=14;

/*check comparison of students performance in previous grade.*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/10'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,sex,age,g1,g2,g3 from (select * from por_students where G1>=15 and G2<=14 AND G3<=14) as t;



/*2) All grade pass students address*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/11'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,address,g1,g2,g3 from (select * from por_students where G1>=15 AND G2>=15 AND G3>=15) as t;


/*All grade pass students traveltime */

INSERT OVERWRITE DIRECTORY '/AnalysisResult/12'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,traveltime,g1,g2,g3 from (select * from por_students where G1>=15 AND G2>=15 AND G3>=15) as t;


/*All grade pass students mother and father education*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/13'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,medu,fedu,g1,g2,g3 from (select * from por_students where G1>=15 AND G2>=15 AND G3>=15) as t;

/*2) G1 and G2 grade pass students address*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/14'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,address,g1,g2,g3 from (select * from por_students where G1>=15 AND G2>=15 AND G3<=14) as t;

/*2) G1 grade pass students address*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/15'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,address,g1,g2,g3 from (select * from por_students where G1>=15 and G2<=14 AND G3<=14) as t;


/*G1 grade pass students traveltime*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/16'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,traveltime,g1,g2,g3 from (select * from por_students where G1>=15 and G2<=14 AND G3<=14) as t;

/* G1 grade pass students mother and father education*/
INSERT OVERWRITE DIRECTORY '/AnalysisResult/17'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,medu,fedu,g1,g2,g3 from (select * from por_students where G1>=15 and G2<=14 AND G3<=14) as t;

/*All pass students famsize is */

INSERT OVERWRITE DIRECTORY '/AnalysisResult/23'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,famsize,g1,g2,g3 from (select * from por_students where G1>=15 and G2>=15 AND G3>=15) as t;

/*students who fail the famsize is gt3*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/18'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,famsize,g1,g2,g3 from (select * from por_students where G1>=15 and G2<=14 AND G3<=14) as t;

/* All pass math_students health and weekly alcohol consumption*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/19'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,walc,health,g1,g2,g3 from (select * from math_students where G1>=15 AND G2>=15 AND G3>=15) as t;

/* G1 Grade math_students health and weekly alcohol consumption*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/20'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,walc,health,g1,g2,g3 from (select * from math_students where G1>=15 and G2<=14 AND G3<=14) as t;

/* All pass por_students health and weekly alcohol consumption*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/21'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,walc,health,g1,g2,g3 from (select * from por_students where G1>=15 AND G2>=15 AND G3>=15) as t;

/* G1 Grade por_students health and weekly alcohol consumption*/

INSERT OVERWRITE DIRECTORY '/AnalysisResult/22'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
select school,age,sex,walc,health,g1,g2,g3 from (select * from por_students where G1>=15 and G2<=14 AND G3<=14) as t;









































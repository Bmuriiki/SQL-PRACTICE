1. //Query the two cities in STATION with the shortest and longest CITY names, as well as their 
  respective lengths (i.e.: number of characters in the name). 
  If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically. //

SELECT CITY,
       LENGTH(CITY) AS CITY_LENGTH
FROM STATION
ORDER BY LENGTH(CITY), CITY
FETCH FIRST 1 ROW ONLY;

SELECT CITY,
       LENGTH(CITY) AS CITY_LENGTH
FROM STATION
ORDER BY LENGTH(CITY) DESC, CITY
FETCH FIRST 1 ROW ONLY;

2. //Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
  Your result cannot contain duplicates.//

SELECT DISTINCT(CITY)
FROM STATION
WHERE LOWER(SUBSTR(CITY,1,1)) IN ('a','e','i','o','u');

3. //Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. 
  If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by 
  ascending ID.//
SELECT NAME
FROM STUDENTS
WHERE MARKS>75
ORDER BY RIGHT(NAME,3), ID ASC;




















1. /*Query the two cities in STATION with the shortest and longest CITY names, as well as their 
  respective lengths (i.e.: number of characters in the name). 
  If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically. */

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

2. /*Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
  Your result cannot contain duplicates.*/

SELECT DISTINCT(CITY)
FROM STATION
WHERE LOWER(SUBSTR(CITY,1,1)) IN ('a','e','i','o','u');

3. /*Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. 
  If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by 
  ascending ID.*/
SELECT NAME
FROM STUDENTS
WHERE MARKS>75
ORDER BY RIGHT(NAME,3), ID ASC;

4. /*You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, 
  and P is the parent of N. Write a query to find the node type of Binary Tree ordered by the value of the node. 
  Output one of the following for each node:
    Root: If node is root node.
    Leaf: If node is leaf node.
    Inner: If node is neither root nor leaf node. */

SELECT N,
       CASE WHEN P IS NULL THEN 'Root'
            WHEN N NOT IN (SELECT DISTINCT(P) FROM BST WHERE P IS NOT NULL) THEN 'Leaf'
            ELSE 'Inner'
            END
FROM BST
ORDER BY N;

5. /*Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the 
  following statements for each record in the table:
  Equilateral: It's a triangle with  sides of equal length.
  Isosceles: It's a triangle with  sides of equal length.
  Scalene: It's a triangle with  sides of differing lengths.
  Not A Triangle: The given values of A, B, and C don't form a triangle.*/

SELECT
       CASE 
            WHEN A+B<= C OR A+C<=B OR B+C<=A THEN  'Not A Triangle'
            WHEN A=B AND B=C THEN 'Equilateral'
            WHEN A=B OR B=C OR A=C THEN 'Isosceles'
            ELSE 'Scalene'
            END TRIANGLES_TYPE
FROM TRIANGLES;

6. /*Generate the following two result sets:

Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each 
profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and 
ASingerName(S).Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in 
ascending order, and output them in the following format:There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in 
OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], 
they should be ordered alphabetically.
Note: There will be at least two entries in the table for each type of occupation. */

SELECT NAME || '(' || SUBSTR(OCCUPATION,1,1) || ')'
FROM OCCUPATIONS
ORDER BY NAME;

SELECT 
    'There are a total of ' || COUNT(*) || ' ' || LOWER(OCCUPATION) || 's.'
FROM OCCUPATIONS
GROUP BY OCCUPATION
ORDER BY COUNT(*), OCCUPATION;

7. 
/*
   
*/
SELECT 
    c.company_code,
    c.founder,
    COUNT(DISTINCT lm.lead_manager_code) AS lead_managers,
    COUNT(DISTINCT sm.senior_manager_code) AS senior_managers,
    COUNT(DISTINCT m.manager_code) AS managers,
    COUNT(DISTINCT e.employee_code) AS employees
FROM Company c
LEFT JOIN Lead_Manager lm
    ON c.company_code = lm.company_code
LEFT JOIN Senior_Manager sm
    ON c.company_code = sm.company_code
LEFT JOIN Manager m
    ON c.company_code = m.company_code
LEFT JOIN Employee e
    ON c.company_code = e.company_code
GROUP BY 
    c.company_code,
    c.founder
ORDER BY c.company_code;


8. 
/*You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. It is guaranteed that the 
difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.If the End_Date of the tasks are 
consecutive, then they are part of the same project. Samantha is interested in finding the total number of different projects completed.
Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. 
If there is more than one project that have the same number of completion days, then order by the start date of the project.*/
SELECT
    MIN(START_DATE) PROJECT_START,
    MAX(END_DATE) PROJECT_END
FROM (
    SELECT
        START_DATE,
        END_DATE,
        START_DATE - ROW_NUMBER() OVER (ORDER BY START_DATE) DAYS GRP
    FROM PROJECTS
) X
GROUP BY GRP
ORDER BY
    DAYS(MAX(END_DATE)) - DAYS(MIN(START_DATE)),
    MIN(START_DATE);

9. /* You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. 
  Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and 
  Salary (offered salary in $ thousands per month).
Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by 
  the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.*/

SELECT S.NAME
FROM STUDENTS S JOIN FRIENDS F ON S.ID = F.ID
     JOIN PACKAGES P1 ON S.ID = P1.ID
     JOIN PACKAGES P2 ON F.FRIEND_ID = P2.ID
WHERE P2.SALARY > P1.SALARY
ORDER BY P2.SALARY;

10.  /* We define an employee's total earnings to be their monthly  worked, and the maximum total earnings to be the maximum total 
  earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as 
  the total number of employees who have maximum total earnings. Then print these values as  space-separated integers.*/

SELECT 
    MAX(SALARY * MONTHS) AS MAX_EARNINGS,
    COUNT(*) AS EMPLOYEE_COUNT
FROM EMPLOYEE
WHERE (SALARY * MONTHS) = (
    SELECT MAX(SALARY * MONTHS)
    FROM EMPLOYEE
);

11. /*Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345 . 
Truncate your answer to  decimal places.*/

SELECT DECIMAL(SUM(LAT_N), 10, 4)
FROM STATION
WHERE LAT_N > 38.7880
  AND LAT_N < 137.2345;

12. /*Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. 
Round your answer to  decimal places.*/
  
SELECT DECIMAL(LONG_W,10,4)
FROM STATION
WHERE LAT_N= (SELECT MAX(LAT_N)
       FROM STATION
       WHERE LAT_N<137.2345);

13. /*Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city 
populations (CITY.Population) rounded down to the nearest integer. Note: CITY.CountryCode and COUNTRY.Code are matching key columns.*/
SELECT COUNTRY.CONTINENT,
       FLOOR(AVG(CITY.POPULATION))
FROM CITY  JOIN COUNTRY
     on CITY.COUNTRYCODE=COUNTRY.CODE
GROUP BY COUNTRY.CONTINENT;

14. /*You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks. Ketty gives Eve a task to 
  generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received 
  a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more 
  than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. 
  Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more 
  than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
  Write a query to help Eve.*/

  SELECT
    CASE WHEN G.GRADE < 8 THEN NULL
    ELSE S.NAME
    END AS NAME,
    G.GRADE,
    S.MARKS
FROM STUDENTS S JOIN GRADES G
    ON S.MARKS BETWEEN G.MIN_MARK AND G.MAX_MARK
ORDER BY 2 DESC,1 ASC;
























































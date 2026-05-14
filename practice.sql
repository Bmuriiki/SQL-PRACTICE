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


















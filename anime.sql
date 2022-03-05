/*

Cleaning Data in SQL Queries

*/
SELECT 
    *
FROM
    anime;

-------------------------------------------------------------------------------------

-- Renaming 'DVD s' to 'DVD'

SELECT DISTINCT
    (Type)
FROM
    anime;
SELECT 
    Name, Type
FROM
    anime
WHERE
    Type = 'DVD S';
UPDATE anime 
SET 
    Type = 'DVD'
WHERE
    Type = 'DVD s';
    
-- Rounding the Rating Column to one decimal place    
    
SELECT 
    *, ROUND(Rating, 1)
FROM
    anime;
UPDATE anime 
SET 
    Rating = ROUND(Rating, 1);
    
-- Changing Double coma to single coma in Tags Column    
    
SELECT 
    REPLACE(Tags, ',,', ',')
FROM
    anime
WHERE
    Tags LIKE '%,,%';
UPDATE anime 
SET 
    Tags = REPLACE(Tags, ',,', ',')
WHERE
    Tags LIKE '%,,%';
    
-- Delecting Columns 'Japanese_name', 'Release_season', 'End_year'    
-- Deleting records where the 'Rating' is below 3.5 and 'Type' is Music
    
Alter table anime
drop column Japanese_name;
Alter table anime
drop column Release_season;
Alter table anime
drop column End_year;
DELETE FROM anime 
WHERE
    Rating > 3.5;
DELETE FROM anime 
WHERE
    Type = 'Music';
    
-- Adding a New column 'Based_on'
-- Breaking out Tags into a New Column 'Based_on'
    
SELECT 
    Tags,
    SUBSTR(Tags, LOCATE('Based', Tags)),
    REPLACE(Tags,
        SUBSTR(Tags, LOCATE('Based', Tags)),
        '')
FROM
    anime;
Alter table anime
add Based_on Text;
UPDATE anime 
SET 
    Based_on = SUBSTR(Tags, LOCATE('Based', Tags));
UPDATE anime 
SET 
    Tags = REPLACE(Tags,
        SUBSTR(Tags, LOCATE('Based', Tags)),
        '');
        
-- Handling Null Values        
        
SELECT 
    Name,
    IFNULL(Content_Warning, 'No Warning'),
    Content_Warning IS NULL,
    LENGTH(Content_Warning)
FROM
    anime;
UPDATE anime 
SET 
    Content_Warning = IFNULL(Content_Warning, 'No Warning');
UPDATE anime 
SET 
    Content_Warning = REPLACE(Content_warning,
        'No Warning',
        'Safe');
UPDATE anime 
SET 
    Episodes = IFNULL(Episodes, 'On going')
WHERE
    Type = 'TV';
UPDATE anime 
SET 
    Episodes = IFNULL(Episodes, 'On going')
WHERE
    Type = 'TV Sp';
UPDATE anime 
SET 
    Episodes = IFNULL(Episodes, 'On going')
WHERE
    Type = 'Dvd';
UPDATE anime 
SET 
    Episodes = IFNULL(Episodes, 1)
WHERE
    Type = 'Movie';
UPDATE anime 
SET 
    Based_on = NULL
WHERE
    LENGTH(Based_on) = 0;
    
-- Trimimg values in 'Type' column
    
SELECT DISTINCT
    (Type), LENGTH(Type)
FROM
    anime;
UPDATE anime 
SET 
    Type = RTRIM(Type);

-- Removing unwanted strings from column Tags

SELECT 
    Tags, SUBSTR(Tags, 1, LENGTH(Tags) - 2)
FROM
    anime;
UPDATE anime 
SET 
    Tags = SUBSTR(Tags, 1, LENGTH(Tags) - 2);



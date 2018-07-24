/* 1) List all the countries that start with a letter entered by the user (prompt). The user 
must enter a lowercase letter */

SELECT * FROM COUNTRIES
WHERE COUNTRY_NAME LIKE UPPER('&COUNTRY_NAME%');


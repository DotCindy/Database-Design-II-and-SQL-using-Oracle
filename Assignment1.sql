/* 1) Display the customer number, customer name and country code for all the customers that are 
in the UK. The country code for United Kingdom is UK. 
Please note that the user could have used UK, Uk, uk, uK. Your SQL must allow for various user 
inputs of the code. They are not entering the country name. */
-- SQL:
SELECT CUST_NO,
       CNAME,
       COUNTRY_CD
FROM CUSTOMERS
WHERE LOWER(COUNTRY_CD) = 'uk';

-- OUTPUT: 
/*   CUST_NO CNAME                          CO
---------- ------------------------------ --
      1025 Fresh Air Co 5                 UK
      1026 GO Outlet London               UK
      1065 Trees to Seas Ltd              UK
      1089 Rock Steady 3                  UK
      1111 Wally Mart 1                   UK
      1112 Wally Mart 2                   UK
      1120 GO Outlet London               UK
      1121 GO Outlet Manchester           UK
      1127 Fresh Air Co 1                 UK
      1128 Fresh Air Co 2                 UK
      1129 Fresh Air Co 3                 UK
      1134 Breathe Free ltd               UK
12 rows selected. */

/* 2) For any GO Outlets list the customer number, customer name and order number if they ordered 
any of these products -- 40303, 40301, 40306. Put result in customer number order. */
-- SQL:
SELECT CUST_NO,
       CNAME,
       ORDER_NO
FROM CUSTOMERS
LEFT JOIN ORDERS
USING (CUST_NO)
LEFT JOIN ORDERLINES
USING (ORDER_NO)
LEFT JOIN PRODUCTS
USING (PROD_NO)
WHERE (PROD_NO IN (40303,40301,40306)) AND
	 (CNAME LIKE ‘%GO Outlets%’
ORDER BY CUST_NO;

-- OUTPUT:
/*   CUST_NO CNAME                            ORDER_NO
---------- ------------------------------ ----------
      1009 GO Outlet Kista AB                    137
      1011 GO Outlet Singapore                   200
      1098 GO Outlet Madrid                       27
      1120 GO Outlet London                       49
      1121 GO Outlet Manchester                   15
      1122 GO Outlet New York                    278
      1122 GO Outlet New York                    218
7 rows selected. */

/* Display all orders for United Kingdom. 
The word entered is United Kingdom and not UK. 
Show only cities that start with L.
Display the customer number, customer name, order number, product name, the total dollars for that line on  the order. 
Give that last column the name of  Total. 
Put the output into customer number order from highest to lowest 
and display only order numbers less than 75 */
-- SQL:
SELECT CUST_NO,
       CNAME,
       ORDER_NO,
       PROD_NAME,
       PRICE*QTY*0.85 AS "Total"
FROM CUSTOMERS
LEFT JOIN ORDERS
USING (CUST_NO)
LEFT JOIN COUNTRIES
ON (COUNTRY_ID = COUNTRY_CD)
LEFT JOIN ORDERLINES
USING (ORDER_NO)
LEFT JOIN PRODUCTS
USING (PROD_NO)
WHERE (ORDER_NO < 75) AND 
      (COUNTRY_NAME = 'United Kingdom')  AND
      (CITY LIKE 'L%')
ORDER BY CUST_NO DESC;

-- OUTPUT:
/*   CUST_NO CNAME                            ORDER_NO PROD_NAME                           Total
---------- ------------------------------ ---------- ------------------------------ ----------
      1120 GO Outlet London                       61 Star Lite                          4768.5
      1120 GO Outlet London                       49 Pocket Water Filter                  3213
      1120 GO Outlet London                       29 MoonGlow                           1754.4
      1120 GO Outlet London                       49 Day Tripper                          11.9
      1120 GO Outlet London                       49 Pack n' Hike                        222.7
      1120 GO Outlet London                       49 GO Cookset                         1285.2
      1120 GO Outlet London                       29 GO Cookset                         1285.2
      1120 GO Outlet London                       61 GO Camp Kettle                    1303.05
      1120 GO Outlet London                       49 GO Headband                           272
      1120 GO Outlet London                       61 GO Wristband                        326.4
      1120 GO Outlet London                       29 GO Wristband                          544 
      1120 GO Outlet London                       29 Pocket U.V. Alerter                 474.3
      1120 GO Outlet London                       49 RiverKind Shampoo                   474.3
      1120 GO Outlet London                       29 RiverKind Detergent                1535.1
      1120 GO Outlet London                       61 Pro-Lite Water Filter              140.25
      1120 GO Outlet London                       61 Pocket Water Filter                7114.5
      1120 GO Outlet London                       61 MoonGlow                          1425.45
17 rows selected.  */

/* 4) Find the total dollar value for all orders from London. Each row will show customer name, 
order number and total dollars for the order. Sort by order number */
-- SQL:
SELECT CNAME,
       ORDER_NO,
       PRICE*QTY*0.85 AS “Total”
FROM CUSTOMERS
LEFT JOIN ORDERS
USING (CUST_NO)
LEFT JOIN ORDERLINES
USING (ORDER_NO)
LEFT JOIN PRODUCTS
USING (PROD_NO)
WHERE CITY = 'London'
ORDER BY ORDER_NO;

-- OUTPUT:
/* CNAME                            ORDER_NO      Total
------------------------------ ---------- ----------
GO Outlet London                       29      474.3
GO Outlet London                       29        544
GO Outlet London                       29     1754.4
GO Outlet London                       29     1535.1
GO Outlet London                       29     1285.2
GO Outlet London                       49     1285.2
GO Outlet London                       49       3213
GO Outlet London                       49      222.7
GO Outlet London                       49       11.9
GO Outlet London                       49      474.3
GO Outlet London                       49        272
GO Outlet London                       61    1303.05
GO Outlet London                       61    1425.45
GO Outlet London                       61     4768.5
GO Outlet London                       61      326.4
GO Outlet London                       61     7114.5
GO Outlet London                       61     140.25
GO Outlet London                      107      193.8
GO Outlet London                      107     1305.6
GO Outlet London                      107      217.6
GO Outlet London                      107      21148
GO Outlet London                      107      994.5
GO Outlet London                      107      336.6
Trees to Seas Ltd                     122     1686.4
Trees to Seas Ltd                     122       71.4
Trees to Seas Ltd                     122      450.5
Trees to Seas Ltd                     122      795.6
Trees to Seas Ltd                     122     872.95
Trees to Seas Ltd                     122     420.75
Trees to Seas Ltd                     170     104.55
Trees to Seas Ltd                     170      785.4
Trees to Seas Ltd                     170       2380
Trees to Seas Ltd                     170    1598.85
33 rows selected. */

/* 5) For all orders in the orders table supply order date and count of the number of orders on 
that date. Only include those from 2015 and have more then 1 order on that date. */
-- SQL:
SELECT ORDER_DT, COUNT(ORDER_DT) AS "ORDER NUMBER"
FROM ORDERS
GROUP BY ORDER_DT
HAVING COUNT(ORDER_DT) > 1
AND SUBSTR(ORDER_DT,8) = '2015';

-- OUTPUT:
/* ORDER_DT    ORDER NUMBER
----------- ------------
02-Apr-2015            3
28-Jan-2015            2
28-Feb-2015            2
29-Mar-2015            2
23-Feb-2015            2
09-Mar-2015            2
20-Mar-2015            2
26-Mar-2015            2
10-Feb-2015            3
12-Feb-2015            2
01-Apr-2015            2
11 rows selected. */
	
/* 6) The Sales Manager would like to see all orders in 2014 from United Kingdom and Canada.
Show the customer number, customer name and country name */
-- SQL:
SELECT CUST_NO,
       CNAME,
       COUNTRY_NAME
FROM CUSTOMERS
LEFT JOIN COUNTRIES
ON (COUNTRY_ID = COUNTRY_CD)
LEFT JOIN ORDERS
USING (CUST_NO)
WHERE (COUNTRY_NAME IN ('United Kingdom', 'Canada')) AND
      (SUBSTR(ORDER_DT,8) = '2014');

-- OUTPUT:
/*   CUST_NO CNAME                          COUNTRY_NAME                            
---------- ------------------------------ ----------------------------------------
      1065 Trees to Seas Ltd              United Kingdom                          
      1042 Vacation Central 4             Canada                                  
      1129 Fresh Air Co 3                 United Kingdom                          
      1025 Fresh Air Co 5                 United Kingdom                          
      1127 Fresh Air Co 1                 United Kingdom                          
      1048 Supras Camping Supplies 5      Canada                                  
      1048 Supras Camping Supplies 5      Canada                                  
      1128 Fresh Air Co 2                 United Kingdom                          
      1048 Supras Camping Supplies 5      Canada                                  
      1132 Excellence en Montagne         Canada                                  
      1111 Wally Mart 1                   United Kingdom                          
      1069 Andes Camping Supplies 3       Canada                                  
      1065 Trees to Seas Ltd              United Kingdom                          
      1129 Fresh Air Co 3                 United Kingdom                          
      1033 Supras Camping Suplies 3       Canada                                  
      1067 Andes Camping Supplies 1       Canada                                  
      1128 Fresh Air Co 2                 United Kingdom                          
      1069 Andes Camping Supplies 3       Canada                                  
      1128 Fresh Air Co 2                 United Kingdom                          
      1067 Andes Camping Supplies 1       Canada                                  
      1042 Vacation Central 4             Canada                                  
      1092 Clear Valley Waters 2          Canada                                  
      1092 Clear Valley Waters 2          Canada                                  
23 rows selected. */
			
/* 7) The President wants to know out of the 150 customers on file, how many customers have not 
placed an order? */
-- SQL:
SELECT COUNT(CUST_NO) AS "No Order Customers"
FROM CUSTOMERS 
LEFT JOIN ORDERS 
USING (CUST_NO)
WHERE ORDER_NO IS NULL;
			
-- OUTPUT:
/* No Order Customers
------------------
                47 */

/* 8) Show what customers (number and name) along with the country name for all customers that 
are in the same countries as the Supra customers. Limit the list to any customer that starts with 
the letters A or B. */
-- SQL:
SELECT CUST_NO, 
       CNAME, 
       COUNTRY_NAME
FROM CUSTOMERS 
LEFT JOIN COUNTRIES
ON (COUNTRY_ID = COUNTRY_CD)
WHERE ((CNAME LIKE 'A%') OR 
      (CNAME LIKE 'B%')) AND
       (COUNTRY_CD IN(SELECT COUNTRY_CD 
                     FROM CUSTOMERS 
                     WHERE CNAME LIKE '%Supra%'));

-- OUTPUT:
/*   CUST_NO CNAME                          COUNTRY_NAME                            
---------- ------------------------------ ----------------------------------------
      1086 All season camping goods       United States of America                
      1078 Act'N'Up Fitness 4             United States of America                
      1077 Act'N'Up Fitness 3             United States of America                
      1076 Act'N'Up Fitness 2             United States of America                
      1075 Act'N'Up Fitness 1             United States of America                
      1072 Advanced Climbing Ltd          United States of America                
      1012 Act'N'Up Fitness 5             United States of America                
      1133 Back woods up front Ltd.       Canada                                  
      1070 Andes Camping Supplies 4       Canada                                  
      1069 Andes Camping Supplies 3       Canada                                  
      1068 Andes Camping Supplies 2       Canada                                  
      1067 Andes Camping Supplies 1       Canada                                  
      1010 Andes Camping Supplies 6       Canada                                  
      1006 Bergsteiger G.m.b.H.           Germany                                 
14 rows selected.  */

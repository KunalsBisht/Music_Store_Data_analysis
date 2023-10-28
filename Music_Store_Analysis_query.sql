Q1) SENIOR MOST EMPLOYEE BASED ON JOB TITLE?

SELECT * from employee
order by levels desc
limit 1;


Q2) COUNTRY WITH MOST INVOICES?

SELECT COUNT(BILLING_COUNTRY) AS COUNT, BILLING_COUNTRY
FROM INVOICE
GROUP BY BILLING_COUNTRY
ORDER BY COUNT DESC


Q3) TOP 3 VALUES OF TOTAL INVOICES?

SELECT * FROM INVOICE
ORDER BY TOTAL DESC
LIMIT 3


Q4) BEST CUSTOMERS? CITY WITH HIGHEST SUM OF INVOICE TOTAL.. RETURN CITY NAME AND SUM OF ALL INVOICE TOTAL

SELECT BILLING_CITY,SUM(TOTAL) AS SUM
FROM INVOICE
GROUP BY BILLING_CITY
ORDER BY SUM DESC
LIMIT 3


Q5) BEST CUSTOMER? ONE WHO SPENT THE MOST MONEY

SELECT CUSTOMER.CUSTOMER_ID, CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME, SUM(INVOICE.TOTAL) AS SUM
FROM CUSTOMER
JOIN INVOICE ON CUSTOMER.CUSTOMER_ID=INVOICE.CUSTOMER_ID
GROUP BY CUSTOMER.CUSTOMER_ID
ORDER BY SUM DESC
LIMIT 1


Q6) RETURN EMAIL,FIRST NAME, LAST NAME & GENRE OF ALL ROCK MUSIC LISTENERS. RETURN EMAIL ALPHABETICALLY BY EMAIL

SELECT DISTINCT EMAIL,FIRST_NAME,LAST_NAME
FROM CUSTOMER
JOIN INVOICE ON CUSTOMER.CUSTOMER_ID=INVOICE.CUSTOMER_ID
JOIN INVOICE_LINE ON INVOICE.INVOICE_ID=INVOICE_LINE.INVOICE_ID
WHERE TRACK_ID IN (
                SELECT track_id FROM track
                JOIN genre ON track.genre_id=genre.genre_id
                WHERE genre.name LIKE 'Rock'
)
ORDER BY EMAIL;


Q7) ARTIST WITH MOST WRITTEN ROCK MUSIC. RETURN QUERY WITH ARTIST NAME AND TOTAL COUNT OF TOP 10 ROCK BAND

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;


Q8)Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milLiseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC;

select * from track


Q9) Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent

WITH best_selling_artist AS (
	SELECT artist.artist_id AS artist_id, artist.name AS artist_name, SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1
	)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;
	
	


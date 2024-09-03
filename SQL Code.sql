# Task 3.8 : Performing Queries
# Step 1: Find the average amount paid by the top 5 customers.
SELECT AVG (total_amount_paid) AS average
FROM (SELECT A.customer_id, A.first_name, A.last_name, D.country, C.city,
SUM(B.amount) AS total_amount_paid
FROM customer A
JOIN payment B ON A.customer_id = B.customer_id
JOIN address E ON A.address_id = E.address_id
JOIN city C ON E.city_id = C.city_id
JOIN country D ON C.country_id = D.country_id
WHERE C.city IN (SELECT city
FROM customer A
JOIN address E ON A.address_id = E.address_id
JOIN city C ON E.city_id = C.city_id
JOIN country D ON C.country_id = D.country_id
GROUP BY C.city
ORDER BY COUNT(A.customer_id) DESC
LIMIT 10)
GROUP BY
  A.customer_id, A.first_name, A.last_name, D.country, C.city
ORDER BY total_amount_paid DESC
LIMIT 5) AS total_amount_paid;

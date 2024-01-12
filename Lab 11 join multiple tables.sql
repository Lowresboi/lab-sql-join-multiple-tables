use sakila;

-- Display store ID, city, and country for each store:
SELECT s.store_id, a.address, a.address2, a.district, c.city
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS c ON a.city_id = c.city_id;

-- Display how much business, in dollars, each store brought in:
SELECT s.store_id, s.address_id, COALESCE(SUM(p.amount), 0) AS total_sales
FROM store s
LEFT JOIN payment p ON s.store_id = p.rental_id
GROUP BY s.store_id, s.address_id;

-- Average running time of films by category:
SELECT c.name, AVG(f.length) AS avg_running_time
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id 
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name;

-- Film categories that are longest:
SELECT c.name, MAX(f.length) AS max_running_time
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id 
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY max_running_time DESC;

-- Most frequently rented movies in descending order:
SELECT f.film_id, f.title, COUNT(r.rental_id) AS rental_frequency
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_frequency DESC;

-- Top five genres in gross revenue in descending order:
SELECT c.name, SUM(p.amount) AS gross_revenue
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id 
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- Check if "Academy Dinosaur" is available for rent from Store 1:
SELECT 
    CASE 
        WHEN COUNT(*) > 0 THEN 'Available'
        ELSE 'Not Available'
    END AS availability
FROM inventory i
JOIN film AS f ON i.film_id = f.film_id
JOIN store AS s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1;





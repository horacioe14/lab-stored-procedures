--  first name, last name, and emails of all the customers who rented Action movies.
-- Convert the query into a simple stored procedure. Use the following query:

use sakila;
drop procedure lab_stored_procedures_1;


DELIMITER // 
create procedure lab_stored_procedures_1()
begin 
select first_name, last_name, email
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name = "Action"
group by first_name, last_name, email;
end //
DELIMITER ;

call lab_stored_procedures_1();





-- 2. Update the stored procedure in a such manner 
-- that it can take a string argument for the category name and return the results
-- for all customers that rented movie of that category/genre. 
-- For eg., it could be action, animation, children, classics, etc.

delimiter //
create Procedure email_action2(in param varchar(50))
begin
 select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name COLLATE utf8mb4_general_ci = param
  group by first_name, last_name, email;
end;
//
delimiter ;
call email_action2("Action");
call email_action2("Travel");





-- 3. Write a query to check the number of movies released in each movie category. 
-- Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. 
-- Pass that number as an argument in the stored procedure.


drop procedure query_3;

delimiter $$
create Procedure query_3(in param2 int)
begin
	select fc.category_id, c.name, count(fc.film_id) as number_of_movies
	from sakila.film_category fc join sakila.category c 
	on fc.category_id = c.category_id
    group by c.name, fc.category_id
    having count(fc.film_id) COLLATE utf8mb4_general_ci > param2;
end;
$$
delimiter ;
call query_3(49);

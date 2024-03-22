-- Show all customer's firstname
SELECT c.firstname FROM customer c

-- Show all customer's information
SELECT c.* FROM customer c where c.firstname ='Pawara' -- Assume we choose 'Pawara'

-- Show all pet' information of each customer we choose
SELECT p.pet_id, p.name, pt.pet_type_name FROM pet p
Inner join customer c on c.customer_id = p.customer_id 
Inner join pet_type pt on pt.pet_type_id = p.pet_type_id
where c.firstname = 'Pawara'


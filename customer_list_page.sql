-- Get all owner's firstname
SELECT firstname FROM customer

-- Get the owner information
SELECT * FROM customer
	WHERE customer_id = 1 -- Assume we choose customer_id 1

-- Get name and pet type of all pets from the specific owner
SELECT p.name, pt.pet_type_name  FROM pet p	
INNER JOIN customer c ON p.customer_id = c.customer_id
INNER JOIN pet_type pt ON p.pet_type_id = pt.pet_type_id
	WHERE p.customer_id = 1 -- Assume we choose customer_id 1

-- Edit pet's information
update pet 
	set name = new_name,
	age = new_age,
	sex = new_sex,
	color = new_color,
	breed_id = new_breed_id,
	pet_type_id = new_pet_type_id,
	WHERE pet_id = 1; -- Assume we choose pet_id 1 

-- Delete a pet
DELETE FROM pet
	WHERE pet_id = 1; -- Assume we choose pet_id 1

-- To add a pet from the specific owner
INSERT INTO pet (name, age, sex, color, breed_id, pet_type_id, customer_id)
VALUES ('Pudding', 2, 'M', 'Orange', 17, 3, 1);
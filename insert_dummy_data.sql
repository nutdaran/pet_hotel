-- Insert the customer table 
INSERT INTO customer (firstname, lastname, tel_no, address)
VALUES ('Pawara', 'Somsongkul', '0999999999', '18/3 Moo.9 Leabklongtaweewattana Road, Bangkok, 10170'),
       ('Daran', 'Thawornwattanapol', '0888888888', 'Bangsan Street, Chonburi, 11101'),
       ('Chutimon', 'Srisombun', '0987654321', '6 Moo.1 Takham, Samphran, Nakornpathom, 73110');

-- Insert the pet_type table 
INSERT INTO pet_type (pet_type_name)
VALUES ('Cat'),
       ('Dog'),
       ('Exotic');

-- Insert the breed table 
------ Assuming pet_type_id 1 is Cat
------ Assuming pet_type_id 2 is Dog
------ Assuming pet_type_id 3 is Exotic
INSERT INTO breed (breed_name, pet_type_id)
VALUES ('Ragdoll', 1),   
	   ('Maine Coon',1),
	   ('Persian',1),
	   ('British Shorthair',1),
	   ('American Shorthair',1),
	   ('Scottish Fold',1),
	   ('Sphynx',1),
       ('Labrador Retriever', 2),             
	   ('German Shepherd', 2), 
       ('Golden Retriever', 2), 
	   ('French Bulldog', 2), 
	   ('Beagle', 2), 
	   ('Chihuahua', 2), 
       ('Bird', 3),            
       ('Rabbit', 3),  
       ('Sugar Glider', 3),  
       ('Hamster', 3);  

-- Insert the pet table 
INSERT INTO pet (name, age, sex, color, breed_id, pet_type_id, customer_id)
VALUES ('MhooP', 4, 'F', 'Light brown', 13, 2, 1),
       ('Khagi', 2, 'M', 'Grey', 4, 1, 2), 
       ('Puk pik', 1, 'M', 'Blue', 14, 3, 3);  

-- Insert the branch table 
INSERT INTO branch (branch_name, location)
VALUES ('Branch001', 'Silom, Bangkok'),
       ('Branch002', 'Phuttamonthon sai 4, Nakorn Pathom');

-- Insert the room table 
INSERT INTO room (room_name, status, price, branch_id, pet_type_id)
VALUES ('Standard Room', 'Occupied', 50.00, 1, 1),  
       ('Superior Room', 'Available', 75.00, 1, 1),  
       ('Small dog Room', 'Available', 60.00, 1, 2),
       ('Medium dog Room', 'Available', 90.00, 1, 2),
       ('Large dog Room', 'Available', 120.00, 1, 2),
       ('Room AC', 'Available', 75.00, 1, 3),
       ('Room Non-AC', 'Available', 60.00, 1, 3),
       ('Standard Room', 'Available', 50.00, 2, 1),  
       ('Superior Room', 'Available', 75.00, 2, 1),  
       ('Small dog Room', 'Available', 60.00, 2, 2),
       ('Medium dog Room', 'Available', 90.00, 2, 2),
       ('Large dog Room', 'Available', 120.00, 2, 2),
       ('Room AC', 'Available', 75.00, 2, 3),
       ('Room Non-AC', 'Available', 60.00, 2, 3);

-- Insert the booking table 
INSERT INTO booking (booking_ref, check_in_date, check_out_date, price, booking_status, customer_id, pet_id, branch_id, room_id)
VALUES ('A1234567', '2024-03-26', '2024-03-30', 300.00, 'Pending', 1, 1, 1, 3),  
       ('A2345678', '2024-03-19', '2024-04-20', 100.00, 'Arrived', 2, 2, 1, 1),  
       ('A3456789', '2024-04-12', '2024-04-15', 240.00, 'Finished', 3, 3, 1, 7);  

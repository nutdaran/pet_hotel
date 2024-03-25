-- Insert the customer table 
INSERT INTO customer (firstname, lastname, tel_no, address)
VALUES ('Pawara', 'Somsongkul', '0999999999', '18/3 Moo.9 Leabklongtaweewattana Road, Bangkok, 10170'),
       ('Daran', 'Thawornwattanapol', '0888888888', 'Rama2 Street, Bangkok, 10150'),
       ('Chutimon', 'Srisombun', '0987654321', '6 Moo.1 Takham, Samphran, Nakornpathom, 73110'),
       ('Himpor', 'Piyaboonpaphol', '0923456789', 'Bang na, Samutprakarn, 11100'),
       ('Minmin', 'Thawornwattanapol', '0912345678', 'Ban Bueng, Chonburi, 20170'),
       ('Opal', 'Som', '0919876543', 'Salaya, Nakornpathom, 73110'),
       ('Nut', 'Tha', '0917893456', 'Salaya, Nakornpathom, 73110');

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
       ('Hamster', 3),
       ('Ball python',3);

-- Insert the pet table 
INSERT INTO pet (name, age, sex, color, breed_id, pet_type_id, customer_id)
VALUES ('MhooP', 4, 'F', 'Light brown', 13, 2, 1),
       ('Mel', 1, 'F', 'Green', 14, 3, 1),
       ('Khagi', 7, 'M', 'Brown',18, 3, 2),
       ('Puk pik', 1, 'M', 'Blue', 14, 3, 3),
       ('Inging', 9, 'F', 'Brown', 12, 2, 4),
       ('Lucky', 5, 'M', 'White', 8, 2, 5),
       ('Milo', 1, 'M', 'Muave', 14, 3, 6),
       ('Sonya',7, 'F', 'Silver', 3, 1, 7);

-- Insert the branch table 
INSERT INTO branch (branch_name, location)
VALUES ('Branch001', 'Silom, Bangkok'),
       ('Branch002', 'Phuttamonthon sai 4, Nakornpathom');

-- Insert the room_type table 
INSERT INTO room_type (room_type_name, price, pet_type_id)
VALUES ('Standard Room', 50.00, 1),
       ('Superior Room', 75.00, 1),
       ('Small dog Room', 60.00, 2),
       ('Medium dog Room', 90.00, 2),
       ('Large dog Room', 120.00, 2),
       ('Room AC', 75.00, 3),
       ('Room Non-AC', 60.00, 3);

-- Insert the room table 
INSERT INTO room (room_num, status, room_type_id, branch_id )
VALUES ('101','Occupied', 1, 1),
	('111','Available', 1, 1),
	('121','Available', 1, 1),
	('102','Available', 2, 1),
	('201','Available', 3, 1),
	('202','Available', 4, 1),
	('203','Available', 5, 1),
	('301','Occupied', 6, 1),
	('302','Occupied', 7, 1),
	('101','Available', 1, 2),
	('102','Available', 2, 2),
	('201','Available', 3, 2),
	('202','Available', 4, 2),
	('203','Available', 5, 2),
	('301','Available', 6, 2),
	('302','Available', 7, 2);
	

-- Insert the booking table 
INSERT INTO booking (booking_ref, check_in_date, check_out_date, price, booking_status, customer_id, pet_id, branch_id, room_id)
VALUES ('A345678', '2024-03-10', '2024-03-15', 300.00, 'Finished',7, 8, 1, 1), -- Nut, Sonya
       ('K678901', '2024-03-11', '2024-03-12', 150.00, 'Finished', 3, 3, 1, 8), -- Chutimon, Puk pik
       ('A123456', '2024-03-25', '2024-03-28', 300.00, 'Arrived', 6, 7, 1, 8), -- Opal, Milo
       ('A234567', '2024-03-25', '2024-03-28', 50.00, 'Arrived', 7,8, 1, 1), -- Nut, Sonya
       ('A124354', '2024-03-25', '2024-03-27', 180.00, 'Arrived', 2, 3, 1, 9), -- Daran, Khagi
       ('A124567', '2024-03-28', '2024-03-30', 180.00, 'Pending', 1, 1, 1, 5), -- Pawara, MoohP
       ('A234678', '2024-03-28', '2024-03-31', 240.00, 'Pending', 2, 3, 1, 9), -- Daran, Khagi
       ('J876432', '2024-04-02','2024-04-05', 240.00, 'Pending', 4, 5, 2, 13); -- Himpor, Inging, B2

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

-- Insert the room table 
INSERT INTO room (room_name, room_num, status, price, branch_id, pet_type_id)
VALUES ('Standard Room', '101', 'Occupied', 50.00, 1, 1),
       ('Superior Room', '102', 'Available', 75.00, 1, 1),
       ('Small dog Room', '201', 'Available', 60.00, 1, 2),
       ('Medium dog Room', '202', 'Occupied', 90.00, 1, 2),
       ('Large dog Room', '203', 'Available', 120.00, 1, 2),
       ('Room AC', '301', 'Occupied', 75.00, 1, 3),
       ('Room Non-AC', '302', 'Occupied', 60.00, 1, 3),
       ('Standard Room', '101', 'Available', 50.00, 2, 1),
       ('Superior Room', '102', 'Available', 75.00, 2, 1),
       ('Small dog Room', '201', 'Available', 60.00, 2, 2),
       ('Medium dog Room', '202', 'Available', 90.00, 2, 2),
       ('Large dog Room', '203', 'Available', 120.00, 2, 2),
       ('Room AC', '303', 'Available', 75.00, 2, 3),
       ('Room Non-AC', '302', 'Available', 60.00, 2, 3);

-- Insert the booking table 
INSERT INTO booking (booking_ref, check_in_date, check_out_date, price, booking_status, customer_id, pet_id, branch_id, room_id)
VALUES ('A345678', '2024-03-10', '2024-03-15', 300.00, 'Finished',7, 5, 1, 1), -- Nut, Sonya
       ('K678901', '2024-03-11', '2024-03-12', 150.00, 'Finished', 3, 3, 1, 6), -- Chutimon, Puk pik
       ('A123456', '2024-03-25', '2024-03-28', 300.00, 'Arrived', 6, 7, 1, 6), -- Opal, Milo
       ('A234567', '2024-03-27', '2024-03-28', 50.00, 'Arrived', 7,8, 1, 1), -- Nut, Sonya
       ('A124354', '2024-03-25', '2024-03-29', 300.00, 'Arrived', 2, 3, 1, 7), -- Daran, Khagi
       ('J764324', '2024-03-26', '2024-03-28', 270.00, 'Arrived', 5, 6, 1, 4),  -- Minmin, Lucky
       ('A124567', '2024-03-28', '2024-03-30', 180.00, 'Pending', 1, 1, 1, 3), -- Pawara, MoohP
       ('A234678', '2024-03-28', '2024-03-31', 240.00, 'Pending', 2, 3, 1, 7), -- Daran, Khagi
       ('J876432', '2024-04-02','2024-04-05', 240.00, 'Pending', 4, 5, 2, 10); -- Himpor, Inging, B2

-- Create the customer table 
Drop table if exists customer CASCADE;
CREATE TABLE customer
(
  customer_id SERIAL PRIMARY KEY,
  firstname VARCHAR(255) NOT NULL,
  lastname VARCHAR(255) NOT NULL,
  tel_no VARCHAR(10) NOT NULL,
  address VARCHAR(255) NOT NULL
);

-- Create the pet_type table 
Drop table if exists pet_type CASCADE;
CREATE TABLE pet_type
(
  pet_type_id SERIAL PRIMARY KEY,
  pet_type_name VARCHAR(255) NOT NULL
);

-- Create the breed table 
Drop table if exists breed CASCADE;
CREATE TABLE breed
(
  breed_id SERIAL PRIMARY KEY,
  breed_name VARCHAR(255) NOT NULL,
  pet_type_id INT NOT NULL,
  FOREIGN KEY (pet_type_id) REFERENCES pet_type(pet_type_id)
);

-- Create the pet table 
Drop table if exists pet CASCADE;
CREATE TABLE pet
(
  pet_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  age INT NOT NULL,
  sex CHAR(1) NOT NULL,
  color VARCHAR(255) NOT NULL,
  breed_id INT NOT NULL,
  pet_type_id INT NOT NULL,
  customer_id INT NOT NULL,
  FOREIGN KEY (breed_id) REFERENCES breed(breed_id),
  FOREIGN KEY (pet_type_id) REFERENCES pet_type(pet_type_id),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Create the branch table 
Drop table if exists branch CASCADE;
CREATE TABLE branch
(
  branch_id SERIAL PRIMARY KEY,
  branch_name VARCHAR(255) NOT NULL,
  location VARCHAR(255) NOT NULL
);

-- Create the room_type table 
Drop table if exists room_type CASCADE;
CREATE TABLE room_type
(
  room_type_id SERIAL PRIMARY KEY,
  room_type_name VARCHAR(255) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  pet_type_id INT NOT NULL,
  FOREIGN KEY (pet_type_id) REFERENCES pet_type(pet_type_id)
);

-- Create the room table 
Drop table if exists room CASCADE;
CREATE TABLE room
(
  room_id SERIAL PRIMARY KEY,
  room_num CHAR(3) NOT NULL,
  status VARCHAR(10) NOT NULL,
  room_type_id INT NOT NULL,
  branch_id INT NOT NULL,
  FOREIGN KEY (room_type_id) REFERENCES room_type(room_type_id),
  FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Create the booking table 
Drop table if exists booking CASCADE;
CREATE TABLE booking
(
  booking_id SERIAL PRIMARY KEY,
  booking_ref CHAR(7) NOT NULL,
  check_in_date DATE NOT NULL,
  check_out_date DATE NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  booking_status VARCHAR(255) NOT NULL,
  customer_id INT NOT NULL,
  pet_id INT NOT NULL,
  branch_id INT NOT NULL,
  room_id INT NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY (pet_id) REFERENCES pet(pet_id),
  FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
  FOREIGN KEY (room_id) REFERENCES room(room_id)
);

-- ADD INDEX

-- Set index on room_num column in room table
create index idx_room_num on
    room (room_num);

-- Set index on room_type_id and branch column in room table
create index idx_rt_branch on
    room (room_type_id, branch_id);

-- Set index on firstname column in customer table
create index idx_customer_name on
    customer (firstname);

-- Set index on name and customer_is column in pet table
create index idx_pet_owner on
    pet (name, customer_id);

-- Set index on booking_ref column in booking table
create index idx_booking_ref on
    booking (booking_ref);

-- Set index on check_in_date and branch_id column in booking table
create index idx_check_in on
    booking (check_in_date, branch_id);

-- Set index on check_out_date and branch_id column in booking table
create  index idx_check_out on
    booking (check_out_date, branch_id);
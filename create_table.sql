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

-- Create the room table 
Drop table if exists room CASCADE;
CREATE TABLE room
(
  room_id SERIAL PRIMARY KEY,
  room_num CHAR(3) NOT NULL,
  room_name VARCHAR(255) NOT NULL,
  status VARCHAR(10) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  branch_id INT NOT NULL,
  pet_type_id INT NOT NULL,
  FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
  FOREIGN KEY (pet_type_id) REFERENCES pet_type(pet_type_id)
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
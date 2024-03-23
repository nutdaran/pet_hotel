
CREATE OR REPLACE PROCEDURE make_booking(
  customer_firstname TEXT,
  customer_lastname TEXT,
  customer_tel_no TEXT,
  customer_address TEXT,
  pet_name TEXT,
  pet_age INT,
  pet_sex TEXT,
  pet_color TEXT,
  breed_id INT,
  new_pet_type_id INT,
  check_in_date DATE,
  check_out_date DATE,
  new_room_type_id INT,
  new_branch_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
  new_customer_id INT;
  new_pet_id INT;
  total_date INT;
  room_type_name_var VARCHAR(255);
  price_var DECIMAL(10, 2);
  total_price DECIMAL(10, 2);
  available_room_id INT;
BEGIN
  -- Add owner information to customer table
  INSERT INTO customer (firstname, lastname, tel_no, address)
  VALUES (customer_firstname, customer_lastname, customer_tel_no, customer_address)
  RETURNING customer_id INTO new_customer_id;

  -- Add pet information to pet table
  INSERT INTO pet (name, age, sex, color, breed_id, pet_type_id, customer_id)
  VALUES (pet_name, pet_age, pet_sex, pet_color, breed_id, new_pet_type_id, new_customer_id)
  RETURNING pet_id INTO new_pet_id;

  -- Retrieve room type name and price
  SELECT room_type_name, price INTO room_type_name_var, price_var
  FROM room_type 
  WHERE pet_type_id = new_pet_type_id;

  -- Get total date from check-in-date and check-out-date
  total_date := CAST(DATE_PART('day', check_out_date) - DATE_PART('day', check_in_date) + 1 AS INTEGER);

  -- Calculate the total price by multiplying total date with price per night
  total_price := price_var * total_date;

  -- Get a room_id and room_num --> available room(s)
  SELECT room_id INTO available_room_id FROM room
  WHERE branch_id = new_branch_id AND room_type_id = new_room_type_id AND status = 'Available'
  ORDER BY RANDOM()
  LIMIT 1;

  -- Insert a booking
  INSERT INTO booking (booking_ref, check_in_date, check_out_date, price, booking_status, customer_id, pet_id, branch_id, room_id)
  VALUES (LPAD(FLOOR(random() * (POWER(10, 8) - 1))::text || SUBSTRING('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789', floor(random() * 36)::int + 1, 1), 7, '0'), 
      check_in_date, 
      check_out_date, 
      total_price, 
      'Pending',
      new_customer_id, 
      new_pet_id, 
      new_branch_id, 
      available_room_id);

  -- Commit the transaction if successful
  COMMIT;
END $$;


-- Call a procedure by using dummy data
CALL make_booking(
  'Lalisa',           -- customer_firstname
  'Manobal',          -- customer_lastname
  '0900000000',       -- customer_tel_no
  'South Korea 999',  -- customer_address
  'Leo',              -- pet_name
  5,                  -- pet_age
  'M',                -- pet_sex
  'brown',            -- pet_color
  6,                  -- breed_id
  1,                  -- new_pet_type_id
  '2024-04-01',       -- check_in_date
  '2024-04-05',       -- check_out_date
  2,                  -- new_room_type_id
  1                   -- new_branch_id
);


CALL make_booking(
  'Opal',             -- customer_firstname
  'Somsongkul',       -- customer_lastname
  '0000000000',       -- customer_tel_no
  'BKK',              -- customer_address
  'MheePooh',         -- pet_name
  8,                  -- pet_age
  'F',                -- pet_sex
  'orange',           -- pet_color
  17,                 -- breed_id
  3,                  -- new_pet_type_id
  '2024-04-05',       -- check_in_date
  '2024-04-13',       -- check_out_date
  6,                  -- new_room_type_id
  2                   -- new_branch_id
);

-- Trigger function: update room status for walk-in booking
create or replace function change_room_status()
returns trigger
language plpgsql
as $$
    begin
    if NEW.check_in_date = current_date then
        UPDATE room
        SET status = 'Occupied'
        WHERE room_id = NEW.room_id;
    end if;

    return null;
    end;
$$;

drop trigger if exists add_walkin_booking_room_status on booking;
create trigger add_walkin_booking_room_status
    after insert
    on booking
    for each row
    execute procedure change_room_status();

-- Trigger function: update booking status for walk-in booking
create or replace function walkin_booking_status()
returns trigger
language plpgsql
as $$
    begin
    if NEW.check_in_date = current_date then
        NEW.booking_status := 'Arrived';
    end if;
    return NEW;
    end;
$$;

drop trigger if exists add_walkin_booking_booking_status on booking;
create trigger add_walkin_booking_booking_status
    before insert
    on booking
    for each row
    execute procedure walkin_booking_status();
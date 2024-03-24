
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
  select * from insert_customer(customer_firstname,
                                customer_lastname,
                                customer_tel_no,
                                customer_address) into new_customer_id;

  -- Add pet information to pet table
  select * from insert_pet(pet_name,
                           pet_age,
                           pet_sex,
                           pet_color,
                           breed_id,
                           new_pet_type_id,
                           new_customer_id) into new_pet_id;

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

CREATE OR REPLACE FUNCTION insert_customer(
    customer_firstname TEXT,
    customer_lastname TEXT,
    customer_tel_no TEXT,
    customer_address TEXT
)
RETURNS INT AS
$$
DECLARE
    new_customer_id INT;
BEGIN
    -- Check if the customer already exists
    SELECT customer_id INTO new_customer_id
    FROM customer
    WHERE firstname = customer_firstname
    AND lastname = customer_lastname;

    -- If the customer doesn't exist, insert a new record
    IF new_customer_id IS NULL THEN
        INSERT INTO customer (firstname, lastname, tel_no, address)
        VALUES (customer_firstname, customer_lastname, customer_tel_no, customer_address)
        RETURNING customer_id INTO new_customer_id;
    END IF;

    RETURN new_customer_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_pet(
    pet_name TEXT,
    pet_age INT,
    pet_sex TEXT,
    pet_color TEXT,
    breed_id INT,
    new_pet_type_id INT,
    c_id INT
)
RETURNS INT AS
$$
DECLARE
    new_pet_id INT;
BEGIN
    -- Check if the customer already exists
    SELECT pet_id INTO new_pet_id
    FROM pet
    WHERE name = pet_name
    AND customer_id = c_id;

    -- If the pet doesn't exist, insert a new record
    IF new_pet_id IS NULL THEN
         INSERT INTO pet (name, age, sex, color, breed_id, pet_type_id, customer_id)
          VALUES (pet_name, pet_age, pet_sex, pet_color, breed_id, new_pet_type_id, c_id)
          RETURNING pet_id INTO new_pet_id;
    END IF;

    RETURN new_pet_id;
END;
$$ LANGUAGE plpgsql;

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

-- Check the available rooms during that period before insert new booking and return a table of available room for user to book
CREATE OR REPLACE FUNCTION get_available_rooms(branch INT, check_in DATE, check_out DATE, pet_type INT)
RETURNS TABLE(room_id INT, room_num CHAR(3)) AS
    $$
    BEGIN
        RETURN QUERY
        SELECT r.room_id, r.room_num
        FROM room r
        JOIN room_type rt ON r.room_type_id = rt.room_type_id
        WHERE r.branch_id = branch
        AND rt.pet_type_id = pet_type
        AND NOT EXISTS (
            SELECT 1
            FROM booking b
            WHERE r.room_id = b.room_id
            AND (
                (check_in BETWEEN b.check_in_date AND b.check_out_date)
                OR (check_out BETWEEN b.check_in_date AND b.check_out_date)
                OR (check_in <= b.check_in_date AND check_out >= b.check_out_date)
            )
        );

        IF NOT FOUND THEN
            RAISE NOTICE 'No available rooms for the specified date range';
        END IF;
    END;
    $$ LANGUAGE plpgsql;

select * from get_available_rooms(1,'2024-03-25','2024-03-26',3); --Exotic

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
  '2024-03-23',       -- check_in_date
  '2024-03-27',       -- check_out_date
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

-- same customer but new pet
CALL make_booking(
  'Opal',             -- customer_firstname
  'Somsongkul',       -- customer_lastname
  '0000000000',       -- customer_tel_no
  'BKK',              -- customer_address
  'Mali',         -- pet_name
  3,                  -- pet_age
  'F',                -- pet_sex
  'black',           -- pet_color
  11,                 -- breed_id
  2,                  -- new_pet_type_id
  '2024-04-05',       -- check_in_date
  '2024-04-13',       -- check_out_date
  3,                  -- new_room_type_id
  1                   -- new_branch_id
);
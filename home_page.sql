-- Get Number Of Available Room in Branch 1
select count(*) from public.room
where status ='Available' and branch_id = 1;

-- Get Number Of Available Room in Branch 1
select count(*) from public.room
where status ='Occupied' and branch_id = 1;

-- Get Expected Arrival Booking List in Branch 1
SELECT b.booking_ref, p.name as pet_name, c.firstname as owner_name
FROM booking b
	
Inner join pet p on b.pet_id = p.pet_id

Inner join customer c on b.customer_id = c.customer_id
	
WHERE b.check_in_date = (
    SELECT MIN(check_in_date)
    FROM booking
    WHERE check_in_date >= '2024-03-28' -- Assume today is 28-03-2024
) AND b.booking_status = 'Pending' AND b.branch_id = 1; 


-- Get Expected Departure Booking List in Branch 1
SELECT b.booking_ref, p.name as pet_name, c.firstname as owner_name
FROM booking b
	
Inner join pet p on b.pet_id = p.pet_id

Inner join customer c on b.customer_id = c.customer_id
	
WHERE b.check_out_date = (
    SELECT MIN(check_out_date)
    FROM booking
    WHERE check_out_date >= '2024-03-28' -- Assume today is 28-03-2024
) AND b.booking_status = 'Arrived' AND b.branch_id = 1; 

-- procedure
create or replace procedure change_booking_status(ref TEXT, new_status TEXT) as
$$
    begin
        update booking b
        set booking_status = new_status
        where b.booking_ref = ref;
    end;
$$ language PLPGSQL;

-- Trigger function: update room status for booking
CREATE OR REPLACE FUNCTION update_room_status()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.booking_status = 'Arrived' THEN
        UPDATE room
        SET status = 'Occupied'
        WHERE room_id = NEW.room_id;
    ELSIF NEW.booking_status = 'Finished' THEN
        UPDATE room
        SET status = 'Available'
        WHERE room_id = NEW.room_id;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Drop trigger if it exists
DROP TRIGGER IF EXISTS booking_status_trigger ON booking;

-- Create trigger to invoke the trigger function upon changes in booking table
CREATE TRIGGER booking_status_trigger
AFTER UPDATE OF booking_status ON booking
FOR EACH ROW
EXECUTE FUNCTION update_room_status();

-- Update Expected Arrival Booking status: "Pending" -> "Arrived"
call change_booking_status('A124567','Arrived');

select * from booking where booking_ref='A124567';
select change_booking_status('A124567','Arrived');
select * from booking where booking_ref='A124567';

-- Update Expect Departure Booking status: "Arrived" -> Finished
call change_booking_status('A123456','Finished');

select * from booking where booking_ref='A123456';
select change_booking_status('A123456','Finished');
select * from booking where booking_ref='A123456';

-- Create a function to search Booking Ref./ Pet Name/ Owner Name 
CREATE OR REPLACE FUNCTION search(text TEXT)
RETURNS TABLE(
  booking_ref CHAR(8),
  pet_name VARCHAR(255),
  owner_name VARCHAR(255)
) AS $$
BEGIN
  RETURN QUERY
    SELECT b.booking_ref, p.name AS pet_name, c.firstname AS owner_name
    FROM booking b
    INNER JOIN pet p ON b.pet_id = p.pet_id
    INNER JOIN customer c ON b.customer_id = c.customer_id
    WHERE b.booking_ref LIKE '%' || text || '%' 
      OR p.name LIKE '%' || text || '%' 
      OR c.firstname LIKE '%' || text || '%';
END;
$$ LANGUAGE plpgsql;

-- Run a function search
SELECT * FROM search('678');

-- Add new branch
INSERT INTO branch (branch_name, location)
VALUES ('Branch003','Phraram9, Bangkok');
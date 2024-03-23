-- Create Booking history view to reduce calling join
DROP VIEW IF EXISTS booking_history;

CREATE VIEW booking_history AS
SELECT b.booking_ref, c.firstname as owner_name, p.name as pet_name,
       b.check_in_date, b.check_out_date,  b.price as total_price
       from booking b
       inner join public.pet p on p.pet_id = b.pet_id
       inner join public.customer c on c.customer_id = b.customer_id
       where b.booking_status = 'Finished' and b.branch_id = 1;

-- Query Booking History in Branch 1
select * from booking_history;

-- sort Booking Ref
SELECT  * FROM booking_history ORDER BY booking_ref ASC;
SELECT  * FROM booking_history ORDER BY booking_ref DESC;

-- sort Owner name
SELECT  * FROM booking_history ORDER BY owner_name ASC;
SELECT  * FROM booking_history ORDER BY owner_name DESC;

-- sort Pet name
SELECT  * FROM booking_history ORDER BY pet_name ASC;
SELECT  * FROM booking_history ORDER BY pet_name DESC;

-- sort Check-in date
SELECT  * FROM booking_history ORDER BY check_in_date ASC;
SELECT  * FROM booking_history ORDER BY check_in_date DESC;

-- sort Check-out date
SELECT  * FROM booking_history ORDER BY check_out_date ASC;
SELECT  * FROM booking_history ORDER BY check_out_date DESC;

-- sort Total price
SELECT  * FROM booking_history ORDER BY total_price ASC;
SELECT  * FROM booking_history ORDER BY total_price DESC;
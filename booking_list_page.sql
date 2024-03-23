DROP VIEW IF EXISTS current_booking_list;

CREATE VIEW current_booking_list AS
SELECT b.booking_ref, c.firstname as owner_name, p.name as pet_name,
            b.check_in_date, b.check_out_date,  b.price as total_price
            from booking b
            inner join public.pet p on p.pet_id = b.pet_id
            inner join public.customer c on c.customer_id = b.customer_id
            where b.booking_status <> 'Finished' and b.branch_id = 1;

SELECT  * FROM current_booking_list;

-- sort Booking Ref
SELECT  * FROM current_booking_list ORDER BY booking_ref ASC;
SELECT  * FROM current_booking_list ORDER BY booking_ref DESC;

-- sort Owner name
SELECT  * FROM current_booking_list ORDER BY owner_name ASC;
SELECT  * FROM current_booking_list ORDER BY owner_name DESC;

-- sort Pet name
SELECT  * FROM current_booking_list ORDER BY pet_name ASC;
SELECT  * FROM current_booking_list ORDER BY pet_name DESC;

-- sort Check-in date
SELECT  * FROM current_booking_list ORDER BY check_in_date ASC;
SELECT  * FROM current_booking_list ORDER BY check_in_date DESC;

-- sort Check-out date
SELECT  * FROM current_booking_list ORDER BY check_out_date ASC;
SELECT  * FROM current_booking_list ORDER BY check_out_date DESC;

-- sort Total price
SELECT  * FROM current_booking_list ORDER BY total_price ASC;
SELECT  * FROM current_booking_list ORDER BY total_price DESC;
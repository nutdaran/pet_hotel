-- Get Number Of Available Room in Branch 1
select count(*) from public.room
where status='Available' and branch_id='1';

-- Get Number Of Available Room in Branch 1
select count(*) from public.room
where status='Occupied' and branch_id='1';

-- Get Expected Arrival Booking List in Branch 1
SELECT b.booking_ref as booking_ref, p.name as pet_name, c.firstname as owner_name
FROM booking b

Inner join pet p on b.pet_id = p.pet_id

Inner join customer c on b.customer_id = c.customer_id

where b.check_in_date = '2024-03-28'; -- Assume today is 28-03-2024

-- Get Expected Departure Booking List in Branch 1
SELECT b.booking_ref as booking_ref, p.name as pet_name, c.firstname as owner_name
FROM booking b

Inner join pet p on b.pet_id = p.pet_id

Inner join customer c on b.customer_id = c.customer_id

where b.check_out_date = '2024-03-28';

-- create a function to change booking status
create or replace function change_booking_status(ref TEXT, new_status TEXT)
returns void as
$$
    update booking b
    set booking_status = new_status
    where b.booking_ref = ref
$$ LANGUAGE SQL;

-- Update Expected Arrival Booking status: "Pending" -> "Arrived"
select * from booking where booking_ref='A124567';

select change_booking_status('A124567','Arrived');

select * from booking where booking_ref='A124567';

-- Update Expect Departure Booking status: "Arrived" -> Finished
select * from booking where booking_ref='A123456';

select change_booking_status('A123456','Arrived');

select * from booking where booking_ref='A123456';
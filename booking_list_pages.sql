-- Create Booking view to reduce calling join
drop view if exists booking_detail;
create view booking_detail as
    select b.booking_ref as booking_ref, c.firstname as owner_name, p.name as pet_name,
    b.check_in_date, b.check_out_date,  b.price as total_price, b.branch_id, b.booking_status
    from booking b
    inner join public.pet p on p.pet_id = b.pet_id
    inner join public.customer c on c.customer_id = b.customer_id;


-- Query Booking History in Branch 1
select * from booking_detail
where booking_status = 'Finished' and branch_id = 1;

-- Query all current booking in Branch 1
select * from booking_detail
where booking_status <> 'Finished' and branch_id = 1;
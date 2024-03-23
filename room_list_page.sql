-- Get all room type name and pet type name
SELECT CONCAT(rt.room_type_name, ' (', pt.pet_type_name, ')') as room_type from room_type rt
INNER JOIN pet_type pt ON rt.pet_type_id = pt.pet_type_id

-- Get the room information
SELECT rt.room_type_name, pt.pet_type_name, rt.price from room_type rt
INNER JOIN pet_type pt ON rt.pet_type_id = pt.pet_type_id
	WHERE rt.room_type_id = 1 -- Assume we choose room_type 1

-- Get all rooms in the specific room type
SELECT room_num, status FROM room 
	where room_type_id = 1 AND branch_id =1 -- Assume we choose room_type 1 and branch 1

-- To add a room in the specific room type
INSERT INTO room (room_num, status, room_type_id, branch_id )
VALUES ('131','Available', 1, 1); 

-- Edit room number
update room 
	set room_num = new_room_num
	WHERE room_id = 1 AND branch_id = 1; -- Assume we choose room_id 1 and branch 1

-- Delete room
DELETE FROM room
	WHERE room_id = 1 AND branch_id = 1; -- Assume we choose room_id 1 and branch 1

-- To add a new room type 
INSERT INTO room_type (room_type_name, price, pet_type_id)
VALUES ('Deluxe Room', 100.00, 1);
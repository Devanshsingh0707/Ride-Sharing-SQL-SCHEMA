
-- Ride Sharing Database

DROP TABLE IF EXISTS ratings CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS rides CASCADE;
DROP TABLE IF EXISTS vehicles CASCADE;
DROP TABLE IF EXISTS drivers CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- USERS table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    user_type VARCHAR(10) NOT NULL CHECK (user_type IN ('driver','rider')),
    created_at TIMESTAMP DEFAULT NOW()
);

-- DRIVERS table
CREATE TABLE drivers (
    driver_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE NOT NULL, -- link to users table
    license_number VARCHAR(50),
    rating NUMERIC(2,1) DEFAULT 5.0,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- VEHICLES table
CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    driver_id INT NOT NULL,
    vehicle_model VARCHAR(100) NOT NULL,
    plate_number VARCHAR(20) UNIQUE NOT NULL,
    vehicle_type VARCHAR(20),
    color VARCHAR(20),
    manufacture_year INT,
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id) ON DELETE CASCADE
);

-- RIDES table
CREATE TABLE rides (
    ride_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,        -- passenger (references users)
    driver_id INT NOT NULL,      -- driver assigned (references drivers)
    vehicle_id INT NOT NULL,     -- vehicle used (references vehicles)
    pickup_location VARCHAR(200) NOT NULL,
    drop_location VARCHAR(200) NOT NULL,
    distance_km NUMERIC(6,2) NOT NULL,
    fare NUMERIC(10,2) NOT NULL,
    ride_status VARCHAR(20) NOT NULL CHECK (ride_status IN ('Completed','Cancelled','Ongoing')),
    requested_time TIMESTAMP NOT NULL,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

-- PAYMENTS table
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    ride_id INT UNIQUE NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    method VARCHAR(10) NOT NULL CHECK (method IN ('UPI','Card','Cash')),
    payment_status VARCHAR(10) NOT NULL CHECK (payment_status IN ('Paid','Pending','Failed')),
    payment_time TIMESTAMP,
    FOREIGN KEY (ride_id) REFERENCES rides(ride_id) ON DELETE CASCADE
);

-- RATINGS table
CREATE TABLE ratings (
    rating_id SERIAL PRIMARY KEY,
    ride_id INT NOT NULL,
    user_id INT NOT NULL,
    driver_id INT NOT NULL,
    rating SMALLINT CHECK (rating BETWEEN 1 AND 5),
    review TEXT,
    rating_time TIMESTAMP,
    FOREIGN KEY (ride_id) REFERENCES rides(ride_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);


-- riders
INSERT INTO users (user_id, user_name, phone, email, user_type, created_at) VALUES
(1,'Aarav','900000001','aarav1@mail.com','rider',NOW()),
(2,'Vivaan','900000002','vivaan2@mail.com','rider',NOW()),
(3,'Aditya','900000003','aditya3@mail.com','rider',NOW()),
(4,'Kabir','900000004','kabir4@mail.com','rider',NOW()),
(5,'Arjun','900000005','arjun5@mail.com','rider',NOW()),
(6,'Krishna','900000006','krishna6@mail.com','rider',NOW()),
(7,'Rohan','900000007','rohan7@mail.com','rider',NOW()),
(8,'Reyansh','900000008','rey8@mail.com','rider',NOW()),
(9,'Dhruv','900000009','dhruv9@mail.com','rider',NOW()),
(10,'Ishaan','900000010','ishaan10@mail.com','rider',NOW()),
(11,'Naira','900000011','naira11@mail.com','rider',NOW()),
(12,'Anaya','900000012','anaya12@mail.com','rider',NOW()),
(13,'Diya','900000013','diya13@mail.com','rider',NOW()),
(14,'Aadhya','900000014','aadhya14@mail.com','rider',NOW()),
(15,'Myra','900000015','myra15@mail.com','rider',NOW()),
(16,'Sara','900000016','sara16@mail.com','rider',NOW()),
(17,'Meera','900000017','meera17@mail.com','rider',NOW()),
(18,'Navya','900000018','navya18@mail.com','rider',NOW()),
(19,'Kiara','900000019','kiara19@mail.com','rider',NOW()),
(20,'Anvi','900000020','anvi20@mail.com','rider',NOW()),
(21,'Mihir','900000021','mihir21@mail.com','rider',NOW()),
(22,'Aman','900000022','aman22@mail.com','rider',NOW()),
(23,'Dev','900000023','dev23@mail.com','rider',NOW()),
(24,'Yash','900000024','yash24@mail.com','rider',NOW()),
(25,'Laksh','900000025','laksh25@mail.com','rider',NOW()),
(26,'Harsh','900000026','harsh26@mail.com','rider',NOW()),
(27,'Sahil','900000027','sahil27@mail.com','rider',NOW()),
(28,'Om','900000028','om28@mail.com','rider',NOW()),
(29,'Jatin','900000029','jatin29@mail.com','rider',NOW()),
(30,'Ritik','900000030','ritik30@mail.com','rider',NOW()),
(31,'Arnav','900000031','arnav31@mail.com','rider',NOW()),
(32,'Samar','900000032','samar32@mail.com','rider',NOW()),
(33,'Avi','900000033','avi33@mail.com','rider',NOW()),
(34,'Rudra','900000034','rudra34@mail.com','rider',NOW()),
(35,'Veer','900000035','veer35@mail.com','rider',NOW()),
(36,'Ayush','900000036','ayush36@mail.com','rider',NOW()),
(37,'Raghav','900000037','raghav37@mail.com','rider',NOW()),
(38,'Virat','900000038','virat38@mail.com','rider',NOW()),
(39,'Kiaan','900000039','kiaan39@mail.com','rider',NOW()),
(40,'Tanish','900000040','tanish40@mail.com','rider',NOW()),
-- drivers 
(41,'Driver1','910000001','d1@mail.com','driver',NOW()),
(42,'Driver2','910000002','d2@mail.com','driver',NOW()),
(43,'Driver3','910000003','d3@mail.com','driver',NOW()),
(44,'Driver4','910000004','d4@mail.com','driver',NOW()),
(45,'Driver5','910000005','d5@mail.com','driver',NOW()),
(46,'Driver6','910000006','d6@mail.com','driver',NOW()),
(47,'Driver7','910000007','d7@mail.com','driver',NOW()),
(48,'Driver8','910000008','d8@mail.com','driver',NOW()),
(49,'Driver9','910000009','d9@mail.com','driver',NOW()),
(50,'Driver10','910000010','d10@mail.com','driver',NOW()),
(51,'Driver11','910000011','d11@mail.com','driver',NOW()),
(52,'Driver12','910000012','d12@mail.com','driver',NOW()),
(53,'Driver13','910000013','d13@mail.com','driver',NOW()),
(54,'Driver14','910000014','d14@mail.com','driver',NOW()),
(55,'Driver15','910000015','d15@mail.com','driver',NOW()),
(56,'Driver16','910000016','d16@mail.com','driver',NOW()),
(57,'Driver17','910000017','d17@mail.com','driver',NOW()),
(58,'Driver18','910000018','d18@mail.com','driver',NOW()),
(59,'Driver19','910000019','d19@mail.com','driver',NOW()),
(60,'Driver20','910000020','d20@mail.com','driver',NOW());

-- driver details
INSERT INTO drivers (driver_id, user_id, license_number, rating) VALUES
(1,41,'MH01A1001',4.9),
(2,42,'MH01A1002',4.8),
(3,43,'MH01A1003',4.7),
(4,44,'MH01A1004',4.9),
(5,45,'MH01A1005',4.6),
(6,46,'MH01A1006',5.0),
(7,47,'MH01A1007',4.5),
(8,48,'MH01A1008',4.8),
(9,49,'MH01A1009',4.9),
(10,50,'MH01A1010',4.7),
(11,51,'MH01A1011',4.8),
(12,52,'MH01A1012',4.6),
(13,53,'MH01A1013',4.5),
(14,54,'MH01A1014',4.9),
(15,55,'MH01A1015',4.7),
(16,56,'MH01A1016',4.8),
(17,57,'MH01A1017',4.6),
(18,58,'MH01A1018',4.5),
(19,59,'MH01A1019',4.9),
(20,60,'MH01A1020',4.8);

-- Vehicle
INSERT INTO vehicles (driver_id, vehicle_model, plate_number, vehicle_type, color, manufacture_year) VALUES
(1, 'Honda City', 'DL03AB1234', 'Car', 'White', 2019),
(2, 'Hyundai Creta', 'MH12CD9087', 'Car', 'Black', 2021),
(3, 'Maruti Swift', 'KA05EF3321', 'Car', 'Red', 2018),
(4, 'Royal Enfield Classic 350', 'DL09GH4455', 'Bike', 'Blue', 2020),
(5, 'Maruti WagonR', 'UP16JK7712', 'Car', 'Silver', 2017),
(6, 'Honda Activa 6G', 'MH03LM5523', 'Bike', 'Grey', 2022),
(7, 'Toyota Innova Crysta', 'DL02XY9988', 'Car', 'White', 2020),
(8, 'Bajaj Pulsar 220', 'KA04ZA1123', 'Bike', 'Black', 2019),
(9, 'Hyundai i20', 'MH14RT4456', 'Car', 'Red', 2021),
(10, 'Suzuki Access 125', 'DL07MN6543', 'Bike', 'Silver', 2018),
(11, 'Tata Nexon', 'UP14QS7765', 'Car', 'Blue', 2023),
(12, 'TVS Jupiter', 'KA03PL5566', 'Bike', 'Brown', 2020),
(13, 'Mahindra XUV300', 'MH15FF9090', 'Car', 'Black', 2019),
(14, 'Royal Enfield Meteor', 'DL10JJ4451', 'Bike', 'Yellow', 2022),
(15, 'Maruti Baleno', 'KA01TT8765', 'Car', 'White', 2021),
(16, 'Honda Unicorn 160', 'UP32AA5643', 'Bike', 'Black', 2017),
(17, 'Hyundai Venue', 'MH13HY2231', 'Car', 'Silver', 2020),
(18, 'TVS Apache RTR 160', 'DL08LK9876', 'Bike', 'Red', 2019),
(19, 'Toyota Fortuner', 'KA09CD1221', 'Car', 'Black', 2022),
(20, 'Honda Shine', 'UP18EE7788', 'Bike', 'Grey', 2018);

-- Ride 
INSERT INTO rides (user_id, driver_id, vehicle_id, pickup_location, drop_location, distance_km, fare, ride_status, requested_time, start_time, end_time) VALUES
(1, 1, 1, 'Connaught Place', 'India Gate', 4.2, 120.00, 'Completed', '2025-01-10 08:10', '2025-01-10 08:15', '2025-01-10 08:30'),
(2, 2, 2, 'Bandra', 'Andheri', 7.5, 180.00, 'Completed', '2025-01-11 09:00', '2025-01-11 09:05', '2025-01-11 09:25'),
(3, 3, 3, 'Indiranagar', 'Majestic', 9.1, 220.00, 'Completed', '2025-01-12 10:20', '2025-01-12 10:25', '2025-01-12 10:50'),
(4, 4, 4, 'Saket', 'Hauz Khas', 3.0, 90.00, 'Completed', '2025-01-13 11:00', '2025-01-13 11:02', '2025-01-13 11:15'),
(5, 5, 5, 'Noida Sec 18', 'Akshardham', 12.3, 260.00, 'Completed', '2025-01-14 07:40', '2025-01-14 07:45', '2025-01-14 08:20'),
(6, 6, 6, 'Pune Station', 'Mg Road', 5.5, 140.00, 'Completed', '2025-01-15 14:10', '2025-01-15 14:15', '2025-01-15 14:35'),
(7, 7, 7, 'Karol Bagh', 'Rajouri Garden', 6.7, 160.00, 'Completed', '2025-01-16 19:00', '2025-01-16 19:05', '2025-01-16 19:30'),
(8, 8, 8, 'Whitefield', 'Koramangala', 11.2, 250.00, 'Completed', '2025-01-17 18:30', '2025-01-17 18:35', '2025-01-17 19:05'),
(9, 9, 9, 'Vashi', 'Panvel', 18.4, 420.00, 'Completed', '2025-01-18 20:10', '2025-01-18 20:20', '2025-01-18 21:00'),
(10, 10, 10, 'Gurgaon Cyber City', 'Delhi Airport T3', 9.9, 250.00, 'Completed', '2025-01-19 06:00', '2025-01-19 06:05', '2025-01-19 06:25'),
(11, 11, 11, 'Noida Sec 62', 'Botanical Garden', 4.8, 110.00, 'Completed', '2025-01-20 13:30', '2025-01-20 13:35', '2025-01-20 13:50'),
(12, 12, 12, 'Koramangala', 'HSR Layout', 3.9, 95.00, 'Completed', '2025-01-21 15:10', '2025-01-21 15:12', '2025-01-21 15:25'),
(13, 13, 13, 'Thane', 'Colaba', 32.5, 700.00, 'Completed', '2025-01-22 09:00', '2025-01-22 09:05', '2025-01-22 10:30'),
(14, 14, 14, 'Punjabi Bagh', 'Pitampura', 8.1, 190.00, 'Completed', '2025-01-23 17:10', '2025-01-23 17:15', '2025-01-23 17:40'),
(15, 15, 15, 'BTM Layout', 'Electronic City', 14.2, 300.00, 'Completed', '2025-01-24 18:00', '2025-01-24 18:10', '2025-01-24 18:50'),
(16, 16, 16, 'Ghazipur', 'Connaught Place', 10.5, 230.00, 'Completed', '2025-01-25 21:10', '2025-01-25 21:15', '2025-01-25 21:45'),
(17, 17, 17, 'Baner', 'Kothrud', 7.3, 170.00, 'Completed', '2025-01-26 08:30', '2025-01-26 08:35', '2025-01-26 08:55'),
(18, 18, 18, 'Lajpat Nagar', 'South Ex', 2.5, 75.00, 'Completed', '2025-01-27 11:00', '2025-01-27 11:02', '2025-01-27 11:12'),
(19, 19, 19, 'Electronic City', 'Hebbal', 21.1, 480.00, 'Completed', '2025-01-28 10:40', '2025-01-28 10:45', '2025-01-28 11:30'),
(20, 20, 20, 'Noida Sec 15', 'GIP Mall', 3.2, 85.00, 'Completed', '2025-01-29 19:00', '2025-01-29 19:05', '2025-01-29 19:18'),
(1, 2, 2, 'Dwarka', 'Janakpuri', 5.6, 145.00, 'Completed', '2025-01-30 08:30', '2025-01-30 08:35', '2025-01-30 08:55'),
(2, 3, 3, 'Bandra', 'BKC', 4.1, 120.00, 'Completed', '2025-01-30 09:10', '2025-01-30 09:12', '2025-01-30 09:25'),
(3, 4, 4, 'Koramangala', 'Indiranagar', 6.2, 160.00, 'Completed', '2025-01-30 10:00', '2025-01-30 10:05', '2025-01-30 10:25'),
(4, 5, 5, 'Saket', 'Malviya Nagar', 1.8, 60.00, 'Completed', '2025-01-30 11:00', '2025-01-30 11:01', '2025-01-30 11:10'),
(5, 6, 6, 'Noida Sec 76', 'Sec 18', 6.7, 150.00, 'Completed', '2025-01-30 12:00', '2025-01-30 12:05', '2025-01-30 12:25'),
(6, 7, 7, 'Pune Camp', 'Katraj', 9.4, 210.00, 'Completed', '2025-01-30 13:00', '2025-01-30 13:05', '2025-01-30 13:30'),
(7, 8, 8, 'Rajouri Garden', 'Janakpuri', 3.9, 100.00, 'Completed', '2025-01-30 14:00', '2025-01-30 14:03', '2025-01-30 14:15'),
(8, 9, 9, 'Whitefield', 'ITPL', 2.7, 70.00, 'Completed', '2025-01-30 15:00', '2025-01-30 15:03', '2025-01-30 15:12'),
(9, 10, 10, 'Andheri', 'Powai', 5.8, 140.00, 'Completed', '2025-01-30 16:00', '2025-01-30 16:05', '2025-01-30 16:25');

-- Payment
INSERT INTO payments (ride_id, amount, method, payment_status, payment_time) VALUES
(1, 120.00, 'UPI', 'Paid', '2025-01-10 08:31'),
(2, 180.00, 'Card', 'Paid', '2025-01-11 09:26'),
(3, 220.00, 'UPI', 'Paid', '2025-01-12 10:51'),
(4, 90.00, 'Cash', 'Paid', '2025-01-13 11:16'),
(5, 260.00, 'UPI', 'Paid', '2025-01-14 08:21'),
(6, 140.00, 'UPI', 'Paid', '2025-01-15 14:36'),
(7, 160.00, 'Card', 'Paid', '2025-01-16 19:31'),
(8, 250.00, 'UPI', 'Paid', '2025-01-17 19:06'),
(9, 420.00, 'Card', 'Paid', '2025-01-18 21:01'),
(10, 250.00, 'UPI', 'Paid', '2025-01-19 06:26'),
(11, 110.00, 'Cash', 'Paid', '2025-01-20 13:51'),
(12, 95.00, 'UPI', 'Paid', '2025-01-21 15:26'),
(13, 700.00, 'Card', 'Paid', '2025-01-22 10:31'),
(14, 190.00, 'UPI', 'Paid', '2025-01-23 17:41'),
(15, 300.00, 'UPI', 'Paid', '2025-01-24 18:51'),
(16, 230.00, 'Cash', 'Paid', '2025-01-25 21:46'),
(17, 170.00, 'UPI', 'Paid', '2025-01-26 08:56'),
(18, 75.00, 'Cash', 'Paid', '2025-01-27 11:13'),
(19, 480.00, 'Card', 'Paid', '2025-01-28 11:31'),
(20, 85.00, 'UPI', 'Paid', '2025-01-29 19:19'),
(21, 145.00, 'UPI', 'Paid', '2025-01-30 08:56'),
(23, 160.00, 'Card', 'Paid', '2025-01-30 10:26'),
(24, 60.00, 'UPI', 'Paid', '2025-01-30 11:11'),
(25, 150.00, 'Cash', 'Paid', '2025-01-30 12:26'),
(26, 210.00, 'UPI', 'Paid', '2025-01-30 13:31'),
(27, 100.00, 'UPI', 'Paid', '2025-01-30 14:16'),
(28, 70.00, 'Cash', 'Paid', '2025-01-30 15:13'),
(29, 140.00, 'UPI', 'Paid', '2025-01-30 16:26');

-- Ratings
INSERT INTO ratings (ride_id, user_id, driver_id, rating, review, rating_time) VALUES
(1, 1, 1, 5, 'Smooth ride, polite driver', '2025-01-10 08:40'),
(2, 2, 2, 4, 'Good driving, car was clean', '2025-01-11 09:40'),
(3, 3, 3, 5, 'Fast and comfortable', '2025-01-12 11:00'),
(4, 4, 4, 4, 'Quick drop, no issues', '2025-01-13 11:25'),
(5, 5, 5, 5, 'Great ride', '2025-01-14 08:30'),
(7, 7, 7, 5, 'Very polite', '2025-01-16 19:40'),
(8, 8, 8, 4, 'Traffic was heavy but ok', '2025-01-17 19:20'),
(9, 9, 9, 5, 'Comfortable long ride', '2025-01-18 21:10'),
(10, 10, 10, 4, 'Nice driver', '2025-01-19 06:35'),
(12, 12, 12, 5, 'Fast and safe', '2025-01-21 15:40'),
(13, 13, 13, 5, 'Excellent service', '2025-01-22 10:45'),
(14, 14, 14, 4, 'Decent ride', '2025-01-23 17:50'),
(15, 15, 15, 5, 'Great experience', '2025-01-24 19:00'),
(17, 17, 17, 5, 'Very punctual', '2025-01-26 09:05'),
(18, 18, 18, 4, 'Short ride, good driver', '2025-01-27 11:20'),
(19, 19, 19, 5, 'Excellent ride', '2025-01-28 11:40'),
(20, 20, 20, 4, 'Quick and easy', '2025-01-29 19:25'),
(21, 1, 2, 5, 'Good pickup timing', '2025-01-30 09:10'),
(22, 2, 3, 4, 'Comfortable ride', '2025-01-30 09:35'),
(23, 3, 4, 5, 'Friendly driver', '2025-01-30 10:35')



-- Queries

-- 1. Get all users
SELECT * FROM users;

-- 2. List all drivers with their license numbers
SELECT d.driver_id, u.user_name AS driver_name, d.license_number
FROM drivers d
JOIN users u ON d.user_id = u.user_id;

-- 3. Get all vehicles with their assigned driver
SELECT v.vehicle_id, v.vehicle_model, u.user_name AS driver_name
FROM vehicles v
JOIN drivers d ON v.driver_id = d.driver_id
JOIN users u ON d.user_id = u.user_id;

-- 4. Get ride history of a specific user
SELECT r.ride_id, r.pickup_location, r.drop_location, r.fare, r.ride_status
FROM rides r
WHERE r.user_id = 5;

-- 5. Count total completed rides
SELECT COUNT(*) AS completed_rides
FROM rides
WHERE ride_status = 'Completed';

-- 6. Calculate total revenue from successful payments
SELECT SUM(amount) AS total_revenue
FROM payments
WHERE payment_status = 'Paid';

-- 7. Driver performance based on average rating
SELECT u.user_name AS driver_name, AVG(rt.rating) AS avg_rating
FROM drivers d
JOIN ratings rt ON d.driver_id = rt.driver_id
JOIN users u ON d.user_id = u.user_id
GROUP BY u.user_name;

-- 8. Show all rides for a particular driver(driver_id=3)
SELECT ride_id, pickup_location, drop_location, fare, ride_status
FROM rides
WHERE driver_id = 3;

-- 9. Find all failed or pending payments
SELECT *
FROM payments
WHERE payment_status != 'Paid';

-- 10. Top 5 drivers with the most completed rides
SELECT d.driver_id, u.user_name AS driver_name, COUNT(*) AS total_completed
FROM drivers d
JOIN rides r ON d.driver_id = r.driver_id
JOIN users u ON d.user_id = u.user_id
WHERE r.ride_status = 'Completed'
GROUP BY d.driver_id, u.user_name
ORDER BY total_completed DESC
LIMIT 5;

-- 13. Show all rides with user and driver names
SELECT r.ride_id, u.user_name AS rider_name, ud.user_name AS driver_name, r.fare, r.ride_status
FROM rides r
JOIN users u ON r.user_id = u.user_id
JOIN drivers d ON r.driver_id = d.driver_id
JOIN users ud ON d.user_id = ud.user_id;

-- 14. Rides created in the last 7 days
SELECT *
FROM rides
WHERE requested_time >= timestamp '2025-01-31' - INTERVAL '7 days';

-- 15. Average fare per kilometer
SELECT AVG(fare / NULLIF(distance_km,0)) AS avg_fare_per_km
FROM rides
WHERE distance_km > 0;

-- 16. Drivers who have not completed any rides
SELECT d.driver_id, u.user_name AS driver_name
FROM drivers d
LEFT JOIN users u ON d.user_id = u.user_id
LEFT JOIN rides r ON d.driver_id = r.driver_id
WHERE r.ride_id IS NULL;


-- 17. Total rides and total earnings grouped by driver
SELECT u.user_name AS driver_name,
       COUNT(r.ride_id) AS total_rides,
       COALESCE(SUM(p.amount),0) AS total_earnings
FROM drivers d
LEFT JOIN rides r ON d.driver_id = r.driver_id
LEFT JOIN payments p ON r.ride_id = p.ride_id
JOIN users u ON d.user_id = u.user_id
GROUP BY u.user_name;

-- 18. Top-rated drivers (avg rating >= 4.5)
SELECT u.user_name AS driver_name, AVG(rt.rating) AS avg_rating
FROM drivers d
JOIN ratings rt ON d.driver_id = rt.driver_id
JOIN users u ON d.user_id = u.user_id
GROUP BY u.user_name
HAVING AVG(rt.rating) >= 4.5;

-- 19. Number of rides by status (ongoing, completed, cancelled)
SELECT ride_status, COUNT(*) AS total
FROM rides
GROUP BY ride_status;

-- 20. Payment method distribution (UPI, Cash, Card)
SELECT method, COUNT(*) AS total_transactions
FROM payments
GROUP BY method;

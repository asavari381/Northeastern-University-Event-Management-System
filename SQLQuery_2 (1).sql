-- CREATE MASTER KEY
-- ENCRYPTION BY PASSWORD = 'NUEvents123';
-- -- Create certificate to protect symmetric key
-- CREATE CERTIFICATE NUEventsCertificate
-- WITH SUBJECT = 'NUEvents Test Certificate',
-- EXPIRY_DATE = '2027-10-31';
-- -- Create symmetric key to encrypt data
-- CREATE SYMMETRIC KEY NUEventsSymmetricKey
-- WITH ALGORITHM = AES_128
-- ENCRYPTION BY CERTIFICATE NUEventsCertificate;
-- -- Open symmetric key
OPEN SYMMETRIC KEY NUEventsSymmetricKey
DECRYPTION BY CERTIFICATE NUEventsCertificate;



-- -- Insert data into Users Table
INSERT INTO Users (Fname, Lname, BirthDate, UserPhone, UserEmail) VALUES 
('John', 'Doe', '1985-01-23',EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'32442345'),'john.doe@email.com'),
('Jane', 'Smith', '1990-04-15', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'213444'),'jane.smith@email.com'),
('Brooke', 'Sanders', '1946-01-13', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'37622153'),'randylewis@gmail.com'),
('Matthew', 'Odonnell', '1991-08-31', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'18420170'),'sburns@yahoo.com'),
('Mary', 'Cox', '1990-01-13', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'53483380'),'summersnathaniel@yahoo.com'),
('Eric', 'Thomas', '1961-02-01', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'72290190'),'ygardner@hensley.com'),
('John', 'Martin', '1964-09-12', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'92927856'),'paynecarla@yahoo.com'),
('Joel', 'Lewis', '1991-07-21', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'22006611'),'robertshepard@gmail.com'),
('Amber', 'Harrison', '1979-12-06', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'73284121'),'wparker@yahoo.com'),
('Kevin', 'Barnett', '1969-03-28', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'86014229'),'christopher15@yahoo.com');

-- -- Insert data into Venue Table
INSERT INTO Venue (VenueName, VenueLocation, Capacity) VALUES 
('Kerr Hall', 'Boston, MA',500),
('Light Hall', 'Boston, MA',200),
('Melvin Hall', 'Boston, MA',450),
('Smith Hall', 'Boston, MA',1000),
('Speare Hall', 'Boston, MA',300),
('Stetson East', 'Boston, MA',500),
('Stetson West', 'Boston, MA',600),
('White Hall', 'Boston, MA',200),
('Ell Hall', 'Boston, MA',200),
('Black Auditorium', 'Boston, MA',1000)

-- -- Insert data into Schedule Table
INSERT INTO Schedule (Date, StartTime, EndTime) VALUES 
('2024-09-15', '18:00', '22:00'),
('2024-10-01', '10:00', '20:00'),
('2024-09-20', '09:00', '17:00'),
('2024-09-25', '10:00', '15:00'),
('2024-10-05', '12:00', '18:00'),
('2024-10-10', '11:00', '16:00'),
('2024-10-15', '08:00', '14:00'),
('2024-10-20', '19:00', '23:00'),
('2024-11-01', '09:30', '13:00'),
('2024-11-05', '14:00', '20:00');


INSERT INTO Budget ( EventID, TotalBudget, Expenditure) VALUES 
(6, 20000, 15000),
(15, 20000, 15000),
(14, 20000, 15000),
(11, 30000, 22000),
(12, 25000, 18000),
(9, 40000, 35000),
(7, 15000, 10000),
(8, 18000, 12000),
(9, 5000, 3000),
(10, 30000, 25000);

-- -- Insert data into Organizer Table
-- INSERT INTO Organizer (OrganizerName, OrganizerEmail, OrganizerPhone) VALUES 
-- ('Event Masters', 'contact@eventmasters.com', '123-456-7890'),
-- ('Party Planners', 'info@partyplanners.net', '098-765-4321');
OPEN SYMMETRIC KEY NUEventsSymmetricKey
DECRYPTION BY CERTIFICATE NUEventsCertificate;
UPDATE Organizer
SET OrganizerPhone = EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), CONVERT(VARCHAR,OrganizerPhone));
INSERT INTO Organizer (OrganizerName, OrganizerEmail, OrganizerPhone) VALUES 
('Event Masters', 'contact@eventmasters.com',EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '123-456-7890')),
('Party Planners', 'info@partyplanners.net', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '098-765-4321')),
('Global Gatherings', 'contact@globalgatherings.com',EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),  '234-567-8901')),
('Festive Affairs', 'info@festiveaffairs.org', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '345-678-9012')),
('Elite Events', 'hello@eliteevents.net', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '456-789-0123')),
('Celebration Co.', 'bookings@celebrationco.com', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '567-890-1234')),
('Premier Planning', 'inquiries@premierplanning.org', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '678-901-2345')),
('Occasion Organizers', 'contact@occasionorganizers.net', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '789-012-3456')),
('Event Horizon', 'events@eventhorizon.com', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '890-123-4567')),
('Splendid Soirees', 'hello@splendidsoirees.org', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '901-234-5678'));

-- -- Assuming the Organizer, Schedule, and Venue tables have data already and we know their IDs
-- -- Insert data into Event Table
INSERT INTO Events (EventName, OrganizerID, ScheduleID, VenueID, EventDescription) VALUES 
('Tech Conference', 41, 11, 11, 'A conference about the latest in technology trends.'),
('Music Festival', 44, 12, 12, 'An outdoor festival featuring various musical acts.'),
('Art & Design Expo', 43, 13,13, 'A showcase of the latest trends in art and design.'),
('Health & Wellness Retreat', 45, 14, 14, 'A retreat focused on health, wellness, and personal growth.'),
('International Film Festival', 42, 15, 15, 'Screenings of international films, documentaries, and shorts.'),
('FoodieCon', 46, 16, 16, 'A convention for food lovers, featuring tastings, workshops, and celebrity chefs.'),
('Literature Festival', 48, 17, 17, 'A celebration of literature with readings, signings, and panels.'),
('Eco-Friendly Expo', 47, 18, 18, 'An expo dedicated to sustainable living and eco-friendly innovations.'),
('Startup Pitch Night', 49, 19, 19, 'An evening where startups pitch their ideas to potential investors.'),
('Science & Innovation Fair', 50, 20, 20, 'A fair showcasing the latest in scientific research and innovative technologies.');

-- -- Insert data into Ticket Table (assuming EventID and UserID from previously inserted records)
INSERT INTO Ticket (EventID, UserID, TicketPrice, TicketType, TicketStatus, TicketLevel) VALUES 
(16, 41, 199.99, 'Conference', 'Confirmed', 'General'),
(17, 42, 49.99, 'Festival', 'Confirmed', 'VIP'),
(18, 43, 299.99, 'Conference', 'Confirmed', 'General'),
(19, 45, 89.99, 'Festival', 'Pending', 'VIP'),
(21, 47, 150.00, 'Concert', 'Confirmed', 'General'),
(25, 50, 120.50, 'Theatre', 'Cancelled', 'VIP'),
(22, 48, 210.00, 'Conference', 'Confirmed', 'General'),
(23, 49, 99.99, 'Festival', 'Pending', 'VIP'),
(20, 44, 175.49, 'Concert', 'Confirmed', 'General'),
(24, 46, 130.00, 'Theatre', 'Cancelled', 'VIP');

-- -- Insert data into Promotions Table (assuming EventID from previously inserted records)
INSERT INTO Promotions (EventID, PromotionChannel, TargetAge, PromotionDescription) VALUES 
(16, 'Social Media', 25, 'Use code TECH21 for a discount.'),
(19, 'Radio', 30, 'Listen to 102.5 FM for a chance to win tickets.'),
(21, 'TV', 35, 'Exclusive TV offer during prime time.'),
(18, 'Online Ads', 20, 'Click the banner for a surprise discount!'),
(20, 'Email', 45, 'Check your inbox for a special promotion!'),
(23, 'Social Media', 22, 'Share and win a free upgrade to VIP.'),
(22, 'Billboards', 28, 'Spot our ad in the city and win tickets.'),
(25, 'Flyers', 38, 'Distribute flyers for a chance at free entry.'),
(17, 'Partnerships', 50, 'Collaborate with us for group discounts.'),
(24, 'Radio', 27, 'The first caller wins a free pass!');

-- -- Insert data into Inventory Table
INSERT INTO Inventory (ItemName, Quantity) VALUES 
('T-Shirt', 500),
('Water Bottle', 1000),
('Mug', 300),
('Keychain', 750),
('Hat', 600),
('Poster', 400),
('Sticker Pack', 800),
('Lanyard', 350),
('Badge', 900),
('Hoodie', 250)

-- -- Insert data into Feedback Table (assuming UserID and EventID from previously inserted records)
INSERT INTO Feedback (UserID, EventID, Rating, Description) VALUES 
(43, 16, 5, 'Great event, very well organized!'),
(44, 17, 4, 'Loved the festival, but the lines were too long.'),
(45, 19, 3, 'The event was good, but needed better seating.'),
(46, 20, 5, 'Absolutely loved the performance!'),
(47, 22, 2, 'Could be improved, the acoustics were poor.'),
(48, 24, 4, 'Great atmosphere and friendly staff.'),
(49, 23, 1, 'I was disappointed with the event management.'),
(50, 21, 5, 'Best event I have been to this year!'),
(41, 25, 4, 'Really enjoyed the event, but parking was an issue.'),
(42, 18, 3, 'Good event overall, but the food was too pricey.');

-- -- Insert data into Vendors Table
INSERT INTO Vendors (VendorName, VendorEmail, VendorType) VALUES 
('ABC Catering', 'contact@abccatering.com', 'Food'),
('XYZ Rentals', 'info@xyzrentals.com', 'Equipment'),
('Delish Dishes', 'info@delishdishes.com', 'Food'),
('Epic Stages', 'contact@epicstages.net', 'Stage'),
('Brilliant Lights', 'sales@brilliantlights.co', 'Lighting'),
('Sound Masters', 'bookings@soundmasters.org', 'Sound'),
('Party Rentals', 'rent@partyrentals.com', 'Equipment'),
('Luxury Limos', 'drive@luxurylimos.net', 'Transport'),
('Floral Fantasies', 'flowers@floralfantasies.org', 'Decor'),
('Sweet Treats', 'orders@sweettreats.com', 'Food');


-- -- Insert data into VOAssociation Table (assuming OrganizerID and VendorID from previously inserted records)
INSERT INTO VOAssociation (OrganizerID, VendorID) VALUES 
(41, 1),
(43, 2),
(42, 3),
(45, 4),
(44, 5),
(46, 6),
(49, 7),
(47, 8),
(48, 9),
(50, 10);

OPEN SYMMETRIC KEY NUEventsSymmetricKey
DECRYPTION BY CERTIFICATE NUEventsCertificate;
INSERT INTO Sponsors (SponsorName, SponsorEmail, SponsorCategory, SponsorPhone) VALUES 
('Innovatech Solutions', 'contact@innovatechsolutions.com', 'Technology', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '301-555-0198')),
('Green Earth Foods', 'info@greenearthfoods.org', 'Food & Beverage', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '301-555-0123')),
('HealthFirst Insurance', 'contact@healthfirstinsurance.net', 'Healthcare', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '301-555-0145')),
('First Security Bank', 'relations@firstsecuritybank.com', 'Financial', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '301-555-0178')),
('JetFly Airlines', 'marketing@jetflyairlines.com', 'Travel', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '301-555-0199')),
('QuickTech Electronics', 'promos@quicktechelectronics.com', 'Retail', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '301-555-0133')),
('Fashion Forward Apparel', 'info@fashionforwardapparel.org', 'Fashion', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '301-555-0166')),
('Global Aid Foundation', 'contact@globalaidfoundation.net', 'Non-Profit', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '301-555-0155')),
('Adventure Outfitters', 'partners@adventureoutfitters.net', 'Outdoor', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '301-555-0222')),
('Cinema World Studios', 'sponsorship@cinemaworldstudios.com', 'Entertainment', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'), '301-555-0333'));

INSERT INTO Budget ( EventID, TotalBudget, Expenditure) VALUES 
(23, 20000, 15000),
(24, 30000, 22000),
(25, 25000, 18000),
(16, 40000, 35000),
(17, 15000, 10000),
(18, 18000, 12000),
(19, 5000, 3000),
(20, 30000, 25000),
(21, 35000, 24000),
(22, 36000, 23000);


INSERT INTO Sponsorship (SponsorID, BudgetID) VALUES 
(72, 11),
(52, 14),
(54, 18),
(53, 12),
(60, 15),
(55, 20),
(57, 17),
(59, 13),
(58, 19),
(60, 16);


DROP TABLE Budget;
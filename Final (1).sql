-- FINAL DATABASE IMPLEMENTAION GROUP 15
-- PROJECT: NUEVENTS (NORTHEASTERN UNIVERSITY EVENT MANAGEMENT SYSTEM)
-- PROJECT MEMBERS WITH NUIDs:
-- 1.ROHAN VASUDEV GINDE - 002646835
-- 2.SIDDHESH NAIK - 002785400
-- 3.KSHETRA HEGDE - 002728959
-- 4.YASH KHANVEKAR - 002871417
-- 5.ASAVARI SHEJWAL - 002810541



-- -- Assuming you're already using the NUEvents database
CREATE DATABASE NUEvents;
GO

-- Switch to the NUEvents database to begin creating tables
USE NUEvents;
GO
--
--CHECK CONSTRAINT USING FUNCTION EXAMPLE
GO
CREATE FUNCTION dbo.IsValidEmail(@Email NVARCHAR(255))
RETURNS BIT
AS
BEGIN
    IF @Email LIKE '%_@__%.__%' AND @Email NOT LIKE '%[^a-zA-Z0-9.@_-]%' AND CHARINDEX('.', REVERSE(@Email)) BETWEEN 1 AND 5
        RETURN 1; -- Valid email
    RETURN 0; -- Invalid email
END
GO

--CHECK CONSTRAINT USING FUNCTION EXAMPLE
GO
CREATE FUNCTION dbo.IsAllowedVenueAndLocation(@VenueName NVARCHAR(255), @VenueLocation NVARCHAR(255))
RETURNS BIT
AS
BEGIN
    -- List of allowed venues
    DECLARE @AllowedVenues TABLE (Name NVARCHAR(255), Location NVARCHAR(255));
    INSERT INTO @AllowedVenues (Name, Location) VALUES
    ('Kerr Hall', 'Boston, MA'),
    ('Light Hall', 'Boston, MA'),
    ('Melvin Hall', 'Boston, MA'),
    ('Smith Hall', 'Boston, MA'),
    ('Speare Hall', 'Boston, MA'),
    ('Stetson East', 'Boston, MA'),
    ('Stetson West', 'Boston, MA'),
    ('White Hall', 'Boston, MA'),
    ('Ell Hall', 'Boston, MA'),
    ('Black Auditorium', 'Boston, MA')
    -- Check if the given venue name and location are in the list of allowed venues
    IF EXISTS(SELECT 1 FROM @AllowedVenues WHERE Name = @VenueName AND Location = @VenueLocation)
        RETURN 1; -- Venue and location are allowed
    RETURN 0; -- Venue or location is not allowed
END
GO

--COMPUTED COLUMN USING FUNCTION EXAMPLE
GO
CREATE FUNCTION dbo.CalculateAge (@BirthDate DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Today DATE = GETDATE();
    DECLARE @Age INT;

    SET @Age = DATEDIFF(YEAR, @BirthDate, @Today) - 
               CASE
                   WHEN (MONTH(@BirthDate) > MONTH(@Today)) OR 
                        (MONTH(@BirthDate) = MONTH(@Today) AND DAY(@BirthDate) > DAY(@Today))
                   THEN 1
                   ELSE 0
               END;

    RETURN @Age;
END;
GO




CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'NUEvents123';
-- Create certificate to protect symmetric key
CREATE CERTIFICATE NUEventsCertificate
WITH SUBJECT = 'NUEvents Test Certificate',
EXPIRY_DATE = '2027-10-31';
-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY NUEventsSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE NUEventsCertificate;
-- Open symmetric key
OPEN SYMMETRIC KEY NUEventsSymmetricKey
DECRYPTION BY CERTIFICATE NUEventsCertificate;



-- Users table
CREATE TABLE [dbo].[Users] (
    [UserID]    INT            IDENTITY (1, 1) NOT NULL,
    [FName]     NVARCHAR (50)  NULL,
    [LName]     NVARCHAR (50)  NULL,
    [BirthDate] DATE           NULL,
    [Age]       AS             ([dbo].[CalculateAge]([BirthDate])), -- Computed column using the function
    [UserPhone] INT            NULL,
    [UserEmail] NVARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC),
    CHECK ([dbo].[IsValidEmail]([UserEmail])=(1))-- Check Constraint Function
);

GO



-- -- Insert data into Users Table
OPEN SYMMETRIC KEY NUEventsSymmetricKey
DECRYPTION BY CERTIFICATE NUEventsCertificate;
INSERT INTO Users (Fname, Lname, BirthDate, UserPhone, UserEmail) VALUES 
('John', 'Doe', '1985-01-23',EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'32442345'),'john.doe@email.com'), -- encryption of column UserPhone
('Jane', 'Smith', '1990-04-15', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'213444'),'jane.smith@email.com'),
('Brooke', 'Sanders', '1946-01-13', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'37622153'),'randylewis@gmail.com'),
('Matthew', 'Odonnell', '1991-08-31', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'18420170'),'sburns@yahoo.com'),
('Mary', 'Cox', '1990-01-13', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'53483380'),'summersnathaniel@yahoo.com'),
('Eric', 'Thomas', '1961-02-01', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'72290190'),'ygardner@hensley.com'),
('John', 'Martin', '1964-09-12', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'92927856'),'paynecarla@yahoo.com'),
('Joel', 'Lewis', '1991-07-21', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'22006611'),'robertshepard@gmail.com'),
('Amber', 'Harrison', '1979-12-06', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'73284121'),'wparker@yahoo.com'),
('Kevin', 'Barnett', '1969-03-28', EncryptByKey(Key_GUID(N'NUEventsSymmetricKey'),'86014229'),'christopher15@yahoo.com');


-- Venue table
CREATE TABLE [dbo].[Venue] (
    [VenueID]       INT            IDENTITY (1, 1) NOT NULL,
    [VenueName]     NVARCHAR (255) NULL,
    [VenueLocation] NVARCHAR (255) NULL,
    [Capacity]      INT            NULL,
    PRIMARY KEY CLUSTERED ([VenueID] ASC)
);
GO


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


-- Schedule table
CREATE TABLE [dbo].[Schedule] (
    [ScheduleID] INT      IDENTITY (1, 1) NOT NULL,
    [Date]       DATE     NULL,
    [StartTime]  TIME (7) NULL,
    [EndTime]    TIME (7) NULL,
    PRIMARY KEY CLUSTERED ([ScheduleID] ASC)
);
GO

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

-- Budget table
CREATE TABLE [dbo].[Budget] (
    [BudgetID]    INT   IDENTITY (1, 1) NOT NULL,
    [TotalBudget] MONEY NULL,
    [Expenditure] MONEY NULL,
    [EventID]     INT   NOT NULL,
    PRIMARY KEY CLUSTERED ([BudgetID] ASC),
    FOREIGN KEY ([EventID]) REFERENCES [dbo].[Events] ([EventID])
);
GO

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


-- Organizer table
CREATE TABLE [dbo].[Organizer] (
    [OrganizerID]    INT            IDENTITY (1, 1) NOT NULL,
    [OrganizerName]  NVARCHAR (255) NULL,
    [OrganizerEmail] NVARCHAR (255) NULL,
    [OrganizerPhone] INT            NULL,
    PRIMARY KEY CLUSTERED ([OrganizerID] ASC),
    CHECK ([dbo].[IsValidEmail]([OrganizerEmail])=(1))
);
GO

OPEN SYMMETRIC KEY NUEventsSymmetricKey
DECRYPTION BY CERTIFICATE NUEventsCertificate;
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


-- Event table
CREATE TABLE [dbo].[Events] (
    [EventID]          INT            IDENTITY (1, 1) NOT NULL,
    [EventName]        NVARCHAR (255) NULL,
    [OrganizerID]      INT            NULL,
    [ScheduleID]       INT            NULL,
    [VenueID]          INT            NULL,
    [EventDescription] NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([EventID] ASC),
    FOREIGN KEY ([OrganizerID]) REFERENCES [dbo].[Organizer] ([OrganizerID]),
    FOREIGN KEY ([ScheduleID]) REFERENCES [dbo].[Schedule] ([ScheduleID]),
    FOREIGN KEY ([VenueID]) REFERENCES [dbo].[Venue] ([VenueID])
);

GO
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


-- Ticket table
CREATE TABLE dbo.Ticket (
    TicketID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT,
    UserID INT,
    TicketDesc NVARCHAR(255),
    TicketType NVARCHAR(50),
    TicketStatus NVARCHAR(50),
    TicketLevel NVARCHAR(50),
    FOREIGN KEY (EventID) REFERENCES dbo.Events(EventID),
    FOREIGN KEY (UserID) REFERENCES dbo.Users(UserID)
    -- Check constraints for Ticket will be applied during insert/update operations in stored procedures or triggers.
);
GO

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

-- Promotions table
CREATE TABLE [dbo].[Promotions] (
    [PromotionID]          INT            IDENTITY (1, 1) NOT NULL,
    [EventID]              INT            NOT NULL,
    [PromotionChannel]     NVARCHAR (255) NULL,
    [TargetAge]            INT            NULL,
    [PromotionDescription] NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([PromotionID] ASC),
    FOREIGN KEY ([EventID]) REFERENCES [dbo].[Events] ([EventID])
);
GO


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


-- Inventory table
CREATE TABLE [dbo].[Inventory] (
    [InventoryID] INT            IDENTITY (1, 1) NOT NULL,
    [EventID]     INT            NULL,
    [ItemName]    NVARCHAR (255) NULL,
    [Quantity]    INT            NULL,
    PRIMARY KEY CLUSTERED ([InventoryID] ASC),
    CONSTRAINT [EventID] FOREIGN KEY ([EventID]) REFERENCES [dbo].[Events] ([EventID])
);
GO

INSERT INTO Inventory (EventID,ItemName, Quantity) VALUES 
(16,'T-Shirt', 500),
(18,'Water Bottle', 1000),
(19,'Mug', 300),
(25,'Keychain', 750),
(23,'Hat', 600),
(23,'Poster', 400),
(20,'Sticker Pack', 800),
(17,'Lanyard', 350),
(21,'Badge', 900),
(22,'Hoodie', 250)


CREATE TABLE [dbo].[Feedback] (
    [FeedbackID]  INT            IDENTITY (1, 1) NOT NULL,
    [UserID]      INT            NULL,
    [EventID]     INT            NULL,
    [Rating]      INT            NULL,
    [Description] NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([FeedbackID] ASC),
    FOREIGN KEY ([EventID]) REFERENCES [dbo].[Events] ([EventID]),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);
GO

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


-- Sponsors table
CREATE TABLE [dbo].[Sponsors] (
    [SponsorID]       INT            IDENTITY (1, 1) NOT NULL,
    [SponsorName]     NVARCHAR (255) NULL,
    [SponsorEmail]    NVARCHAR (255) NULL,
    [SponsorCategory] NVARCHAR (50)  NULL,
    [SponsorPhone]    INT            NULL,
    PRIMARY KEY CLUSTERED ([SponsorID] ASC),
    CHECK ([dbo].[IsValidEmail]([SponsorEmail])=(1))
);
GO



-- Sponsorship table
CREATE TABLE [dbo].[Sponsorship] (
    [SponsorshipID] INT IDENTITY (1, 1) NOT NULL,
    [BudgetID]      INT NULL,
    [SponsorID]     INT NULL,
    PRIMARY KEY CLUSTERED ([SponsorshipID] ASC),
    FOREIGN KEY ([BudgetID]) REFERENCES [dbo].[Budget] ([BudgetID]),
    FOREIGN KEY ([SponsorID]) REFERENCES [dbo].[Sponsors] ([SponsorID])
);
GO


-- Vendors table
CREATE TABLE [dbo].[Vendors] (
    [VendorID]    INT            IDENTITY (1, 1) NOT NULL,
    [VendorName]  NVARCHAR (255) NULL,
    [VendorEmail] NVARCHAR (255) NULL,
    [VendorType]  NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([VendorID] ASC),
    CHECK ([dbo].[IsValidEmail]([VendorEmail])=(1))
);
GO
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


-- VOAssociation table
CREATE TABLE [dbo].[VOAssociation] (
    [OrganizerID] INT NOT NULL,
    [VendorID]    INT NOT NULL,
    PRIMARY KEY CLUSTERED ([OrganizerID] ASC, [VendorID] ASC),
    FOREIGN KEY ([OrganizerID]) REFERENCES [dbo].[Organizer] ([OrganizerID]),
    FOREIGN KEY ([VendorID]) REFERENCES [dbo].[Vendors] ([VendorID])
);
GO

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

-- VIEW 1 - View Entire Events Summary

GO
CREATE VIEW ComprehensiveEventSummary AS
SELECT 
    e.EventID,
    e.EventName,
    e.EventDescription,
    v.VenueName,
    s.Date,
    s.StartTime,
    s.EndTime,
    o.OrganizerName,
    o.OrganizerID,  -- If you need OrganizerID, it must be included in the GROUP BY
    COUNT(DISTINCT t.TicketID) AS TotalTicketsSold,
    SUM(ISNULL(t.TicketPrice, 0)) AS TotalRevenue,
    AVG(f.Rating) AS AverageFeedbackRating,
    (SELECT COUNT(DISTINCT sp.SponsorID)
        FROM Sponsorship sp
        INNER JOIN Budget b ON sp.BudgetID = b.BudgetID
        WHERE b.EventID = e.EventID
    ) AS NumberOfSponsors,
    STRING_AGG(p.PromotionChannel, '; ') AS PromotionChannelsUsed,
    (SELECT COUNT(DISTINCT ven.VendorID)
        FROM VOAssociation va
        INNER JOIN Vendors ven ON va.VendorID = ven.VendorID
        WHERE va.OrganizerID = o.OrganizerID
    ) AS NumberOfVendors
FROM 
    Events e
INNER JOIN Venue v ON e.VenueID = v.VenueID
INNER JOIN Schedule s ON e.ScheduleID = s.ScheduleID
INNER JOIN Organizer o ON e.OrganizerID = o.OrganizerID
LEFT JOIN Ticket t ON e.EventID = t.EventID
LEFT JOIN Feedback f ON e.EventID = f.EventID
LEFT JOIN Promotions p ON e.EventID = p.EventID
GROUP BY 
    e.EventID,
    e.EventName,
    e.EventDescription,
    v.VenueName,
    s.Date,
    s.StartTime,
    s.EndTime,
    o.OrganizerName,
    o.OrganizerID;  -- Added OrganizerID here
GO


-- VIEW 2 _ Check on User Feedbacks
GO
CREATE VIEW EventFeedback AS
SELECT 
    e.EventID,
    e.EventName,
    u.UserID,
    u.Fname + ' ' + u.Lname AS FullName,
    f.Rating,
    f.Description AS FeedbackDescription
FROM 
    Feedback f
INNER JOIN Users u ON f.UserID = u.UserID
INNER JOIN Events e ON f.EventID = e.EventID;
GO

--View 3 _ Identifying Visitors by Age Group
CREATE VIEW VisitorsByAgeGroup AS
SELECT
    e.EventID,
    e.EventName,
    CASE
        WHEN DATEDIFF(YEAR, c.BirthDate, GETDATE()) BETWEEN 18 AND 25 THEN '18-25'
        WHEN DATEDIFF(YEAR, c.BirthDate, GETDATE()) BETWEEN 26 AND 35 THEN '26-35'
        WHEN DATEDIFF(YEAR, c.BirthDate, GETDATE()) BETWEEN 36 AND 45 THEN '36-45'
        ELSE '46+'
    END AS AgeGroup,
    COUNT(t.TicketID) AS VisitorCount
FROM
    NUEvents.dbo.Events e
JOIN
    NUEvents.dbo.Ticket t ON e.EventID = t.EventID
JOIN
    NUEvents.dbo.Users c ON t.UserID = c.UserID
GROUP BY
    e.EventID, e.EventName, Age,c.BirthDate;
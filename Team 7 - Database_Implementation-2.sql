USE ProjectTeam7Test;
-- Functions
-- Func to validate email adress
CREATE FUNCTION ValidateEmail_Ak (@Email VARCHAR(100))
RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT
    SET
	@Result = 0

    IF (@Email LIKE '%@%._%')
        SET
	@Result = 1

    RETURN @Result
END;
-- computed column for age based on Date of Birth - Func 
CREATE FUNCTION CalculateAge (@DOB DATE)
RETURNS INT
AS
BEGIN
	DECLARE @Age INT
    SET
	@Age = DATEDIFF(YEAR, @DOB, GETDATE())
    IF (DATEADD(YEAR, @Age, @DOB) > GETDATE()) SET
	@Age = @Age - 1
    RETURN @Age
END;
----Function to check MaxScore 
CREATE FUNCTION ValidateMaxScore(@MaxScore INT)
RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT
    SET
	@Result = 0
    
    IF (@MaxScore > 30)
	AND (@MaxScore < 100)
        SET
	@Result = 1
    
    RETURN @Result
END;
--Function to check Test Duration
CREATE FUNCTION CheckDurationRange (@Duration INT)
RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT = 0
    
    IF (@Duration >= 0
	AND @Duration <= 60)
        SET
	@Result = 1
    
    RETURN @Result
END;
--Function to check Number of Openings
CREATE FUNCTION ValidateNumber_of_Openings(@Number_of_Openings INT)
RETURNS BIT
BEGIN
	
    DECLARE @Result BIT
    SET
	@Result = 0
    IF @Number_of_Openings > 0
        SET
	@Result = 1
        
    RETURN @Result
END;
--Function to check Job_Posting_Date < Job_Start_Date 
CREATE FUNCTION check_job_date(@Job_Posting_Date Date,
@Job_Start_Date Date) 
RETURNS BIT
BEGIN
	
	DECLARE @Result BIT
	SET
	@Result = 0
  	IF @Job_Posting_Date < @Job_Start_Date
    	SET
	@Result = 1

    RETURN @Result
END;
-- Encryption

CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Test_P@sswOrd';
-- Create certificate to protect symmetric key
CREATE CERTIFICATE TestCertificate
WITH SUBJECT = 'AdventureWorks Test Certificate',
EXPIRY_DATE = '2026-10-31';
-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY TestSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE TestCertificate;
-- Open symmetric key
OPEN SYMMETRIC KEY TestSymmetricKey
DECRYPTION BY CERTIFICATE TestCertificate;
-- Job_Position
CREATE TABLE Job_Position (
  Job_Position_ID INT PRIMARY KEY,
  Job_Position_Name VARCHAR(45),
  Job_Position_Description VARCHAR(200)
);

INSERT
	INTO
	Job_Position (Job_Position_ID,
	Job_Position_Name,
	Job_Position_Description)
VALUES (1,
'Manager',
'Supervises teams and departments, responsible for overall performance and results');

INSERT
	INTO
	Job_Position (Job_Position_ID,
	Job_Position_Name,
	Job_Position_Description)
VALUES (2,
'Software Developer',
'Designs and develops software applications for various platforms and devices');

INSERT
	INTO
	Job_Position (Job_Position_ID,
	Job_Position_Name,
	Job_Position_Description)
VALUES (3,
'Sales Representative',
'Generates revenue by selling products or services to customers and clients');

INSERT
	INTO
	Job_Position (Job_Position_ID,
	Job_Position_Name,
	Job_Position_Description)
VALUES (4,
'Marketing Coordinator',
'Assists in the implementation of marketing campaigns and strategies');

INSERT
	INTO
	Job_Position (Job_Position_ID,
	Job_Position_Name,
	Job_Position_Description)
VALUES (5,
'Accountant',
'Manages financial transactions and performs audits to ensure accuracy and compliance');

INSERT
	INTO
	Job_Position (Job_Position_ID,
	Job_Position_Name,
	Job_Position_Description)
VALUES (6,
'Human Resources Specialist',
'Coordinates HR policies and procedures, manages employee relations and development');

INSERT
	INTO
	Job_Position (Job_Position_ID,
	Job_Position_Name,
	Job_Position_Description)
VALUES (7,
'Operations Analyst',
'Analyzes data and processes to optimize performance and efficiency');

INSERT
	INTO
	Job_Position (Job_Position_ID,
	Job_Position_Name,
	Job_Position_Description)
VALUES (8,
'Customer Service Representative',
'Resolves customer inquiries and issues, provides information and support');

INSERT
	INTO
	Job_Position (Job_Position_ID,
	Job_Position_Name,
	Job_Position_Description)
VALUES (9,
'Legal Counsel',
'Provides legal advice and counsel to organizations, manages regulatory compliance');

INSERT
	INTO
	Job_Position (Job_Position_ID,
	Job_Position_Name,
	Job_Position_Description)
VALUES (10,
'Nurse',
'Provides medical care and support to patients in various healthcare settings');
-- Job_Category
CREATE TABLE Job_Category (
  Job_Category_ID INT PRIMARY KEY,
  Job_Category_Name VARCHAR(45),
  Job_Category_Description VARCHAR(200)
);

INSERT
	INTO
	Job_Category (Job_Category_ID,
	Job_Category_Name,
	Job_Category_Description)
VALUES (1,
'Sales',
'Job positions related to sales and business development');

INSERT
	INTO
	Job_Category (Job_Category_ID,
	Job_Category_Name,
	Job_Category_Description)
VALUES (2,
'Marketing',
'Job positions related to marketing and advertising');

INSERT
	INTO
	Job_Category (Job_Category_ID,
	Job_Category_Name,
	Job_Category_Description)
VALUES (3,
'Finance',
'Job positions related to finance and accounting');

INSERT
	INTO
	Job_Category (Job_Category_ID,
	Job_Category_Name,
	Job_Category_Description)
VALUES (4,
'IT',
'Job positions related to information technology and software development');

INSERT
	INTO
	Job_Category (Job_Category_ID,
	Job_Category_Name,
	Job_Category_Description)
VALUES (5,
'Human Resources',
'Job positions related to HR and talent acquisition');

INSERT
	INTO
	Job_Category (Job_Category_ID,
	Job_Category_Name,
	Job_Category_Description)
VALUES (6,
'Operations',
'Job positions related to operations and supply chain management');

INSERT
	INTO
	Job_Category (Job_Category_ID,
	Job_Category_Name,
	Job_Category_Description)
VALUES (7,
'Engineering',
'Job positions related to engineering and product development');

INSERT
	INTO
	Job_Category (Job_Category_ID,
	Job_Category_Name,
	Job_Category_Description)
VALUES (8,
'Customer Service',
'Job positions related to customer service and support');

INSERT
	INTO
	Job_Category (Job_Category_ID,
	Job_Category_Name,
	Job_Category_Description)
VALUES (9,
'Legal',
'Job positions related to legal and regulatory compliance');

INSERT
	INTO
	Job_Category (Job_Category_ID,
	Job_Category_Name,
	Job_Category_Description)
VALUES (10,
'Healthcare',
'Job positions related to healthcare and medical services');
-- Job_Platform

CREATE TABLE Job_Platform (
  Job_Platform_ID INT PRIMARY KEY,
  Job_Platform_Name VARCHAR(45),
  Job_Platform_Description VARCHAR(200)
);

INSERT
	INTO
	Job_Platform (Job_Platform_ID,
	Job_Platform_Name,
	Job_Platform_Description)
VALUES (1,
'LinkedIn',
'Professional networking and job search platform');

INSERT
	INTO
	Job_Platform (Job_Platform_ID,
	Job_Platform_Name,
	Job_Platform_Description)
VALUES (2,
'Indeed',
'Job search engine and employment website');

INSERT
	INTO
	Job_Platform (Job_Platform_ID,
	Job_Platform_Name,
	Job_Platform_Description)
VALUES (3,
'Glassdoor',
'Job search engine and employer review site');

INSERT
	INTO
	Job_Platform (Job_Platform_ID,
	Job_Platform_Name,
	Job_Platform_Description)
VALUES (4,
'Monster',
'Job search engine and career advice website');

INSERT
	INTO
	Job_Platform (Job_Platform_ID,
	Job_Platform_Name,
	Job_Platform_Description)
VALUES (5,
'CareerBuilder',
'Job search engine and recruitment platform');

INSERT
	INTO
	Job_Platform (Job_Platform_ID,
	Job_Platform_Name,
	Job_Platform_Description)
VALUES (6,
'SimplyHired',
'Job search engine and employment website');

INSERT
	INTO
	Job_Platform (Job_Platform_ID,
	Job_Platform_Name,
	Job_Platform_Description)
VALUES (7,
'ZipRecruiter',
'Job search engine and employment marketplace');

INSERT
	INTO
	Job_Platform (Job_Platform_ID,
	Job_Platform_Name,
	Job_Platform_Description)
VALUES (8,
'Upwork',
'Freelance and remote job platform');

INSERT
	INTO
	Job_Platform (Job_Platform_ID,
	Job_Platform_Name,
	Job_Platform_Description)
VALUES (9,
'FlexJobs',
'Job search engine and remote work job board');

INSERT
	INTO
	Job_Platform (Job_Platform_ID,
	Job_Platform_Name,
	Job_Platform_Description)
VALUES (10,
'We Work Remotely',
'Remote job board for various industries');
-- Organization
CREATE TABLE Organization (
  Organization_ID INT PRIMARY KEY,
  Organization_Name VARCHAR(45),
  Organization_Description VARCHAR(200)
);

INSERT
	INTO
	Organization (Organization_ID,
	Organization_Name,
	Organization_Description)
VALUES (1,
'Acme Corporation',
'Manufacturer of widgets and gadgets');

INSERT
	INTO
	Organization (Organization_ID,
	Organization_Name,
	Organization_Description)
VALUES (2,
'Globex Corporation',
'International conglomerate with diverse business interests');

INSERT
	INTO
	Organization (Organization_ID,
	Organization_Name,
	Organization_Description)
VALUES (3,
'Initech Industries',
'Provider of software and consulting services');

INSERT
	INTO
	Organization (Organization_ID,
	Organization_Name,
	Organization_Description)
VALUES (4,
'Stark Industries',
'Technology and defense contractor');

INSERT
	INTO
	Organization (Organization_ID,
	Organization_Name,
	Organization_Description)
VALUES (5,
'Wayne Enterprises',
'Holding company for various business ventures');

INSERT
	INTO
	Organization (Organization_ID,
	Organization_Name,
	Organization_Description)
VALUES (6,
'Oscorp Industries',
'Biotech and engineering research firm');

INSERT
	INTO
	Organization (Organization_ID,
	Organization_Name,
	Organization_Description)
VALUES (7,
'Umbrella Corporation',
'Pharmaceutical and biotech company');

INSERT
	INTO
	Organization (Organization_ID,
	Organization_Name,
	Organization_Description)
VALUES (8,
'Weyland-Yutani Corporation',
'Multinational conglomerate with interests in aerospace and defense');

INSERT
	INTO
	Organization (Organization_ID,
	Organization_Name,
	Organization_Description)
VALUES (9,
'Aperture Science',
'Provider of experimental research and development services');

INSERT
	INTO
	Organization (Organization_ID,
	Organization_Name,
	Organization_Description)
VALUES (10,
'Black Mesa Research Facility',
'Government-funded research facility');
-- Recruiter 
CREATE TABLE Recruiter (
Recruiter_ID INT PRIMARY KEY,
First_Name VARCHAR(45),
Last_Name VARCHAR(45),
Email NVARCHAR(100),
Phone VARBINARY(250),
CONSTRAINT Recruiter_ValidEmail CHECK (dbo.ValidateEmail_Ak(Email) = 1)
);

INSERT
	INTO
	Recruiter
(
Recruiter_ID,
	First_Name,
	Last_Name,
	Email,
	Phone
)
VALUES
(1,
'Jamaica',
'Fernandez',
'fernandez.jamaica@gmail.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'617-764-2234' )),
(2,
'Jane',
'Smith',
'smith.jane@example.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'617-784-2234' )),
(3,
'Drake',
'Lee',
'lee.drake@example.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'617-784-9988' )),
(4,
'Sarah',
'Johnson',
'johnson.sarah@example.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'617-784-7777' )),
(5,
'Michael',
'Wang',
'wang.michael@example.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'617-783-1111' )),
(6,
'Emily',
'Garcia',
'garcia.emily@example.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'617-783-3344' )),
(7,
'Kevin',
'Kim',
'kim.kevin@example.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'617-782-6677' )),
(8,
'Stephanie',
'Chen',
'chen.stephanie@example.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'617-782-4455' )),
(9,
'Brian',
'Davis',
'davis.brian@example.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'617-781-8899' )),
(10,
'Jennifer',
'Nguyen',
'nguyen.jennifer@example.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'617-781-2233' ));
-- Online Assessments
CREATE TABLE Online_Assessments (
    OA_ID INT PRIMARY KEY,
    Code VARCHAR(45),
    OA_Duration INT CHECK (dbo.CheckDurationRange(OA_Duration) = 1),
    Max_Score INT CHECK (dbo.ValidateMaxScore(Max_Score) = 1)
);

INSERT
	INTO
	Online_Assessments (OA_ID,
	Code,
	OA_Duration,
	Max_Score)
VALUES 
    (1,
'CODE01',
45,
80),
    (2,
'CODE02',
60,
95),
    (3,
'CODE03',
30,
50),
    (4,
'CODE04',
45,
70),
    (5,
'CODE05',
60,
90),
    (6,
'CODE06',
15,
40),
    (7,
'CODE07',
20,
35),
    (8,
'CODE08',
30,
60),
    (9,
'CODE09',
55,
85),
    (10,
'CODE10',
45,
75);
-- Candidate
CREATE TABLE Candidate (
    Candidate_ID INT PRIMARY KEY,
    First_Name VARCHAR(100),
    Last_Name VARCHAR(100),
    Date_Of_Birth DATE,
    Age AS dbo.CalculateAge(Date_Of_Birth),
    Email NVARCHAR(100) CHECK (dbo.ValidateEmail_Ak(Email) = 1),
    Phone VARBINARY(100),
    Summary NVARCHAR(100)
);

INSERT
	INTO
	Candidate (Candidate_ID,
	First_Name,
	Last_Name,
	Date_Of_Birth,
	Email,
	Phone,
	Summary)
VALUES
(1,
'John',
'Doe',
'1995-12-05',
'johndoe@gmail.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'444-555-6666'),
'Experienced software engineer with knowledge of multiple programming languages');

INSERT
	INTO
	Candidate (Candidate_ID,
	First_Name,
	Last_Name,
	Date_Of_Birth,
	Email,
	Phone,
	Summary)
VALUES (2,
'Sarah',
'Johnson',
'1993-05-23',
'sarahjohnson@hotmail.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'777-888-9999'),
'Recent computer science graduate with strong skills in Java and Python');

INSERT
	INTO
	Candidate (Candidate_ID,
	First_Name,
	Last_Name,
	Date_Of_Birth,
	Email,
	Phone,
	Summary)
VALUES (3,
'David',
'Lee',
'1987-09-14',
'davidlee@yahoo.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'123-456-7890'),
'Web developer with experience in JavaScript and PHP');

INSERT
	INTO
	Candidate (Candidate_ID,
	First_Name,
	Last_Name,
	Date_Of_Birth,
	Email,
	Phone,
	Summary)
VALUES (4,
'Emily',
'Smith',
'1991-07-10',
'emilysmith@gmail.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'555-444-3333'),
'Full-stack developer with expertise in React and Node.js');

INSERT
	INTO
	Candidate (Candidate_ID,
	First_Name,
	Last_Name,
	Date_Of_Birth,
	Email,
	Phone,
	Summary)
VALUES (5,
'Alex',
'Garcia',
'1990-03-27',
'alexgarcia@gmail.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'222-333-4444'),
'Software engineer with experience in C++ and Python');

INSERT
	INTO
	Candidate (Candidate_ID,
	First_Name,
	Last_Name,
	Date_Of_Birth,
	Email,
	Phone,
	Summary)
VALUES (6,
'Olivia',
'Lee',
'1994-01-19',
'olivialee@hotmail.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'333-222-1111'),
'Front-end developer with proficiency in HTML, CSS, and JavaScript');

INSERT
	INTO
	Candidate (Candidate_ID,
	First_Name,
	Last_Name,
	Date_Of_Birth,
	Email,
	Phone,
	Summary)
VALUES (7,
'William',
'Brown',
'1988-08-07',
'williambrown@yahoo.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'444-333-2222'),
'Experienced software developer with knowledge of Java, Python, and Ruby');

INSERT
	INTO
	Candidate (Candidate_ID,
	First_Name,
	Last_Name,
	Date_Of_Birth,
	Email,
	Phone,
	Summary)
VALUES (8,
'Sophia',
'Kim',
'1992-12-31',
'sophiakim@gmail.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'111-222-3333'),
'Back-end developer with expertise in Python and Django');

INSERT
	INTO
	Candidate (Candidate_ID,
	First_Name,
	Last_Name,
	Date_Of_Birth,
	Email,
	Phone,
	Summary)
VALUES (9,
'Aiden',
'Chen',
'1986-06-02',
'aidenchen@hotmail.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'666-777-8888'),
'Software engineer with experience in C# and .NET');

INSERT
	INTO
	Candidate (Candidate_ID,
	First_Name,
	Last_Name,
	Date_Of_Birth,
	Email,
	Phone,
	Summary)
VALUES (10,
'Emma',
'Wang',
'1995-09-18',
'emmawang@yahoo.com',
EncryptByKey(Key_GUID(N'TestSymmetricKey'),
'999-888-7777'),
'Full-stack developer with expertise in React, Node.js, and MongoDB');
-- Document 
   
CREATE TABLE Document (
  Document_ID INT PRIMARY KEY,
  Name NVARCHAR(100),
  Document BINARY(1000),
  URL NVARCHAR(200),
  Last_Update DATETIME
);

INSERT
	INTO
	Document (Document_ID,
	Name,
	Document,
	URL,
	Last_Update)
VALUES
  (1,
'Document 1',
0x12FFB7,
'http://example.com/document1',
'2022-03-01 08:30:00'),
  (2,
'Document 2',
0x8BF2E7,
'http://example.com/document2',
'2022-03-02 09:00:00'),
  (3,
'Document 3',
0x74D3C6,
'http://example.com/document3',
'2022-03-03 10:30:00'),
  (4,
'Document 4',
0x6AB1F5,
'http://example.com/document4',
'2022-03-04 11:00:00'),
  (5,
'Document 5',
0x923FF4,
'http://example.com/document5',
'2022-03-05 12:30:00'),
  (6,
'Document 6',
0x5B5D17,
'http://example.com/document6',
'2022-03-06 14:00:00'),
  (7,
'Document 7',
0x1D4EB1,
'http://example.com/document7',
'2022-03-07 15:30:00'),
  (8,
'Document 8',
0x8A3BFC,
'http://example.com/document8',
'2022-03-08 17:00:00'),
  (9,
'Document 9',
0x6D2B7C,
'http://example.com/document9',
'2022-03-09 18:30:00'),
  (10,
'Document 10',
0x29BA8D,
'http://example.com/document10',
'2022-03-10 19:00:00');
-- Application Status

CREATE TABLE Application_Status (
  Application_Status_ID INT PRIMARY KEY,
  Application_Status NVARCHAR(100)
);

INSERT
	INTO
	Application_Status (Application_Status_ID,
	Application_Status)
VALUES
  (1,
'Submitted'),
  (2,
'Under Review'),
  (3,
'Interview Scheduled'),
  (4,
'Interview Conducted'),
  (5,
'Rejected'),
  (6,
'Offer Extended'),
  (7,
'Offer Accepted'),
  (8,
'Offer Declined'),
  (9,
'Withdrawn'),
  (10,
'Hired');
--  Job
CREATE TABLE Job (
  Job_ID INT PRIMARY KEY,
  Job_Name VARCHAR(45),
  Job_Description VARCHAR(80),
  Job_Posting_Date Date,
  Job_Start_Date Date,
  Number_of_Openings INT CONSTRAINT chk_Number_of_Openings CHECK (dbo.ValidateNumber_of_Openings(Number_of_Openings) = 1),
  Job_Position_ID INT FOREIGN KEY REFERENCES Job_Position(Job_Position_ID),
  Job_Category_ID INT FOREIGN KEY REFERENCES Job_Category(Job_Category_ID),
  Job_Platform_ID INT FOREIGN KEY REFERENCES Job_Platform(Job_Platform_ID),
  Organization_ID INT FOREIGN KEY REFERENCES Organization(Organization_ID),
  Recruiter_ID INT FOREIGN KEY REFERENCES Recruiter(Recruiter_ID),
  CONSTRAINT chk_Job_Dates CHECK (dbo.check_job_date(Job_Posting_Date,
Job_Start_Date) = 1)
);

INSERT
	INTO
	Job (Job_ID,
	Job_Name,
	Job_Description,
	Job_Posting_Date,
	Job_Start_Date,
	Number_of_Openings,
	Job_Position_ID,
	Job_Category_ID,
	Job_Platform_ID,
	Organization_ID,
	Recruiter_ID)
VALUES 
    (1,
'Software Developer',
'Develop and maintain software applications',
'2022-01-01',
'2022-02-01',
5,
2,
4,
1,
1,
1),
    (2,
'Database Administrator',
'Design, implement and maintain databases',
'2022-01-01',
'2022-02-01',
3,
7,
4,
2,
1,
1),
    (3,
'Project Manager',
'Plan, execute and manage projects',
'2022-01-01',
'2022-02-01',
2,
1,
6,
1,
1,
2),
    (4,
'Software Engineer',
'Design and develop software systems',
'2022-01-01',
'2022-02-01',
4,
2,
4,
3,
2,
2),
    (5,
'Data Analyst',
'Collect, analyze and interpret data',
'2022-01-01',
'2022-02-01',
1,
7,
4,
1,
2,
3),
    (6,
'Web Developer',
'Design and develop websites and web applications',
'2022-01-01',
'2022-02-01',
6,
2,
4,
1,
3,
3),
    (7,
'Network Administrator',
'Manage and maintain network systems',
'2022-01-01',
'2022-02-01',
2,
7,
4,
2,
3,
3),
    (8,
'UI/UX Designer',
'Design user interfaces and experiences',
'2022-01-01',
'2022-02-01',
1,
2,
4,
3,
2,
4),
    (9,
'Technical Writer',
'Write and edit technical documents',
'2022-01-01',
'2022-02-01',
1,
6,
5,
1,
3,
4),
    (10,
'Software Tester',
'Test software for bugs and defects',
'2022-01-01',
'2022-02-01',
3,
2,
4,
1,
2,
5);
-- Candidate_Job_Application


CREATE TABLE Candidate_Job_Application (
  Candidate_Document_ID INT PRIMARY KEY,
  Date_Of_Application DATETIME,
  Education NVARCHAR(100),
  Experience NVARCHAR(100),
  other_info NVARCHAR(100),
  Job_ID INT REFERENCES Job(Job_ID),
  Candidate_ID INT REFERENCES Candidate(Candidate_ID)
);

INSERT
	INTO
	Candidate_Job_Application (Candidate_Document_ID,
	Date_Of_Application,
	Education,
	Experience,
	other_info,
	Job_ID,
	Candidate_ID)
VALUES
  (1,
'2022-01-01 10:00:00',
'Bachelor of Science in Computer Science',
'0 years of experience in software development',
'Experience with Java, Python, and SQL',
1,
1),
  (2,
'2022-01-02 09:00:00',
'Master of Science in Computer Science',
'5 years of experience in software development',
'Recent grad',
4,
2),
  (3,
'2022-01-03 12:00:00',
'Master of Science in Computer Science',
'2 years of experience in software development',
'Web Developer experience in JS and PHP',
6,
3),
  (4,
'2022-01-04 11:00:00',
'Bachelor of Science in Computer Science',
'3 years of experience in software development',
'Full Stack Developer experience in Reactjs and Nodejs',
1,
4),
  (5,
'2022-01-05 14:00:00',
'Master of Science in Computer Science',
'4 years of experience in Data Engineering',
'Experience with Python, R, and data visualization',
5,
5),
  (6,
'2022-01-06 15:00:00',
'Bachelor of Science in Computer Science',
'6 years of experience in Software Designing',
'Front End Dev with HTML and CSS',
8,
6),
  (7,
'2022-01-07 08:00:00',
'Master of Science in Computer Science',
'8 years of experience in Software Engineering',
'Experience with Java Python Ruby',
3,
7),
  (8,
'2022-01-08 13:00:00',
'Bachelor of Science in Computer Science',
'5 years of experience in Software Engineering',
'Experience with Back End Python and Django',
1,
8),
  (9,
'2022-01-09 16:00:00',
'Bachelor of Science in Computer Science',
'5 years of experience in Software Engineering',
'Software Engineer with experience in C# and .NET',
4,
9),
  (10,
'2022-01-10 17:00:00',
'Master of Science in Computer Science',
'7 years of experience in Engineering',
'Full stack dev with experience in React, MongoDB and Nodejs',
3,
10);
-- Document_Application


CREATE TABLE Document_Application (
  ID INT PRIMARY KEY,
  Document_ID INT FOREIGN KEY REFERENCES Document(Document_ID),
  Candidate_Job_Application_ID INT FOREIGN KEY REFERENCES Candidate_Job_Application(Candidate_Document_ID)
);

INSERT
	INTO
	Document_Application (ID,
	Document_ID,
	Candidate_Job_Application_ID)
VALUES (1,
1,
1),
(2,
2,
2),
(3,
3,
3),
(4,
4,
4),
(5,
5,
5),
(6,
6,
6),
(7,
7,
7),
(8,
8,
8),
(9,
9,
9),
(10,
10,
10);
-- Applciation_Test
CREATE TABLE Application_Test (
  Application_Test_ID INT PRIMARY KEY,
  Start_Time DATETIME,
  End_Time Datetime,
  
  OA_ID INT FOREIGN KEY REFERENCES Online_Assessments(OA_ID),
  Candidate_Job_Application_ID INT FOREIGN KEY REFERENCES Candidate_Job_Application(Candidate_Document_ID)
);

INSERT
	INTO
	Application_Test (Application_Test_ID,
	Start_Time,
	End_Time,
	OA_ID,
	Candidate_Job_Application_ID)
VALUES
(1,
'2023-04-06 10:00:00',
'2023-04-06 11:00:00',
1,
1),
(2,
'2023-04-07 09:00:00',
'2023-04-07 10:00:00',
2,
2),
(3,
'2023-04-08 11:00:00',
'2023-04-08 12:00:00',
3,
3),
(4,
'2023-04-09 13:00:00',
'2023-04-09 14:00:00',
4,
4),
(5,
'2023-04-10 08:00:00',
'2023-04-10 09:00:00',
5,
5),
(6,
'2023-04-11 12:00:00',
'2023-04-11 13:00:00',
6,
6),
(7,
'2023-04-12 14:00:00',
'2023-04-12 15:00:00',
7,
7),
(8,
'2023-04-13 10:00:00',
'2023-04-13 11:00:00',
8,
8),
(9,
'2023-04-14 09:00:00',
'2023-04-14 10:00:00',
9,
9),
(10,
'2023-04-15 11:00:00',
'2023-04-15 12:00:00',
10,
10);
-- Application_Status_Change

CREATE TABLE Application_Status_Change (
  ID INT PRIMARY KEY,
  Date_Changed DATETIME,
  Application_Status_ID INT FOREIGN KEY REFERENCES Application_Status(Application_Status_ID),
  Candidate_Job_Application_ID INT FOREIGN KEY REFERENCES Candidate_Job_Application(Candidate_Document_ID)
);

INSERT
	INTO
	Application_Status_Change (ID,
	Date_Changed,
	Application_Status_ID,
	Candidate_Job_Application_ID)
VALUES
  (1,
'2022-01-01',
6,
1),
  (2,
'2022-01-02',
9,
2),
  (3,
'2022-01-03',
10,
3),
  (4,
'2022-01-04',
5,
4),
  (5,
'2022-01-05',
5,
5),
  (6,
'2022-01-06',
2,
6),
  (7,
'2022-01-07',
10,
7),
  (8,
'2022-01-08',
10,
8),
  (9,
'2022-01-09',
10,
9),
  (10,
'2022-01-10',
5,
10);
-- Candidate_Evaluation
CREATE TABLE Candidate_Evaluation (
Candidate_Evaluation_ID INT PRIMARY KEY,
Notes VARCHAR(250),
Hired VARCHAR(45),
Recruiter_ID INT FOREIGN KEY REFERENCES Recruiter(Recruiter_ID),
Candidate_Job_Application_ID INT FOREIGN KEY REFERENCES Candidate_Job_Application(Candidate_Document_ID)
);

INSERT
	INTO
	Candidate_Evaluation (
Candidate_Evaluation_ID,
	Notes ,
	Hired ,
	Recruiter_ID,
	Candidate_Job_Application_ID
)
VALUES
(1,
'Promising Candidate' ,
'Yes',
7,
6),
(2,
'Not willing to Relocate' ,
'No',
4,
2),
(3,
'Excellent Candidate.Perfect fit ' ,
'Yes',
1,
3),
(4,
'Amazing command on data' ,
'Yes',
3,
8),
(5,
'Has no idea about job description' ,
'No',
5,
10),
(6,
'On Maternity Leave' ,
'No',
7,
4),
(7,
'Great communication skills. Great organization fit' ,
'Yes',
2,
9),
(8,
'Work ethic matches' ,
'Yes',
6,
1),
(9,
'Not able to perform basic tasks' ,
'No',
8,
5),
(10,
'Must be hired immediately to fulfill gap in deliverables' ,
'Yes',
9,
7);
-- Views

CREATE VIEW Job_Opening_Details_by_Org AS
SELECT
	o.Organization_Name,
	SUM(j.Number_of_Openings) AS Total_Openings ,
	j.Job_Name,
	jc.Job_Category_Name
FROM
	Organization o
INNER JOIN Job j on
	j.Organization_ID = o.Organization_ID
INNER JOIN Job_Category jc on
	jc.Job_Category_ID = j.Job_Category_ID
GROUP BY
	o.Organization_Name,
	j.Job_Name,
	jc.Job_Category_Name;

CREATE VIEW ApplicationTracker AS
SELECT
	c.First_Name ,
	c.Last_Name,
	cja.Date_Of_Application ,
	j.Job_Name ,
	as2.Application_Status ,
	r.First_Name + ' ' + r.Last_Name AS RecruiterName
FROM
	Candidate c
JOIN Candidate_Job_Application cja on
	c.Candidate_ID = cja.Candidate_ID
JOIN Job j on
	j.Job_ID = cja.Job_ID
JOIN Application_Status_Change asc2 on
	asc2.Candidate_Job_Application_ID = cja.Candidate_Document_ID
JOIN Application_Status as2 on
	as2.Application_Status_ID = asc2.Application_Status_ID
JOIN Recruiter r on
	j.Recruiter_ID = r.Recruiter_ID ;

CREATE VIEW Hiring_Statistics AS
Select
	as2.Application_Status,
	COUNT(asc2.Application_Status_ID) AS Total
FROM
	Application_Status_Change asc2
INNER JOIN Application_Status as2 on
	as2.Application_Status_ID = asc2.Application_Status_ID
GROUP BY
	as2.Application_Status;

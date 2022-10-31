-- Author Levi Hutchins C3386116
DROP TABLE Reservations
DROP TABLE Acquisition
DROP TABLE AcquisitionItemInfo
DROP TABLE CourseOffering_Privilege
DROP TABLE CourseOffering_Student
DROP TABLE CourseOffering
DROP TABLE StudentMember
DROP TABLE StaffMember
DROP TABLE Privilege
DROP TABLE MovableResource
DROP TABLE MovableItemInfo
DROP TABLE ImmovableResource
DROP TABLE Loan
DROP TABLE Resources
DROP TABLE Category
DROP TABLE Member



CREATE TABLE Member(
	MemberID	CHAR(5) PRIMARY KEY,
	Name		VARCHAR(30) NOT NULL,
	Email		VARCHAR(50) NOT NULL,
	Address		VARCHAR(50) NOT NULL, 
	Status		VARCHAR(10) DEFAULT 'active' CHECK (Status IN ('active','expired')) NOT NULL,
	Phone		CHAR(10),
	Comments	VARCHAR(50),
); 
go

CREATE TABLE Category(
	CategoryID				CHAR(5) PRIMARY KEY NOT NULL,
	Name					VARCHAR(30),
	Description				VARCHAR(100),
	MaxTimeAllowedToBorrowInHrs	INT NOT NULL,
	);
go

CREATE TABLE Resources(
	ResourceID		CHAR(5) PRIMARY KEY NOT NULL,
	CategoryID		CHAR(5),
	Description		VARCHAR(100),
	Status			VARCHAR(11)  DEFAULT 'available' CHECK (Status IN ('available','unavailable')) NOT NULL,

	FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON UPDATE CASCADE ON DELETE CASCADE,
	); 
go
CREATE TABLE Loan(
	LoanID				CHAR(5) PRIMARY KEY,
	ResourceID			CHAR(5) NOT NULL,
	MemberID			CHAR(5) NOT NULL,
	Borrower			VARCHAR(30) NOT NULL,
	DateBorrowed		DATE NOT NULL,
	DaeReturned			DATE,
	DateDue				DATE NOT NULL,


	FOREIGN KEY (MemberID) REFERENCES Member(MemberID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (ResourceID) REFERENCES Resources ON UPDATE CASCADE ON DELETE NO ACTION
); 
go
CREATE TABLE ImmovableResource(
	ResourceID	CHAR(5) PRIMARY KEY,
	Capacity	VARCHAR(30) NOT NULL,
	Room		VARCHAR(5),
	Building	VARCHAR(15),
	Campus		VARCHAR(15)

);
go
CREATE TABLE MovableItemInfo(
	MovableItemID	CHAR(5) PRIMARY KEY,
	Name			VARCHAR(30) NOT NULL,
	Make			VARCHAR(25) NOT NULL,
	Manufacturer	VARCHAR(30) ,
	Urgency			VARCHAR(20) ,
	Year			CHAR(4),
	AssetValue		INT NOT NULL, 
	BuildingSDS		VARCHAR(30),
);
go


CREATE TABLE MovableResource(
	ResourceID		CHAR(5) PRIMARY KEY NOT NULL,
	MovableItemID	CHAR(5) NOT NULL,
	Model			VARCHAR(20) ,

	FOREIGN KEY (ResourceID) REFERENCES Resources ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (MovableItemID) REFERENCES MovableItemInfo(MovableItemID) ON UPDATE CASCADE ON DELETE NO ACTION

);
go

CREATE TABLE Privilege(
	PrivilegeID			CHAR(5) PRIMARY KEY,
	CategoryID			CHAR(5) NOT NULL,
	Name				VARCHAR(30) NOT NULL,
	Description			VARCHAR(50),
	BorrowedAtOneTime	INT NOT NULL,

	FOREIGN KEY (CategoryID) REFERENCES Category ON UPDATE CASCADE ON DELETE CASCADE
);
go

CREATE TABLE StaffMember(
	MemberID	CHAR(5) PRIMARY KEY,
	Position	VARCHAR(30),
	Status		VARCHAR(15) DEFAULT 'Yes' CHECK (Status IN ('Yes','No')) NOT NULL,

	FOREIGN KEY (MemberID) REFERENCES Member(MemberID) ON UPDATE CASCADE ON DELETE NO ACTION,

);
go

CREATE TABLE StudentMember(
	MemberID		CHAR(5) PRIMARY KEY NOT NULL,
	PointsAvailable	INT,

	FOREIGN KEY (MemberID) REFERENCES Member(MemberID) ON UPDATE CASCADE ON DELETE NO ACTION,

);
go

CREATE TABLE CourseOffering(
	OfferingID			CHAR(5) PRIMARY KEY,
	Name				VARCHAR(30),
	SemesterOffered		CHAR(1),
	YearOffered			CHAR(4), 
	BeginDate			DATE,
	EndDate				DATE
);
go

CREATE TABLE CourseOffering_Student(
	OfferingID	CHAR(5)	PRIMARY KEY,
	MemberID	CHAR(5) NOT NULL,

	FOREIGN KEY (OfferingID) REFERENCES CourseOffering ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY  (MemberID) REFERENCES StudentMember ON UPDATE CASCADE ON DELETE NO ACTION 
);
go
CREATE TABLE CourseOffering_Privilege(
	OfferingID	CHAR(5) PRIMARY KEY,
	PrivilegeID	CHAR(5) NOT NULL,

	FOREIGN KEY (OfferingID) REFERENCES CourseOffering(OfferingID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (PrivilegeID) REFERENCES Privilege(PrivilegeID) ON UPDATE CASCADE ON DELETE NO ACTION,
);
go
--- Do Later ----

-- Do Later ---
CREATE TABLE AcquisitionItemInfo(
	ItemID			CHAR(5) PRIMARY KEY,
	Name			VARCHAR(30) NOT NULL,
	Manufacturer	VARCHAR(50) NOT NULL,
	YEAR			CHAR(4) NOT NULL,
	Description		VARCHAR(50),
	Model			VARCHAR(20),
	Price			INT NOT NULL, --chage


);
go
CREATE TABLE Acquisition(
	AcquisitionID		CHAR(5) PRIMARY KEY,
	MemberID			CHAR(5),
	ItemID				CHAR(5),
	Urgency				VARCHAR(20),
	Status				VARCHAR(15) DEFAULT 'Acquired' CHECK (Status IN ('Acquired','Pending')) NOT NULL,
	FundCode			CHAR(5),
	VendorCode			CHAR(5),
	Notes				VARCHAR(50),

	FOREIGN KEY (ItemID) REFERENCES AcquisitionItemInfo(ItemID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (MemberID) REFERENCES Member(MemberID) ON UPDATE CASCADE ON DELETE NO ACTION
);
go

CREATE TABLE Reservations(
	ReservationID		CHAR(5) PRIMARY KEY,
	MemberID			CHAR(5) NOT NULL,
	ResourceID			CHAR(5) NOT NULL,
	CollectionDateTime  DATE,
	ReturnDateTime      DATE NOT NULL,

	FOREIGN KEY (MemberID) REFERENCES Member(MemberID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID) ON UPDATE CASCADE ON DELETE CASCADE 
);
go



INSERT INTO Member VALUES ('MB001','Levi Hutchins','C0001@uon','First Street','active','0422338791',NULL);
INSERT INTO Member VALUES ('MB002','Bob Smith','C2000@uon','Charles Av','expired','0622339101',NULL);
INSERT INTO Member VALUES ('MB003','John Wayne','C3201@uon','March Close','active','0299199191',NULL);
INSERT INTO Member VALUES ('MB004','Olivia Jane','C4221@uon','David Parade','expired','0213568190',NULL);
INSERT INTO Member VALUES ('MB200','Marge Swan','C3111@uon','Swan Close','Active','0482710391',NULL);
INSERT INTO Member VALUES ('MB201','Harry Gray','C1010@uon','Charles Kay Dr','expired','0456192371',NULL);
INSERT INTO Member VALUES ('MB202','Ben Roberts','C0000@uon','Penns Rd','active','0462904718',NULL);
INSERT INTO Member VALUES ('MB203','Bart Simpson','C0020@uon','Evergreen Terrace','active','1234567890',NULL);


INSERT INTO Category VALUES('CR100','Laptop','Fast laptops',24);
INSERT INTO Category VALUES('CR200','Speaker','Genuine JBL speakers',48);
INSERT INTO Category VALUES('CR250','Camera','HD Camera',48);
INSERT INTO Category VALUES('CR300','Room','Collaboration Rooms',5);
INSERT INTO Category VALUES('CR400','Desktop','Alienware desktops',3);

INSERT INTO Resources VALUES('RS100','CR100','Fast laptop great for data science students','available');
INSERT INTO Resources VALUES('RS200','CR100','Portable laptop for simple document work','available');
INSERT INTO Resources VALUES('RS300','CR200','Loud speaker with great bass','unavailable');
INSERT INTO Resources VALUES('RS350','CR250','HD Photography Camera','unavailable');
INSERT INTO Resources VALUES('RS400','CR300','Collaboration room for math students','unavailable');
INSERT INTO Resources VALUES('RS500','CR300','Collaboration room for computer science students','unavailable');
INSERT INTO Resources VALUES('RS600','CR300','Collaboration room for  science students','unavailable');
INSERT INTO Resources VALUES('RS700','CR300','Collaboration room for law students','unavailable');

INSERT INTO Loan VALUES('LN001','RS100','MB001','Levi Hutchins','10/12/2021',NULL,'10/18/2022')
INSERT INTO Loan VALUES('LN002','RS200','MB002','Bob Smith','10/8/2021',NULL,'12/11/2022')
INSERT INTO Loan VALUES('LN003','RS100','MB001','Levi Hutchins','10/1/2021',NULL,'10/10/2022')
INSERT INTO Loan VALUES('LN004','RS500','MB004','Olivia Jane','10/8/2021',NULL,'12/11/2022')
INSERT INTO Loan VALUES('LN005','RS350','MB002','Bob Smith','10/7/2022',NULL,'12/7/2022')
INSERT INTO Loan VALUES('LN006','RS350','MB001','Levi Hutchins','8/7/2022',NULL,'12/7/2022')



INSERT INTO ImmovableResource VALUES ('RS400','30',NULL,NULL,'Callaghan');
INSERT INTO ImmovableResource VALUES ('RS500','50','ES100',NULL,'Callaghan');
INSERT INTO ImmovableResource VALUES ('RS600','20',NULL,NULL,'Callaghan');
INSERT INTO ImmovableResource VALUES ('RS700','10',NULL,NULL,'Callaghan');

INSERT INTO MovableItemInfo VALUES('MI001','Fast laptop','ASUS',NULL,NULL,'2021',1500,NULL);
INSERT INTO MovableItemInfo VALUES('MI002','Portable speaker','JBL',NULL,'Urgent','2018',100,NULL);
INSERT INTO MovableItemInfo VALUES('MI003','Camera','Sony',NULL,'Not Urgent','2016',1200,NULL);
INSERT INTO MovableItemInfo VALUES('MI004','Portable Laptop','Apple',NULL,NULL,'2022',1500,NULL);

INSERT INTO MovableResource VALUES('RS100','MI001',NULL);
INSERT INTO MovableResource VALUES('RS200','MI004',NULL);
INSERT INTO MovableResource VALUES('RS300','MI002',NULL);
INSERT INTO MovableResource VALUES('RS350','MI003','SONY AX500');




INSERT INTO Privilege VALUES('PR001','CR100','StudentMember','Comp Sci Student',4);
INSERT INTO Privilege VALUES('PR002','CR200','StudentMember','Math Student',4);
INSERT INTO Privilege VALUES('PR003','CR300','StaffMember',NULL,6);
INSERT INTO Privilege VALUES('PR004','CR400','StaffMember',NULL,6);

INSERT INTO StaffMember VALUES('MB200','Admin','Yes');
INSERT INTO StaffMember VALUES('MB201','Lecturer','No');
INSERT INTO StaffMember VALUES('MB203','CEO','No');
INSERT INTO StaffMember VALUES('MB202','Coordinator','Yes');

INSERT INTO StudentMember VALUES('MB001',12);
INSERT INTO StudentMember VALUES('MB002',12);
INSERT INTO StudentMember VALUES('MB003',12);
INSERT INTO StudentMember VALUES('MB004',12);

INSERT INTO CourseOffering VALUES('OF101','Data Structures','2','2022','6/1/2022','10/31/2022');
INSERT INTO CourseOffering VALUES('OF202','Discrete Mathematics','2','2022','6/1/2022','10/31/2022');
INSERT INTO CourseOffering VALUES('OF303','Database Information','2','2022','6/1/2022','10/31/2022');
INSERT INTO CourseOffering VALUES('OF404','Web Technologies','2','2022','6/1/2022','10/31/2022');

INSERT INTO CourseOffering_Student VALUES('OF202','MB001')
INSERT INTO CourseOffering_Student VALUES('OF404','MB003')
INSERT INTO CourseOffering_Student VALUES('OF303','MB004')
INSERT INTO CourseOffering_Student VALUES('OF101','MB002')

INSERT INTO CourseOffering_Privilege VALUES('OF202','PR001');
INSERT INTO CourseOffering_Privilege VALUES('OF101','PR002');
INSERT INTO CourseOffering_Privilege VALUES('OF404','PR003');
INSERT INTO CourseOffering_Privilege VALUES('OF303','PR004');

INSERT INTO AcquisitionItemInfo VALUES('AIT01','Norton 360','Norton','2022',NULL,NULL,99);
INSERT INTO AcquisitionItemInfo VALUES('AIT02','Surface Pro','Microsoft','2021',NULL,NULL,1500);
INSERT INTO AcquisitionItemInfo VALUES('AIT03','Ipad Pro','Aplle','2022',NULL,NULL,1100);
INSERT INTO AcquisitionItemInfo VALUES('AIT04','Azure Software','Microsoft','2019',NULL,NULL,10000);

INSERT INTO Acquisition VALUES('A0001','MB200','AIT01',NULL,'Acquired',NULL,NULL,NULL);
INSERT INTO Acquisition VALUES('A0002','MB201','AIT02',NULL,'Pending',NULL,NULL,NULL);
INSERT INTO Acquisition VALUES('A0003','MB001','AIT04',NULL,'Acquired',NULL,NULL,NULL);
INSERT INTO Acquisition VALUES('A0004','MB002','AIT03',NULL,'Pending',NULL,NULL,NULL);

INSERT INTO Reservations VALUES('REV01','MB001','RS100','2/1/2021','3/3/2021');
INSERT INTO Reservations VALUES('REV02','MB002','RS400','6/6/2018','6/6/2018');
INSERT INTO Reservations VALUES('REV03','MB203','RS300','1/1/2022','3/3/2022');
INSERT INTO Reservations VALUES('REV04','MB203','RS400','12/3/2022','12/3/2022');
INSERT INTO Reservations VALUES('REV05','MB203','RS400','12/3/2022','12/3/2022');
INSERT INTO Reservations VALUES('REV06','MB200','RS200',NULL,'3/3/2023');
INSERT INTO Reservations VALUES('REV07','MB003','RS500','2022/06/05','2022/06/05');



-- Question 1
SELECT Name
FROM Member
WHERE MemberID = 
				(SELECT MemberID FROM 
				CourseOffering_Student 
				WHERE OfferingID = 'OF202');

-- Question 2
SELECT BorrowedAtOneTime
FROM Privilege
WHERE CategoryID = 
				(SELECT CategoryID FROM
				Category WHERE CategoryID ='CR200');

-- Question 3
SELECT m.Name AS 'Name', m.Phone AS 'Phone',
COUNT(r.MemberID) AS 'Reservations'
FROM Member m, Reservations r, StaffMember s
WHERE r.MemberID = s.MemberID AND s.MemberID = m.MemberID AND s.MemberID = 'MB203'
AND YEAR(r.CollectionDateTime) = '2022'
GROUP BY m.Name, m.Phone;


-- Question 4
SELECT DISTINCT(m.Name) AS 'Sony AX500 Borrowed By'
FROM Member m, StudentMember sm, Category c, Loan l, MovableResource mrs, Resources rc
WHERE l.MemberID = m.MemberID AND m.MemberID = sm.MemberID AND 
l.ResourceID = rc.ResourceID AND rc.CategoryID = c.CategoryID AND c.Name = 'Camera' AND mrs.Model = 'SONY AX500'
AND YEAR(l.DateBorrowed) = YEAR(SYSDATETIME());

-- Question 5
SELECT res.resourceID, item.Name 
FROM MovableResource res, MovableItemInfo item, Loan l
WHERE  res.MovableItemID = item.MovableItemID AND l.ResourceID = res.ResourceID AND Month(l.DateBorrowed) = Month(SYSDATETIME())
AND Year(l.DateBorrowed) = YEAR(SYSDATETIME())
GROUP BY res.ResourceID, item.Name 

-- Question 6
SELECT res.CollectionDateTime, im.Room,
COUNT(DISTINCT(res.ReservationID)) AS 'Num of Reservations'
FROM ImmovableResource im, Resources r, Reservations res
WHERE r.CategoryID = 'CR300' AND r.ResourceID = 'RS500' AND im.Room = 'ES100' AND res.CollectionDateTime = '2022/06/05'  OR res.CollectionDateTime = '2022/05/01' OR res.CollectionDateTime = '2022/09/19'
GROUP BY res.CollectionDateTime, im.Room, r.CategoryID, res.ReservationID;


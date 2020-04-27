DROP TABLE CUSTOMERS CASCADE CONSTRAINTS;
DROP TABLE LIBRARIANS CASCADE CONSTRAINTS;
DROP TABLE BOOKS CASCADE CONSTRAINTS;
DROP TABLE CHECKEDBOOKS CASCADE CONSTRAINTS;
DROP TABLE ROOMS CASCADE CONSTRAINTS;
DROP TABLE RESERVEDROOMS CASCADE CONSTRAINTS;
DROP TABLE MEETINGS CASCADE CONSTRAINTS;


CREATE TABLE CUSTOMERS(
	CustID  			CHAR(6)		    NOT NULL,
	FirstName			CHAR(50)		NOT NULL,
    LastName			CHAR(50)		NOT NULL,
    CustEmail           VARCHAR(100)    NOT NULL,
    NumBooksCheckedOut	INT     		NOT NULL,
	LateFees		    INT         	NULL,
	CONSTRAINT			CUSTOMER_PK		PRIMARY KEY(CustID),
    CONSTRAINT          MaxCheckedBooks CHECK(NumBooksCheckedOut < 50)
	);

CREATE TABLE LIBRARIANS(
	LibrarianID  		CHAR(5)		    NOT NULL,
	FirstName			CHAR(50)		NOT NULL,
    LastName			CHAR(50)		NOT NULL,
    LibrarianEmail      VARCHAR(100)    NOT NULL,
	StartDate		    Date        	NOT NULL,
	Salary	            Char(5)        	NOT NULL,
    MainSubject         VARCHAR(100)    NULL,
	CONSTRAINT			LIBRARIAN_PK	PRIMARY KEY(LibrarianID)
	);

CREATE TABLE BOOKS(
	BookID  			CHAR(8)		    NOT NULL,
	BookTitle			CHAR(50)		NOT NULL,
    Author  			CHAR(50)		NOT NULL,
	CheckedOut		    VARCHAR(3)	    NOT NULL,
	Genre           	VARCHAR(100)	NOT NULL,
    eBook               CHAR(12)        NOT NULL,
    Price           	INT		        NULL,
	CONSTRAINT			BOOK_PK		PRIMARY KEY(BookID)
	);

CREATE TABLE CHECKEDBOOKS(
	BooksID  			CHAR(8)		    NOT NULL,
    CustomID            CHAR(6)         NOT NULL,
	Late    			CHAR(3)		    NOT NULL,
	RenewalNumber	    VARCHAR(3)	    NOT NULL,
	DueDate             DATE        	NOT NULL,
	CONSTRAINT			CHECKEDBOOKS_PK		PRIMARY KEY(BooksID, CustomID),
    CONSTRAINT          CB_BooksID_FK       FOREIGN KEY(BooksID)
                                                REFERENCES BOOKS(BookID),
    CONSTRAINT          CB_CustomID_FK      FOREIGN KEY(CustomID)
                                                REFERENCES CUSTOMERS(CustID),
    CONSTRAINT          MaxRenewals         CHECK(RenewalNumber < 4)   
	);

CREATE TABLE ROOMS(
    RoomsID             CHAR(4)         NOT NULL,
    SeatAmount          INT             NOT NULL,
    CONSTRAINT          ROOM_PK         PRIMARY KEY(RoomsID)
    );

CREATE TABLE RESERVEDROOMS(
	RoomID  			CHAR(4)		    NOT NULL,
	CustoID 			CHAR(6)         NOT NULL,
    ReservedDate  		DATE		    NOT NULL,
	StartTime		    TIMESTAMP 	    NOT NULL,
	EndTime           	TIMESTAMP	    NOT NULL,
	CONSTRAINT			RR_PK		        PRIMARY KEY(RoomID, CustoID),
    CONSTRAINT          RR_RoomID_FK        FOREIGN KEY(RoomID)
                                                REFERENCES ROOMS(RoomsID),
    CONSTRAINT          RR_CustID_FK        FOREIGN KEY(CustoID)
                                                REFERENCES CUSTOMERS(CustID)
	);


CREATE TABLE MEETINGS(
	MeetingID  			CHAR(3)                     NOT NULL,
	LibrID			    CHAR(5)			            NOT NULL,
    CustomID  			CHAR(6)			            NOT NULL,
	RoomID 	            CHAR(4)	                    NOT NULL,
    MeetingName		    VARCHAR(100)                NOT NULL,
    CONSTRAINT			MEETINGS_PK		            PRIMARY KEY(MeetingID),
    CONSTRAINT          MEETINGS_LIBRARIAN_FK       FOREIGN KEY (LibrID)
                                                        REFERENCES LIBRARIANS(LibrarianID),
    CONSTRAINT          MEETINGS_CUSTOMER_FK        FOREIGN KEY (CustomID)
                                                        REFERENCES CUSTOMERS(CustID),
	CONSTRAINT          MEETING_ROOMS_FK            FOREIGN KEY (RoomID)
                                                        REFERENCES ROOMS(RoomsID)
    );

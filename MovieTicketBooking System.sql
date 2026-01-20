create database ADBMSPROJECT
use ADBMSPROJECT

create table Movies( MovieId int primary key, Title varchar(100), Duration int , Genre varchar(100), ReleaseDate date)


Create table  Shows( ShowId int primary key, MovieId int,CONSTRAINT FK_Shows_Movies
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),ShowDate date, ShowTime time,  HallName varchar(100)) 


Create table Seats(SeatId int primary key, ShowId int, Constraint showID foreign key(ShowId) references Shows(ShowId), seatNumber varchar(100), isAvailable bit)

create table Bookings(BookingId int primary key, ShowId int, Constraint fk_showId foreign key (ShowId) references Shows(ShowId), customerName varchar(100),seatNumber varchar(10), BookingDate datetime)

Drop table Bookings



--CREATE TABLE TickBookings(
  --  BookingId INT PRIMARY KEY IDENTITY(1,1),
    --ShowId INT,
	--MovieId int,
	--CONSTRAINT FK_Show_Movies  FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    --CustomerName VARCHAR(100),
    --SeatNumber VARCHAR(10),
    --BookingDate DATETIME,
    --HallName VARCHAR(100),
    --ShowTime TIME,
    --TicketQuantity INT,
    --TicketPrice INT,
    --TotalAmount INT,
    --CONSTRAINT FK_Bookings_Shows FOREIGN KEY (ShowId) REFERENCES Shows(ShowId)
--);

--drop table TickBookings



CREATE TABLE TickBookings2(
    BookingId INT PRIMARY KEY IDENTITY(1,1),
    ShowId INT,
    MovieId INT,
    CustomerName VARCHAR(100),
    SeatNumber VARCHAR(10),
    BookingDate DATETIME,
    HallName VARCHAR(100),
    ShowTime TIME,
    TicketQuantity INT,
    TicketPrice INT,
    TotalAmount INT,
    CONSTRAINT FK_Bookings_Showss FOREIGN KEY (ShowId) REFERENCES Shows(ShowId),
    CONSTRAINT FK_Bookings_Movies FOREIGN KEY (MovieId) REFERENCES Movies(MovieId)
);

select*from TickBookings2





select*from TickBookings2







CREATE PROCEDURE TicketBookings2
    @ShowId INT,
    @MovieId INT,
    @CustomerName VARCHAR(100),
    @SeatNumber VARCHAR(10),
    @HallName VARCHAR(100),
    @ShowTime TIME,
    @TicketQuantity INT,
    @TicketPrice INT,
    @TotalAmount INT,
    @BookingDate DATETIME
AS
BEGIN
    INSERT INTO TickBookings2(
        ShowId,
        MovieId,
        CustomerName,
        SeatNumber,
        HallName,
        ShowTime,
        TicketQuantity,
        TicketPrice,
        TotalAmount,
        BookingDate
    )
    VALUES(
        @ShowId,
        @MovieId,
        @CustomerName,
        @SeatNumber,
        @HallName,
        @ShowTime,
        @TicketQuantity,
        @TicketPrice,
        @TotalAmount,
        @BookingDate
    );
END;


create procedure updateBookings

@BookingId int,
@ShowId INT,
    @MovieId INT,
    @CustomerName VARCHAR(100),
    @SeatNumber VARCHAR(10),
    @HallName VARCHAR(100),
    @ShowTime TIME,
    @TicketQuantity INT,
    @TicketPrice INT,
    @TotalAmount INT,
    @BookingDate DATETIME

AS
BEGIN
update TickBookings2
set
ShowId = @ShowId,
        MovieId = @MovieId,
        CustomerName = @CustomerName,
        SeatNumber = @SeatNumber,
        HallName = @HallName,
        ShowTime = @ShowTime,
        TicketQuantity = @TicketQuantity,
        TicketPrice = @TicketPrice,
        TotalAmount = @TotalAmount,
        BookingDate = @BookingDate
    WHERE BookingId = @BookingId;
End

CREATE TRIGGER trg_DeleteBooking
ON TickBookings2
AFTER DELETE
AS
BEGIN
    PRINT 'Booking deleted successfully';
END



select*from TickBookings2



select*from TickBookings






select*from Movies
select*from Shows


CREATE PROCEDURE InsertMovie
    @movieId INT,
    @title VARCHAR(100),
    @duration INT,
    @genre VARCHAR(100),
    @releaseDate DATE
AS
BEGIN
    INSERT INTO Movies (MovieId, Title, Duration, Genre, ReleaseDate)
    VALUES (@movieId, @title, @duration, @genre, @releaseDate);
END


create procedure updateMovie
   @movieId INT,
    @title VARCHAR(100),
    @duration INT,
    @genre VARCHAR(100),
    @releaseDate DATE
	as 
	begin
	update Movies
	set
	Title=@title,
	Duration=@duration,
	Genre=@genre,
	ReleaseDate=@releaseDate
	where MovieId=@movieId
	end


	create procedure deleteMovie
	@movieId int
	as
	begin
	Delete from Movies where MovieId=@movieId;
	end



	Select*from TickBookings


	CREATE TABLE aLog
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ActionName VARCHAR(10),
    ActionDateTime DATETIME,
    NoOfRowsAffected INT
);





CREATE TRIGGER trg_Student_Audit
ON TickBookings2
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @Action VARCHAR(10)
    DECLARE @Rows INT

 
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Action = 'INSERT'
        SET @Rows = (SELECT COUNT(*) FROM inserted)
    END

   
    ELSE IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Action = 'UPDATE'
        SET @Rows = (SELECT COUNT(*) FROM inserted)
    END

  
    ELSE IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @Action = 'DELETE'
        SET @Rows = (SELECT COUNT(*) FROM deleted)
    END

    INSERT INTO aLog (ActionName, ActionDateTime, NoOfRowsAffected)
    VALUES (@Action, GETDATE(), @Rows)
END;

select *from alog

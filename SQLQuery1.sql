CREATE DATABASE Hospital;
USE Hospital;

CREATE TABLE Departments (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Name NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Doctors (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name NVARCHAR(MAX) NOT NULL,
    Premium MONEY NOT NULL DEFAULT 0 CHECK (Premium >= 0),
    Salary MONEY NOT NULL CHECK (Salary > 0),
    Surname NVARCHAR(MAX) NOT NULL
);

CREATE TABLE DoctorsExaminations (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    EndTime TIME NOT NULL,
    StartTime TIME NOT NULL CHECK (StartTime BETWEEN '08:00:00' AND '18:00:00'),
    DoctorId INT NOT NULL,
    ExaminationId INT NOT NULL,
    WardId INT NOT NULL,
    FOREIGN KEY (DoctorId) REFERENCES Doctors(Id),
    FOREIGN KEY (ExaminationId) REFERENCES Examinations(Id),
    FOREIGN KEY (WardId) REFERENCES Wards(Id)
);

CREATE TABLE Examinations (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Wards (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name NVARCHAR(20) NOT NULL UNIQUE,
    Places INT NOT NULL CHECK (Places >= 1),
    DepartmentId INT NOT NULL,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);

CREATE TRIGGER CheckMaxDoctorsInWard
ON Wards
AFTER INSERT, UPDATE
AS
BEGIN
    IF (SELECT COUNT(*) FROM Doctors WHERE WardId = (SELECT Id FROM inserted)) > 10
    BEGIN
        RAISEERROR ('Exceeded maximum number of doctors in the ward.', 16, 1)
        ROLLBACK TRANSACTION
    END
END;

CREATE TRIGGER CheckBestBookDeletion
ON Wards
FOR DELETE
AS
BEGIN
    DECLARE @BestBookName NVARCHAR(MAX)
    SELECT TOP 1 @BestBookName = Name FROM Books ORDER BY Popularity DESC

    IF (SELECT Name FROM deleted) = @BestBookName
    BEGIN
        RAISEERROR ('Deletion of the best book is not allowed.', 16, 1)
        ROLLBACK TRANSACTION
    END
END;

CREATE TRIGGER UpdateDepartmentSalary
ON Doctors
AFTER UPDATE
AS
BEGIN
    UPDATE Departments
    SET TotalSalary = (SELECT SUM(Salary + Premium) FROM Doctors WHERE DepartmentId = (SELECT DepartmentId FROM inserted))
    WHERE Id = (SELECT DepartmentId FROM inserted)
END;

CREATE TRIGGER UpdateDepartmentPopularExamination
ON DoctorsExaminations
AFTER INSERT
AS
BEGIN
    DECLARE @PopularExamination NVARCHAR(MAX)
    SELECT TOP 1 @PopularExamination = Name FROM Examinations GROUP BY Name ORDER BY COUNT(*) DESC

    UPDATE Departments
    SET PopularExamination = @PopularExamination
    WHERE Id = (SELECT DepartmentId FROM inserted)
END;

CREATE TRIGGER CheckSalaryChanges
ON Doctors
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Salary) OR UPDATE(Premium)
    BEGIN
        RAISEERROR ('Changes in salary and premium for doctors are not allowed.', 16, 1)
        ROLLBACK TRANSACTION
    END
END;

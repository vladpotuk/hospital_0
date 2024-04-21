USE Hospital;

INSERT INTO Departments (Building, Name) VALUES (1, 'Cardiology');
INSERT INTO Departments (Building, Name) VALUES (2, 'Neurology');
INSERT INTO Departments (Building, Name) VALUES (3, 'Orthopedics');
INSERT INTO Departments (Building, Name) VALUES (4, 'Pediatrics');
INSERT INTO Departments (Building, Name) VALUES (5, 'Oncology');

INSERT INTO Doctors (Name, Premium, Salary, Surname) VALUES ('John', 200, 5000, 'Doe');
INSERT INTO Doctors (Name, Premium, Salary, Surname) VALUES ('Jane', 250, 5500, 'Smith');
INSERT INTO Doctors (Name, Premium, Salary, Surname) VALUES ('David', 150, 4800, 'Johnson');
INSERT INTO Doctors (Name, Premium, Salary, Surname) VALUES ('Sarah', 300, 6000, 'Williams');


INSERT INTO Examinations (Name) VALUES ('MRI');
INSERT INTO Examinations (Name) VALUES ('CT Scan');
INSERT INTO Examinations (Name) VALUES ('X-Ray');
INSERT INTO Examinations (Name) VALUES ('Ultrasound');

INSERT INTO Wards (Name, Places, DepartmentId) VALUES ('Ward A', 20, 1);
INSERT INTO Wards (Name, Places, DepartmentId) VALUES ('Ward B', 15, 2);
INSERT INTO Wards (Name, Places, DepartmentId) VALUES ('Ward C', 25, 3);
INSERT INTO Wards (Name, Places, DepartmentId) VALUES ('Ward D', 18, 4);
INSERT INTO Wards (Name, Places, DepartmentId) VALUES ('Ward E', 22, 5);


INSERT INTO DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) VALUES ('12:00:00', '09:00:00', 1, 1, 1);
INSERT INTO DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) VALUES ('14:00:00', '11:00:00', 2, 2, 2);
INSERT INTO DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) VALUES ('16:00:00', '13:00:00', 3, 3, 3);
INSERT INTO DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) VALUES ('10:00:00', '07:00:00', 4, 4, 4);

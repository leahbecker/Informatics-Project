DROP TABLE IF EXISTS tutorSlot;
DROP TABLE IF EXISTS instructsCourse;
DROP TABLE IF EXISTS problem;
DROP TABLE IF EXISTS instructsCourse;
DROP TABLE IF EXISTS takesCourse;
DROP TABLE IF EXISTS weeklySlot;
DROP TABLE IF EXISTS tutors;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS courseName;
DROP TABLE IF EXISTS admins;
DROP TABLE IF EXISTS courseTaken;
DROP TABLE IF EXISTS tutorApp;
DROP TABLE IF EXISTS account;


CREATE TABLE account (
    hawkID VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    hashedpass VARCHAR(255) NOT NULL,
    userRole VARCHAR(20),
    sessionsRemaining INT DEFAULT NULL,
    PRIMARY KEY (hawkID)
);
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole,sessionsRemaining) VALUES ('johnsmith', 'John', 'Smith', '$2a$12$gbkwiCA1rC3s0WAIaGaGq.7yGWV21k4KWSGRk4UQ6H5D19F5Vv4b.','student',5);
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('leahbecker', 'Leah', 'Becker', '$2a$12$OGseqSeG63NyjgSFUDc3jOmg2TS5gRFmK1G4MbGXZRlDhppc5EbwG','tutor');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('jamescharles', 'James', 'Charles', '$2a$12$leIFOJRfZlj3CImnZvhZdO219sIjNYQHJceOZ29AysN9I4XMWxCXO','faculty');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole,sessionsRemaining) VALUES ('kennyenokian', 'Kenny', 'Enokian', '$2a$12$rLPFKgUP.LpsyTK4qXsHteloqN61A8BmJa8fjY0sDRtR2s8/B4kZC','student',4);
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('lilyjohnson', 'Lily', 'Johnson', '$2a$12$FYVwpUAyfhwDlNHksQ391uh8GMoGEC15/alaii7ySsX55gu7vl4ZS','tutor');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('tedmoseby', 'Ted', 'Moseby', '$2a$12$/x4Ssj4EwtV9xdTVHuNImuiWPznq5fn1naQvhmAus/wF1c2KuquKq','faculty');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole,sessionsRemaining) VALUES ('rachelbartlett', 'Rachel', 'Bartlett', '$2a$12$0PAOOGt2y/kq2HHCoTqhz.KE/d0vybUYpaWWphYQWLbbFrquc.7Xm','student',2);
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('ashleyhewitt', 'Ashley', 'Hewitt', '$2a$12$RNNUy077VNwpbcGMR.Qilefac/nvvYHoUf3aof9WblRfDkJgHScNS','faculty');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('shelbyjoe', 'Shelby', 'Joe', '$2a$12$SJHpSGW2FS4K7Gad32pIfetvv1yxItYLWD2.a/iRRWZhcfmm7pVia','tutor');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole,sessionsRemaining) VALUES ('zachdotzler', 'Zach', 'Dotzler', '$2a$12$sg/bAZc7BE7CPDX/ARZiHepq3O3xWBuIuV/i3yUXiWrVKB/FXelAy','student',6);
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('jessday', 'Jess', 'Day', '$2a$12$dDQk98TqS7OXkF8WsFe8Oe5ORYFw2.z0/Qe13AbXTubKuKqn5Hz.6','tutor');


CREATE TABLE tutorApp (
  FK_hawkID VARCHAR(50) NOT NULL,
  email VARCHAR(60) NOT NULL,
  phone VARCHAR(12) NOT NULL,
  FOREIGN KEY (FK_hawkID) REFERENCES account(hawkID),
  PRIMARY KEY (FK_hawkID)
);
INSERT INTO tutorApp (FK_hawkID, email, phone) VALUES ('jessday', 'jess-day@uiowa.edu', '123-456-7890');


CREATE TABLE courseTaken (
  courseTakenID INT UNSIGNED AUTO_INCREMENT NOT NULL,
  FFK_hawkID VARCHAR(50) NOT NULL,
  courseNum INT NOT NULL,
  courseName VARCHAR(50) NOT NULL,
  courseGrade VARCHAR(2) NOT NULL,
  PRIMARY KEY (courseTakenID),
  FOREIGN KEY (FFK_hawkID) REFERENCES tutorApp(FK_hawkID)
);
INSERT INTO courseTaken (FFK_hawkID, courseNum, courseName, courseGrade) VALUES ('jessday', 1020, 'Principles of Computing', 'B-');

CREATE TABLE admins (
    isAdmin BOOLEAN NOT NULL DEFAULT FALSE,
    FK_hawkID VARCHAR(50) NOT NULL,
    PRIMARY KEY (FK_hawkID),
    FOREIGN KEY (FK_hawkID) REFERENCES account(hawkID)
);
INSERT INTO admins (isAdmin, FK_hawkID) VALUES (True, 'ashleyhewitt');

CREATE TABLE courseName (
  courseNum INT NOT NULL,
  courseName VARCHAR(50) NOT NULL,
  PRIMARY KEY (courseNum)
);
INSERT INTO courseName (courseNum,courseName) VALUES (1020,'Principles of Computing');
INSERT INTO courseName (courseNum, courseName) VALUES (1110,'Introduction to Computer Science');
INSERT INTO courseName (courseNum, courseName) VALUES (1210,'Computer Science I:Fundamentals');

CREATE TABLE course (
    courseID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    FK_courseNum INT NOT NULL,
    sectionNum VARCHAR(50) NOT NULL,
    PRIMARY KEY (courseID),
    FOREIGN KEY (FK_courseNum) REFERENCES courseName(courseNum)
);
INSERT INTO course (FK_courseNum,sectionNum) VALUES (1020,'0A01');
INSERT INTO course (FK_courseNum, sectionNum) VALUES (1110,'0A01');
INSERT INTO course (FK_courseNum, sectionNum) VALUES (1210,'0A01');

CREATE TABLE tutors (
    tutorID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    FK_hawkID VARCHAR(50) NOT NULL,
    FK_courseID INT UNSIGNED NOT NULL,
    PRIMARY KEY (tutorID),
    FOREIGN KEY (FK_hawkID) REFERENCES account(hawkID),
    FOREIGN KEY (FK_courseID) REFERENCES course(courseID)
    
);

INSERT INTO tutors (FK_hawkID, FK_courseID) VALUES ('leahbecker', 1);
INSERT INTO tutors (FK_hawkID, FK_courseID) VALUES ('lilyjohnson', 1);
INSERT INTO tutors (FK_hawkID, FK_courseID) VALUES ('shelbyjoe', 2);


CREATE TABLE weeklySlot (
    hawkID VARCHAR(50) NOT NULL,
    weekday VARCHAR(50) NOT NULL,
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    PRIMARY KEY (hawkID),
    FOREIGN KEY (hawkID) REFERENCES tutors(FK_hawkID)
);

INSERT INTO weeklySlot (hawkID, weekday, startTime, endTime) VALUES ('leahbecker', 'Monday', '9:00', '10:00');
INSERT INTO weeklySlot (hawkID, weekday, startTime, endTime) VALUES ('lilyjohnson', 'Tuesday', '12:00', '1:00');
INSERT INTO weeklySlot (hawkID, weekday, startTime, endTime) VALUES ('shelbyjoe', 'Thursday', '3:00', '4:00');


CREATE TABLE takesCourse (
    takesCourseID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    FK_hawkID VARCHAR(50) NOT NULL,
    FK_courseID INT UNSIGNED NOT NULL,
    sessionsRemaining INT NOT NULL,
    PRIMARY KEY (takesCourseID),
    FOREIGN KEY (FK_hawkID) REFERENCES account(hawkID),
    FOREIGN KEY (FK_courseID) REFERENCES course(courseID)
);
INSERT INTO takesCourse (FK_hawkID, FK_courseID, sessionsRemaining) VALUES ('kennyenokian',1, 6);
INSERT INTO takesCourse (FK_hawkID, FK_courseID, sessionsRemaining) VALUES ('johnsmith',1, 4);
INSERT INTO takesCourse (FK_hawkID, FK_courseID, sessionsRemaining) VALUES ('rachelbartlett',2, 5);
INSERT INTO takesCourse (FK_hawkID, FK_courseID, sessionsRemaining) VALUES ('zachdotzler',3, 2);


CREATE TABLE instructsCourse (
  
    instructsCourseID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    FK_hawkID VARCHAR(50) NOT NULL,
    FK_courseID INT UNSIGNED NOT NULL,
    PRIMARY KEY (instructsCourseID),
    FOREIGN KEY (FK_hawkID) REFERENCES account(hawkID),
    FOREIGN KEY (FK_courseID) REFERENCES course(courseID)
);


CREATE TABLE problem (
  problemID INT UNSIGNED AUTO_INCREMENT NOT NULL,
  title VARCHAR(99) NOT NULL,
  text VARCHAR(9999),
  FK_courseNum INT NOT NULL,
  PRIMARY KEY (problemID),
  FOREIGN KEY (FK_courseNum) REFERENCES courseName(courseNum)
);
INSERT INTO problem (title, text, FK_courseNum) VALUES ('CS:1020 Practice Problem 1', 'This is the problem text. This is the practice problem for CS:1020',1020);
INSERT INTO problem (title, text, FK_courseNum) VALUES ('Exam Preparedness', 'Which concepts do you feel you need improvement in before Exam 1? Which are you most confident in? ',1020);
INSERT INTO problem (title, text, FK_courseNum) VALUES ('CS:1110 Practice Problem 1', 'This is the problem text. This is the practice problem for CS:1110',1110);
INSERT INTO problem (title, text, FK_courseNum) VALUES ('CS:1210 Practice Problem 1', 'This is the problem text. This is the practice problem for CS:1210',1210);

CREATE TABLE answersProblem(
  answersProblemID INT UNSIGNED AUTO_INCREMENT NOT NULL,
  FK_problemID INT UNSIGNED NOT NULL,
  FK_hawkID VARCHAR(50),
  answerText VARCHAR(9999),
  PRIMARY KEY (answersProblemID),
  FOREIGN KEY (FK_problemID) REFERENCES problem(problemID),
  FOREIGN KEY (FK_hawkID) REFERENCES account(hawkID)
);

CREATE TABLE tutorSlot (
  slotID INT UNSIGNED AUTO_INCREMENT NOT NULL,
  FK_student VARCHAR(50) DEFAULT null,
  FK_tutor VARCHAR(50),
  FK_courseID INT UNSIGNED NOT NULL,
  datetime DATETIME NOT NULL,
  canceledByTutor BOOLEAN DEFAULT False,
  canceledByStudent BOOLEAN DEFAULT False,
  PRIMARY KEY (slotID),
  FOREIGN KEY (FK_student) REFERENCES account(hawkID),
  FOREIGN KEY (FK_tutor) REFERENCES account(hawkID),
  FOREIGN KEY (FK_courseID) REFERENCES course(courseID)
);
INSERT INTO tutorSlot (FK_student, FK_tutor, FK_courseID, datetime) VALUES ('kennyenokian', 'leahbecker', 1, '2018-04-26 09:30:00');
INSERT INTO tutorSlot (FK_student, FK_tutor, FK_courseID, datetime) VALUES ('johnsmith', 'lilyjohnson', 1, '2018-05-20 09:00:00');
INSERT INTO tutorSlot (FK_student, FK_tutor, FK_courseID, datetime) VALUES (null, 'leahbecker', 1, '2018-05-21 09:30:00');
INSERT INTO tutorSlot (FK_student, FK_tutor, FK_courseID, datetime) VALUES (null, 'leahbecker', 1, '2018-05-25 09:00:00');
INSERT INTO tutorSlot (FK_student, FK_tutor, FK_courseID, datetime) VALUES (null, 'lilyjohnson', 1, '2018-06-01 12:30:00');
INSERT INTO tutorSlot (FK_student, FK_tutor, FK_courseID, datetime) VALUES (null, 'leahbecker', 1, '2018-06-02 10:30:00');
INSERT INTO tutorSlot (FK_student, FK_tutor, FK_courseID, datetime) VALUES (null, 'leahbecker', 1, '2018-05-07 01:30:00');

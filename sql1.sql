DROP TABLE IF EXISTS tutorSlot;
DROP TABLE IF EXISTS problem;
DROP TABLE IF EXISTS instructsCourse;
DROP TABLE IF EXISTS takesCourse;
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
    PRIMARY KEY (hawkID)
);
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('johnsmith', 'John', 'Smith', 'abcabc','student');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('leahbecker', 'Leah', 'Becker', 'abcabc','tutor');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('jamescharles', 'James', 'Charles', 'abcabc','faculty');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('kennyenokian', 'Kenny', 'Enokian', 'abcabc','student');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('lilyjohnson', 'Lily', 'Johnson', 'abcabc','tutor');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('tedmoseby', 'Ted', 'Moseby', 'abcabc','faculty');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('rachelbartlett', 'Rachel', 'Bartlett', 'abcabc','student');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('ashleyhewitt', 'Ashley', 'Hewitt', 'abcabc','faculty');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('shelbyjoe', 'Shelby', 'Joe', 'abcabc','tutor');
INSERT INTO account (hawkID, firstName, lastName, hashedpass, userRole) VALUES ('zachdotzler', 'Zach', 'Dotzler', 'abcabc','student');

CREATE TABLE tutorApp (
  FK_hawkID VARCHAR(50) NOT NULL,
  email VARCHAR(60) NOT NULL,
  phone VARCHAR(12) NOT NULL,
  FOREIGN KEY (FK_hawkID) REFERENCES account(hawkID),
  PRIMARY KEY (FK_hawkID)
);

CREATE TABLE courseTaken (
  courseTakenID INT UNSIGNED AUTO_INCREMENT NOT NULL,
  FFK_hawkID VARCHAR(50) NOT NULL,
  courseNum INT NOT NULL,
  courseName VARCHAR(50) NOT NULL,
  courseGrade VARCHAR(2) NOT NULL,
  PRIMARY KEY (courseTakenID),
  FOREIGN KEY (FFK_hawkID) REFERENCES tutorApp(FK_hawkID)
  
);

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
    sectionNum INT NOT NULL,
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

-- INSERT INTO tutors (FK_hawkID, FK_courseID) VALUES ('johnsmith', '1020, 1110, 1210');
-- INSERT INTO tutors (FK_hawkID, FK_courseID) VALUES ('leahbecker', '1020, 1110, 1210');


CREATE TABLE weeklySlot (
    hawkID VARCHAR(50) NOT NULL,
    weekday VARCHAR(50) NOT NULL,
    startTime INT NOT NULL,
    endTime INT NOT NULL,
    PRIMARY KEY (hawkID),
    FOREIGN KEY (hawkID) REFERENCES tutors(FK_hawkID),
    
);


CREATE TABLE takesCourse (
    takesCourseID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    FK_hawkID VARCHAR(50) NOT NULL,
    FK_courseID INT UNSIGNED NOT NULL,
    PRIMARY KEY (takesCourseID),
    FOREIGN KEY (FK_hawkID) REFERENCES account(hawkID),
    FOREIGN KEY (FK_courseID) REFERENCES course(courseID)
);
INSERT INTO takesCourse (FK_hawkID, FK_courseID) VALUES ('kennyenokian',1);
INSERT INTO takesCourse (FK_hawkID, FK_courseID) VALUES ('johnsmith',1);
INSERT INTO takesCourse (FK_hawkID, FK_courseID) VALUES ('rachelbartlett',2);
INSERT INTO takesCourse (FK_hawkID, FK_courseID) VALUES ('zachdotzler',3);
--INSERT INTO takesCourse (FK_hawkID, FK_courseID) VALUES ('tedmoseby', '1020');
-- INSERT INTO takesCourse (FK_hawkID, FK_courseID) VALUES ('rachelbartlett', '1110');
-- INSERT INTO takesCourse (FK_hawkID, FK_courseID) VALUES ('shelbyjoe', '1210');

CREATE TABLE instructsCourse (
    instructsCourseID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    FK_hawkID VARCHAR(50) NOT NULL,
    FK_courseID INT UNSIGNED NOT NULL,
    PRIMARY KEY (instructsCourseID),
    FOREIGN KEY (FK_hawkID) REFERENCES account(hawkID),
    FOREIGN KEY (FK_courseID) REFERENCES course(courseID)
);

-- INSERT INTO instructsCourse (FK_hawkID, FK_courseID) VALUES ('jamescharles', '1020');
-- INSERT INTO instructsCourse (FK_hawkID, FK_courseID) VALUES ('kennyenokian', '1110');
-- INSERT INTO instructsCourse (FK_hawkID, FK_courseID) VALUES ('lilyjohnson', '1210');

CREATE TABLE problem (
  problemID INT UNSIGNED AUTO_INCREMENT NOT NULL,
  title VARCHAR(99) NOT NULL,
  text VARCHAR(9999),
  FK_courseNum INT NOT NULL,
  PRIMARY KEY (problemID),
  FOREIGN KEY (FK_courseNum) REFERENCES courseName(courseNum)
);

CREATE TABLE tutorSlot (
  slotID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  FK_student VARCHAR(50),
  FK_tutor VARCHAR(50) NOT NULL,
  FK_courseID INT UNSIGNED NOT NULL,
  datetime DATETIME NOT NULL,
  canceledByTutor BOOLEAN DEFAULT False,
  canceledByStudent BOOLEAN DEFAULT False,
  PRIMARY KEY (slotID),
  FOREIGN KEY (FK_student) REFERENCES takesCourse(hawkID),
  FOREIGN KEY (FK_tutor) REFERENCES tutors(hawkID),
  FOREIGN KEY (FK_courseID) REFERENCES course(courseID)
);

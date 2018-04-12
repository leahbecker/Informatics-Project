--account
DROP TABLE IF EXISTS tutorSlot;
DROP TABLE IF EXISTS courseTaken;
DROP TABLE IF EXISTS scheduleAvail;
DROP TABLE IF EXISTS tutorApp;
DROP TABLE IF EXISTS tutorSched;
DROP TABLE IF EXISTS practiceProb;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS userRole;
DROP TABLE IF EXISTS account;

CREATE TABLE account (
    hawkID VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    hashedpass VARCHAR(255) NOT NULL,
    PRIMARY KEY (hawkID)
);

INSERT INTO account (hawkID, firstName, lastName, hashedpass) VALUES ('johnsmith', 'John', 'Smith', 'abcabc');
INSERT INTO account (hawkID, firstName, lastName, hashedpass) VALUES ('leahbecker', 'Leah', 'Becker', 'abcabc');
INSERT INTO account (hawkID, firstName, lastName, hashedpass) VALUES ('jamescharles', 'James', 'Charles', 'abcabc');
INSERT INTO account (hawkID, firstName, lastName, hashedpass) VALUES ('kennyenokian', 'Kenny', 'Enokian', 'abcabc');
INSERT INTO account (hawkID, firstName, lastName, hashedpass) VALUES ('lilyjohnson', 'Lily', 'Johnson', 'abcabc');
INSERT INTO account (hawkID, firstName, lastName, hashedpass) VALUES ('tedmoseby', 'Ted', 'Moseby', 'abcabc');
INSERT INTO account (hawkID, firstName, lastName, hashedpass) VALUES ('rachelbartlett', 'Rachel', 'Bartlett', 'abcabc');
INSERT INTO account (hawkID, firstName, lastName, hashedpass) VALUES ('ashleyhewitt', 'Ashley', 'Hewitt', 'abcabc');
INSERT INTO account (hawkID, firstName, lastName, hashedpass) VALUES ('shelbyjoe', 'Shelby', 'Joe', 'abcabc');


-- This a table to hold information about the type of user someone is and holds basic information about them


CREATE TABLE userRole (
  roleID INT UNSIGNED AUTO_INCREMENT NOT NULL,
  hawkID VARCHAR(50) NOT NULL,
  administrator BOOLEAN NOT NULL DEFAULT False,
  theirRole VARCHAR(255) NOT NULL,
  PRIMARY KEY (roleID),
  CONSTRAINT FK_rolehawk FOREIGN KEY (hawkID) REFERENCES account(hawkID)

);



INSERT INTO userRole (hawkID, administrator, theirRole) VALUES ('johnsmith', False, 'Tutor');
INSERT INTO userRole (hawkID, administrator, theirRole) VALUES ('leahbecker', False, 'Tutor');
INSERT INTO userRole (hawkID, administrator, theirRole) VALUES ('jamescharles', False, 'Faculty');
INSERT INTO userRole (hawkID, administrator, theirRole) VALUES ('kennyenokian', False, 'Faculty');
INSERT INTO userRole (hawkID, administrator, theirRole) VALUES ('lilyjohnson', False, 'Faculty');
INSERT INTO userRole (hawkID, administrator, theirRole) VALUES ('tedmoseby', False, 'Student');
INSERT INTO userRole (hawkID, administrator, theirRole) VALUES ('rachelbartlett', False, 'Student');
INSERT INTO userRole (hawkID, administrator, theirRole) VALUES ('shelbyjoe', False, 'Student');
INSERT INTO userRole (hawkID, administrator, theirRole) VALUES ('ashleyhewitt', True, 'Administrator');



--course


CREATE TABLE course (
    courseID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    uniCourseNum INT(50) NOT NULL,
    sessionSeason VARCHAR(50) NOT NULL,
    PRIMARY KEY (courseID)
    

);

INSERT INTO course (title, uniCourseNum, sessionSeason) VALUES ('Principles of Computing', '1020', 'Fall');
INSERT INTO course (title, uniCourseNum, sessionSeason) VALUES ('Intro to Computer Science', '1110', 'Fall');
INSERT INTO course (title, uniCourseNum, sessionSeason) VALUES ('Computer Science I: Fundamentals', '1210', 'Spring');




CREATE TABLE practiceProb (
    probID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    courseID INT UNSIGNED NOT NULL,
    probText VARCHAR(999999) NOT NULL,
    title INT(50) NOT NULL,
    course VARCHAR(50) NOT NULL,
    sectionNum VARCHAR(50) NOT NULL,
    PRIMARY KEY (probID),
    CONSTRAINT FK_courseprob FOREIGN KEY (courseID) REFERENCES course(courseID)

);


INSERT INTO practiceProb (courseID, probText, title, course, sectionNum) VALUES ('1', 'Some problem', 'Practice Problems', 'Principles of Computing', '0A01');
INSERT INTO practiceProb (courseID, probText, title, course, sectionNum) VALUES ('1', 'Some problem', 'Practice Problems', 'Intro to Computer Science', '0A01');
INSERT INTO practiceProb (courseID, probText, title, course, sectionNum) VALUES ('1', 'Some problem', 'Practice Problems', 'Computer Science I: Fundamentals', '0A01');



-- This a table to hold information about a tutor's availability

CREATE TABLE tutorSched (
  tutorID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  hawkID VARCHAR(50) NOT NULL,
  startTime TIME NOT NULL,
  numSlots INT NOT NULL,
  weekday VARCHAR(255) NOT NULL,
  PRIMARY KEY (tutorID),
  CONSTRAINT FK_hawktutor FOREIGN KEY (hawkID) REFERENCES userRole(hawkID)
);

INSERT INTO tutorSched (hawkID, startTime, numSlots, weekday) VALUES ('johnsmith', '9:00', '5', 'Monday, Wednesday, Friday');
INSERT INTO tutorSched (hawkID, startTime, numSlots, weekday) VALUES ('johnsmith', '12:00', '3', 'Tuesday, Thursday');
INSERT INTO tutorSched (hawkID, startTime, numSlots, weekday) VALUES ('leahbecker', '1:00', '5', 'Monday, Wednesday, Friday');
INSERT INTO tutorSched (hawkID, startTime, numSlots, weekday) VALUES ('leahbecker', '5:00', '2', 'Tuesday, Thursday');


CREATE TABLE tutorApp (
    appID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    hawkID VARCHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL,
    phone VARCHAR(10) NOT NULL,
    PRIMARY KEY (appID),
    FOREIGN KEY (hawkID) REFERENCES userRole(hawkID)
);

--INSERT INTO tutorApp (hawkID, email, phone) VALUES ('', '', '', '');

CREATE TABLE scheduleAvail (
    availID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    hawkID VARCHAR(20) NOT NULL,
    weekday VARCHAR(15) NOT NULL,
    startTime DATE NOT NULL,
    numOfSlots INT,
    PRIMARY KEY (availID),
    FOREIGN KEY (hawkID) REFERENCES tutorApp(hawkID)
);

--INSERT INTO scheduleAvail (hawkID, weekday, startTime, numOfSlots) VALUES ('', '', '', '', '');

-- This a table to hold information about a course that has been taken by a potential tutor

CREATE TABLE courseTaken (
  courseID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  hawkID VARCHAR(50) NOT NULL,
  title VARCHAR(50) NOT NULL,
  grade VARCHAR(255) NOT NULL,
  PRIMARY KEY (courseID),
  CONSTRAINT FK_hawkcourse FOREIGN KEY (hawkID) REFERENCES tutorApp(hawkID)

);

INSERT INTO courseTaken (hawkID, title, grade) VALUES ('lb', 'Principles of Computing, Intro to Computer Science, Computer Science I: Fundamentals', 'A, A, A-');
INSERT INTO courseTaken (hawkID, title, grade) VALUES ('db', 'Principles of Computing, Intro to Computer Science', 'A-, A-');
INSERT INTO courseTaken (hawkID, title, grade) VALUES ('bb', 'Principles of Computing, Intro to Computer Science, Computer Science I: Fundamentals', 'A, B+ A');



CREATE TABLE tutorSlot (
    slotID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    hawkID VARCHAR(20) NOT NULL,
    course VARCHAR(20) NOT NULL,
    datetime DATE TIME NOT NULL,
    student BOOLEAN,
    canceledByTutor BOOLEAN,
    canceledByStudent BOOLEAN,
    PRIMARY KEY (slotID),
    FOREIGN KEY (hawkID) REFERENCES userRole(hawkID)
);

INSERT INTO tutorSlot (hawkID, course, datetime, student, canceledByTutor, canceledByStudent) VALUES ('tedmoseby', 'Principles of Computing', 'datetime', True, False, False);
INSERT INTO tutorSlot (hawkID, course, datetime, student, canceledByTutor, canceledByStudent) VALUES ('shelbyjoe', 'Computer Science I: Fundamentals', 'datetime', True, False, False);
INSERT INTO tutorSlot (hawkID, course, datetime, student, canceledByTutor, canceledByStudent) VALUES ('rachelbartlett', 'Intro to Computer Science', 'datetime', True, False, False);

--account
DROP TABLE IF EXISTS account;

CREATE TABLE account (
    accountID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    hawkID VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    administrator BOOLEAN NOT NULL DEFAULT False,
    PRIMARY KEY (accountID)
);
--INSERT INTO account (accountID, hawkID, firstName, lastName, administrator) VALUES ('', '', '', '', '');


-- This a table to hold information about the type of user someone is and holds basic information about them
DROP TABLE IF EXISTS userRole;

CREATE TABLE userRole (
  roleID INT UNSIGNED AUTO_INCREMENT NOT NULL,
  hawkID VARCHAR(50) NOT NULL,
  uniCourseNum INT(50) NOT NULL,
  theirRole VARCHAR(255) NOT NULL,
  credits INT NULL,
  PRIMARY KEY (roleID),
  FOREIGN KEY (hawkID) REFERENCES account(hawkID)
);

--INSERT INTO userRole (roleID, hawkID, courseID, theirRole, credits) VALUES ('', '', '', '', '');


--course
DROP TABLE IF EXISTS course;

CREATE TABLE course (
    courseID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    uniCourseNum INT(50) NOT NULL,
    sessionSeason VARCHAR(50) NOT NULL,
    PRIMARY KEY (courseID)
    FOREIGN KEY (uniCourseNum) REFERENCES userRole(uniCourseNum)
);

--INSERT INTO course (courseID, title, uniCourseNum, sessionSeason) VALUES ('', '', '', '');

DROP TABLE IF EXISTS practiceProb;

CREATE TABLE practiceProb (
    probID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    probText VARCHAR(999999) NOT NULL,
    title INT(50) NOT NULL,
    course VARCHAR(50) NOT NULL,
    sectionNum VARCHAR(50) NOT NULL,
    PRIMARY KEY (courseID)
    FOREIGN KEY (title) REFERENCES course(title)
);
--INSERT INTO practiceProb (probID, probText, title, course, sectionNum) VALUES ('', '', '', '', '');


-- This a table to hold information about a tutor's availability
DROP TABLE IF EXISTS tutorSched;

CREATE TABLE tutorSched (
  tutorID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  hawkID VARCHAR(50) NOT NULL,
  courseID INT NOT NULL AUTO_INCREMENT,
  startTime TIME NOT NULL,
  numSlots INT NOT NULL,
  weekday VARCHAR(255) NOT NULL,
  PRIMARY KEY (tutorID),
  FOREIGN KEY (hawkID) REFERENCES userRole(hawkID)
);
--INSERT INTO tutorSched (tutorID, hawkID, courseID, startTime, numSlots, weekday) VALUES ('', '', '', '', '', '');

DROP TABLE IF EXISTS tutorApp;

CREATE TABLE tutorApp (
    appID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    hawkID VARCHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL,
    phone VARCHAR(10) NOT NULL,
    PRIMARY KEY (appID),
    FOREIGN KEY (hawkID) REFERENCES userRole(hawkID)
);
--INSERT INTO tutorApp (appID, hawkID, email, phone) VALUES ('', '', '', '');

DROP TABLE IF EXISTS scheduleAvail;

CREATE TABLE scheduleAvail (
    availID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    hawkID VARCHAR(20) NOT NULL,
    weekday VARCHAR(15) NOT NULL,
    startTime DATE NOT NULL,
    numOfSlots INT,
    PRIMARY KEY (availID),
    FOREIGN KEY (hawkID) REFERENCES tutorApp(hawkID)
);
--INSERT INTO scheduleAvail (availID, hawkID, weekday, startTime, numOfSlots) VALUES ('', '', '', '', '');

-- This a table to hold information about a course that has been taken by a potential tutor
DROP TABLE IF EXISTS courseTaken;

CREATE TABLE courseTaken (
  courseID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  hawkID VARCHAR(50) NOT NULL,
  title VARCHAR(50) NOT NULL,
  grade VARCHAR(255) NOT NULL,
  PRIMARY KEY (courseID),
  FOREIGN KEY (hawkID) REFERENCES tutorApp(hawkID)
);
--INSERT INTO courseTaken (courseID, hawkID, title, grade) VALUES ('', '', '', '');

DROP TABLE IF EXISTS tutorSlot;

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
--INSERT INTO tutorSlot (slotID, hawkID, course, datetime, student, canceledByTutor, canceledByStudent) VALUES ('', '', '', '', '', '', '');







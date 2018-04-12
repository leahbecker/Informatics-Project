DROP TABLE IF EXISTS takesCourse;
DROP TABLE IF EXISTS tutors;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS admins;
DROP TABLE IF EXISTS accountt;


CREATE TABLE accountt (
    hawkID VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    hashedpass VARCHAR(255) NOT NULL,
    PRIMARY KEY (hawkID)
);

INSERT INTO accountt (hawkID, firstName, lastName, hashedpass) VALUES ('johnsmith', 'John', 'Smith', 'abcabc');
INSERT INTO accountt (hawkID, firstName, lastName, hashedpass) VALUES ('leahbecker', 'Leah', 'Becker', 'abcabc');
INSERT INTO accountt (hawkID, firstName, lastName, hashedpass) VALUES ('jamescharles', 'James', 'Charles', 'abcabc');
INSERT INTO accountt (hawkID, firstName, lastName, hashedpass) VALUES ('kennyenokian', 'Kenny', 'Enokian', 'abcabc');
INSERT INTO accountt (hawkID, firstName, lastName, hashedpass) VALUES ('lilyjohnson', 'Lily', 'Johnson', 'abcabc');
INSERT INTO accountt (hawkID, firstName, lastName, hashedpass) VALUES ('tedmoseby', 'Ted', 'Moseby', 'abcabc');
INSERT INTO accountt (hawkID, firstName, lastName, hashedpass) VALUES ('rachelbartlett', 'Rachel', 'Bartlett', 'abcabc');
INSERT INTO accountt (hawkID, firstName, lastName, hashedpass) VALUES ('ashleyhewitt', 'Ashley', 'Hewitt', 'abcabc');
INSERT INTO accountt (hawkID, firstName, lastName, hashedpass) VALUES ('shelbyjoe', 'Shelby', 'Joe', 'abcabc');

CREATE TABLE admins (
    isAdmin BOOLEAN NOT NULL DEFAULT FALSE,
    FK_hawkID VARCHAR(50) NOT NULL,
    PRIMARY KEY (FK_hawkID),
    FOREIGN KEY (FK_hawkID) REFERENCES accountt(hawkID)
);

INSERT INTO admins (isAdmin, FK_hawkID) VALUES (True, 'ashleyhewitt');


CREATE TABLE course (
    courseID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    PRIMARY KEY (courseID)
);


CREATE TABLE tutors (
    tutorID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    FK_hawkID VARCHAR(50) NOT NULL,
    FK_courseID INT UNSIGNED NOT NULL,
    PRIMARY KEY (tutorID),
    FOREIGN KEY (FK_hawkID) REFERENCES accountt(hawkID),
    FOREIGN KEY (FK_courseID) REFERENCES course(courseID)
    
);

INSERT INTO tutors (FK_hawkID, FK_courseID) VALUES ('johnsmith', '1020, 1110, 1210');
INSERT INTO tutors (FK_hawkID, FK_courseID) VALUES ('leahbecker', '1020, 1110, 1210');

CREATE TABLE takesCourse (
    takesCourseID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    FK_hawkID VARCHAR(50) NOT NULL,
    FK_courseID INT UNSIGNED NOT NULL,
    PRIMARY KEY (takesCourseID),
    FOREIGN KEY (FK_hawkID) REFERENCES accountt(hawkID),
    FOREIGN KEY (FK_courseID) REFERENCES course(courseID)
);

INSERT INTO takesCourse (FK_hawkID, FK_courseID) VALUES ('tedmoseby', '1020');
INSERT INTO takesCourse (FK_hawkID, FK_courseID) VALUES ('rachelbartlett', '1110');
INSERT INTO takesCourse (FK_hawkID, FK_courseID) VALUES ('shelbyjoe', '1210');

CREATE TABLE instructsCourse (
    instructsCourseID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    FK_hawkID VARCHAR(50) NOT NULL,
    FK_courseID INT UNSIGNED NOT NULL,
    PRIMARY KEY (instructsCourseID),
    FOREIGN KEY (FK_hawkID) REFERENCES accountt(hawkID),
    FOREIGN KEY (FK_courseID) REFERENCES course(courseID)
);

INSERT INTO instructsCourse (FK_hawkID, FK_courseID) VALUES ('jamescharles', '1020');
INSERT INTO instructsCourse (FK_hawkID, FK_courseID) VALUES ('kennyenokian', '1110');
INSERT INTO instructsCourse (FK_hawkID, FK_courseID) VALUES ('lilyjohnson', '1210');

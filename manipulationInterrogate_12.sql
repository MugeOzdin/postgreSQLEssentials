--------- Manipulating the data -----------
-- 2 teachers 
INSERT INTO universityx.person VALUES (16, 'P2049', false, 'Jane', 'DOE', NULL, NULL, NULL, 'jane.doe@universityx.com', NULL, NULL, NULL, NULL); 
INSERT INTO universityx.person VALUES (18, 'P1234', false, 'John', 'BROWN', NULL, NULL, NULL, 'john.brown@universityx.com', NULL, NULL, NULL, NULL); 
-- 3 students
INSERT INTO universityx.person VALUES (19, 'E1235', true, 'Etienne', 'DUGARY', '2001-09-11', '(+33)656009977', '477 avenue roman', 'etienne.dugary@universityx.com', 'Lilles', '59000', 'FR', 'FR'); 
INSERT INTO universityx.person VALUES (20, 'E1236', true, 'Phil', 'MORIS', '2006-11-21', '(+33)65239977', '47 avenue roman', 'phil.moris@universityx.com', 'Montepellier', '34000', 'FR', 'FR'); 
INSERT INTO universityx.person VALUES (21, 'E1237', true, 'Rachid', 'ELDINE', '2003-05-14', '(+33)65899977', '77 avenue roman', 'rachid.eldine@universityx.com', 'Lyon', '69000', 'FR', 'FR'); 

-- Fundamental courses
INSERT INTO universityx.course VALUES (12,'UL916', 'Cours SQL', 20, true, 3, 'Salle 405');
-- Non-fundamental courses 
INSERT INTO universityx.course VALUES (13,'UL917', 'Cours Python', 40, false, 4, 'Amphi 4');
-- Course with the same room as the UL course
INSERT INTO universityx.course VALUES (14,'UL914', 'Cours Azure', 60, false, 5, 'Amphi 7(AI)');
-- Course without information on duration and unit value
---------------- TO BE MODIFIED IF NECESSARY --------------------------
--ALTER TABLE universityx.course ALTER COLUMN duration drop not null;
--ALTER TABLE universityx.course ALTER COLUMN unitvalue drop not null;
INSERT INTO universityx.course VALUES (11,'UL916', 'Cours SQL', null, false, null, 'Amphi 7(AI)');

UPDATE universityx.person SET phone = '+(33)667876923' WHERE personcode = 'E2102';

UPDATE universityx.person SET phone = '(+33)190919293' WHERE isstudent = false;

SELECT * FROM universityx.person;

SELECT * FROM universityx.course;
SELECT * FROM universityx.professorcoursegiven;
INSERT INTO universityx.professorcoursegiven VALUES (6, 'UL916', 'P2049', '2021-07-01', '2021-07-01T11:00:00', '2021-07-01T11:00:00');
INSERT INTO universityx.professorcoursegiven VALUES (7, 'UL917', 'P2049', TO_DATE('01/07/2021', 'DD/MM/YYYY'), '2021-07-01T11:00:00', '2021-07-01T11:00:00');
INSERT INTO universityx.professorcoursegiven VALUES (8, 'UL916', 'P1234', TO_DATE('01/08/2021', 'DD/MM/YYYY'), 
'01/8/2021 11:00:00' , '2021-07-01T11:00:00');
TO_TIMESTAMP('01/8/2021 11:00:00' ,'DD/MM/YYYY HH24:MI:SS');

SELECT * FROM universityx.professorcoursegiven;
INSERT INTO universityx.studentcoursetaken VALUES (20, 'E2108',7 ,'UL917',15.0, '2021-07-01',NOW(), NULL);
INSERT INTO universityx.studentcoursetaken VALUES (21, 'E2104',8 ,'UL916',15.0, '2021-08-01',NOW(), NULL);

INSERT INTO universityx.professorcoursegiven (idcoursegiven, course_coursecode, person_personcode, coursedate, coursestartedat, coursefinishedat) 
VALUES (9, 'UL711', 'P1234','2021-06-01', '2021-06-01T11:00:00', '2021-06-01T12:00:00');

UPDATE universityx.professorcoursegiven SET person_personcode='P2044' WHERE course_coursecode='UL105';


DELETE FROM universityx.studentcoursetaken WHERE coursegiven_course_coursecode='UL712' AND person_personcode='E2103';

DELETE FROM universityx.studentcoursetaken WHERE coursegiven_course_coursecode='UL719';
DELETE FROM universityx.professorcoursegiven WHERE course_coursecode='UL719' /*CASCADE*/;


------------- Interrogate the database ---------------
SELECT * FROM universityx.course;

SELECT firstname, lastname FROM universityx.person ORDER BY Lastname;

SELECT firstname, lastname FROM universityx.person WHERE city = 'Paris';

SELECT DISTINCT city from universityx.Person WHERE isstudent = true;

SELECT * FROM universityx.course WHERE isfundamental is true and unitvalue >= 2;

SELECT * from universityx.Person WHERE streetaddress is null;

SELECT * from universityx.course WHERE coursename like 'Découverte%';

SELECT * from universityx.Person WHERE (streetaddress like '%avenue%' or streetaddress like '%boulevard%') and isstudent = true ;

SELECT * from universityx.Person WHERE city != 'Paris';
SELECT * from universityx.Person WHERE city not like 'Paris';

SELECT * FROM universityx.studentcoursetaken WHERE person_personcode ='E2104' order by score; 

SELECT * FROM universityx.professorcoursegiven WHERE person_personcode = 'P2040' or person_personcode = 'P2044';
SELECT * FROM universityx.professorcoursegiven WHERE person_personcode IN ('P2040','P2044');

SELECT * FROM universityx.person WHERE isstudent = false;
SELECT * FROM universityx.person WHERE personcode like 'P%';
SELECT * FROM universityx.person WHERE isstudent != true;
SELECT * FROM universityx.person WHERE personcode not like 'E%';

SELECT * FROM universityx.person WHERE birthdate between '2001-01-01' and '2001-03-01';

SELECT score*2 FROM universityx.studentcoursetaken WHERE person_personcode ='E2101';

SELECT 'Professeur ' || firstname || ' ' || lastname FROM universityx.person WHERE isstudent = false;
SELECT CONCAT('professor ', firstname, ' ', lastname )FROM universityx.person WHERE isstudent = false;

SELECT course_coursecode, person_personcode, coursedate,  TO_CHAR(coursestartedat, 'HH24:MI:SS'), TO_CHAR(coursefinishedat,'HH24:MI:SS'), FROM universityx.professorcoursegiven;

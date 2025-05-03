---
CREATE USER student WITH ENCRYPTED PASSWORD 'student1';
CREATE USER professor WITH ENCRYPTED PASSWORD 'professor1';
CREATE USER secretary WITH ENCRYPTED PASSWORD 'secretary1';

GRANT CONNECT ON DATABASE db_tp TO student, professor, secretary;
GRANT USAGE ON SCHEMA universityx TO student, professor, secretary;

--
GRANT SELECT(firstname, lastname, personcode) ON TABLE universityx.person TO student; 
GRANT SELECT ON TABLE universityx.course, universityx.professorcoursegiven, universityx.studentcoursetaken TO student;
GRANT INSERT ON TABLE universityx.person, universityx.studentcoursetaken TO student;

---
GRANT SELECT(firstname, lastname, personcode) ON TABLE universityx.person TO professor; 
GRANT SELECT ON TABLE universityx.course, universityx.professorcoursegiven, universityx.studentcoursetaken TO professor;
GRANT INSERT, UPDATE, DELETE ON TABLE universityx.course, universityx.professorcoursegiven TO professor;

---
GRANT SELECT ON TABLE universityx.person, universityx.course, universityx.professorcoursegiven, universityx.studentcoursetaken, universityx.country TO secretary; 
GRANT UPDATE, DELETE ON TABLE universityx.person, universityx.course, universityx.professorcoursegiven, universityx.studentcoursetaken, universityx.country TO secretary;


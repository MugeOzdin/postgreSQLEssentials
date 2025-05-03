---------- Other components --------
---
-- Creating tables
CREATE TABLE tab1 (id INT NOT NULL, texte VARCHAR(32) DEFAULT NULL);
CREATE TABLE tab2 (id SERIAL NOT NULL, texte VARCHAR(32) DEFAULT NULL);

-- 3 queries to observe my sequences
SELECT * FROM information_schema.sequences;
SELECT * FROM pg_sequences;
SELECT * FROM tab2_id_seq;

---
INSERT INTO  tab1 VALUES (DEFAULT,DEFAULT);
-- > error
---
INSERT INTO  tab2 VALUES (DEFAULT,DEFAULT);
-- > insert OK auto-increment SERIAL 
-- > Field value = NULL
-------- Table result -----------
-- id   texte
-- 1    NULL

-- Add auto-increment to table 1
CREATE SEQUENCE tab1_id_seq; -- by default MINVALUE 1 MAXVALUE 9223372036854775807 INCREMENT 1 NOCYCLE
ALTER TABLE tab1 ALTER COLUMN id SET DEFAULT NEXTVAL('tab1_id_seq'); 

---
INSERT INTO tab1 VALUES (DEFAULT, DEFAULT);
SELECT * FROM tab1;
-- id  texte
-- 1   NULL
SELECT currval('tab1_id_seq');
--> 1

-- Execute SELECT nextval('my_sequence');
SELECT nextval('tab1_id_seq');
--> 2

---
INSERT INTO tab1 VALUES (DEFAULT, DEFAULT);
SELECT currval('tab1_id_seq');
--> 3
SELECT * FROM tab1;
-- id  texte
-- 1   NULL
-- 3   NULL

---
CREATE OR REPLACE VIEW listeCours 
(cours,professeur,duree,coefficient,fondamentale,date_examen) 
AS 
SELECT coursename as cours, CONCAT('Professeur ',lastname,' ', firstname) as professeur, duration as duree, unitvalue as coefficient, 
CASE isfundamental
	when true then 'Fondamentale'
	when false then 'Non fondamentale'
END as fondamentale, 
TO_CHAR(coursedate, 'DD/MM/YYYY') as date_examen
FROM universityx.person
INNER JOIN universityx.professorcoursegiven ON personcode = person_personcode
INNER JOIN universityx.course ON coursecode = course_coursecode;

Select * from listeCours;


---
CREATE OR REPLACE PROCEDURE inscriptionEtudiant (codeCours VARCHAR(5), nomEtudiant VARCHAR(32) , nomProf VARCHAR(32))
language 'plpgsql'
AS $$
DECLARE 
    codeCoursProf INT;
    codeEtudiant VARCHAR(5);
    codeProf VARCHAR(5);
BEGIN 
-- Retrieve the course code codeCourse given by the nameProfessor
    SELECT idcoursegiven INTO codeCoursProf
    FROM universityx.professorcoursegiven prof
    INNER JOIN universityx.person ON person.personcode = prof.person_personcode
    WHERE person.lastname = nomProf
    AND prof.course_coursecode = codeCours;

   -- SELECT personcode INTO codeProf FROM universityx.person WHERE lastname = nomProf;
   -- SELECT idcoursegiven INTO codeCoursProf FROM universityx.professorcoursegiven WHERE course_coursecode = codeCours 
   -- AND person_personcode = codeProf;

-- Retrieve the student code
    SELECT personcode INTO codeEtudiant
    FROM universityx.person 
    WHERE lastname = nomEtudiant;

    INSERT INTO universityx.studentcoursetaken VALUES (DEFAULT, codeEtudiant,codeCoursProf,codeCours, NULL, NULL , NOW(), NULL);
    RAISE NOTICE '% est inscrit au cours % donné par le professeur %',nomEtudiant,codeCours,nomProf ;
END;$$

CALL inscriptionEtudiant('UL105','BELLUCHI','KALAKA')
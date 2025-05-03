---------- Analyze the data  -------------
---
SELECT firstname, lastname, SUBSTR(postcode,1, 2) FROM universityx.person;
SELECT firstname, lastname, LPAD(postcode, 2) FROM universityx.person;

---
SELECT CONCAT(SUBSTR(firstname,1, 1), SUBSTR(lastname,1, 2)) FROM universityx.person;

---
Select firstname, lastname, TO_CHAR(birthdate,'DAY DD MONTH YYYY') FROM universityx.person;

---
SELECT avg(score) FROM universityx.studentcoursetaken;

---
SELECT person_personcode,avg(score) FROM universityx.studentcoursetaken GROUP BY person_personcode;
SELECT person_personcode,SUM(score)/COUNT(score) FROM universityx.studentcoursetaken GROUP BY person_personcode;

---
SELECT person_personcode,sum(coursefinishedat - coursestartedat) FROM universityx.professorcoursegiven GROUP BY person_personcode;

---
SELECT person_personcode, AVG(score) FROM universityx.studentcoursetaken GROUP BY person_personcode HAVING AVG(score) <10; 

---
SELECT person_personcode, AVG(score), RANK() OVER(order by avg(score)) FROM universityx.studentcoursetaken 
group by person_personcode
LIMIT 3
OFFSET 2;

---
select person_personcode, coursegiven_course_coursecode, score, 
MIN(score) OVER(PARTITION BY coursegiven_idcoursegiven), 
MAX(score) OVER(PARTITION BY coursegiven_idcoursegiven), 
AVG(score) OVER(PARTITION BY coursegiven_idcoursegiven),
CONCAT(RANK() OVER (PARTITION BY coursegiven_idcoursegiven ORDER BY score DESC),'/',
COUNT(score) OVER(PARTITION BY coursegiven_idcoursegiven)) AS classement
from universityx.studentcoursetaken;


-- modify the search_path to avoid specifying the schema name each time: set search_path to universityx;

---------- Interrogerate the data across multiple tables ----------
---
SELECT firstname, lastname, AVG(score) 
FROM person  
INNER JOIN studentcoursetaken ON person_personcode = personcode
group by  firstname, lastname; 

---
SELECT firstname, lastname, personcode, course_coursecode
FROM person  
LEFT JOIN professorcoursegiven ON person_personcode = personcode
WHERE isstudent = false
and  course_coursecode is  null;
-- OR
SELECT personcode FROM universityx.person WHERE isstudent is False
EXCEPT
SELECT DISTINCT person_personcode FROM universityx.professorcoursegiven;

---
CREATE TABLE universityx.school (
    schoolID INT PRIMARY KEY,
    school_name VARCHAR(2),
    school_address VARCHAR(30))

INSERT INTO universityx.school VALUES (1,'E1', '10 rue Sextius Michel');
INSERT INTO universityx.school VALUES (2,'E2', '5 rue Dr.Finlay');
INSERT INTO universityx.school VALUES (3,'E3', '37 Quai de Grenelle');

---
SELECT school_address FROM universityx.school 
UNION 
SELECT streetaddress FROM universityx.person;

---
SELECT personcode, firstname, lastname, AVG(score),
CASE
        WHEN AVG(score)>= 10 THEN 'Validé'
        WHEN AVG(score)<10 THEN 'Non validé'
END
FROM universityx.person 
INNER JOIN universityx.studentcoursetaken ON person_personcode = personcode
GROUP BY(personcode, firstname, lastname);

---
ALTER TABLE universityx.person ADD COLUMN mrg_id VARCHAR(5);
ALTER TABLE universityx.person ADD CONSTRAINT  fk_mrg_person FOREIGN KEY (mrg_id) REFERENCES universityx.person(personcode);
---
UPDATE universityx.person SET mrg_id = 'P2049' WHERE personcode = 'E2105';
---
SELECT p1.firstname as prenom_prof, p1.lastname as nom_prof, p2.firstname as prenom_eleve, p2.lastname as nom_eleve 
FROM universityx.person p1
LEFT JOIN universityx.person p2 ON p1.personcode = p2.mrg_id
WHERE p1.isstudent = false;

---
select A.firstname AS personne_1, B.firstname AS personne_2, (EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM A.birthdate)) 
from universityx.person A, universityx.person B
WHERE A.idperson != B.idperson 
AND (EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM A.birthdate)) = (EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM B.birthdate))
AND A.isstudent = true
order by (EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM A.birthdate));

---
Select firstname, coursename FROM Person
cross join course
where isstudent = true
order by firstname; 

---
Select * FROM universityx.studentcoursetaken 
WHERE person_personcode IN (
    SELECT person_personcode 
    FROM universityx.studentcoursetaken
    GROUP BY person_personcode
    HAVING AVG(score) > 10
    ) AND score < 10
    ;

---
SELECT p.firstname, p.lastname, coursename, MIN(score) as minimum ,MAX(score) as maximum, AVG(score), COUNT(score),
p1.lastname
FROM person p
LEFT JOIN professorcoursegiven ON personcode = person_personcode
LEFT JOIN studentcoursetaken  ON coursegiven_idcoursegiven = idcoursegiven
LEFT JOIN course ON coursecode = course_coursecode
LEFT JOIN person p1 ON p1.personcode = p.mrg_id
WHERE p.isstudent = false
group by coursename, p.firstname, p.lastname,p1.lastname;
/* secretary */
SELECT CURRENT_USER;

SELECT * FROM universityx.person;

UPDATE universityx.person SET city='Lyon' WHERE personcode IN('P1998', 'E1998');
INSERT INTO universityx.studentcoursetaken VALUES (15, 'E1998', 1, 'UL712', NULL, '2006-01-01', '2006-01-01', NULL)

REVOKE UPDATE ON universityx.person FROM secretary;
/* professor */
SELECT CURRENT_USER;

INSERT INTO universityx.person VALUES (17, 'P1998', TRUE, 'Jane', 'Doe', '1900-01-01', '(+33)66675155)', '135 rue Brancion', 'jane.doe@universityx.fr', 'Paris', '75015', 'FR', 'FR');
INSERT INTO universityx.course VALUES (11, 'UL100', 'Fondamentaux SQL', 60, True, 3, 'A011-A013 (ST)');
INSERT INTO universityx.professorcoursegiven VALUES (6, 'UL100', 'P1998', '2006-01-01', '2021-06-01T11:00:00', '2021-06-01T12:00:00')

INSERT INTO universityx.country VALUES (1000, 'FR', 'France');

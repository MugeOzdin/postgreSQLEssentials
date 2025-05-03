CREATE TABLE IF NOT EXISTS universityx.studentcoursetaken
(
    idcoursetaken serial NOT NULL,
    person_personcode character varying(5) NOT NULL,
    coursegiven_idcoursegiven integer NOT NULL,
    coursegiven_course_coursecode character varying(5) NOT NULL,
    score double precision,
    examdate date,
    noteenteredat timestamp without time zone,
    notemodifiedat timestamp without time zone,
    CONSTRAINT studentcoursetaken_pkey PRIMARY KEY (idcoursetaken),
    CONSTRAINT fk_coursetaken_coursegiven FOREIGN KEY (coursegiven_idcoursegiven)
        REFERENCES universityx.professorcoursegiven (idcoursegiven) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_professorcoursegiven_person FOREIGN KEY (person_personcode)
        REFERENCES universityx.person (personcode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
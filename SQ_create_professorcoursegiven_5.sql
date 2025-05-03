CREATE TABLE IF NOT EXISTS universityx.professorcoursegiven
(
    idcoursegiven serial NOT NULL,
    course_coursecode character varying(5) NOT NULL,
    person_personcode character varying(5) NOT NULL,
    coursedate date,
    coursestartedat timestamp without time zone,
    coursefinishedat timestamp without time zone,
    CONSTRAINT professorcoursegiven_pkey PRIMARY KEY (idcoursegiven),
    CONSTRAINT fk_coursegiven_course FOREIGN KEY (course_coursecode)
        REFERENCES universityx.course (coursecode)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_professorcoursegiven_person FOREIGN KEY (person_personcode)
        REFERENCES universityx.person (personcode)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
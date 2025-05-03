CREATE TABLE IF NOT EXISTS universityx.course
(
    idcourse SERIAL NOT NULL,
    coursecode character varying(5) NOT NULL,
    coursename character varying(255) NOT NULL,
    duration integer NULL,
    isfundamental boolean NOT NULL,
    unitvalue double precision NOT NULL,
    room character varying(30),
    CONSTRAINT course_pkey PRIMARY KEY (idcourse),
    CONSTRAINT course_coursecode_key UNIQUE (coursecode)
)


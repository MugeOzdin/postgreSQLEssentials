CREATE TABLE IF NOT EXISTS universityx.person
(
    idperson serial NOT NULL,
    personcode character varying(5) NOT NULL,
    isstudent boolean NOT NULL,
    firstname character varying(32) NOT NULL,
    lastname character varying(32) NOT NULL,
    birthdate date,
    phone character varying(15),
    streetaddress character varying(255),
    email character varying(36),
    city character varying(36),
    postcode character varying(5),
    countrycode character varying(2),
    country_codeiso2 character varying(2),
    CONSTRAINT idperson_unique PRIMARY KEY (idperson),
    CONSTRAINT codeperson_unique UNIQUE (personcode),
    CONSTRAINT fk_person_country FOREIGN KEY (country_codeiso2)
        REFERENCES universityx.country (codeiso2)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
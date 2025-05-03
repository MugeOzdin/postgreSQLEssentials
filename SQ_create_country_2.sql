CREATE TABLE IF NOT EXISTS universityx.country
(
    idcountry SERIAL NOT NULL,
    codeiso2 character varying(2)  NOT NULL,
    label character varying(255) NOT NULL,
    CONSTRAINT uniquecountry UNIQUE (idcountry),
    CONSTRAINT uniquecountry2 UNIQUE (codeiso2)
)
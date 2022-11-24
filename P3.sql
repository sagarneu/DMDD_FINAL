SET SERVEROUTPUT on;

DECLARE 
    user_table_count number;
    user_group_table_count number;
    groups_table_count number;
    events_table_count number;
    event_tags_table_count number;
    tags_table_count number;
    registrations_table_count number;
    payments_table_count number;
    location_table_count number;
    city_table_count number;
    state_table_count number;
    country_table_count number;
    
BEGIN
    select count(*)
    into user_table_count from user_tables
    where table_name = 'USERS';
      
    select count(*)
    into user_group_table_count from user_tables
    where table_name = 'USER_GROUPS';
    
    select count(*)
    into groups_table_count from user_tables
    where table_name = 'GROUPS';
    
    select count(*)
    into events_table_count from user_tables
    where table_name = 'EVENTS';
    
    select count(*)
    into event_tags_table_count from user_tables
    where table_name = 'EVENT_TAGS';
    
    select count(*)
    into tags_table_count from user_tables
    where table_name = 'TAGS';
    
    select count(*)
    into registrations_table_count from user_tables
    where table_name = 'REGISTRATIONS';
    
    select count(*)
    into payments_table_count from user_tables
    where table_name = 'PAYMENTS';
    
    select count(*)
    into location_table_count from user_tables
    where table_name = 'LOCATION';
    
    select count(*)
    into city_table_count from user_tables
    where table_name = 'CITY';
    
    select count(*)
    into state_table_count from user_tables
    where table_name = 'STATE';
    
    select count(*)
    into country_table_count from user_tables
    where table_name = 'COUNTRY'; 
    
    IF(user_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE USERS CASCADE CONSTRAINT';
    EXECUTE IMMEDIATE 'DROP SEQUENCE user_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE group_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE user_group_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE event_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE tag_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE event_tag_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE location_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE city_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE state_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE country_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE payment_id_seq';
    EXECUTE IMMEDIATE 'DROP SEQUENCE registration_id_seq';
    END IF;
    
    IF(user_group_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE USER_GROUPS CASCADE CONSTRAINTS';
    END IF;
    
    IF(groups_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE GROUPS CASCADE CONSTRAINTS';
    END IF;
    
    IF(events_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE EVENTS CASCADE CONSTRAINTS';
    END IF;
    
    IF(event_tags_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE EVENT_TAGS CASCADE CONSTRAINTS';
    END IF;
    
    IF(tags_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE TAGS CASCADE CONSTRAINTS';
    END IF;
    
    IF(registrations_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE REGISTRATIONS CASCADE CONSTRAINTS';
    END IF;
    
    IF(payments_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE PAYMENTS CASCADE CONSTRAINTS';
    END IF;
    
    IF(location_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE LOCATION CASCADE CONSTRAINTS';
    END IF;
    
    IF(city_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE CITY CASCADE CONSTRAINTS';
    END IF;
    
    IF(state_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE STATE CASCADE CONSTRAINTS';
    END IF;
    
    IF(country_table_count > 0) THEN EXECUTE IMMEDIATE 'DROP TABLE COUNTRY CASCADE CONSTRAINTS';
    END IF;
        
END;
/


CREATE TABLE USERS (
    user_id INT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    username VARCHAR(30) NOT NULL UNIQUE,
    email_id VARCHAR(255) NOT NULL UNIQUE,
    mobile VARCHAR(15) NOT NULL UNIQUE,
    campus_location VARCHAR(30) NOT NULL,
    password RAW(100) NOT NULL,
    is_organizer number(1) NOT NULL,    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE GROUPS (
    group_id INT PRIMARY KEY,
    group_name VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE USER_GROUPS (
    user_group_id INT PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users,
    group_id INT NOT NULL REFERENCES groups
);

CREATE TABLE TAGS (
    tag_id INT PRIMARY KEY,
    tag_name VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE EVENT_TAGS (
    event_tag_id INT PRIMARY KEY,
    tag_id INT NOT NULL REFERENCES users,
    event_id INT NOT NULL REFERENCES groups
);

CREATE TABLE COUNTRY (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(30) NOT NULL
);

CREATE TABLE STATE (
    state_id INT PRIMARY KEY,
    state_name VARCHAR(30) NOT NULL,
    country_id INT NOT NULL REFERENCES country
);

CREATE TABLE CITY (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(30) NOT NULL,
    state_id INT NOT NULL REFERENCES state
);

CREATE TABLE LOCATION (
    location_id INT PRIMARY KEY,
    address_line_1 VARCHAR(255) NOT NULL,
    address_line_2 VARCHAR(255),
    city_id INT NOT NULL REFERENCES city
);

CREATE TABLE EVENTS (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(30) NOT NULL,
    event_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    registration_fee int,
    used_id INT NOT NULL REFERENCES users,
    location_id INT NOT NULL REFERENCES location
);

CREATE TABLE REGISTRATIONS (
    registration_id INT PRIMARY KEY,
    event_id INT NOT NULL REFERENCES events,
    user_id INT NOT NULL REFERENCES users,
    registration_status number(1) NOT NULL,
    payment_status number(1) NOT NULL
);

CREATE TABLE PAYMENTS (
    payment_id INT PRIMARY KEY,
    payment_status number(1) NOT NULL,
    registration_id INT NOT NULL REFERENCES registrations,
    user_id INT NOT NULL REFERENCES users,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE SEQUENCE user_id_seq
ORDER;

CREATE SEQUENCE group_id_seq
ORDER;

CREATE SEQUENCE user_group_id_seq
ORDER;

CREATE SEQUENCE event_id_seq
ORDER;

CREATE SEQUENCE tag_id_seq
ORDER;

CREATE SEQUENCE event_tag_id_seq
ORDER;

CREATE SEQUENCE location_id_seq
ORDER;

CREATE SEQUENCE city_id_seq
ORDER;

CREATE SEQUENCE state_id_seq
ORDER;

CREATE SEQUENCE country_id_seq
ORDER;

CREATE SEQUENCE payment_id_seq
ORDER;

CREATE SEQUENCE registration_id_seq
ORDER;

INSERT INTO users (
    user_id,
    first_name,
    last_name, 
    username, 
    email_id, 
    mobile,
    campus_location, 
    password,
    is_organizer)
VALUES (
    user_id_seq.nextval,
    'Sagar',
    'Reddy',
    'sagred',
    'sagred@gmail.com',
    '984767498',
    'boston',
    STANDARD_HASH('wss234d', 'SHA256'),
    0
    );

INSERT INTO users (
    user_id,
    first_name,
    last_name, 
    username, 
    email_id, 
    mobile,
    campus_location, 
    password,
    is_organizer)
VALUES (
    user_id_seq.nextval,
    'Teja',
    'Reddy',
    'tejfred',
    'narasimtefja@gmail.com',
    '8577f468423',
    'boston',
    STANDARD_HASH('12345678', 'SHA256'),
    1
    );

    INSERT INTO users (
    user_id,
    first_name,
    last_name, 
    username, 
    email_id, 
    mobile,
    campus_location, 
    password,
    is_organizer)
VALUES (
    user_id_seq.nextval,
    'Mamatha',
    'D',
    'mamathad',
    'mamatha21@gmail.com',
    '847467848',
    'Seatlle',
    STANDARD_HASH('qazxsw', 'SHA256'),
    0
    );

    INSERT INTO users (
    user_id,
    first_name,
    last_name, 
    username, 
    email_id, 
    mobile,
    campus_location, 
    password,
    is_organizer)
VALUES (
    user_id_seq.nextval,
    'Anu',
    'Myna',
    'anumyna',
    'anumy@gmail.com',
    '998376467',
    'boston',
    STANDARD_HASH('12345678', 'SHA256'),
    1
    );

    INSERT INTO users (
    user_id,
    first_name,
    last_name, 
    username, 
    email_id, 
    mobile,
    campus_location, 
    password,
    is_organizer)
VALUES (
    user_id_seq.nextval,
    'Gopi',
    'Krishna',
    'gopikrish',
    'gopi@gmail.com',
    '829938998',
    'Silicon Valley',
    STANDARD_HASH('qwerty', 'SHA256'),
    0
    );


    INSERT INTO users (
    user_id,
    first_name,
    last_name, 
    username, 
    email_id, 
    mobile,
    campus_location, 
    password,
    is_organizer)
VALUES (
    user_id_seq.nextval,
    'Lohith',
    'Reddy',
    'lohired',
    'lohired@gmail.com',
    '3737638983',
    'Toronto',
    STANDARD_HASH('poiuytr', 'SHA256'),
    0
    );

    INSERT INTO users (
    user_id,
    first_name,
    last_name, 
    username, 
    email_id, 
    mobile,
    campus_location, 
    password,
    is_organizer)
VALUES (
    user_id_seq.nextval,
    'Arundathi',
    'Neela',
    'arunel',
    'arunda@gmail.com',
    '9876789876',
    'Portland',
    STANDARD_HASH('uhbygv', 'SHA256'),
    1
    );


    INSERT INTO users (
    user_id,
    first_name,
    last_name, 
    username, 
    email_id, 
    mobile,
    campus_location, 
    password,
    is_organizer)
VALUES (
    user_id_seq.nextval,
    'Kusuma',
    'NK',
    'kusunk',
    'kusu@gmail.com',
    '876787987',
    'boston',
    STANDARD_HASH('uhytryui', 'SHA256'),
    0
    );

    INSERT INTO users (
    user_id,
    first_name,
    last_name, 
    username, 
    email_id, 
    mobile,
    campus_location, 
    password,
    is_organizer)
VALUES (
    user_id_seq.nextval,
    'Juhi',
    'Reddy',
    'juhipa',
    'juhi@gmail.com',
    '878956345',
    'Seatlle',
    STANDARD_HASH('4567890', 'SHA256'),
    1
    );


    INSERT INTO users (
    user_id,
    first_name,
    last_name, 
    username, 
    email_id, 
    mobile,
    campus_location, 
    password,
    is_organizer)
VALUES (
    user_id_seq.nextval,
    'Santhosh',
    'Raj',
    'santhu',
    'santhu@gmail.com',
    '78892776738',
    'boston',
    STANDARD_HASH('tyruiw', 'SHA256'),
    0
    );

select * from users;

INSERT INTO GROUPS (
    group_id,
    group_name)
VALUES (
    group_id_seq.nextval,
    'Blockchain'
    );

INSERT INTO GROUPS (
    group_id,
    group_name)
VALUES (
    group_id_seq.nextval,
    'Virtual Reality'
    );

INSERT INTO GROUPS (
    group_id,
    group_name)
VALUES (
    group_id_seq.nextval,
    'Photography'
    );

INSERT INTO GROUPS (
    group_id,
    group_name)
VALUES (
    group_id_seq.nextval,
    'Robotics'
    );

INSERT INTO GROUPS (
    group_id,
    group_name)
VALUES (
    group_id_seq.nextval,
    'Literature'
    );
select * from groups;


INSERT INTO USER_GROUPS (
    user_group_id,
    user_id,
    group_id)
VALUES (
    user_group_id_seq.nextval,
    1,
    1
);

INSERT INTO USER_GROUPS (
    user_group_id,
    user_id,
    group_id)
VALUES (
    user_group_id_seq.nextval,
    3,
    2
);

INSERT INTO USER_GROUPS (
    user_group_id,
    user_id,
    group_id)
VALUES (
    user_group_id_seq.nextval,
    6,
    3
);

INSERT INTO USER_GROUPS (
    user_group_id,
    user_id,
    group_id)
VALUES (
    user_group_id_seq.nextval,
    1,
    4
);

INSERT INTO USER_GROUPS (
    user_group_id,
    user_id,
    group_id)
VALUES (
    user_group_id_seq.nextval,
    7,
    5
);
select * from user_groups;


INSERT INTO TAGS (
    tag_id,
    tag_name)
VALUES (
    tag_id_seq.nextval,
    'neu'
    );

INSERT INTO TAGS (
    tag_id,
    tag_name)
VALUES (
    tag_id_seq.nextval,
    'boston'
    );

INSERT INTO TAGS (
    tag_id,
    tag_name)
VALUES (
    tag_id_seq.nextval,
    'blockchain'
    );

INSERT INTO TAGS (
    tag_id,
    tag_name)
VALUES (
    tag_id_seq.nextval,
    'tiktok'
    );

INSERT INTO TAGS (
    tag_id,
    tag_name)
VALUES (
    tag_id_seq.nextval,
    'acting'
    );
select * from tags;

INSERT INTO COUNTRY (
    country_id,
    country_name
    )
VALUES (
    country_id_seq.nextval,
    'IN'
    );

INSERT INTO COUNTRY (
    country_id,
    country_name
    )
VALUES (
    country_id_seq.nextval,
    'USA'
    );

INSERT INTO COUNTRY (
    country_id,
    country_name
    )
VALUES (
    country_id_seq.nextval,
    'CA'
    );

INSERT INTO COUNTRY (
    country_id,
    country_name
    )
VALUES (
    country_id_seq.nextval,
    'GER'
    );

INSERT INTO COUNTRY (
    country_id,
    country_name
    )
VALUES (
    country_id_seq.nextval,
    'UK'
    );

select * from country;


INSERT INTO STATE (
    state_id,
    state_name,
    country_id
    )
VALUES (
    state_id_seq.nextval,
    'MA',
    2
    );

INSERT INTO STATE (
    state_id,
    state_name,
    country_id
    )
VALUES (
    state_id_seq.nextval,
    'CA',
    2
    );

INSERT INTO STATE (
    state_id,
    state_name,
    country_id
    )
VALUES (
    state_id_seq.nextval,
    'WA',
    2
    );

INSERT INTO STATE (
    state_id,
    state_name,
    country_id
    )
VALUES (
    state_id_seq.nextval,
    'ME',
    1
    );

INSERT INTO STATE (
    state_id,
    state_name,
    country_id
    )
VALUES (
    state_id_seq.nextval,
    'TO',
    3
    );
select * from state;


INSERT INTO CITY (
    city_id,
    city_name,
    state_id
    )
VALUES (
    city_id_seq.nextval,
    'boston',
    1
    );

INSERT INTO CITY (
    city_id,
    city_name,
    state_id
    )
VALUES (
    city_id_seq.nextval,
    'Silicon Valley',
    2
    );

INSERT INTO CITY (
    city_id,
    city_name,
    state_id
    )
VALUES (
    city_id_seq.nextval,
    'Seatlle',
    3
    );

INSERT INTO CITY (
    city_id,
    city_name,
    state_id
    )
VALUES (
    city_id_seq.nextval,
    'Portland',
    4
    );

INSERT INTO CITY (
    city_id,
    city_name,
    state_id
    )
VALUES (
    city_id_seq.nextval,
    'Onio',
    5
    );
select * from city;


INSERT INTO LOCATION (
    location_id,
    address_line_1,
    address_line_2,
    city_id
    )
VALUES (
    location_id_seq.nextval,
    '360 College of engineering',
    'Mass Avenue',
    1
    );

INSERT INTO LOCATION (
    location_id,
    address_line_1,
    address_line_2,
    city_id
    )
VALUES (
    location_id_seq.nextval,
    '280 centre street',
    'Fenway',
    1
    );

INSERT INTO LOCATION (
    location_id,
    address_line_1,
    address_line_2,
    city_id
    )
VALUES (
    location_id_seq.nextval,
    '43 tabor place',
    'Silicon Avenue',
    2
    );

INSERT INTO LOCATION (
    location_id,
    address_line_1,
    address_line_2,
    city_id
    )
VALUES (
    location_id_seq.nextval,
    '225 centre street',
    'Dang Square',
    3
    );

INSERT INTO LOCATION (
    location_id,
    address_line_1,
    address_line_2,
    city_id
    )
VALUES (
    location_id_seq.nextval,
    '285 washington st',
    'Allston',
    1
    );
select * from location;


INSERT INTO EVENTS (
    event_id,
    event_name,
    event_date,
    registration_fee,
    used_id,
    location_id
    )
VALUES (
    event_id_seq.nextval,
    'Solidity',
    '23-DEC-2022 10:31:19.860660119',
    25,
    1,
    1
    );

INSERT INTO EVENTS (
    event_id,
    event_name,
    event_date,
    registration_fee,
    used_id,
    location_id
    )
VALUES (
    event_id_seq.nextval,
    'Oculus',
    '24-DEC-2022 10:31:19.860660119',
    10,
    10,
    1
    );

INSERT INTO EVENTS (
    event_id,
    event_name,
    event_date,
    registration_fee,
    used_id,
    location_id
    )
VALUES (
    event_id_seq.nextval,
    'Hackathon',
    '12-DEC-2022 10:31:19.860660119',
    17,
    9,
    3
    );

INSERT INTO EVENTS (
    event_id,
    event_name,
    event_date,
    registration_fee,
    used_id,
    location_id
    )
VALUES (
    event_id_seq.nextval,
    'Ted Talk',
    '20-DEC-2022 10:31:19.860660119',
    14,
    7,
    4
    );

INSERT INTO EVENTS (
    event_id,
    event_name,
    event_date,
    registration_fee,
    used_id,
    location_id
    )
VALUES (
    event_id_seq.nextval,
    'Literature',
    '28-DEC-2022 10:31:19.860660119',
    5,
    5,
    2
    );
select * from events;


INSERT INTO EVENT_TAGS (
    event_tag_id,
    tag_id,
    event_id)
VALUES (
    event_tag_id_seq.nextval,
    2,
    1 
    );

INSERT INTO EVENT_TAGS (
    event_tag_id,
    tag_id,
    event_id)
VALUES (
    event_tag_id_seq.nextval,
    1,
    2 
    );

INSERT INTO EVENT_TAGS (
    event_tag_id,
    tag_id,
    event_id)
VALUES (
    event_tag_id_seq.nextval,
    2,
    3 
    );

INSERT INTO EVENT_TAGS (
    event_tag_id,
    tag_id,
    event_id)
VALUES (
    event_tag_id_seq.nextval,
    5,
    2 
    );

INSERT INTO EVENT_TAGS (
    event_tag_id,
    tag_id,
    event_id)
VALUES (
    event_tag_id_seq.nextval,
    2,
    4 
    );
select * from event_tags;


INSERT INTO REGISTRATIONS (
    registration_id,
    event_id,
    user_id,
    registration_status,
    payment_status
    )
VALUES (
    registration_id_seq.nextval,
    3,
    1,
    1,
    1
    );

INSERT INTO REGISTRATIONS (
    registration_id,
    event_id,
    user_id,
    registration_status,
    payment_status
    )
VALUES (
    registration_id_seq.nextval,
    1,
    2,
    1,
    1
    );

INSERT INTO REGISTRATIONS (
    registration_id,
    event_id,
    user_id,
    registration_status,
    payment_status
    )
VALUES (
    registration_id_seq.nextval,
    5,
    3,
    0,
    0
    );

INSERT INTO REGISTRATIONS (
    registration_id,
    event_id,
    user_id,
    registration_status,
    payment_status
    )
VALUES (
    registration_id_seq.nextval,
    3,
    4,
    1,
    1
    );

INSERT INTO REGISTRATIONS (
    registration_id,
    event_id,
    user_id,
    registration_status,
    payment_status
    )
VALUES (
    registration_id_seq.nextval,
    2,
    1,
    1,
    0
    );
select * from registrations;



INSERT INTO PAYMENTS (
    payment_id,
    payment_status,
    registration_id,
    user_id
    )
VALUES (
    payment_id_seq.nextval,
    1,
    1,
    1
    );

INSERT INTO PAYMENTS (
    payment_id,
    payment_status,
    registration_id,
    user_id
    )
VALUES (
    payment_id_seq.nextval,
    1,
    4,
    4
    );

INSERT INTO PAYMENTS (
    payment_id,
    payment_status,
    registration_id,
    user_id
    )
VALUES (
    payment_id_seq.nextval,
    0,
    5,
    1
    );

INSERT INTO PAYMENTS (
    payment_id,
    payment_status,
    registration_id,
    user_id
    )
VALUES (
    payment_id_seq.nextval,
    1,
    2,
    2
    );

INSERT INTO PAYMENTS (
    payment_id,
    payment_status,
    registration_id,
    user_id
    )
VALUES (
    payment_id_seq.nextval,
    0,
    3,
    3
    );
select * from payments;


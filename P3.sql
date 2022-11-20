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


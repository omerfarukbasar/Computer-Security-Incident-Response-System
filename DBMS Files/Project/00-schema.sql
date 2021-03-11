--
-- Author: Omer Basar
-- Filename: 00-schema.txt
-- Version: 12/14/20
--

--
-- Begin Transaction
--
BEGIN;

--
-- Create the tables
--
CREATE TABLE person (
	person_email varchar(100),
	last varchar(100),
	first varchar(100),
	job_title varchar(100),
	PRIMARY KEY (person_email)
	);

CREATE TABLE incident (
	incident_id varchar(10),
	type varchar(10),
	date_created date,
	state varchar(10),
	PRIMARY KEY (incident_id),
	CHECK (state = 'open' OR state = 'closed' OR state = 'stalled')
	);

CREATE TABLE comment (
	incident_id varchar(10),
	comment_id varchar(10),
	commenter_name varchar(100),
	description varchar(1000),
	time_recorded timestamp,
	PRIMARY KEY (incident_id, comment_id),
	FOREIGN KEY (incident_id) REFERENCES incident(incident_id)
	);

CREATE TABLE incident_person (
	incident_id varchar(10),
	person_email varchar(100),
	association varchar(1000),
	PRIMARY KEY (incident_id, person_email),
	FOREIGN KEY (incident_id) REFERENCES incident(incident_id),
	FOREIGN KEY (person_email) REFERENCES person(person_email)
	);

CREATE TABLE incident_ip (
	incident_id varchar(10),
	ip_address inet,
	association varchar(1000),
	PRIMARY KEY (incident_id, ip_address),
	FOREIGN KEY (incident_id) REFERENCES incident(incident_id)
	);

--
-- Create the indexes
--
CREATE INDEX comment_index ON comment(incident_id);

CREATE INDEX ip_index ON incident_ip(incident_id);

CREATE INDEX person_index ON incident_person(incident_id);

-- 
-- Create the views
-- 
CREATE VIEW incidentReportView
AS SELECT 
		incident.incident_id AS incident_id,
		incident.type AS type,
		incident.date_created AS date_created,
		incident.state AS state,
		incident_person.person_email AS person_email,
		incident_person.association AS person_association,
		incident_ip.ip_address AS ip_addresss,
		incident_ip.association AS ip_association,
		comment.description AS comment_info,
		comment.time_recorded AS comment_timestamp

   FROM incident
		FULL JOIN incident_person ON (incident.incident_id = incident_person.incident_id)
		FULL JOIN incident_ip ON (incident.incident_id = incident_ip.incident_id)
		FULL JOIN comment ON (incident.incident_id = comment.incident_id)
   ORDER BY incident_ip asc,
   			time_recorded desc;

-- 
-- Grant permissions
--
GRANT SELECT
ON    incidentReportView
TO    "kees";

--
-- To check who has priveleges for views
--
SELECT grantor,grantee,privilege_type
FROM information_schema.table_privileges
WHERE table_name = 'incidentReportView';

--
-- Or just use \z
--
\z incidentReportView;

--
-- Commit the changes
--
COMMIT;


	

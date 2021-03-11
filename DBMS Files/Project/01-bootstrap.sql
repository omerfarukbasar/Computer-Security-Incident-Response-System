--
-- Author: Omer Basar
-- Filename: 01-bootstrap.txt
-- Version: 12/14/20
--

--
-- Begin Transaction
--
BEGIN;

--
-- people
--
INSERT INTO person (person_email, last, first, job_title)
VALUES
('bob@gmail.com', 'ross', 'bob', 'painter');

INSERT INTO person (person_email, last, first, job_title)
VALUES
('josh@gmail.com', 'wang', 'josh', 'accountant');

--
-- incidents
--
INSERT INTO incident (incident_id, type, date_created, state)
VALUES
('100000000', 'printer', '2020-12-14', 'open');

INSERT INTO incident (incident_id, type, date_created, state)
VALUES
('200000000', 'fax', '2020-12-14', 'open');

--
-- incident_persons
--
INSERT INTO incident_person (incident_id, person_email, association)
VALUES
('100000000', 'bob@gmail.com', 'broke the printer.');

INSERT INTO incident_person (incident_id, person_email, association)
VALUES
('200000000', 'josh@gmail.com', 'has issues with faxing.');

INSERT INTO incident_person (incident_id, person_email, association)
VALUES
('200000000', 'bob@gmail.com', 'caused the jamming.');

--
-- incident_ips
--
INSERT INTO incident_ip (incident_id, ip_address, association)
VALUES
('100000000', '15.179.12.4', 'bob owns this computer');

INSERT INTO incident_ip (incident_id, ip_address, association)
VALUES
('100000000', '72.6.255.210', 'bob also owns this computer');

--
-- comments
--
INSERT INTO comment (incident_id, comment_id, commenter_name, description, time_recorded)
VALUES
('100000000', '000000001', 'jerry boy', 'sample description 1', '2020-12-14 10:48:02');

INSERT INTO comment (incident_id, comment_id, commenter_name, description, time_recorded)
VALUES
('100000000', '000000002', 'spider man', 'sample description 2', '2020-12-14 12:02:36');

INSERT INTO comment (incident_id, comment_id, commenter_name, description, time_recorded)
VALUES
('200000000', '000000003', 'tommy bag', 'sample description 3', '2020-12-14 16:27:59');

INSERT INTO comment (incident_id, comment_id, commenter_name, description, time_recorded)
VALUES
('200000000', '000000004', 'jillian cruz', 'sample description 4', '2020-12-14 17:19:41');

--
-- Commit the changes
--
COMMIT;


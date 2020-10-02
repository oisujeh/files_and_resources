-- PATIENT FLAG Section
-- drop exisitng tables
delete from patientflags_flag_tag;
delete from patientflags_flag;
delete from patientflags_tag_role;

-- 'inserting new flags'

INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(1, 'No HIV Diagnosis Date', 'select distinct patient_id
from patient p
where (select value_datetime from obs where concept_id = 160554 and person_id = p.patient_id limit 1) is null and p.voided is null', 'Patient has no HIV Diagnosis date recorded', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-27 09:32:37.000', 1, '2020-07-15 14:55:20.000', 0, NULL, NULL, NULL, '19208809-c2e2-46f8-96a3-0b853988417d', 1);
INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(2, 'No HIV Enrollment Date', 'select distinct patient_id from patient p
where (select encounter_datetime from encounter where encounter_type = 14 and patient_id = p.patient_id limit 1) is null and p.voided is null', 'Patient has no HIV Enrollment Date Recorded', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-27 09:34:24.000', 1, '2020-07-15 14:55:29.000', 0, NULL, NULL, NULL, 'bde08bc9-e0da-41c3-aed2-d8948c5c3147', 1);
INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(3, 'No Address/LGA Documented', 'select p.patient_id, pd.address1,pd.city_village 
from patient p 
join person_address pd on p.patient_id = pd.person_id  
where pd.address1 is null and pd.city_village is null and p.voided is null', 'No Address/LGA Documented', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-27 09:43:08.000', 1, '2019-10-11 09:59:06.000', 0, NULL, NULL, NULL, '32d00137-fe52-4596-ab79-e8c9c9e54515', 1);
INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(4, 'Patient Started ART but with no documented ART Regimen', 'select * from patient p 
where p.patient_id in (select distinct person_id from obs b join encounter e on e.encounter_id = b.encounter_id
where b.concept_id = 159599) and p.patient_id not in (select distinct person_id from obs b join encounter e on e.encounter_id = b.encounter_id
where e.encounter_type = 13 and b.concept_id in (164506,164513,165702,164507,164514,165703)) and p.voided is null', 'Started ART but no documented ART Regimen', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-27 09:48:38.000', 1, '2019-11-06 20:59:25.000', 0, NULL, NULL, NULL, '8c9cd66c-05ae-4601-8dfa-92df7a18e798', 1);
INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(5, 'No Documented Weight in Last Clinical Visit', 'select distinct p.patient_id, MAX(e.encounter_datetime),  
GROUP_CONCAT(DISTINCT(o.concept_id) SEPARATOR '','') AS concepts 
from patient p 
join encounter e on e.patient_id = p.patient_id and e.encounter_type = 12
join obs o on o.encounter_id = e.encounter_id
where e.encounter_datetime between date_add(now(), interval -6 month) and now()
group by p.patient_id
HAVING FIND_IN_SET(''5089'', GROUP_CONCAT((o.concept_id) SEPARATOR '','')) = 0', 'No Documented Weight in Last Clinical Visit', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-27 09:49:15.000', 1, '2020-07-15 14:55:10.000', 0, NULL, NULL, NULL, '4a0d0590-5774-4386-aea3-5f13ed8d1ae7', 1);
INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(6, 'Ped Patient without Last MUAC', 'select distinct p.patient_id, MAX(e.encounter_datetime),
GROUP_CONCAT(DISTINCT(o.concept_id) SEPARATOR '','') AS concepts 
from patient p 
join person pe on pe.person_id = p.patient_id
join encounter e on e.patient_id = p.patient_id and e.encounter_type = 12
join obs o on o.encounter_id = e.encounter_id
where e.encounter_datetime between date_add(now(), interval -6 month) and now() 
and datediff(e.encounter_datetime,pe.birthdate)/365 <= 5
group by p.patient_id
HAVING FIND_IN_SET(''165935'', GROUP_CONCAT((o.concept_id) SEPARATOR '','')) = 0 OR
	   FIND_IN_SET(''165243'', GROUP_CONCAT((o.concept_id) SEPARATOR '','')) = 0', 'No Documented MUAC in Last Visit', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-27 09:49:58.000', 1, '2020-07-15 14:56:28.000', 0, NULL, NULL, NULL, 'abc9e1a2-acd5-49ae-a79e-ea08137e88e3', 1);
INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(7, 'Have no Documented WHO in Last Clinical Visit', 'select distinct p.patient_id, MAX(e.encounter_datetime),  
GROUP_CONCAT(DISTINCT(o.concept_id) SEPARATOR '','') AS concepts 
from patient p 
join encounter e on e.patient_id = p.patient_id and e.encounter_type = 12
join obs o on o.encounter_id = e.encounter_id
where e.encounter_datetime between date_add(now(), interval -6 month) and now()
group by p.patient_id
HAVING FIND_IN_SET(''5356'', GROUP_CONCAT((o.concept_id) SEPARATOR '','')) = 0', 'Have no Documented WHO in Last Clinical Visit', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-27 09:52:14.000', 1, '2020-07-15 14:54:51.000', 0, NULL, NULL, NULL, 'f0c645e9-f1cd-4546-9476-7291614cf619', 1);
INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(8, 'Patient with no documented TB Status in last clinical visit', 'select distinct p.patient_id, MAX(e.encounter_datetime),  
GROUP_CONCAT(DISTINCT(o.concept_id) SEPARATOR '','') AS concepts 
from patient p 
join encounter e on e.patient_id = p.patient_id and e.encounter_type = 12
join obs o on o.encounter_id = e.encounter_id
where e.encounter_datetime between date_add(now(), interval -6 month) and now()
group by p.patient_id
HAVING FIND_IN_SET(''1659'', GROUP_CONCAT((o.concept_id) SEPARATOR '','')) = 0', 'Patient with no documented TB Status in last clinical visit', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-27 09:54:07.000', 1, '2020-07-15 14:55:47.000', 0, NULL, NULL, NULL, '64dc1a09-7ce0-4175-97e4-93b5ed08b936', 1);
INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(9, 'Dead without documented date of death', 'select p.patient_id from patient p join obs b on p.patient_id = b.person_id where patient_id in
(select b.person_id patient_id from obs b where b.concept_id = 165470 and b.value_coded = 165889)
and p.patient_id in 
(select bb.person_id as patient_id from obs bb where bb.concept_id = 165469 and bb.value_datetime is null ) 
group by p.patient_id;', 'Recorded as Dead Without Documented Date of Death', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-27 09:55:54.000', 1, '2020-07-15 14:54:26.000', 0, NULL, NULL, NULL, '5282bb1a-3f97-4021-aeab-7eff03ef4c4c', 1);
INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(10, 'Patient with regimen but no drug refill duration', 'select p.patient_id, max(e.encounter_datetime) ,
(select max(obs_datetime) from obs where person_id = p.patient_id  and concept_id in (164506, 164513,165702,164507,164514,165703) limit 1 ) as lastRegimen, 
(select max(obs_datetime) from obs where person_id = p.patient_id  and concept_id = 159368 limit 1) as lastDuration
from patient p 
join encounter e on p.patient_id = e.patient_id and e.encounter_type = 14
group by p.patient_id
having lastDuration is null and lastRegimen is not null', 'Patient with regimen but no drug refill duration', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-27 11:39:21.000', 1, '2020-07-15 14:55:57.000', 0, NULL, NULL, NULL, 'a20784cb-3587-4d13-91c7-cc0058ef92b7', 1);
INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(11, 'Patient without documented VL in last 12 months', 'select p.patient_id, max(e.encounter_datetime), e.encounter_type,
(select TIMESTAMPDIFF(month,max(value_datetime),curdate())  from obs where person_id = p.patient_id 
and concept_id in (159951) limit 1) as diffsample 
from patient p 
join encounter e on p.patient_id = e.patient_id and e.encounter_type = 11
group by p.patient_id
having diffsample >= 12', 'Have No Documented VL in Last 12 Months', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-27 11:45:26.000', 1, '2020-07-15 14:56:20.000', 0, NULL, NULL, NULL, '0982b200-0075-4f05-92fe-3837a11c6b73', 1);
INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(12, 'Patient with viral load without test date', 'select p.patient_id
from patient p 
join encounter e on p.patient_id = e.patient_id and e.encounter_type = 11
where p.patient_id in 
(select person_id as patient_id  from obs where person_id = p.patient_id  and concept_id in (856) group by patient_id order by obs_datetime desc )
and p.patient_id not in
(select  person_id as patient_id from obs where  concept_id = 159951 group by patient_id order by obs_datetime desc ) 
group by p.patient_id', 'Have Viral Load Without a Result Test Date', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-28 08:43:06.000', 1, '2020-07-15 14:56:09.000', 0, NULL, NULL, NULL, 'e4188c1d-56d8-4eb0-92a9-15d224a94ce2', 1);
INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(13, 'Patient with CD4 Ordered without Result', 'select p.patient_id,
(select value_coded  from obs where person_id = p.patient_id 
and concept_id in (165731) order by obs_datetime desc limit 1) as adultCD4Order,
(select value_numeric  from obs where person_id = p.patient_id 
 and concept_id = 5497 order by obs_datetime desc limit 1) as adultCD4Result,
(select value_coded  from obs where person_id = p.patient_id 
 and concept_id in (165748) order by obs_datetime desc limit 1) as pedCD4Order,
(select value_numeric  from obs where person_id = p.patient_id 
 and concept_id in (730) order by obs_datetime desc limit 1) as pedCD4Result
from patient p 
join encounter e on p.patient_id = e.patient_id and e.encounter_type = 11
group by p.patient_id
having (adultCD4Order is not null and adultCD4Result is null) 
or pedCD4Order is not null and pedCD4Result is null', 'Have CD4 Ordered Without CD4 Result', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-28 09:01:46.000', 1, '2020-07-15 14:55:38.000', 0, NULL, NULL, NULL, '5c1fc5fe-7b19-4937-a893-bcbba4202b9d', 1);
INSERT INTO patientflags_flag
        (flag_id, name, criteria, message, enabled, evaluator, description, creator, date_created, changed_by, date_changed, retired, retired_by, date_retired, retire_reason, uuid, priority_id)
VALUES(14, 'Inactive Patient with no documented exit reason', 'select p.patient_id,
(select (TIMESTAMPDIFF(day,value_datetime,curdate())) from obs where person_id = p.patient_id  
and concept_id in (164506, 164513,165702,164507,164514,165703) order by obs_datetime desc limit 1) as lastRegimenDiff, 
(select value_numeric from obs where person_id = p.patient_id and concept_id = 159368 order by obs_datetime desc limit 1) as lastDuration,
(select value_coded from obs where person_id = p.patient_id and concept_id = 165470 order by obs_datetime desc limit 1 ) as reasonTermination
from patient p 
join encounter e on p.patient_id = e.patient_id and e.encounter_type in (14,15)
group by p.patient_id
having (lastRegimenDiff + lastDuration) > 28 and reasonTermination is null', 'Inactive Patient With No Documented Exit Reason', 1, 'org.openmrs.module.patientflags.evaluator.SQLFlagEvaluator', NULL, 1, '2019-09-28 09:24:01.000', 1, '2020-07-15 14:55:01.000', 0, NULL, NULL, NULL, '847b79b2-3448-4950-81d4-328b0af2044d', 1);


-- 'linking patientflags to tags'

INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(3, 1);
INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(4, 1);
INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(9, 1);
INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(7, 1);
INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(14, 1);
INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(5, 1);
INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(1, 1);
INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(2, 1);
INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(13, 1);
INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(8, 1);
INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(10, 1);
INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(12, 1);
INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(11, 1);
INSERT INTO patientflags_flag_tag
        (flag_id, tag_id)
VALUES(6, 1);

-- 'inserting flga roles

INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Adherence');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Anonymous');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Administers System');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Configures Appointment Scheduling');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Configures Forms');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Configures Metadata');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Edits Existing Encounters');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Enters ADT Events');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Enters Vitals');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Has Super User Privileges');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Manages Atlas');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Manages Provider Schedules');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Records Allergies');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Registers Patients');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Requests Appointments');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Schedules And Overbooks Appointments');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Schedules Appointments');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Sees Appointment Schedule');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Uses Capture Vitals App');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Uses Patient Summary');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Application: Writes Clinical Notes');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Authenticated');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Careandsupport');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Clinician');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Dataclerk');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Lab');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Organizational: Doctor');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Organizational: Hospital Administrator');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Organizational: Nurse');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Organizational: Registration Clerk');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Organizational: System Administrator');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Pharmacist');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Privilege Level: Full');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Privilege Level: High');
INSERT INTO patientflags_tag_role
        (tag_id, `role`)
VALUES(1, 'Provider');


-- REPORT's SECTION
drop function if exists getconceptval;
drop function if exists getoutcome;
drop procedure if exists drugduration;
drop function if exists daysofarvrefil;
drop function if exists getdaysofarvrefil;

DELIMITER ;;
CREATE FUNCTION `getconceptval`
(`obsid` int,`cid` int, pid int) RETURNS decimal
(10,0)
BEGIN

	#Routine body goes here...

DECLARE value_num INT;

SELECT DISTINCT obs.value_numeric
into value_num
from obs
WHERE  obs.obs_group_id is not null and obs.obs_group_id=obsid and obs.concept_id=cid and obs.person_id=pid and obs.voided=0
GROUP BY obs.concept_id,obs.obs_group_id;

RETURN value_num;

END ;;
DELIMITER ;

DELIMITER ;;
CREATE FUNCTION `getdaysofarvrefil`
(`obsid` numeric,`obsgroupid` numeric,`valuenumeric` numeric) RETURNS decimal
(10,0)
BEGIN

	#Routine body goes here...

DECLARE ans NUMERIC;


IF obsid=obsgroupid THEN

SET ans
= valuenumeric;

ELSE

SET ans
= null;

END
IF;

RETURN ans;

END ;;
DELIMITER ;

DELIMITER ;;
CREATE FUNCTION `getoutcome`
(`lastpickupdate` date,`daysofarvrefill` numeric,`ltfudays` numeric, `enddate` date) RETURNS text CHARSET utf8
BEGIN

        DECLARE  ltfudate DATE;

DECLARE  ltfunumber NUMERIC;

DECLARE  daysdiff NUMERIC;

DECLARE outcome text;

SET ltfunumber
=daysofarvrefill+ltfudays;

SELECT DATE_ADD(lastpickupdate, INTERVAL ltfunumber
DAY) INTO ltfudate;

SELECT DATEDIFF(ltfudate,enddate)
into daysdiff;

SELECT
IF(daysdiff >=0,"Active","LTFU") into outcome;

RETURN outcome;

END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `drugduration`
(IN `enddate` date)
BEGIN

	#Routine body goes here...

drop table if exists arvmedication;

create   table  arvmedication as

select DISTINCT obs.person_id, obs.obs_id
from obs
where concept_id=162240 and voided=0 and obs.obs_datetime <=enddate

GROUP BY obs.person_id,obs.concept_id
ORDER BY  obs.obs_datetime DESC;

CREATE  INDEX pid ON arvmedication(person_id);



END ;;
DELIMITER ;



UPDATE patientflags_flag
SET criteria = 'SELECT p.patient_id
FROM patient p
WHERE p.patient_id IN
    (SELECT b.person_id patient_id
     FROM obs b
     WHERE b.concept_id = 165470
       AND b.value_coded = 165889
       AND b.person_id =  p.patient_id)
  AND p.patient_id IN
    (SELECT bb.person_id AS patient_id
     FROM obs bb
     WHERE bb.concept_id = 165469
     AND bb.person_id =  p.patient_id
       AND bb.value_datetime IS NULL )'
WHERE flag_id = 9;


UPDATE patientflags_flag
SET criteria = 'SELECT p.patient_id
FROM patient p,
     encounter e
WHERE p.patient_id IN
    (SELECT person_id patient_id
     FROM obs
     WHERE person_id = p.patient_id
       AND concept_id IN (164506,
                          164513,
                          165702,
                          164507,
                          164514,
                          165703)
     ORDER BY obs_datetime)
  AND p.patient_id NOT IN
    (SELECT person_id patient_id
     FROM obs
     WHERE person_id = p.patient_id
       AND concept_id = 159368
     ORDER BY obs_datetime)
  AND p.patient_id = e.patient_id
  AND e.encounter_type = 14'
WHERE flag_id = 10;


UPDATE patientflags_flag
SET criteria = 'SELECT p.patient_id
FROM patient p
WHERE p.patient_id IN
    (SELECT DISTINCT e.patient_id
     FROM encounter e
     WHERE p.patient_id = e.patient_id
       AND e.encounter_type = 11
     ORDER BY encounter_datetime DESC)
  AND p.patient_id IN
    (SELECT person_id patient_id
     FROM obs
     WHERE concept_id = 159951
     AND person_id = p.patient_id
     GROUP BY person_id
     HAVING TIMESTAMPDIFF(MONTH, max(value_datetime), curdate()) >= 12)'
WHERE flag_id = 11;


UPDATE patientflags_flag
SET criteria = 'SELECT p.patient_id
FROM patient p
WHERE p.patient_id IN
    (SELECT person_id AS patient_id
     FROM obs
     WHERE person_id = p.patient_id
       AND concept_id IN (856)
     GROUP BY patient_id
     ORDER BY obs_datetime DESC)
  AND p.patient_id NOT IN
    (SELECT person_id AS patient_id
     FROM obs
     WHERE concept_id = 159951
     GROUP BY patient_id
     ORDER BY obs_datetime DESC)'
WHERE flag_id = 12;


UPDATE patientflags_flag
SET criteria = 'SELECT p.patient_id
FROM patient p
WHERE (((p.patient_id IN
           (SELECT person_id patient_id
            FROM obs
            WHERE person_id = p.patient_id
              AND concept_id =165731
            GROUP BY person_id
            HAVING max(obs_datetime)))
        AND (p.patient_id NOT IN
               (SELECT person_id patient_id
                FROM obs
                WHERE person_id = p.patient_id
                  AND concept_id = 5497
                GROUP BY person_id
                HAVING max(obs_datetime))))
       OR ((p.patient_id IN
              (SELECT person_id patient_id
               FROM obs
               WHERE person_id = p.patient_id
                 AND concept_id = 165748
               GROUP BY person_id
               HAVING max(obs_datetime)))
           AND (p.patient_id NOT IN
                  (SELECT person_id patient_id
                   FROM obs
                   WHERE person_id = p.patient_id
                     AND concept_id = 730
                   GROUP BY person_id
                   HAVING max(obs_datetime)))))
  AND p.patient_id IN
    (SELECT e.patient_id
     FROM encounter e
     WHERE p.patient_id = e.patient_id
       AND e.encounter_type = 11)'
WHERE flag_id = 13;


UPDATE patientflags_flag
SET criteria = 'SELECT p.patient_id
FROM patient p
WHERE (
         (SELECT (TIMESTAMPDIFF(DAY, value_datetime, curdate()))
          FROM obs
          WHERE person_id = p.patient_id
            AND concept_id IN (164506,
                               164513,
                               165702,
                               164507,
                               164514,
                               165703)
          HAVING max(obs_datetime)) +
         (SELECT value_numeric
          FROM obs
          WHERE person_id = p.patient_id
            AND concept_id = 159368
          HAVING max(obs_datetime))) > 28
  AND
    (SELECT value_coded
     FROM obs
     WHERE person_id = p.patient_id
       AND concept_id = 165470
     HAVING max(obs_datetime)) IS NULL
  AND p.patient_id IN
    (SELECT e.patient_id
     FROM encounter e
     WHERE p.patient_id = e.patient_id
       AND e.encounter_type IN (14,
                                15))'
WHERE flag_id = 14;



UPDATE patientflags_flag
SET criteria = 'SELECT p.patient_id
FROM patient p
WHERE p.patient_id IN
    (SELECT person_id patient_id
     FROM obs
     WHERE person_id = p.patient_id
     HAVING FIND_IN_SET(\'165935\', GROUP_CONCAT((concept_id) SEPARATOR \',\')) = 0
     OR FIND_IN_SET(\'165243\', GROUP_CONCAT((concept_id) SEPARATOR \',\')) = 0)
  AND p.patient_id IN
    (SELECT e.patient_id
     FROM encounter e,
          person pe
     WHERE e.encounter_datetime BETWEEN date_add(now(), interval -6 MONTH) AND now()
       AND datediff(e.encounter_datetime, pe.birthdate)/365 <= 5
       AND e.encounter_type = 12
       AND e.patient_id = p.patient_id
       AND e.patient_id = pe.person_id
     HAVING MAX(e.encounter_datetime))'
WHERE flag_id = 6;


UPDATE patientflags_flag
SET criteria = 'SELECT p.patient_id
FROM patient p,
     encounter e
WHERE p.patient_id IN
    (SELECT o.person_id AS patient_id
     FROM obs o
     WHERE o.encounter_id = e.encounter_id
     HAVING FIND_IN_SET(\'5089\', GROUP_CONCAT(DISTINCT(o.concept_id) SEPARATOR \',\')) = 0)
  AND p.patient_id IN
    (SELECT e2.patient_id
     FROM encounter e2
     WHERE e.encounter_id = e2.encounter_id
       AND e2.encounter_type = 12
       AND e2.encounter_datetime BETWEEN date_add(now(), interval -6 MONTH) AND now()
     HAVING MAX(e2.encounter_datetime))
  AND e.patient_id = p.patient_id'
WHERE flag_id = 5;



UPDATE patientflags_flag
SET criteria = 'SELECT p.patient_id
FROM patient p,
     encounter e
WHERE p.patient_id IN
    (SELECT o.person_id AS patient_id
     FROM obs o
     WHERE o.encounter_id = e.encounter_id
     HAVING FIND_IN_SET(\'5356\', GROUP_CONCAT(DISTINCT(o.concept_id) SEPARATOR \',\')) = 0)
  AND p.patient_id IN
    (SELECT e2.patient_id
     FROM encounter e2
     WHERE e.encounter_id = e2.encounter_id
       AND e2.encounter_type = 12
       AND e2.encounter_datetime BETWEEN date_add(now(), interval -6 MONTH) AND now()
     HAVING MAX(e2.encounter_datetime))
  AND e.patient_id = p.patient_id'
WHERE flag_id = 7;



UPDATE patientflags_flag
SET criteria = 'SELECT p.patient_id
FROM patient p,
     encounter e
WHERE p.patient_id IN
    (SELECT o.person_id AS patient_id
     FROM obs o
     WHERE o.encounter_id = e.encounter_id
     HAVING FIND_IN_SET(\'1659\', GROUP_CONCAT(DISTINCT(o.concept_id) SEPARATOR \',\')) = 0)
  AND p.patient_id IN
    (SELECT e2.patient_id
     FROM encounter e2
     WHERE e.encounter_id = e2.encounter_id
       AND e2.encounter_type = 12
       AND e2.encounter_datetime BETWEEN date_add(now(), interval -6 MONTH) AND now()
     HAVING MAX(e2.encounter_datetime))
  AND e.patient_id = p.patient_id'
WHERE flag_id = 8;


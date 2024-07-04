-- ----------------------------------------------------------------
--
-- This is a script to add the MIMIC-III indexes for Oracle.
--
-- ----------------------------------------------------------------

-- The below command defines the schema where the data should reside
--ALTER SESSION SET CURRENT_SCHEMA = MIMICIII;

-- Restoring the default schema can be accomplished using the same command, replacing "MIMICIII" with your username.

-- ADMISSIONS
drop index ADMISSIONS_idx01;
CREATE INDEX ADMISSIONS_IDX01
  ON ADMISSIONS (SUBJECT_ID,HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index ADMISSIONS_idx02;
CREATE INDEX ADMISSIONS_IDX02
  ON ADMISSIONS (ADMITTIME, DISCHTIME, DEATHTIME)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index ADMISSIONS_idx03;
CREATE INDEX ADMISSIONS_IDX03
  ON ADMISSIONS (ADMISSION_TYPE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;


-----------
--CALLOUT--
-----------

drop index CALLOUT_idx01;
CREATE INDEX CALLOUT_IDX01
  ON CALLOUT (SUBJECT_ID, HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index CALLOUT_idx02;
CREATE INDEX CALLOUT_IDX02
  ON CALLOUT (CURR_CAREUNIT)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index CALLOUT_idx03;
CREATE INDEX CALLOUT_IDX03
  ON CALLOUT (CALLOUT_SERVICE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index CALLOUT_idx04;
CREATE INDEX CALLOUT_IDX04
  ON CALLOUT (CURR_WARDID, CALLOUT_WARDID, DISCHARGE_WARDID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index CALLOUT_idx05;
CREATE INDEX CALLOUT_IDX05
  ON CALLOUT (CALLOUT_STATUS, CALLOUT_OUTCOME)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index CALLOUT_idx06;
CREATE INDEX CALLOUT_IDX06
  ON CALLOUT (CREATETIME, UPDATETIME, ACKNOWLEDGETIME, OUTCOMETIME)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- CAREGIVERS
drop index CAREGIVERS_idx01;
CREATE INDEX CAREGIVERS_IDX01
  ON CAREGIVERS (CGID, LABEL)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- CHARTEVENTS
drop index CHARTEVENTS_idx01;
CREATE INDEX CHARTEVENTS_idx01
  ON CHARTEVENTS (SUBJECT_ID, HADM_ID, ICUSTAY_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;


drop index CHARTEVENTS_idx02;
CREATE INDEX CHARTEVENTS_idx02
  ON CHARTEVENTS (ITEMID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;


drop index CHARTEVENTS_idx03;
CREATE INDEX CHARTEVENTS_idx03
  ON CHARTEVENTS (CHARTTIME, STORETIME)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;


drop index CHARTEVENTS_idx04;
CREATE INDEX CHARTEVENTS_idx04
  ON CHARTEVENTS (CGID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index CHARTEVENTS_idx05;
CREATE INDEX CHARTEVENTS_idx05
  ON CHARTEVENTS (VALUE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- CPTEVENTS
drop index CPTEVENTS_idx01;
CREATE INDEX CPTEVENTS_idx01
  ON CPTEVENTS (SUBJECT_ID, HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index CPTEVENTS_idx02;
CREATE INDEX CPTEVENTS_idx02
  ON CPTEVENTS (CPT_CD, TICKET_ID_SEQ)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- D_CPT
-- Table is 134 rows - doesn't need an index.

-- D_ICD_DIAGNOSES
drop index D_ICD_DIAG_idx01;
CREATE INDEX D_ICD_DIAG_idx01
  ON D_ICD_DIAGNOSES (ICD9_CODE, DIAG_OR_PROC)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index D_ICD_DIAG_idx02;
CREATE INDEX D_ICD_DIAG_idx02
  ON D_ICD_DIAGNOSES (SHORT_TITLE, LONG_TITLE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- D_ICD_PROCEDURES
drop index D_ICD_PROC_idx01;
CREATE INDEX D_ICD_PROC_idx01
  ON D_ICD_PROCEDURES (ICD9_CODE, DIAG_OR_PROC)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index D_ICD_PROC_idx02;
CREATE INDEX D_ICD_PROC_idx02
  ON D_ICD_PROCEDURES (SHORT_TITLE, LONG_TITLE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- D_ITEMS
drop index D_ITEMS_idx01;
CREATE INDEX D_ITEMS_idx01
  ON D_ITEMS (ITEMID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index D_ITEMS_idx02;
CREATE INDEX D_ITEMS_idx02
  ON D_ITEMS (LABEL, DBSOURCE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index D_ITEMS_idx03;
CREATE INDEX D_ITEMS_idx03
  ON D_ITEMS (CATEGORY)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- D_LABITEMS
drop index D_LABITEMS_idx01;
CREATE INDEX D_LABITEMS_idx01
  ON D_LABITEMS (ITEMID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index D_LABITEMS_idx02;
CREATE INDEX D_LABITEMS_idx02
  ON D_LABITEMS (LABEL, FLUID, CATEGORY)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index D_LABITEMS_idx03;
CREATE INDEX D_LABITEMS_idx03
  ON D_LABITEMS (LOINC_CODE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- DATETIMEEVENTS
drop index DATETIMEEVENTS_idx01;
CREATE INDEX DATETIMEEVENTS_idx01
  ON DATETIMEEVENTS (SUBJECT_ID, HADM_ID, ICUSTAY_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index DATETIMEEVENTS_idx02;
CREATE INDEX DATETIMEEVENTS_idx02
  ON DATETIMEEVENTS (ITEMID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index DATETIMEEVENTS_idx03;
CREATE INDEX DATETIMEEVENTS_idx03
  ON DATETIMEEVENTS (CHARTTIME)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index DATETIMEEVENTS_idx04;
CREATE INDEX DATETIMEEVENTS_idx04
  ON DATETIMEEVENTS (CGID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index DATETIMEEVENTS_idx05;
CREATE INDEX DATETIMEEVENTS_idx05
  ON DATETIMEEVENTS (VALUE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- DIAGNOSES_ICD
drop index DIAGNOSES_ICD_idx01;
CREATE INDEX DIAGNOSES_ICD_idx01
  ON DIAGNOSES_ICD (SUBJECT_ID, HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index DIAGNOSES_ICD_idx02;
CREATE INDEX DIAGNOSES_ICD_idx02
  ON DIAGNOSES_ICD (ICD9_CODE, SEQUENCE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index DIAGNOSES_ICD_idx03;
CREATE INDEX DIAGNOSES_ICD_idx03
  ON DIAGNOSES_ICD (DESCRIPTION)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- DRGCODES
drop index DRGCODES_idx01;
CREATE INDEX DRGCODES_idx01
  ON DRGCODES (SUBJECT_ID, HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index DRGCODES_idx02;
CREATE INDEX DRGCODES_idx02
  ON DRGCODES (DRG_CODE, DRG_TYPE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index DRGCODES_idx03;
CREATE INDEX DRGCODES_idx03
  ON DRGCODES (DESCRIPTION, DRG_SEVERITY)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- ICUSTAYEVENTS
drop index ICUSTAYEVENTS_idx01;
CREATE INDEX ICUSTAYEVENTS_idx01
  ON ICUSTAYEVENTS (SUBJECT_ID, HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index ICUSTAYEVENTS_idx02;
CREATE INDEX ICUSTAYEVENTS_idx02
  ON ICUSTAYEVENTS (ICUSTAY_ID, DBSOURCE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index ICUSTAYEVENTS_idx03;
CREATE INDEX ICUSTAYEVENTS_idx03
  ON ICUSTAYEVENTS (LOS)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index ICUSTAYEVENTS_idx04;
CREATE INDEX ICUSTAYEVENTS_idx04
  ON ICUSTAYEVENTS (FIRST_CAREUNIT)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index ICUSTAYEVENTS_idx05;
CREATE INDEX ICUSTAYEVENTS_idx05
  ON ICUSTAYEVENTS (LAST_CAREUNIT)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- IOEVENTS
drop index IOEVENTS_idx01;
CREATE INDEX IOEVENTS_idx01
  ON IOEVENTS (SUBJECT_ID, HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index IOEVENTS_idx02;
CREATE INDEX IOEVENTS_idx02
  ON IOEVENTS (ICUSTAY_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index IOEVENTS_idx03;
CREATE INDEX IOEVENTS_idx03
  ON IOEVENTS (ENDTIME, STARTTIME)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index IOEVENTS_idx04;
CREATE INDEX IOEVENTS_idx04
  ON IOEVENTS (ITEMID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index IOEVENTS_idx05;
CREATE INDEX IOEVENTS_idx05
  ON IOEVENTS (RATE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index IOEVENTS_idx06;
CREATE INDEX IOEVENTS_idx06
  ON IOEVENTS (VOLUME)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index IOEVENTS_idx07;
CREATE INDEX IOEVENTS_idx07
  ON IOEVENTS (CGID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index IOEVENTS_idx08;
CREATE INDEX IOEVENTS_idx08
  ON IOEVENTS (LINKORDERID, ORDERID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index IOEVENTS_idx09;
CREATE INDEX IOEVENTS_idx09
  ON IOEVENTS (ORDERCATEGORYDESCRIPTION, ORDERCATEGORYNAME, SECONDARYORDERCATEGORYNAME)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index IOEVENTS_idx10;
CREATE INDEX IOEVENTS_idx10
  ON IOEVENTS (ORDERCOMPONENTTYPEDESCRIPTION, ORDERCATEGORYDESCRIPTION)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- LABEVENTS
drop index LABEVENTS_idx01;
CREATE INDEX LABEVENTS_idx01
  ON LABEVENTS (SUBJECT_ID, HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index LABEVENTS_idx02;
CREATE INDEX LABEVENTS_idx02
  ON LABEVENTS (ITEMID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index LABEVENTS_idx03;
CREATE INDEX LABEVENTS_idx03
  ON LABEVENTS (CHARTTIME)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index LABEVENTS_idx04;
CREATE INDEX LABEVENTS_idx04
  ON LABEVENTS (VALUE, VALUENUM)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- MICROBIOLOGYEVENTS
drop index MICROBIOLOGYEVENTS_idx01;
CREATE INDEX MICROBIOLOGYEVENTS_idx01
  ON MICROBIOLOGYEVENTS (SUBJECT_ID, HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index MICROBIOLOGYEVENTS_idx02;
CREATE INDEX MICROBIOLOGYEVENTS_idx02
  ON MICROBIOLOGYEVENTS (CHARTDATE, CHARTTIME)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index MICROBIOLOGYEVENTS_idx03;
CREATE INDEX MICROBIOLOGYEVENTS_idx03
  ON MICROBIOLOGYEVENTS (SPEC_ITEMID, ORG_ITEMID, AB_ITEMID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- NOTEEVENTS
drop index NOTEEVENTS_idx01;
CREATE INDEX NOTEEVENTS_idx01
  ON NOTEEVENTS (SUBJECT_ID, HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index NOTEEVENTS_idx02;
CREATE INDEX NOTEEVENTS_idx02
  ON NOTEEVENTS (CHARTDATE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index NOTEEVENTS_idx03;
CREATE INDEX NOTEEVENTS_idx03
  ON NOTEEVENTS (CGID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index NOTEEVENTS_idx04;
CREATE INDEX NOTEEVENTS_idx04
  ON NOTEEVENTS (RECORD_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index NOTEEVENTS_idx05;
CREATE INDEX NOTEEVENTS_idx05
  ON NOTEEVENTS (CATEGORY, DESCRIPTION)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- PATIENTS

drop index PATIENTS_idx01;
CREATE INDEX PATIENTS_idx01
  ON PATIENTS (HOSPITAL_EXPIRE_FLAG)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- PRESCRIPTIONS
drop index PRESCRIPTIONS_idx01;
CREATE INDEX PRESCRIPTIONS_idx01
  ON PRESCRIPTIONS (SUBJECT_ID, HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index PRESCRIPTIONS_idx02;
CREATE INDEX PRESCRIPTIONS_idx02
  ON PRESCRIPTIONS (ICUSTAY_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index PRESCRIPTIONS_idx03;
CREATE INDEX PRESCRIPTIONS_idx03
  ON PRESCRIPTIONS (DRUG_TYPE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index PRESCRIPTIONS_idx04;
CREATE INDEX PRESCRIPTIONS_idx04
  ON PRESCRIPTIONS (DRUG)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index PRESCRIPTIONS_idx05;
CREATE INDEX PRESCRIPTIONS_idx05
  ON PRESCRIPTIONS (STARTTIME, ENDTIME)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- PROCEDURES_ICD
drop index PROCEDURES_ICD_idx01;
CREATE INDEX PROCEDURES_ICD_idx01
  ON PROCEDURES_ICD (SUBJECT_ID, HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index PROCEDURES_ICD_idx02;
CREATE INDEX PROCEDURES_ICD_idx02
  ON PROCEDURES_ICD (ICD9_CODE, PROC_SEQ_NUM)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- SERVICES
drop index SERVICES_idx01;
CREATE INDEX SERVICES_idx01
  ON SERVICES (SUBJECT_ID, HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index SERVICES_idx02;
CREATE INDEX SERVICES_idx02
  ON SERVICES (TRANSFERTIME)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index SERVICES_idx03;
CREATE INDEX SERVICES_idx03
  ON SERVICES (CURR_SERVICE, PREV_SERVICE)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

-- TRANSFERS
drop index TRANSFERS_idx01;
CREATE INDEX TRANSFERS_idx01
  ON TRANSFERS (SUBJECT_ID, HADM_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index TRANSFERS_idx02;
CREATE INDEX TRANSFERS_idx02
  ON TRANSFERS (ICUSTAY_ID)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index TRANSFERS_idx03;
CREATE INDEX TRANSFERS_idx03
  ON TRANSFERS (CURR_CAREUNIT, PREV_CAREUNIT)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index TRANSFERS_idx04;
CREATE INDEX TRANSFERS_idx04
  ON TRANSFERS (INTIME, OUTTIME)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

drop index TRANSFERS_idx05;
CREATE INDEX TRANSFERS_idx05
  ON TRANSFERS (LOS)
TABLESPACE MIMIC3_IDX
parallel 4 NOLOGGING;

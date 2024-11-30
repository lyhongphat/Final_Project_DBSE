------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------
-- Run with sysorcl
------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------

-- Open all pluggable databases
ALTER PLUGGABLE DATABASE ALL OPEN;

-- Set the audit trail to DB and extended, effective after the next startup
ALTER SYSTEM SET audit_trail = DB, EXTENDED SCOPE = SPFILE;

-- Shut down the database immediately
SHUTDOWN IMMEDIATE;

-- Start up the database
STARTUP;

-- Remove all records from the audit trail table
TRUNCATE TABLE aud$;

-- Remove all records from the fine-grained auditing log table
TRUNCATE TABLE fga_log$;
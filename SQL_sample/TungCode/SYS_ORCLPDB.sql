GRANT create procedure TO sec_admin; 

GRANT SELECT ON dba_audit_trail TO sec_admin;
GRANT SELECT ON dba_audit_trail TO BPGiamSat;

-- SHOW PARAMETER AUDIT;

GRANT EXECUTE ON DBMS_CRYPTO TO SEC_PASSPORT;
GRANT CREATE PROCEDURE TO SEC_PASSPORT;
GRANT EXECUTE ON DBMS_CRYPTO TO BPXacThuc; 
     
GRANT dba to sec_admin WITH ADMIN OPTION;
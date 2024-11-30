-- which role have access to which table
-- ROLE GUEST
GRANT SELECT ON passport.user_request TO GUEST;
GRANT SELECT ON passport.passport_details TO GUEST;
GRANT SELECT ON passport.location TO GUEST;

GRANT INSERT (location_id, passport_id, full_name, gender, CCCD, phone, email, extendDuration) ON passport.user_request TO GUEST;

-- ROLE BPXacThuc
BEGIN
   FOR R IN (SELECT owner, table_name FROM all_tables WHERE owner='PASSPORT') LOOP
      EXECUTE IMMEDIATE 'grant select on '||R.owner||'.'||R.table_name||' to BPXacThuc';
   END LOOP;
END;
/

GRANT UPDATE (is_authenticated, is_rejected, note) ON passport.user_request TO BPXacThuc;

-- ROLE BPXetDuyet
GRANT SELECT ON passport.userRequest TO BPXetDuyet;
GRANT SELECT ON passport.location TO BPXetDuyet;
GRANT SELECT ON passport.employee TO BPXetDuyet;
GRANT SELECT ON passport.passport TO BPXetDuyet;

GRANT UPDATE (is_approve, is_rejected, note) ON passport.user_request TO BPXetDuyet;

-- ROLE BPLuuTru
GRANT SELECT ON passport.employee TO BPLuuTru;
GRANT SELECT ON passport.passport TO BPLuuTru;
GRANT SELECT ON passport.user_request TO BPLuuTru;

grant update (note) on passport.user_request to BPLuuTru;
grant update (enddate) on passport.passport to BPLuuTru;

-- ROLE BPGiamSat
GRANT SELECT ON passport.passport TO BPGiamSat;
GRANT SELECT ON passport.userRequest TO BPGiamSat;
GRANT SELECT ON passport.employee TO BPGiamSat;


GRANT select, insert, update ON user_request TO sec_admin;
GRANT select, insert, update ON resident TO sec_admin; 

-- sec_passport
BEGIN
   FOR R IN (SELECT owner, table_name FROM all_tables WHERE owner='PASSPORT') LOOP
      EXECUTE IMMEDIATE 'grant select on '||R.owner||'.'||R.table_name||' to sec_passport';
   END LOOP;
END;
/

GRANT UPDATE ON passport.user_request TO sec_passport;
GRANT UPDATE ON passport.resident TO sec_passport;

--Audit

AUDIT ALL ON USERREQUEST BY ACCESS;
AUDIT ALL ON PASSPORT BY ACCESS;

AUDIT ALL ON RESIDENT BY ACCESS WHENEVER SUCCESSFUL;
AUDIT ALL ON RESIDENT BY ACCESS WHENEVER NOT SUCCESSFUL;

AUDIT ALL ON EMPLOYEE BY ACCESS WHENEVER SUCCESSFUL;
AUDIT ALL ON EMPLOYEE BY ACCESS WHENEVER NOT SUCCESSFUL;

GRANT UPDATE ON passport.employee TO sec_passport;
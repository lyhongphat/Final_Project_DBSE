-- RLS to protect data from an condition
-- This function will protect data unfixable
CREATE OR REPLACE FUNCTION is_rejecteds (
    p_schema IN VARCHAR2 DEFAULT NULL,
    p_object IN VARCHAR2 DEFAULT NULL
) RETURN VARCHAR2 AS
BEGIN
    RETURN 'is_rejected = 0';
END;
/

BEGIN
    dbms_rls.add_policy(
        object_schema => 'PASSPORT', 
        object_name => 'USER_REQUEST', 
        policy_name => 'REJECT_IS_REJECT_POL', 
        function_schema => 'SEC_ADMIN',
        policy_function => 'is_rejecteds',
        statement_types => 'UPDATE');
END;
/

-- This function only allow LuuTru to update passport date and user request have been proved by authen and approve
-- this function will protect data unfixable
CREATE OR REPLACE FUNCTION ready_to_update (
    p_schema IN VARCHAR2 DEFAULT NULL,
    p_object IN VARCHAR2 DEFAULT NULL
) RETURN VARCHAR2 AS
BEGIN
    RETURN 'passport_id in (select passport_id from passport.user_request WHERE is_authenticated=1 AND is_approve=1 AND is_rejected=0) AND USER=''LUUTRU''';
END;
/

BEGIN
    dbms_rls.add_policy(
        object_schema => 'PASSPORT', 
        object_name => 'PASSPORT', 
        policy_name => 'READY_TO_UPDATE_PASSPORT_POL', 
        function_schema => 'SEC_ADMIN',
        policy_function => 'ready_to_update',
        statement_types => 'UPDATE, DELETE');
END;
/


create or replace function passport_filter (
    p_schema IN VARCHAR2 DEFAULT NULL,
    p_object IN VARCHAR2 DEFAULT NULL
) RETURN VARCHAR2 IS predicate VARCHAR2(2000);
BEGIN
    IF SYS_CONTEXT('USERENV', 'SESSION_USER') = 'LUUTRU' THEN
        predicate := '1=1';
    ELSE
        predicate := 'resident_id in (select id from passport.resident)';
    END IF;
    RETURN predicate;
END;
/

BEGIN
    dbms_rls.add_policy(
        object_schema => 'PASSPORT', 
        object_name => 'PASSPORT', 
        policy_name => 'PASSPOR_FILTER_POL', 
        function_schema => 'SEC_ADMIN',
        policy_function => 'passport_filter',
        statement_types => 'SELECT');
END;
/

--EXECUTE dbms_rls.drop_policy('PASSPORT','USER_REQUEST','REJECT_IS_REJECT_POL');
--EXECUTE dbms_rls.drop_policy('PASSPORT','PASSPORT','READY_TO_UPDATE_PASSPORT_POL');
--EXECUTE dbms_rls.drop_policy('PASSPORT','PASSPORT','PASSPOR_FILTER_POL');

-- run this if something wrong with policy
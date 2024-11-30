-- Create level (policy_name, level_num, short_name, long_name)
EXECUTE sa_components.create_level('ACCESS_USERREQUEST',3000,'SENS','SENSITIVE'); 
EXECUTE sa_components.create_level('ACCESS_USERREQUEST',2000,'CONF','CONFIDENTIAL'); 
EXECUTE sa_components.create_level('ACCESS_USERREQUEST',1000,'PUB','PUBLIC'); 

-- Create compartment (policy_name, comp_num, short_name, long_name)
EXECUTE sa_components.create_compartment('ACCESS_USERREQUEST',4000,'GS','BPGiamSat'); 
EXECUTE sa_components.create_compartment('ACCESS_USERREQUEST',3000,'XT','BPXacThuc');
EXECUTE sa_components.create_compartment('ACCESS_USERREQUEST',2000,'XD','BPXetDuyet');
EXECUTE sa_components.create_compartment('ACCESS_USERREQUEST',1000,'LT','BPLuuTru');

-- Create group (policy_name, group_num, short_name, long_name, parent_name)
EXECUTE sa_components.create_group('ACCESS_USERREQUEST',50,'HCM','Ho Chi Minh');
EXECUTE sa_components.create_group('ACCESS_USERREQUEST',40,'TD','Thu Duc','HCM'); 
EXECUTE sa_components.create_group('ACCESS_USERREQUEST',10,'Q1','Quan 1','HCM');
EXECUTE sa_components.create_group('ACCESS_USERREQUEST',20,'Q2','Quan 2','HCM');
EXECUTE sa_components.create_group('ACCESS_USERREQUEST',30,'Q3','Quan 3','HCM');

-- Create label (policy_name, label_tag, label_value)
EXECUTE sa_label_admin.create_label ('ACCESS_USERREQUEST',10000,'PUB'); 
EXECUTE sa_label_admin.create_label ('ACCESS_USERREQUEST',23010,'CONF:XT:Q1'); 
EXECUTE sa_label_admin.create_label ('ACCESS_USERREQUEST',23020,'CONF:XT:Q2');
EXECUTE sa_label_admin.create_label ('ACCESS_USERREQUEST',23030,'CONF:XT:Q3');
EXECUTE sa_label_admin.create_label ('ACCESS_USERREQUEST',23040,'CONF:XT:TD'); 
EXECUTE sa_label_admin.create_label ('ACCESS_USERREQUEST',22050,'CONF:XD:HCM'); 
EXECUTE sa_label_admin.create_label ('ACCESS_USERREQUEST',21050,'CONF:LT:HCM');

-- automatic gen label for user request table
CREATE OR REPLACE FUNCTION sec_admin.gen_userReq_label (
    location_id      INTEGER,
    is_authenticated NUMBER DEFAULT 0,
    is_approve      NUMBER DEFAULT 0,
    is_rejected      NUMBER DEFAULT 0
) RETURN lbacsys.lbac_label AS
    i_label VARCHAR2(80);
BEGIN 
/************* define level *************/
    IF is_rejected = 1 THEN
        RETURN to_lbac_data_label('ACCESS_USERREQUEST', 'CONF');
    END IF;
    i_label := 'CONF:';
/************* define Compartment and group *************/
    -- If the user request is not yet authenticated, authenticator will do
    IF is_authenticated = 0 THEN
        IF location_id = 1 THEN
            i_label := i_label || 'XT:Q1';
        ELSIF location_id = 2 THEN
            i_label := i_label || 'XT:Q2';
        ELSIF location_id = 3 THEN
            i_label := i_label || 'XT:Q3';
        ELSIF location_id = 4 THEN
            i_label := i_label || 'XT:TD';
        END IF;
    -- If the user request is authenticated, the censor will approve the request or not
    ELSIF is_approve = 0 THEN
        i_label := i_label || 'XD:HCM';
    ELSE 
        i_label := i_label || 'LT:HCM';
    END IF; 
    
    RETURN to_lbac_data_label('ACCESS_USERREQUEST', i_label);
END;
/

-- Apply policy to table resident (cuz it is the same, i don't want to make another policy :P)
-- run code below it you don't want this policy
--BEGIN 
--   sa_policy_admin.remove_table_policy (
--     policy_name   => 'ACCESS_USERREQUEST',
--        schema_name    => 'PASSPORT', 
--        table_name     => 'user_request',
--        drop_column    => true); 
--END;
--/

-- Then apply policy to table user request
BEGIN
    sa_policy_admin.apply_table_policy(
        policy_name => 'ACCESS_USERREQUEST', 
        schema_name => 'PASSPORT', 
        table_name => 'USER_REQUEST', 
        table_options => 'HIDE,READ_CONTROL,WRITE_CONTROL', 
        label_function => 'sec_admin.gen_userReq_label (:new.location_id, :new.is_authenticated, :new.is_approve, :new.is_rejected)',
        predicate => NULL);
END;
/

-- grant function we created to lbacsys;
GRANT execute ON sec_admin.gen_userReq_label TO lbacsys;

-- Apply policy to table resident (cuz it is the same, i don't want to make another policy :P)
-- run code below it you don't want this policy
--BEGIN 
--    sa_policy_admin.remove_table_policy (
--        policy_name   => 'ACCESS_USERREQUEST',
--        schema_name    => 'PASSPORT', 
--        table_name     => 'Resident',
--        drop_column    => true); 
--END;
--/

BEGIN
    sa_policy_admin.apply_table_policy (
        policy_name     => 'ACCESS_USERREQUEST', 
        schema_name      => 'PASSPORT', 
        table_name       => 'Resident', 
        table_options    => 'HIDE, READ_CONTROL, WRITE_CONTROL, CHECK_CONTROL');
END;
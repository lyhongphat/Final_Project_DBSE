---- set level to user (policy_name, user_name, max_level, min_level, def_level, row_level)
EXECUTE sa_user_admin.set_levels('ACCESS_USERREQUEST', 'NguoiDung', 'PUB', 'PUB', 'PUB', 'PUB');
EXECUTE sa_user_admin.set_levels('ACCESS_USERREQUEST', 'XacThuc', 'CONF', 'PUB', 'CONF', 'CONF');
EXECUTE sa_user_admin.set_levels('ACCESS_USERREQUEST', 'XacThucQuan1', 'CONF', 'PUB', 'CONF', 'CONF');
EXECUTE sa_user_admin.set_levels('ACCESS_USERREQUEST', 'XacThucQuan2', 'CONF', 'PUB', 'CONF', 'CONF');
EXECUTE sa_user_admin.set_levels('ACCESS_USERREQUEST', 'XacThucQuan3', 'CONF', 'PUB', 'CONF', 'CONF');
EXECUTE sa_user_admin.set_levels('ACCESS_USERREQUEST', 'XetDuyet', 'CONF', 'PUB', 'CONF', 'CONF');
EXECUTE sa_user_admin.set_levels('ACCESS_USERREQUEST', 'LuuTru', 'CONF', 'PUB', 'CONF', 'CONF');
EXECUTE sa_user_admin.set_levels('ACCESS_USERREQUEST', 'GiamSat', 'SENS', 'SENS', 'SENS', 'SENS');
-- done

-- set compartment to user (policy_name, user_name, read_comps, write_comps, def_comps, row_comps)
-- user will not have own compartment
EXECUTE sa_user_admin.set_compartments('ACCESS_USERREQUEST', 'XacThuc', 'XT', 'XT', 'XT', 'XT');
EXECUTE sa_user_admin.set_compartments('ACCESS_USERREQUEST', 'XacThucQuan1', 'XT', 'XT', 'XT', 'XT');
EXECUTE sa_user_admin.set_compartments('ACCESS_USERREQUEST', 'XacThucQuan2', 'XT', 'XT', 'XT', 'XT');
EXECUTE sa_user_admin.set_compartments('ACCESS_USERREQUEST', 'XacThucQuan3', 'XT', 'XT', 'XT', 'XT');
EXECUTE sa_user_admin.set_compartments('ACCESS_USERREQUEST', 'XetDuyet', 'XD', 'XD', 'XD', 'XD');
EXECUTE sa_user_admin.set_compartments('ACCESS_USERREQUEST', 'LuuTru', 'LT', 'LT', 'LT', 'LT');
EXECUTE sa_user_admin.set_compartments('ACCESS_USERREQUEST', 'GiamSat', 'GS', 'GS', 'GS', 'GS');

-- set group (policy_name, user_name, read_groups, write_groups, def_groups, row_groups)
EXECUTE sa_user_admin.set_groups('ACCESS_USERREQUEST', 'XacThuc', 'TD', 'TD', 'TD', 'TD');
EXECUTE sa_user_admin.set_groups('ACCESS_USERREQUEST', 'XacThucQuan1', 'Q1', 'Q1', 'Q1', 'Q1');
EXECUTE sa_user_admin.set_groups('ACCESS_USERREQUEST', 'XacThucQuan2', 'Q2', 'Q2', 'Q2', 'Q2');
EXECUTE sa_user_admin.set_groups('ACCESS_USERREQUEST', 'XacThucQuan3', 'Q3', 'Q3', 'Q3', 'Q3');
EXECUTE sa_user_admin.set_groups('ACCESS_USERREQUEST', 'XetDuyet', 'HCM', 'HCM', 'HCM', 'HCM');
EXECUTE sa_user_admin.set_groups('ACCESS_USERREQUEST', 'LuuTru', 'HCM', 'HCM', 'HCM', 'HCM');
EXECUTE sa_user_admin.set_groups('ACCESS_USERREQUEST', 'GiamSat', 'HCM', 'HCM', 'HCM', 'HCM');

-- Apply full access for this user to test purpose
BEGIN 
    sa_user_admin.set_user_privs (
        policy_name  => 'ACCESS_USERREQUEST', 
        user_name     => 'sec_passport', 
        PRIVILEGES    => 'FULL'); 
END; 
/

------ Apply label tag to data user request
UPDATE PASSPORT.userRequest
SET
    OLS_COLUMN = char_to_label('ACCESS_USERREQUEST', 'CONF:XT:Q1')
WHERE 
    IS_AUTHENTICATED = 0 AND location_id = 1;

UPDATE PASSPORT.userRequest
SET 
    OLS_COLUMN = char_to_label('ACCESS_USERREQUEST', 'CONF:XT:Q2')
WHERE 
    IS_AUTHENTICATED = 0 AND location_id = 2;
    
UPDATE PASSPORT.userRequest
SET
    OLS_COLUMN = char_to_label('ACCESS_USERREQUEST', 'CONF:XT:Q3')
WHERE 
    IS_AUTHENTICATED = 0 AND location_id = 3;
    
UPDATE PASSPORT.userRequest
SET
    OLS_COLUMN = char_to_label('ACCESS_USERREQUEST', 'CONF:XT:TD')
WHERE 
    IS_AUTHENTICATED = 0 AND location_id = 4;

COMMIT;

SELECT * FROM PASSPORT.resident;
UPDATE PASSPORT.resident
SET
    OLS_COLUMN = char_to_label('ACCESS_USERREQUEST', 'CONF:XT:Q1')
WHERE 
    location_id = 1;

UPDATE PASSPORT.resident
SET 
    OLS_COLUMN = char_to_label('ACCESS_USERREQUEST', 'CONF:XT:Q2')
WHERE 
	location_id = 2;
    
UPDATE PASSPORT.resident
SET
    OLS_COLUMN = char_to_label('ACCESS_USERREQUEST', 'CONF:XT:Q3')
WHERE 
    location_id = 3;
    
UPDATE PASSPORT.resident
SET
    OLS_COLUMN = char_to_label('ACCESS_USERREQUEST', 'CONF:XT:TD')
WHERE 
    location_id = 4;

commit;
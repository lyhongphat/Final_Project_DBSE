-- Package dùng để tạo ra các thành phần của nhãn 
GRANT execute ON sa_components TO sec_admin; 
 
-- Package dùng để tạo các nhãn 
GRANT execute ON sa_label_admin TO sec_admin; 
 
-- Package dùng để gán chính sách cho các table/schema 
GRANT execute ON sa_policy_admin TO sec_admin; 

-- Package dùng để gen data label
GRANT execute ON to_lbac_data_label TO sec_admin WITH GRANT OPTION; 

-- Package dùng để gán các label cho user 
GRANT execute ON sa_user_admin TO sec_passport; 


--- Tạo Policy cho cơ sở dữ liệu 
BEGIN 
	SA_SYSDBA.CREATE_POLICY (policy_name => 'ACCESS_USERREQUEST', column_name => 'OLS_COLUMN'); 
END; 

-- Cấp quyền cho admin để có thể tạo nhãn
GRANT access_userrequest_dba TO sec_admin;
GRANT access_userrequest_dba TO sec_passport;

--BEGIN 
--SA_SYSDBA.DROP_POLICY ( policy_name => 'ACCESS_USERREQUEST', drop_column => true); 
--END;   

select * from ALL_SA_LABELS WHERE POLICY_NAME = 'ACCESS_USERREQUEST';
SELECT  USERNAME, TIMESTAMP, obj_name, action_name, priv_used, sql_text
FROM dba_audit_trail 
WHERE obj_name IN ('USERREQUEST', 'RESIDENT')
ORDER BY TIMESTAMP DESC;
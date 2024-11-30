
-- Cập nhật cột password trong bảng employee bằng cách sử dụng mã hóa
DECLARE
    l_password_raw RAW(2000);
BEGIN
    FOR emp_rec IN (SELECT id, password FROM PASSPORT.employee) -- Replace with the actual condition
    LOOP
        -- Encrypt the password
        l_password_raw := DBMS_CRYPTO.encrypt(
            src  => UTL_RAW.cast_to_raw(emp_rec.password),
            typ  => DBMS_CRYPTO.des_cbc_pkcs5,
            key  => UTL_RAW.cast_to_raw('abcdefgh')
        );

        -- Update the encrypted password in the table
        UPDATE PASSPORT.employee
        SET password = RAWTOHEX(l_password_raw)
        WHERE id = emp_rec.id;
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE validate_login(
    p_username IN VARCHAR2,
    p_raw_password IN RAW,
    p_result OUT NUMBER,
    p_id OUT NUMBER,
    p_role OUT VARCHAR
)
AS
    l_stored_password RAW(2000);
    l_decrypted RAW(2000);
BEGIN
    -- Retrieve the stored encrypted password for the given username
    SELECT password
    INTO l_stored_password
    FROM PASSPORT.employee
    WHERE username = p_username;

    -- Encrypt the input password for comparison
    l_decrypted := DBMS_CRYPTO.decrypt(
        src  => l_stored_password,
        typ  => DBMS_CRYPTO.DES_CBC_PKCS5,
        key  => UTL_RAW.cast_to_raw('abcdefgh')
    );

    -- Check if the encrypted input matches the stored password
    IF p_raw_password = l_decrypted THEN
        p_result := 1; -- Successful login
        SELECT id, role
        INTO p_id, p_role
        FROM PASSPORT.employee
        WHERE username = p_username;
    ELSE
        p_result := 0; -- Failed login
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_result := 0; -- Username not found

END validate_login;
/

-- Test procedure
SET SERVEROUTPUT ON;
DECLARE
    l_result NUMBER;
    l_id NUMBER;
    l_role VARCHAR(10);
BEGIN
    validate_login('XetDuyet', UTL_RAW.cast_to_raw('password'), l_result, l_id, l_role);
    DBMS_OUTPUT.put_line('Login Result: ' || l_result || ', id: ' || l_id || ', role: ' || l_role);
END;
/

GRANT EXECUTE ON validate_login to BPXacThuc;
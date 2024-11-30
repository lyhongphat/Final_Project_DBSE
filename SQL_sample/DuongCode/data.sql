-- Add data to location
INSERT INTO location (nation, city, district)
WITH district_data AS (
  SELECT 'Vietnam' AS nation, 'Ho Chi Minh City' AS city, 'Quan 1' AS district FROM dual UNION ALL
  SELECT 'Vietnam' AS nation, 'Ho Chi Minh City' AS city, 'Quan 2' AS district FROM dual UNION ALL
  SELECT 'Vietnam' AS nation, 'Ho Chi Minh City' AS city, 'Quan 3' AS district FROM dual UNION ALL
  SELECT 'Vietnam' AS nation, 'Ho Chi Minh City' AS city, 'Quan Thu Duc' AS district FROM dual
)
SELECT * FROM district_data;
SELECT * FROM location;

-- Resident
INSERT INTO resident (location_id, fullName, gender, CCCD, phone, email) 
WITH resident_data AS (
  SELECT 1, 'Nguyen Thi A', 'Female', '123456789013', '1234567890', 'nguyenvana@email.com' FROM dual UNION ALL
  SELECT 2, 'Tran Thi B', 'Female', '987654321098', '0987654321', 'tranthib@email.com' FROM dual UNION ALL
  SELECT 3, 'John Doe', 'Male', '654321098765', '555-1234', 'john.doe@email.com' FROM dual UNION ALL
  SELECT 4, 'Nguyen Duc Toan', 'Male', '091202009045', '0375325687', 'toiiuvn111@gmail.com' FROM dual UNION ALL
  SELECT 2, 'Pham Tien Dung', 'Male', '091234675823', '0376436798', 'iamtiendung@gmail.com' FROM dual UNION ALL
  SELECT 3, 'Le Huynh Thanh Duong', 'Male', '091234673333', '0374214576', 'lehuy@gmail.com' FROM dual 
)
SELECT * FROM resident_data;
select * from resident;

-- Passport
INSERT INTO passport (resident_id, passport_id, start_date, end_date) 
WITH passport_data AS (
  SELECT 1, 'VN123456', TO_DATE('01-01-2022', 'DD-MM-YYYY'), TO_DATE('01-01-2027', 'DD-MM-YYYY') FROM dual UNION ALL
  SELECT 2, 'VN987654', TO_DATE('01-01-2021', 'DD-MM-YYYY'), TO_DATE('01-01-2026', 'DD-MM-YYYY') FROM dual UNION ALL
  SELECT 3, 'US123456', TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('01-01-2028', 'DD-MM-YYYY') FROM dual UNION ALL
  SELECT 3, 'US123457', TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2029', 'DD-MM-YYYY') FROM dual UNION ALL
  SELECT 4, 'VN456123', TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('01-01-2028', 'DD-MM-YYYY') FROM dual UNION ALL
  SELECT 5, 'VN112233', TO_DATE('05-12-2020', 'DD-MM-YYYY'), TO_DATE('05-12-2025', 'DD-MM-YYYY') FROM dual UNION ALL
  SELECT 6, 'VN123123', TO_DATE('08-08-2018', 'DD-MM-YYYY'), TO_DATE('08-08-2023', 'DD-MM-YYYY') FROM dual

)
SELECT * FROM passport_data;

-- userRequest 
--Alternative insert 
INSERT INTO PASSPORT.userRequest (location_id, passport_id, full_name, gender, CCCD, phone, email, extend_duration) 
WITH user_request_data AS (
  SELECT 1 as locationId, 'VN123456' as passportId, 'Nguyen Van A' as fullName, 'Male' as gender, '123456789012' as CCCD, '1234567890' as phone, 'nguyenvana@email.com' as email, 2 as extendDuration FROM dual UNION ALL
  SELECT 2 as locationId, 'VN987654' as passportId, 'Tran Thi B' as fullName, 'Female' as gender, '987654321098' as CCCD, '0987654321' as phone, 'tranthib@email.com' as email, 2 as extendDuration FROM dual UNION ALL
  SELECT 3 as locationId, 'US123456' as passportId, 'John Doe' as fullName, 'Male' as gender, '654321098765' as CCCD, '555-1234' as phone, 'john.doe@email.com' as email, 3 as extendDuration FROM dual
)
SELECT * FROM user_request_data;
select * from userRequest;

-- Insert employee resident data
INSERT INTO resident (location_id, full_name, gender, CCCD, phone, email) 
WITH resident_data AS (
  SELECT 1, 'Truong Phi', 'Male', '123456789494', '1234567899', 'top1server@email.com' FROM dual UNION ALL -- quan ly quan 1
  SELECT 2, 'Luu Bi', 'Male', '987654321000', '0987654333', 'luubi@email.com' FROM dual UNION ALL -- quan ly quan 2
  SELECT 3, 'Quan Vu', 'Male', '654321098777', '555-9865', 'quanvu@email.com' FROM dual UNION ALL -- quan ly quan 3
  SELECT 4, 'Jr Sophia', 'Female', '091202001212', '0375325699', 'sophia2002@gmail.com' FROM dual UNION ALL -- quan ly thu duc
  SELECT 4, 'Hoa Da', 'Female', '091234675111', '0376436711', 'chidep1912@gmail.com' FROM dual UNION ALL -- thuoc bo phan xet duyet
  SELECT 4, 'Nguyen Thi Mai', 'Female', '091234673334', '0374214598', 'mainguyen@gmail.com' FROM dual UNION ALL -- thuoc bo phan luu tru
  SELECT 4, 'Tran Minh Admin', 'Male', '091234673335', '0374214577', 'admin@gmail.com' FROM dual -- thuoc bo phan giam sat
)
SELECT * FROM resident_data;
select * from resident;

-- employee
INSERT INTO employee (resident_id, username, password, role) 
WITH employee_data AS (
  SELECT 7, 'XacThuc', 'password', 'BPXacThuc' FROM dual UNION ALL -- quanThuDuc
  SELECT 8, 'XacThucQuan1', 'password', 'BPXacThuc' FROM dual UNION ALL -- quan 1
  SELECT 9, 'XacThucQuan2', 'password', 'BPXacThuc' FROM dual UNION ALL -- quan 2
  SELECT 10, 'XacThucQuan3', 'password', 'BPXacThuc' FROM dual UNION ALL --quan 3
  SELECT 11, 'XetDuyet', 'password', 'BPXetDuyet' FROM dual UNION ALL -- xet duyet
  SELECT 12, 'LuuTru', 'password', 'BPLuuTru' FROM dual UNION ALL -- luu tru
  SELECT 13, 'GiamSat', 'password', 'BPGiamSat' FROM dual -- giam sat
)
SELECT * FROM employee_data;

commit;
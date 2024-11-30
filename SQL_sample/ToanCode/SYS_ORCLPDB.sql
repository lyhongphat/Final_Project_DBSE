-- database will be stored here
grant connect, create table to passport identified by passport;
grant create view to passport;

-- security role
GRANT connect, create user, drop user, create role, drop any role 
TO sec_passport IDENTIFIED BY sec_passport; 
    
GRANT connect TO sec_admin IDENTIFIED BY sec_admin; 
GRANT EXECUTE ON dbms_rls TO sec_admin;

-- base role
CREATE ROLE GUEST;
CREATE ROLE BPXacThuc;
CREATE ROLE BPXetDuyet;
CREATE ROLE BPLuuTru;
CREATE ROLE BPGiamSat;

-- User with base role (to identify connection with user)
GRANT GUEST, CONNECT TO NguoiDung IDENTIFIED BY nguoidung;
GRANT BPXacThuc, CONNECT TO XacThuc IDENTIFIED BY xacthuc; -- cai nay cua quan thu duc
GRANT BPXacThuc, CONNECT TO XacThucQuan1 IDENTIFIED BY xacthuc;
GRANT BPXacThuc, CONNECT TO XacThucQuan2 IDENTIFIED BY xacthuc;
GRANT BPXacThuc, CONNECT TO XacThucQuan3 IDENTIFIED BY xacthuc;

GRANT BPXetDuyet, CONNECT TO XetDuyet IDENTIFIED BY xetduyet;
GRANT BPLuuTru, CONNECT TO LuuTru IDENTIFIED BY luutru;
GRANT BPGiamSat, CONNECT TO GiamSat IDENTIFIED BY giamsat;
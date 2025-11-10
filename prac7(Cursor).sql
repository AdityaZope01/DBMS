CREATE DATABASE prac7;

USE prac7;

CREATE TABLE N_RollCall(rollno INT,name VARCHAR(30));

CREATE TABLE O_RollCall(rollno INT,name VARCHAR(30));

INSERT INTO N_RollCall values(1,"A"),(2,"B"),(3,"C"),(4,"D");

INSERT INTO O_RollCall values(2,"B"),(3,"C"),(5,"E"),(6,"F");


SELECT * FROM N_RollCall;

SELECT * FROM O_RollCall;

drop procedure if exists mycursor;

delimiter //

CREATE PROCEDURE mycursor()
BEGIN
    DECLARE  done       INT DEFAULT 0;
    DECLARE  c_rollno   int;
    DECLARE  c_name     char(20);

    DECLARE  c_studentN CURSOR  for SELECT rollno,name FROM O_RollCall where rollno not in(select rollno from N_RollCall);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    BEGIN
        OPEN c_studentN;
        read_loop:LOOP
            FETCH c_studentN into c_rollno, c_name;  

            IF done = 1 THEN
                LEAVE read_loop;
            END IF;          

            insert into N_RollCall(rollno,name) values(c_rollno, c_name);

        END LOOP;
        CLOSE c_studentN;
    END;
END;

//

delimiter ;

CALL my cursor();
SELECT * FROM N_RollCall;
SELECT * FROM O_RollCall;
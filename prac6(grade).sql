CREATE DATABASE prac6;

USE prac6;

CREATE TABLE Result(rollno INT,name VARCHAR(30),class VARCHAR(20));

CREATE TABLE Stud_Marks(rollno int PRIMARY KEY AUTO_INCREMENT ,name VARCHAR(20), marks int);

INSERT INTO Stud_Marks(name,marks) VALUES ("John Doe",850),("Harry Potter",1250),("Emma Watson",1450),("Lucy Hutton",950),("Tom Felton",750);

SELECT * FROM Stud_Marks;


drop procedure if exists proc_Grade;

delimiter //

create procedure proc_Grade()
begin

DECLARE done INT default  0;

DECLARE s_marks int;
DECLARE s_rollno int;
DECLARE s_name varchar(30);
DECLARE s_class varchar(80);

DECLARE s_student cursor For Select  rollno, name, marks from stud_marks;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


open s_student;

read_loop: LOOP

        fetch s_student  into s_rollno,s_name,s_marks;

        IF done = 1 THEN
                LEAVE read_loop;
        END IF;

        if(s_marks<=1500 and s_marks>=990) then
                set s_class='Distinction';

        elseif(s_marks<=989 and s_marks>=900) then
                set s_class='First Class';
        
        elseif (s_marks<=899 and s_marks>=825) then
                set s_class='Higher Second Class';

        else
                set s_class='Pass';

        end if;

        insert into Result(rollno,name,class)values(s_rollno,s_name,s_class);

END LOOP;

close s_student;
end;
//

delimiter ;

CALL proc_Grade();
SELECT * FROM Result;




USE cleaner
Show Tables
describe pago
select * from pago
select * from cliente

insert into pago (id_transaccion, codigo_cliente, forma_pago, fecha_pago, total)
values ('ak-std-000027', 4, 'paypal', sysdate(), 5000)

insert pago (id_transaccion, codigo_cliente, forma_pago, fecha_pago, total)
values ('ak-std-000028', 4, 'paypal', sysdate(), 300) 

/*QUIZ PROFE BELMAN*/

DELIMITER //
Create Procedure sp_insertar_pago ( IN p_id_transaccion varchar (50), IN p_codigo_cliente int, in p_forma_pago varchar (20), in p_fecha_pago DATE, in p_total int)

begin
declare v_existe_id_tran varchar(50);

select count(*)
into v_existe_id_tran
from pago where id_transaccion = p_id_transaccion;

if v_existe_id_tran = 0 then

	insert into pago (id_transaccion, codigo_cliente, forma_pago, fecha_pago, total)
	values (p_id_transaccion, p_codigo_cliente, p_forma_pago, p_fecha_pago, p_total);
	CALL SP_INSERTAR_BOLITA ('EJECUTADO DESDE PROCEDURE');

end if;
end //
DELIMITER ;

/*QUIZ PROFE BELMAN*/

CALL SP_INSERTAR_PAGO ('ak-std-000029', 4, 'paypal', sysdate(), 300);

/*QUIZ PROFE BELMAN*/

Create table logs(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    MENSAJE VARCHAR (100),
    FECHA TIMESTAMP DEFAULT current_timestamp
);



DELIMITER //
CREATE EVENT REVISION_BOLITA
ON SCHEDULE EVERY 30 second
DO
	CALL SP_INSERTAR_BOLITA ('EJECUTADO DESDE EVENTO');

    
    

DELIMITER //
Create Procedure SP_INSERTAR_BOLITA (IN B_MENSAJE VARCHAR(100))

begin

	INSERT INTO LOGS(MENSAJE)
    values (B_MENSAJE);
end //
DELIMITER ;

/*QUIZ PROFE BELMAN*/

DROP EVENT REVISION_BOLITA;
DROP PROCEDURE SP_INSERTAR_BOLITA;

show events;

SHOW variables LIKE 'event_scheduler';

SET GLOBAL event_scheduler = ON;

SELECT * FROM LOGS;

ALTER EVENT REVISION_BOLITA disable
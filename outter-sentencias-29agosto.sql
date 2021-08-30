select  nom_conductor, marca_vehiculo, placa_transporte, estado from conductores inner join conductores_transportes on id_conductor = id_conductores
inner join transportes on id_transportes = id_transporte

select * from conductores_transportes

insert into conductores_transportes values (1, 1, 3, 'PVZ-808')
insert into conductores_transportes values (2, 2, 4, 'PDC-456')
insert into conductores_transportes values (3, 3, 5, 'PGH-874')
insert into conductores_transportes values (4, 4, 1, 'PGC-798')
insert into conductores_transportes values (5, 5, 2, 'PFC-353')

select  nom_conductor, marca_vehiculo, placa_transporte, estado from conductores inner join conductores_transportes on id_conductor = id_conductores
inner join transportes on id_transportes = id_transporte

select  id_paquete, descripcion_paquete, estado_paquete, nom_cliente, nom_destinatario, 
dir_destinatario, nom_conductor, marca_vehiculo, placa_transporte 
from paquete as p inner join clientes as cl on p.cedula_cliente = cl.cedula_cliente
inner join conductores as c on p.id_conductor = c.id_conductor
inner join destinatario as d on p.id_destinatario = d.id_destinatario
inner join conductores_transportes as ct on ct.id_conductores = c.id_conductor 
inner join transportes as t on t.id_transporte = ct.id_transportes where p.estado_paquete = 'Enviado'

select  id_paquete, descripcion_paquete, estado_paquete, nom_cliente, nom_destinatario, 
dir_destinatario, nom_conductor, marca_vehiculo, placa_transporte 
from paquete as p inner join clientes as cl on p.cedula_cliente = cl.cedula_cliente
inner join conductores as c on p.id_conductor = c.id_conductor
inner join destinatario as d on p.id_destinatario = d.id_destinatario
inner join conductores_transportes as ct on ct.id_conductores = c.id_conductor 
inner join transportes as t on t.id_transporte = ct.id_transportes where p.estado_paquete = 'Enviado'
select * from paquete

create or replace function InsertInTables (
	cedula varchar(50), 
	nomC  varchar(50), 
	dicC varchar(50), 
	emailC varchar(50), 
	telC varchar(50), 
	idD int, 
	nomD varchar(50), 
	dirD varchar(50), 
	emailD varchar(50), 
	TelD varchar(50),
	idP int,
	idC int,
	desP varchar(50),
	uniP varchar(50),
	pesoP decimal(4,3),
	estadoP varchar(50)
) returns void as
$$
Begin
insert into clientes values (cedula, nomC, dicC, emailC, telC);
insert into destinatario values (idD, nomD, dirD, emailD, TelD);
insert into paquete values (idP,cedula, idC, idD, desP, uniP, pesoP, estadoP);
end;
$$
language 'plpgsql'

select * from paquete

create or replace function UpdateInTables (
	cedula varchar(50), 
	nomC  varchar(50), 
	dirC varchar(50), 
	emailC varchar(50), 
	telC varchar(50), 
	idD int, 
	nomD varchar(50), 
	dirD varchar(50), 
	emailD varchar(50), 
	telD varchar(50),
	idP int,
	idC int,
	desP varchar(50),
	uniP varchar(50),
	pesoP decimal(4,3),
	estadoP varchar(50)
) returns void as
$$
Begin
update clientes set nom_cliente = nomC,dir_cliente=dirC,email_cliente = emailC, telefono_cliente =telC where id_cliente = cedula;
update destinatario set nom_destinatario = nomD, dir_destinatario = dirD,email_destinatario = emailD, telefono_destinatario = telD where id_destinatario =idD;
update paquete set fk_id_conductor= idC,descripcion_paquete = desP, unidad_medida = uniP,peso_producto = pesoP,estado_paquete = estadoP where id_paquete =idP;
end;
$$
language 'plpgsql'

select updateintables('1752035343', 'kenneth')
select * from paquete

DROP FUNCTION updateintables

select id_cliente, nom_cliente, dir_cliente, email_cliente, telefono_cliente, 
id_destinatario, nom_destinatario, dir_destinatario, email_destinatario, telefono_destinatario,
id_paquete,descripcion_paquete, unidad_medida,peso_producto, estado_paquete, id_conductor 
from clientes as cl  inner join paquete as p on p.fk_id_cliente = cl.id_cliente
inner join conductores as c on p.fk_id_conductor = c.id_conductor
inner join destinatario as d on p.fk_id_destinatario = d.id_destinatario
inner join conductores_transportes as ct on ct.id_conductores = c.id_conductor 
inner join transportes as t on t.id_transporte = ct.id_transportes where p.id_paquete


alter table paquete rename column id_conductor to fk_id_conductor
alter table paquete rename column id_destinatario to fk_id_destinatario
alter table paquete rename column cedula_cliente to fk_id_cliente

select * from paquete

insert into clientes values ('1752034567', 'Yolito', 'Argelia', 'yolito@gmail.com', '0992723491')

update clientes set nom_cliente = 'Yerald', dir_cliente='Peru' where id_cliente = '1752034567'

delete from paquete where id_paquete = 2

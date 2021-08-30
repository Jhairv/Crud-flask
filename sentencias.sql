create table clientes (
	cedula_cliente varchar(50) primary key not null,
	nom_cliente varchar(50) not null,
	dir_cliente varchar (50) not null,
	email_cliente varchar(50) not null,
	telefono_cliente varchar (10) not null
)

create table destinatario (
	id_destinatario int primary key not null,
	nom_destinatario varchar(50) not null,
	dir_destinatario varchar (50) not null,
	email_destinatario varchar (50) not null,
	telefono_destinatario varchar (11) not null
)

create table Paquete (
	id_paquete int primary key not null,
	cedula_cliente varchar(50) not null,
	id_conductor int not null,
	id_destinatario int not null,
	descripcion_paquete varchar(50) not null,
	unidad_medida varchar(25) not null,
	peso_producto decimal(4,2) not null,
	estado_paquete varchar(20) not null,
	constraint fk_cliente
	foreign key(cedula_cliente)
	references clientes(cedula_cliente),
	constraint fk_destinatario
	foreign key(id_destinatario)
	references destinatario(id_destinatario),
	constraint fk_conductor
	foreign key(id_conductor)
	references conductores(id_conductor)
)


create table transportes (
	id_transporte int primary key not null,
	marca_vehiculo varchar (50) not null,
	capacidad_carga int not null
)

create table conductores (
	id_conductor int primary key not null,
	nom_conductor varchar(50) not null,
	tipo_licencia varchar(50) not null,
	num_licencia varchar(50) not null
)

create table conductores_transportes (
	id_conductores_transportes int primary key not null,
	id_conductores int not null,
	id_transportes int not null,
	placa_transporte varchar(20) not null,
	constraint fk_condcutores
	foreign key(id_conductores)
	references conductores(id_conductor),
	constraint fk_transportes
	foreign key(id_transportes)
	references transportes(id_transporte)
)


insert into transportes values (1,'Volvo',7000)
insert into transportes values (2, 'Mercedes', 7000)
insert into transportes values (3, 'Man', 7000)
insert into transportes values (4, 'Chevrolet', 7000)
insert into transportes values (5, 'Mazda', 7000)

select * from conductores
alter table conductores add column estado varchar(50) not null
insert into conductores values (1,'Kenneth Ibadango','E','0349382793', 'Disponible')
insert into conductores values (2,'Jeremy Ramos','E','0349382793', 'Disponible')
insert into conductores values (3,'Renzo Vascones','E','0349382793', 'Disponible')
insert into conductores values (4,'Alexander Flores','E','0349382793', 'Disponible')
insert into conductores values (5,'Israel Restrepo','E','0349382793', 'Disponible')

select * from conductores_transportes
insert into conductores_transportes values (1, 1, 3, 'PVZ-808')
insert into conductores_transportes values (2, 2, 4, 'PDC-456')
insert into conductores_transportes values (3, 3, 5, 'PGH-874')
insert into conductores_transportes values (4, 4, 1, 'PGC-798')
insert into conductores_transportes values (5, 5, 2, 'PFC-353')


select * from conductores_transportes

insert into conductores_transportes values (5, 5, 2, 'GST-6894')

select  nom_conductor, marca_vehiculo, placa_transporte, estado from conductores inner join conductores_transportes on id_conductor = id_conductores
inner join transportes on id_transportes = id_transporte

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
select InsertIntables (
	'1714417753', 
	'Lidia Galarza', '
	Chillogallo', 
	'lg@gmail.com', 
	'0998276423',
	1,
	'Renzo Vasquez',
	'Machachi',
	'rv@gmail.com',
	'0973897849',
	1,
	2,
	'Telefono',
	'Kg',
	4.5,
	'Registrado'
)
drop function InsertIntables
select * from destinatario
select * from clientes
select * from Paquete
select * from conductores
select * from transportes
select * from conductores_transportes
select id_paquete, descripcion_paquete, nom_cliente, nom_destinatario, 
dir_destinatario, nom_conductor, marca_vehiculo, placa_transporte 
from paquete as p inner join clientes as cl on p.cedula_cliente = cl.cedula_cliente
inner join conductores as c on p.id_conductor = c.id_conductor
inner join destinatario as d on p.id_destinatario = d.id_destinatario
inner join conductores_transportes as ct on ct.id_conductores = c.id_conductor 
inner join transportes as t on t.id_transporte = ct.id_transportes






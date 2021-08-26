-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.7.2
-- PostgreSQL version: 9.4
-- Project Site: pgmodeler.com.br
-- Model Author: ---

SET check_function_bodies = false;
-- ddl-end --


-- Database creation must be done outside an multicommand file.
-- These commands were put in this file only for convenience.
-- -- object: new_database | type: DATABASE --
-- -- DROP DATABASE new_database;
-- CREATE DATABASE new_database
-- ;
-- -- ddl-end --
-- 

-- object: public."Transportes" | type: TABLE --
-- DROP TABLE public."Transportes";
CREATE TABLE public."Transportes"(
	id_vehiculo integer NOT NULL,
	marca_vehiculo character varying(25) NOT NULL,
	capacidad_vehiculo integer NOT NULL,
	"color_vehículo" character varying(25) NOT NULL,
	CONSTRAINT id_transporte PRIMARY KEY (id_vehiculo)

);
-- ddl-end --
-- object: public."Conductores" | type: TABLE --
-- DROP TABLE public."Conductores";
CREATE TABLE public."Conductores"(
	id_conductor integer NOT NULL,
	nom_conductor character varying(50) NOT NULL,
	tipo_licencia character varying(15) NOT NULL,
	num_licencia_conductor character varying(10) NOT NULL,
	CONSTRAINT id_conductor PRIMARY KEY (id_conductor)

);
-- ddl-end --
-- object: public."Paquete" | type: TABLE --
-- DROP TABLE public."Paquete";
CREATE TABLE public."Paquete"(
	id_paquete integer NOT NULL,
	cedula_cliente character varying(10) NOT NULL,
	id_conductor integer NOT NULL,
	id_destinatario integer NOT NULL,
	descripcion_productos character varying(50) NOT NULL,
	unidad_medida_producto character varying(25) NOT NULL,
	peso_producto decimal(4,2) NOT NULL,
	estado_paquete character varying(20) NOT NULL,
	CONSTRAINT id_paquete PRIMARY KEY (id_paquete)

);
-- ddl-end --
-- object: public.conductores_transportes | type: TABLE --
-- DROP TABLE public.conductores_transportes;
CREATE TABLE public.conductores_transportes(
	id_conductores_transportes integer NOT NULL,
	id_conductores integer NOT NULL,
	id_transportes integer NOT NULL,
	placa_transporte character varying(20) NOT NULL,
	capacidad_carga decimal(2,2) NOT NULL,
	CONSTRAINT id_conductores_transportes PRIMARY KEY (id_conductores_transportes)

);
-- ddl-end --
-- object: public."Clientes" | type: TABLE --
-- DROP TABLE public."Clientes";
CREATE TABLE public."Clientes"(
	cedula_cliente character varying(10) NOT NULL,
	"Nom_cliente" character varying(50) NOT NULL,
	dir_cliente character varying NOT NULL,
	email_cliente character varying(50) NOT NULL,
	telefono_cliente character varying(10) NOT NULL,
	CONSTRAINT id_cliente PRIMARY KEY (cedula_cliente)

);
-- ddl-end --
-- object: public."Destinatario" | type: TABLE --
-- DROP TABLE public."Destinatario";
CREATE TABLE public."Destinatario"(
	id_destinatario integer NOT NULL,
	"Nom_destinatario" character varying(50) NOT NULL,
	dir_destinatario character varying NOT NULL,
	email_destinatario character varying(50) NOT NULL,
	telefono_destinatario character varying(10) NOT NULL,
	CONSTRAINT id_destinatario PRIMARY KEY (id_destinatario)

);
-- ddl-end --
-- object: conductor_paquete | type: CONSTRAINT --
-- ALTER TABLE public."Paquete" DROP CONSTRAINT conductor_paquete;
ALTER TABLE public."Paquete" ADD CONSTRAINT conductor_paquete FOREIGN KEY (id_conductor)
REFERENCES public."Conductores" (id_conductor) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: destinatario_paquete | type: CONSTRAINT --
-- ALTER TABLE public."Paquete" DROP CONSTRAINT destinatario_paquete;
ALTER TABLE public."Paquete" ADD CONSTRAINT destinatario_paquete FOREIGN KEY (id_destinatario)
REFERENCES public."Destinatario" (id_destinatario) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: cliente_paquete | type: CONSTRAINT --
-- ALTER TABLE public."Paquete" DROP CONSTRAINT cliente_paquete;
ALTER TABLE public."Paquete" ADD CONSTRAINT cliente_paquete FOREIGN KEY (cedula_cliente)
REFERENCES public."Clientes" (cedula_cliente) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: conductores_transportes_conductores | type: CONSTRAINT --
-- ALTER TABLE public.conductores_transportes DROP CONSTRAINT conductores_transportes_conductores;
ALTER TABLE public.conductores_transportes ADD CONSTRAINT conductores_transportes_conductores FOREIGN KEY (id_conductores)
REFERENCES public."Conductores" (id_conductor) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: transportes_transportes_conductores | type: CONSTRAINT --
-- ALTER TABLE public.conductores_transportes DROP CONSTRAINT transportes_transportes_conductores;
ALTER TABLE public.conductores_transportes ADD CONSTRAINT transportes_transportes_conductores FOREIGN KEY (id_transportes)
REFERENCES public."Transportes" (id_vehiculo) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --




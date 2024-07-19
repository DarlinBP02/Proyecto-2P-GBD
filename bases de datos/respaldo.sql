--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12
-- Dumped by pg_dump version 14.12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: adquisicion_libro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adquisicion_libro (
    adqui_code integer NOT NULL,
    libro_code integer NOT NULL,
    prov_code integer NOT NULL,
    adqui_fecha date NOT NULL,
    adqui_costo numeric(11,2) NOT NULL
);


ALTER TABLE public.adquisicion_libro OWNER TO postgres;

--
-- Name: autor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autor (
    autorcode integer NOT NULL,
    autor_nombres character varying(50) NOT NULL,
    autor_apellidos character varying(50) NOT NULL,
    ciudad character varying(50),
    pais character varying(50)
);


ALTER TABLE public.autor OWNER TO postgres;

--
-- Name: biblioteca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.biblioteca (
    biblioteca_code integer NOT NULL,
    ciudad_code integer NOT NULL,
    blibloteca_name character varying(50) NOT NULL,
    bdireccion character varying(100) NOT NULL
);


ALTER TABLE public.biblioteca OWNER TO postgres;

--
-- Name: bibliotecario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bibliotecario (
    bibli_code integer NOT NULL,
    biblioteca_code integer NOT NULL,
    bibli_nombre character varying(50) NOT NULL,
    bibli_apellido character varying(50) NOT NULL,
    bibli_direccion character varying(100) NOT NULL,
    bibli_jornada character varying(50) NOT NULL,
    bibli_telefono character varying(20) NOT NULL
);


ALTER TABLE public.bibliotecario OWNER TO postgres;

--
-- Name: centroestudio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.centroestudio (
    cenestu_code integer NOT NULL,
    cenestu_nombre character varying(50) NOT NULL,
    cenestu_direccion character varying(100) NOT NULL,
    cenestu_telef character varying(20)
);


ALTER TABLE public.centroestudio OWNER TO postgres;

--
-- Name: ciudad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ciudad (
    ciudad_code integer NOT NULL,
    ciudad_nombre character varying(50) NOT NULL
);


ALTER TABLE public.ciudad OWNER TO postgres;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    cliente_code integer NOT NULL,
    cenestu_code integer NOT NULL,
    ciudad_code integer NOT NULL,
    cliente_cedula character varying(50) NOT NULL,
    cliente_nombres character varying(50) NOT NULL,
    cliente_apellidos character varying(50) NOT NULL,
    cliente_telef character varying(20) NOT NULL,
    cliente_direccion character varying(100) NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- Name: detalleventa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalleventa (
    dventa_code integer NOT NULL,
    venta_code integer NOT NULL,
    libro_code integer NOT NULL,
    cantidad integer NOT NULL,
    precio numeric(11,2) NOT NULL
);


ALTER TABLE public.detalleventa OWNER TO postgres;

--
-- Name: edicion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edicion (
    edicion_code integer NOT NULL,
    editorial_code integer NOT NULL,
    edicion character varying(100)
);


ALTER TABLE public.edicion OWNER TO postgres;

--
-- Name: editorial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.editorial (
    editorial_code integer NOT NULL,
    editorial_nombre character varying(50) NOT NULL
);


ALTER TABLE public.editorial OWNER TO postgres;

--
-- Name: estadoprestamo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadoprestamo (
    estado_code integer NOT NULL,
    estado character varying(50)
);


ALTER TABLE public.estadoprestamo OWNER TO postgres;

--
-- Name: genero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genero (
    genero_code smallint NOT NULL,
    genero_nombre character varying(20) NOT NULL
);


ALTER TABLE public.genero OWNER TO postgres;

--
-- Name: libro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.libro (
    libro_code integer NOT NULL,
    genero_code smallint NOT NULL,
    editorial_code integer NOT NULL,
    biblioteca_code integer NOT NULL,
    edicion_code integer NOT NULL,
    isbn character varying(15) NOT NULL,
    libro_nombre character varying(50) NOT NULL,
    libro_fecha_publi date NOT NULL,
    libro_descrip character varying(100) NOT NULL,
    versiondigital character varying(50)
);


ALTER TABLE public.libro OWNER TO postgres;

--
-- Name: libro_autor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.libro_autor (
    libaut integer NOT NULL,
    libro_code integer NOT NULL,
    autorcode integer NOT NULL
);


ALTER TABLE public.libro_autor OWNER TO postgres;

--
-- Name: multas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.multas (
    multa_code integer NOT NULL,
    prestamo_code integer NOT NULL,
    multa_descripcion character varying(200) NOT NULL,
    multa_valor numeric(11,2),
    multa_fecha date
);


ALTER TABLE public.multas OWNER TO postgres;

--
-- Name: prestamo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prestamo (
    prestamo_code integer NOT NULL,
    cliente_code integer NOT NULL,
    libro_code integer NOT NULL,
    bibli_code integer NOT NULL,
    estado_code integer NOT NULL,
    fecha_prestamo date NOT NULL,
    fecha_max_devolucion date NOT NULL,
    fecha_real_devolucion date,
    precio_prestamo numeric(11,2) NOT NULL
);


ALTER TABLE public.prestamo OWNER TO postgres;

--
-- Name: proveedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proveedor (
    prov_code integer NOT NULL,
    prov_nombre character varying(50) NOT NULL,
    prov_direccion character varying(100),
    prov_telefono character varying(50),
    prov_email character varying(100)
);


ALTER TABLE public.proveedor OWNER TO postgres;

--
-- Name: venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venta (
    venta_code integer NOT NULL,
    bibli_code integer NOT NULL,
    venta_fecha date NOT NULL
);


ALTER TABLE public.venta OWNER TO postgres;

--
-- Data for Name: adquisicion_libro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.adquisicion_libro (adqui_code, libro_code, prov_code, adqui_fecha, adqui_costo) FROM stdin;
1	101	1	2023-01-01	50.00
2	102	2	2023-02-01	60.00
3	103	3	2023-03-01	70.00
\.


--
-- Data for Name: autor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.autor (autorcode, autor_nombres, autor_apellidos, ciudad, pais) FROM stdin;
1	Autor Nombre A	Autor Apellido A	Ciudad A	País A
2	Autor Nombre B	Autor Apellido B	Ciudad B	País B
3	Autor Nombre C	Autor Apellido C	Ciudad C	País C
\.


--
-- Data for Name: biblioteca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.biblioteca (biblioteca_code, ciudad_code, blibloteca_name, bdireccion) FROM stdin;
1	1	Biblioteca Central	Calle Principal 123
2	2	Biblioteca Norte	Avenida Norte 456
3	3	Biblioteca Sur	Calle Sur 789
\.


--
-- Data for Name: bibliotecario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bibliotecario (bibli_code, biblioteca_code, bibli_nombre, bibli_apellido, bibli_direccion, bibli_jornada, bibli_telefono) FROM stdin;
1	1	Bibliotecario Nombre A	Bibliotecario Apellido A	Dirección A	Mañana	1234567890
2	2	Bibliotecario Nombre B	Bibliotecario Apellido B	Dirección B	Tarde	0987654321
3	3	Bibliotecario Nombre C	Bibliotecario Apellido C	Dirección C	Noche	1122334455
\.


--
-- Data for Name: centroestudio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.centroestudio (cenestu_code, cenestu_nombre, cenestu_direccion, cenestu_telef) FROM stdin;
1	Centro de Estudio A	Dirección A	1234567890
2	Centro de Estudio B	Dirección B	0987654321
3	Centro de Estudio C	Dirección C	1122334455
\.


--
-- Data for Name: ciudad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ciudad (ciudad_code, ciudad_nombre) FROM stdin;
1	Ciudad A
2	Ciudad B
3	Ciudad C
\.


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (cliente_code, cenestu_code, ciudad_code, cliente_cedula, cliente_nombres, cliente_apellidos, cliente_telef, cliente_direccion) FROM stdin;
1	1	1	0000000001	Cliente Nombre A	Cliente Apellido A	1234567890	Dirección Cliente A
2	2	2	0000000002	Cliente Nombre B	Cliente Apellido B	0987654321	Dirección Cliente B
3	3	3	0000000003	Cliente Nombre C	Cliente Apellido C	1122334455	Dirección Cliente C
\.


--
-- Data for Name: detalleventa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalleventa (dventa_code, venta_code, libro_code, cantidad, precio) FROM stdin;
1	1	101	2	20.00
2	2	102	1	25.00
3	3	103	3	30.00
\.


--
-- Data for Name: edicion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.edicion (edicion_code, editorial_code, edicion) FROM stdin;
1	1	Primera Edición
2	2	Segunda Edición
3	3	Tercera Edición
\.


--
-- Data for Name: editorial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.editorial (editorial_code, editorial_nombre) FROM stdin;
1	Editorial Alfa
2	Editorial Beta
3	Editorial Gamma
\.


--
-- Data for Name: estadoprestamo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadoprestamo (estado_code, estado) FROM stdin;
1	Prestado
2	Devuelto
3	Retrasado
\.


--
-- Data for Name: genero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genero (genero_code, genero_nombre) FROM stdin;
1	Ficción
2	No Ficción
3	Misterio
\.


--
-- Data for Name: libro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.libro (libro_code, genero_code, editorial_code, biblioteca_code, edicion_code, isbn, libro_nombre, libro_fecha_publi, libro_descrip, versiondigital) FROM stdin;
101	1	1	1	1	978-3-16-148410	Libro A	2022-01-01	Descripción del Libro A	Versión Digital A
102	2	2	2	2	978-1-23-456789	Libro B	2022-02-01	Descripción del Libro B	Versión Digital B
103	3	3	3	3	978-0-12-345678	Libro C	2022-03-01	Descripción del Libro C	Versión Digital C
\.


--
-- Data for Name: libro_autor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.libro_autor (libaut, libro_code, autorcode) FROM stdin;
1	101	1
2	102	2
3	103	3
\.


--
-- Data for Name: multas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.multas (multa_code, prestamo_code, multa_descripcion, multa_valor, multa_fecha) FROM stdin;
1	1	Multa por retraso	2.00	2023-04-15
2	2	Multa por daño	5.00	2023-05-15
3	3	Multa por pérdida	10.00	2023-06-15
\.


--
-- Data for Name: prestamo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prestamo (prestamo_code, cliente_code, libro_code, bibli_code, estado_code, fecha_prestamo, fecha_max_devolucion, fecha_real_devolucion, precio_prestamo) FROM stdin;
1	1	101	1	1	2023-04-01	2023-04-10	\N	5.00
2	2	102	2	2	2023-05-01	2023-05-10	2023-05-09	5.00
3	3	103	3	3	2023-06-01	2023-06-10	\N	5.00
\.


--
-- Data for Name: proveedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proveedor (prov_code, prov_nombre, prov_direccion, prov_telefono, prov_email) FROM stdin;
1	Proveedor A	Dirección Proveedor A	123456789	proveedorA@example.com
2	Proveedor B	Dirección Proveedor B	987654321	proveedorB@example.com
3	Proveedor C	Dirección Proveedor C	456789123	proveedorC@example.com
\.


--
-- Data for Name: venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venta (venta_code, bibli_code, venta_fecha) FROM stdin;
1	1	2023-01-01
2	2	2023-02-01
3	3	2023-03-01
\.


--
-- Name: adquisicion_libro pk_adquisicion_libro; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adquisicion_libro
    ADD CONSTRAINT pk_adquisicion_libro PRIMARY KEY (adqui_code);


--
-- Name: autor pk_autor; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autor
    ADD CONSTRAINT pk_autor PRIMARY KEY (autorcode);


--
-- Name: biblioteca pk_biblioteca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.biblioteca
    ADD CONSTRAINT pk_biblioteca PRIMARY KEY (biblioteca_code);


--
-- Name: bibliotecario pk_bibliotecario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bibliotecario
    ADD CONSTRAINT pk_bibliotecario PRIMARY KEY (bibli_code);


--
-- Name: centroestudio pk_centroestudio; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.centroestudio
    ADD CONSTRAINT pk_centroestudio PRIMARY KEY (cenestu_code);


--
-- Name: ciudad pk_ciudad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT pk_ciudad PRIMARY KEY (ciudad_code);


--
-- Name: cliente pk_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT pk_cliente PRIMARY KEY (cliente_code);


--
-- Name: detalleventa pk_detalleventa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalleventa
    ADD CONSTRAINT pk_detalleventa PRIMARY KEY (dventa_code);


--
-- Name: edicion pk_edicion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edicion
    ADD CONSTRAINT pk_edicion PRIMARY KEY (edicion_code);


--
-- Name: editorial pk_editorial; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editorial
    ADD CONSTRAINT pk_editorial PRIMARY KEY (editorial_code);


--
-- Name: estadoprestamo pk_estadoprestamo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadoprestamo
    ADD CONSTRAINT pk_estadoprestamo PRIMARY KEY (estado_code);


--
-- Name: genero pk_genero; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero
    ADD CONSTRAINT pk_genero PRIMARY KEY (genero_code);


--
-- Name: libro pk_libro; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro
    ADD CONSTRAINT pk_libro PRIMARY KEY (libro_code);


--
-- Name: libro_autor pk_libro_autor; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro_autor
    ADD CONSTRAINT pk_libro_autor PRIMARY KEY (libaut);


--
-- Name: multas pk_multas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.multas
    ADD CONSTRAINT pk_multas PRIMARY KEY (multa_code);


--
-- Name: prestamo pk_prestamo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT pk_prestamo PRIMARY KEY (prestamo_code);


--
-- Name: proveedor pk_proveedor; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT pk_proveedor PRIMARY KEY (prov_code);


--
-- Name: venta pk_venta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT pk_venta PRIMARY KEY (venta_code);


--
-- Name: adquisicion_libro_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX adquisicion_libro_pk ON public.adquisicion_libro USING btree (adqui_code);


--
-- Name: autor_libroautor_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX autor_libroautor_fk ON public.libro_autor USING btree (autorcode);


--
-- Name: autor_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX autor_pk ON public.autor USING btree (autorcode);


--
-- Name: biblioteca_bibliotecario_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX biblioteca_bibliotecario_fk ON public.bibliotecario USING btree (biblioteca_code);


--
-- Name: biblioteca_libro_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX biblioteca_libro_fk ON public.libro USING btree (biblioteca_code);


--
-- Name: biblioteca_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX biblioteca_pk ON public.biblioteca USING btree (biblioteca_code);


--
-- Name: bibliotecario_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX bibliotecario_pk ON public.bibliotecario USING btree (bibli_code);


--
-- Name: bibliotecario_prestamo_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX bibliotecario_prestamo_fk ON public.prestamo USING btree (bibli_code);


--
-- Name: bibliotecario_venta_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX bibliotecario_venta_fk ON public.venta USING btree (bibli_code);


--
-- Name: centroe_cliente_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX centroe_cliente_fk ON public.cliente USING btree (cenestu_code);


--
-- Name: centroestudio_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX centroestudio_pk ON public.centroestudio USING btree (cenestu_code);


--
-- Name: ciudad_biblioteca_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ciudad_biblioteca_fk ON public.biblioteca USING btree (ciudad_code);


--
-- Name: ciudad_cliente_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ciudad_cliente_fk ON public.cliente USING btree (ciudad_code);


--
-- Name: ciudad_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ciudad_pk ON public.ciudad USING btree (ciudad_code);


--
-- Name: cliente_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cliente_pk ON public.cliente USING btree (cliente_code);


--
-- Name: cliente_prestamo_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cliente_prestamo_fk ON public.prestamo USING btree (cliente_code);


--
-- Name: detalleventa_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX detalleventa_pk ON public.detalleventa USING btree (dventa_code);


--
-- Name: edicion_libro_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX edicion_libro_fk ON public.libro USING btree (edicion_code);


--
-- Name: edicion_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX edicion_pk ON public.edicion USING btree (edicion_code);


--
-- Name: editorial_edicion_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX editorial_edicion_fk ON public.edicion USING btree (editorial_code);


--
-- Name: editorial_libro_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX editorial_libro_fk ON public.libro USING btree (editorial_code);


--
-- Name: editorial_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX editorial_pk ON public.editorial USING btree (editorial_code);


--
-- Name: estadopre_prestamo_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX estadopre_prestamo_fk ON public.prestamo USING btree (estado_code);


--
-- Name: estadoprestamo_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX estadoprestamo_pk ON public.estadoprestamo USING btree (estado_code);


--
-- Name: genero_libro_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX genero_libro_fk ON public.libro USING btree (genero_code);


--
-- Name: genero_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX genero_pk ON public.genero USING btree (genero_code);


--
-- Name: libro_adquisicionl_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libro_adquisicionl_fk ON public.adquisicion_libro USING btree (libro_code);


--
-- Name: libro_autor_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX libro_autor_pk ON public.libro_autor USING btree (libaut);


--
-- Name: libro_detalleventa_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libro_detalleventa_fk ON public.detalleventa USING btree (libro_code);


--
-- Name: libro_libroautor_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libro_libroautor_fk ON public.libro_autor USING btree (libro_code);


--
-- Name: libro_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX libro_pk ON public.libro USING btree (libro_code);


--
-- Name: libro_prestamo_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libro_prestamo_fk ON public.prestamo USING btree (libro_code);


--
-- Name: multas_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX multas_pk ON public.multas USING btree (multa_code);


--
-- Name: prestamo_multa_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX prestamo_multa_fk ON public.multas USING btree (prestamo_code);


--
-- Name: prestamo_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX prestamo_pk ON public.prestamo USING btree (prestamo_code);


--
-- Name: proveedor_adquisicionl_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX proveedor_adquisicionl_fk ON public.adquisicion_libro USING btree (prov_code);


--
-- Name: proveedor_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX proveedor_pk ON public.proveedor USING btree (prov_code);


--
-- Name: venta_detalleventa_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX venta_detalleventa_fk ON public.detalleventa USING btree (venta_code);


--
-- Name: venta_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX venta_pk ON public.venta USING btree (venta_code);


--
-- Name: adquisicion_libro fk_adquisic_libro_adq_libro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adquisicion_libro
    ADD CONSTRAINT fk_adquisic_libro_adq_libro FOREIGN KEY (libro_code) REFERENCES public.libro(libro_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: adquisicion_libro fk_adquisic_proveedor_proveedo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adquisicion_libro
    ADD CONSTRAINT fk_adquisic_proveedor_proveedo FOREIGN KEY (prov_code) REFERENCES public.proveedor(prov_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: bibliotecario fk_bibliote_bibliotec_bibliote; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bibliotecario
    ADD CONSTRAINT fk_bibliote_bibliotec_bibliote FOREIGN KEY (biblioteca_code) REFERENCES public.biblioteca(biblioteca_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: biblioteca fk_bibliote_ciudad_bi_ciudad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.biblioteca
    ADD CONSTRAINT fk_bibliote_ciudad_bi_ciudad FOREIGN KEY (ciudad_code) REFERENCES public.ciudad(ciudad_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: cliente fk_cliente_centroe_c_centroes; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cliente_centroe_c_centroes FOREIGN KEY (cenestu_code) REFERENCES public.centroestudio(cenestu_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: cliente fk_cliente_ciudad_cl_ciudad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cliente_ciudad_cl_ciudad FOREIGN KEY (ciudad_code) REFERENCES public.ciudad(ciudad_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: detalleventa fk_detallev_libro_det_libro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalleventa
    ADD CONSTRAINT fk_detallev_libro_det_libro FOREIGN KEY (libro_code) REFERENCES public.libro(libro_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: detalleventa fk_detallev_venta_det_venta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalleventa
    ADD CONSTRAINT fk_detallev_venta_det_venta FOREIGN KEY (venta_code) REFERENCES public.venta(venta_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: edicion fk_edicion_editorial_editoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edicion
    ADD CONSTRAINT fk_edicion_editorial_editoria FOREIGN KEY (editorial_code) REFERENCES public.editorial(editorial_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: libro_autor fk_libro_au_autor_lib_autor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro_autor
    ADD CONSTRAINT fk_libro_au_autor_lib_autor FOREIGN KEY (autorcode) REFERENCES public.autor(autorcode) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: libro_autor fk_libro_au_libro_lib_libro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro_autor
    ADD CONSTRAINT fk_libro_au_libro_lib_libro FOREIGN KEY (libro_code) REFERENCES public.libro(libro_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: libro fk_libro_bibliotec_bibliote; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro
    ADD CONSTRAINT fk_libro_bibliotec_bibliote FOREIGN KEY (biblioteca_code) REFERENCES public.biblioteca(biblioteca_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: libro fk_libro_edicion_l_edicion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro
    ADD CONSTRAINT fk_libro_edicion_l_edicion FOREIGN KEY (edicion_code) REFERENCES public.edicion(edicion_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: libro fk_libro_editorial_editoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro
    ADD CONSTRAINT fk_libro_editorial_editoria FOREIGN KEY (editorial_code) REFERENCES public.editorial(editorial_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: libro fk_libro_genero_li_genero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro
    ADD CONSTRAINT fk_libro_genero_li_genero FOREIGN KEY (genero_code) REFERENCES public.genero(genero_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: multas fk_multas_prestamo__prestamo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.multas
    ADD CONSTRAINT fk_multas_prestamo__prestamo FOREIGN KEY (prestamo_code) REFERENCES public.prestamo(prestamo_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: prestamo fk_prestamo_bibliotec_bibliote; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT fk_prestamo_bibliotec_bibliote FOREIGN KEY (bibli_code) REFERENCES public.bibliotecario(bibli_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: prestamo fk_prestamo_cliente_p_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT fk_prestamo_cliente_p_cliente FOREIGN KEY (cliente_code) REFERENCES public.cliente(cliente_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: prestamo fk_prestamo_estadopre_estadopr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT fk_prestamo_estadopre_estadopr FOREIGN KEY (estado_code) REFERENCES public.estadoprestamo(estado_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: prestamo fk_prestamo_libro_pre_libro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT fk_prestamo_libro_pre_libro FOREIGN KEY (libro_code) REFERENCES public.libro(libro_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: venta fk_venta_bibliotec_bibliote; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_bibliotec_bibliote FOREIGN KEY (bibli_code) REFERENCES public.bibliotecario(bibli_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--


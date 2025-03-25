DROP TABLE asesoria CASCADE CONSTRAINTS;
DROP TABLE empresa CASCADE CONSTRAINTS;
DROP TABLE empleado CASCADE CONSTRAINTS;
DROP TABLE sector CASCADE CONSTRAINTS;
DROP TABLE comuna CASCADE CONSTRAINTS;
DROP TABLE profesion CASCADE CONSTRAINTS;
DROP TABLE afp CASCADE CONSTRAINTS;
DROP TABLE isapre CASCADE CONSTRAINTS;
DROP TABLE porc_metas CASCADE CONSTRAINTS;
DROP TABLE remuneracion CASCADE CONSTRAINTS;

--------------------------------------------------------
--  DDL for Table AFP
--------------------------------------------------------
CREATE TABLE afp (
  idafp NUMBER(1,0) NOT NULL,
  nomafp VARCHAR2(20) NOT NULL,
  porc NUMBER(5,2) NOT NULL,
  CONSTRAINT pk_afp PRIMARY KEY (idafp)
);
--------------------------------------------------------
--  DDL for Table ASESORIA
--------------------------------------------------------

CREATE TABLE asesoria (
  rutemp VARCHAR2(10) NOT NULL,
  idempresa NUMBER NOT NULL,  
  inicio DATE NOT NULL, 
  fin DATE NOT NULL,
  CONSTRAINT pk_asesoria PRIMARY KEY (rutemp, idempresa)
);
--------------------------------------------------------
--  DDL for Table COMUNA
--------------------------------------------------------

CREATE TABLE comuna (
  codcomuna NUMBER NOT NULL, 
  nomcomuna VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_comuna PRIMARY KEY (codcomuna)
);
--------------------------------------------------------
--  DDL for Table EMPRESA
--------------------------------------------------------

CREATE TABLE empresa (
  idempresa NUMBER NOT NULL, 
  codcomuna NUMBER NOT NULL, 
  codsector NUMBER NOT NULL, 
  nomempresa VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_empresa PRIMARY KEY (idempresa)
);

--------------------------------------------------------
--  DDL for Table ISAPRE
--------------------------------------------------------

CREATE TABLE isapre (
  idisapre NUMBER(1,0) NOT NULL, 
  nomisapre VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_isapre PRIMARY KEY (idisapre)
);

--------------------------------------------------------
--  DDL for Table PROFESION
--------------------------------------------------------

CREATE TABLE profesion (
  idprofesion NUMBER NOT NULL, 
  nomprofesion VARCHAR2(25) NOT NULL, 
  asignacion NUMBER(5,2) NOT NULL,
  CONSTRAINT pk_profesion PRIMARY KEY (idprofesion)
);

--------------------------------------------------------
--  DDL for Table PROFESIONAL
--------------------------------------------------------

CREATE TABLE empleado (
  rutemp VARCHAR2(10) NOT NULL, 
  idemp NUMBER NOT NULL,
  codcomuna NUMBER, 
  idprofesion NUMBER, 
  appemp VARCHAR2(15) NOT NULL, 
  apmemp VARCHAR2(15) NOT NULL, 
  nomemp VARCHAR2(20) NOT NULL, 
  ecivper VARCHAR2(15) NOT NULL
  CONSTRAINT ckc_ecivper_emp CHECK (ecivper IN ('Soltero','Casado','Divorciado','Viudo')), 
  sueldo_base NUMBER(8) NOT NULL, 
  idafp NUMBER(1,0) NOT NULL, 
  idisapre NUMBER(1,0) NOT NULL,
  CONSTRAINT pk_emp PRIMARY KEY (rutemp)
);
--------------------------------------------------------
--  DDL for Table SECTOR
--------------------------------------------------------

CREATE TABLE sector (
  codsector NUMBER NOT NULL, 
  nomsector VARCHAR2(20) NOT NULL,
  porsector NUMBER(3) NOT NULL,
  CONSTRAINT pk_sector PRIMARY KEY (codsector)
);

--------------------------------------------------------
--  DDL for Table PORC_METAS
--------------------------------------------------------

CREATE TABLE porc_metas (
  cod_porc_metas NUMBER(3) NOT NULL, 
  cant_inf NUMBER(3) NOT NULL,
  cant_sup NUMBER(3) NOT NULL,
  porc_bonif_metas NUMBER(3) NOT NULL,
  CONSTRAINT pk_porc_metas PRIMARY KEY (cod_porc_metas)
);

--------------------------------------------------------
--  DDL for Table REMUNERACION
--------------------------------------------------------

CREATE TABLE remuneracion (
  rutemp VARCHAR2(10) NOT NULL, 
  mes NUMBER(4) NOT NULL, 
  anno NUMBER(4) NOT NULL,
  sueldo_base NUMBER(10) NOT NULL, 
  bono_vacaciones NUMBER(8) NOT NULL,
  bono_metas NUMBER(8) NOT NULL,
  bono_colacion NUMBER(8) NOT NULL,
  bono_movilizacion NUMBER(8) NOT NULL,
  bono_profesion NUMBER(8) NOT NULL,
  bono_sector NUMBER(8) NOT NULL,
  afp NUMBER(8) NOT NULL,
  isapre NUMBER(8) NOT NULL,
  liquido_a_pagar NUMBER(8) NOT NULL, 
  CONSTRAINT remuneracion_pk PRIMARY KEY (rutemp, mes, anno)
);

ALTER TABLE empresa
   ADD CONSTRAINT fk_empresa_pertenece_sector FOREIGN KEY (codsector)
      REFERENCES sector (codsector);
      
ALTER TABLE empresa
   ADD CONSTRAINT fk_empresa_ubica_comuna FOREIGN KEY (codcomuna)
      REFERENCES comuna (codcomuna);

ALTER TABLE empleado
   ADD CONSTRAINT fk_empleado_vive_comuna FOREIGN KEY (codcomuna)
      REFERENCES comuna (codcomuna);

ALTER TABLE empleado
   ADD CONSTRAINT fk_empleado_profesion FOREIGN KEY (idprofesion)
      REFERENCES profesion (idprofesion);

ALTER TABLE empleado
   ADD CONSTRAINT fk_afp_empleado FOREIGN KEY (idafp)
      REFERENCES afp (idafp);

ALTER TABLE empleado
   ADD CONSTRAINT fk_isapre_empleado FOREIGN KEY (idisapre)
      REFERENCES isapre (idisapre);

ALTER TABLE asesoria
   ADD CONSTRAINT fk_asesoria_empleado FOREIGN KEY (rutemp)
      REFERENCES empleado (rutemp);

ALTER TABLE asesoria
   ADD CONSTRAINT fk_asesoria_empresa FOREIGN KEY (idempresa)
      REFERENCES empresa (idempresa);

ALTER TABLE remuneracion 
   ADD CONSTRAINT fk_remuneracion_empleado FOREIGN KEY (rutemp)
      REFERENCES empleado (rutemp);

INSERT INTO afp VALUES (1, 'CAPITAL', 11.44);
INSERT INTO afp VALUES (2, 'CUPRUM',	11.48);   
INSERT INTO afp VALUES (3, 'HABITAT',	11.27); 
INSERT INTO afp VALUES (4, 'MODELO',	10.77); 
INSERT INTO afp VALUES (5, 'PLANVITAL',	12.36);
INSERT INTO afp VALUES (6, 'PROVIDA',	11.54); 

INSERT INTO sector VALUES (1,'Comunicaciones',5);
INSERT INTO sector VALUES (2,'Servicios',7);
INSERT INTO sector VALUES (3,'Banca',9);
INSERT INTO sector VALUES (4,'Retail',10);

INSERT INTO comuna VALUES (80,'Las Condes');
INSERT INTO comuna VALUES (81,'Providencia');
INSERT INTO comuna VALUES (82,'Santiago');
INSERT INTO comuna VALUES (83,'Ñuñoa');
INSERT INTO comuna VALUES (84,'Vitacura');
INSERT INTO comuna VALUES (85,'La Reina');
INSERT INTO comuna VALUES (86,'La Florida');
INSERT INTO comuna VALUES (87,'Maipú');
INSERT INTO comuna VALUES (88,'Lo Barnechea');
INSERT INTO comuna VALUES (89,'Macul');
INSERT INTO comuna VALUES (90,'San Miguel');
INSERT INTO comuna VALUES (91,'Peñalolén');

INSERT INTO empresa VALUES (1,81,4,'Falabella');
INSERT INTO empresa VALUES (2,81,4,'Almacenes Paris');
INSERT INTO empresa VALUES (3,82,3,'Banco Santander');
INSERT INTO empresa VALUES (4,81,3,'Banco Estado');
INSERT INTO empresa VALUES (5,82,2,'Chilectra');
INSERT INTO empresa VALUES (6,82,2,'Aguas Andinas');
INSERT INTO empresa VALUES (7,81,2,'CGE');
INSERT INTO empresa VALUES (8,81,1,'Entel');
INSERT INTO empresa VALUES (9,81,1,'MaleStar');
INSERT INTO empresa VALUES (10,81,1,'Claro');
INSERT INTO empresa VALUES (11,82,4,'Ripley');

INSERT INTO isapre VALUES (1,'Masvida');
INSERT INTO isapre VALUES (2,'Vida Tres');
INSERT INTO isapre VALUES (3,'Banmédica');
INSERT INTO isapre VALUES (4,'Ferrosalud');
INSERT INTO isapre VALUES (5,'Colmena');
INSERT INTO isapre VALUES (6,'Consalud');
INSERT INTO isapre VALUES (7,'Cruz Blanca');

INSERT INTO profesion VALUES (1, 'Contador Auditor', 12.3);
INSERT INTO profesion VALUES (2, 'Contador', 8.0);
INSERT INTO profesion VALUES (3, 'Ingeniero Informático', 14.36);
INSERT INTO profesion VALUES (4, 'Ingeniero Prevencionista', 21.34);
INSERT INTO profesion VALUES (5, 'Ingeniero Comercial', 14.32);
INSERT INTO profesion VALUES (6, 'Ingeniero Industrial', 22.44);

INSERT INTO empleado VALUES ('60579696',1,89,4,'Perez','Marquez','Roberto','Soltero',550000,4,6);
INSERT INTO empleado VALUES ('69467678',2,83,2,'Weiss','Marquez','Mico','Soltero',1000000,5,1);
INSERT INTO empleado VALUES ('170676427',3,85,3,'Silva','carvallo','Herman','Viudo',340000,5,3);
INSERT INTO empleado VALUES ('206248954',4,80,1,'Leyton','Moran','Kleyton','Casado',200000,5,3);
INSERT INTO empleado VALUES ('206522999',5,81,2,'Borgui','Chor','Brando','Divorciado',400000,4,6);
INSERT INTO empleado VALUES ('207184768',6,82,3,'Sevallos','Landon','Lesly','Casado',600000,4,3);
INSERT INTO empleado VALUES ('208231386',7,83,4,'Moll','Darring','Nolan','Divorciado',800000,4,4);
INSERT INTO empleado VALUES ('208232220',8,84,5,'Moya','Warrior','Devora','Viudo',900000,4,2);
INSERT INTO empleado VALUES ('208993164',9,85,6,'Ramirez','Bolton','Wilson','Soltero',500000,5,2);
INSERT INTO empleado VALUES ('209300844',10,86,1,'Jerez','Townsend','Hector','Casado',300000,4,2);
INSERT INTO empleado VALUES ('210435832',11,87,2,'Toledo','Pug','Sharo','Divorciado',2600000,1,2);
INSERT INTO empleado VALUES ('210475308',12,88,3,'Barrera','Villegas','Regina','Soltero',1100000,3,5);
INSERT INTO empleado VALUES ('62752020',13,80,5,'Fernandez','Pineda','Marcela','Divorciado',700000,2,5);
INSERT INTO empleado VALUES ('65020661',14,81,6,'Wells','Keyla','Leonardo','Soltero',600000,1,1);
INSERT INTO empleado VALUES ('6694138K',15,82,1,'Pereda','Chepar','Marcia','Divorciado',300000,2,2);

INSERT INTO asesoria VALUES ('60579696',1,'01/03/2020','31/07/2020');
INSERT INTO asesoria VALUES ('60579696',2,'02/03/2020','18/09/2020');
INSERT INTO asesoria VALUES ('60579696',3,'10/03/2020','18/07/2020');
INSERT INTO asesoria VALUES ('60579696',4,'29/03/2020','17/06/2020');
INSERT INTO asesoria VALUES ('60579696',5,'13/02/2020','14/06/2020');
INSERT INTO asesoria VALUES ('60579696',6,'29/03/2020','17/08/2020');
INSERT INTO asesoria VALUES ('60579696',7,'22/05/2020','18/10/2020');
INSERT INTO asesoria VALUES ('60579696',8,'24/03/2020','20/09/2020');
INSERT INTO asesoria VALUES ('60579696',9,'17/02/2020','14/09/2020');
INSERT INTO asesoria VALUES ('60579696',10,'08/03/2020','05/07/2020');
INSERT INTO asesoria VALUES ('60579696',11,'28/03/2020','05/08/2020');
INSERT INTO asesoria VALUES ('69467678',1,'06/05/2020','11/08/2020');
INSERT INTO asesoria VALUES ('69467678',2,'27/03/2020','12/07/2020');
INSERT INTO asesoria VALUES ('69467678',3,'07/03/2020','10/07/2020');
INSERT INTO asesoria VALUES ('69467678',4,'25/03/2020','18/08/2020');
INSERT INTO asesoria VALUES ('69467678',5,'21/07/2020','18/07/2020');
INSERT INTO asesoria VALUES ('69467678',6,'09/03/2020','13/08/2020');
INSERT INTO asesoria VALUES ('69467678',7,'09/06/2020','13/09/2020');
INSERT INTO asesoria VALUES ('69467678',8,'25/03/2020','19/08/2020');
INSERT INTO asesoria VALUES ('69467678',9,'26/03/2020','18/12/2020');
INSERT INTO asesoria VALUES ('69467678',10,'29/03/2020','10/09/2020');
INSERT INTO asesoria VALUES ('69467678',11,'22/02/2020','13/07/2020');
INSERT INTO asesoria VALUES ('170676427',1,'19/03/2020','09/08/2020');
INSERT INTO asesoria VALUES ('170676427',2,'21/03/2020','17/08/2020');
INSERT INTO asesoria VALUES ('170676427',3,'29/07/2020','02/11/2020');
INSERT INTO asesoria VALUES ('170676427',4,'12/03/2020','02/09/2020');
INSERT INTO asesoria VALUES ('206248954',1,'12/03/2020','08/08/2020');
INSERT INTO asesoria VALUES ('206248954',2,'20/07/2020','13/08/2020');
INSERT INTO asesoria VALUES ('206248954',3,'22/03/2020','09/11/2020');
INSERT INTO asesoria VALUES ('206522999',1,'11/03/2020','02/08/2020');
INSERT INTO asesoria VALUES ('206522999',2,'23/03/2020','16/08/2020');
INSERT INTO asesoria VALUES ('206522999',3,'25/03/2020','07/11/2020');
INSERT INTO asesoria VALUES ('206522999',4,'12/02/2020','08/09/2020');
INSERT INTO asesoria VALUES ('207184768',1,'19/03/2020','30/09/2020');
INSERT INTO asesoria VALUES ('207184768',2,'05/03/2020','12/08/2020');
INSERT INTO asesoria VALUES ('207184768',3,'16/03/2020','10/12/2020');
INSERT INTO asesoria VALUES ('207184768',4,'09/07/2020','15/09/2020');
INSERT INTO asesoria VALUES ('208231386',1,'08/03/2020','05/07/2020');
INSERT INTO asesoria VALUES ('208231386',2,'13/03/2020','14/10/2020');
INSERT INTO asesoria VALUES ('208231386',3,'02/03/2020','18/09/2020');
INSERT INTO asesoria VALUES ('208231386',4,'29/05/2020','17/08/2020');
INSERT INTO asesoria VALUES ('208231386',5,'22/03/2020','18/10/2020');
INSERT INTO asesoria VALUES ('208231386',6,'28/03/2020','05/09/2020');
INSERT INTO asesoria VALUES ('208232220',1,'12/07/2020','07/08/2020');
INSERT INTO asesoria VALUES ('208232220',2,'22/03/2020','14/08/2020');
INSERT INTO asesoria VALUES ('208232220',3,'22/03/2020','08/11/2020');
INSERT INTO asesoria VALUES ('208232220',4,'13/02/2020','09/09/2020');
INSERT INTO asesoria VALUES ('208993164',1,'05/07/2020','12/10/2020');
INSERT INTO asesoria VALUES ('208993164',2,'16/03/2020','10/11/2020');
INSERT INTO asesoria VALUES ('208993164',3,'09/03/2020','15/08/2020');
INSERT INTO asesoria VALUES ('208993164',4,'08/03/2020','05/09/2020');
INSERT INTO asesoria VALUES ('208993164',5,'13/01/2020','14/11/2020');
INSERT INTO asesoria VALUES ('208993164',6,'02/03/2020','18/07/2020');
INSERT INTO asesoria VALUES ('208993164',7,'29/03/2020','17/08/2020');
INSERT INTO asesoria VALUES ('209300844',1,'23/03/2020','16/08/2020');
INSERT INTO asesoria VALUES ('209300844',2,'25/07/2020','07/11/2020');
INSERT INTO asesoria VALUES ('209300844',3,'12/03/2020','08/09/2020');
INSERT INTO asesoria VALUES ('209300844',4,'19/08/2020','30/09/2020');
INSERT INTO asesoria VALUES ('209300844',5,'05/03/2020','12/08/2020');
INSERT INTO asesoria VALUES ('209300844',6,'16/03/2020','10/12/2020');
INSERT INTO asesoria VALUES ('210435832',1,'19/07/2020','09/08/2020');
INSERT INTO asesoria VALUES ('210435832',2,'21/03/2020','17/08/2020');
INSERT INTO asesoria VALUES ('210435832',3,'29/03/2020','02/11/2020');
INSERT INTO asesoria VALUES ('210435832',4,'12/03/2020','02/09/2020');
INSERT INTO asesoria VALUES ('210435832',5,'12/05/2020','08/08/2020');
INSERT INTO asesoria VALUES ('210435832',6,'20/03/2020','13/08/2020');
INSERT INTO asesoria VALUES ('210435832',7,'22/07/2020','09/11/2020');
INSERT INTO asesoria VALUES ('210475308',9,'12/03/2020','08/08/2020');
INSERT INTO asesoria VALUES ('210475308',8,'20/03/2020','13/08/2020');
INSERT INTO asesoria VALUES ('210475308',7,'22/07/2020','09/11/2020');
INSERT INTO asesoria VALUES ('62752020',8,'11/07/2020','02/08/2020');
INSERT INTO asesoria VALUES ('62752020',4,'23/03/2020','16/08/2020');
INSERT INTO asesoria VALUES ('62752020',3,'25/03/2020','07/11/2020');
INSERT INTO asesoria VALUES ('62752020',7,'12/03/2020','08/09/2020');
INSERT INTO asesoria VALUES ('65020661',3,'25/07/2020','07/11/2020');
INSERT INTO asesoria VALUES ('65020661',4,'12/03/2020','08/09/2020');
INSERT INTO asesoria VALUES ('6694138K',1,'25/07/2020','07/11/2020');
INSERT INTO asesoria VALUES ('6694138K',3,'12/03/2020','08/09/2020');

INSERT INTO porc_metas VALUES (1,1,5,3);
INSERT INTO porc_metas VALUES (2,6,10,5);
INSERT INTO porc_metas VALUES (3,11,15,7);
INSERT INTO porc_metas VALUES (4,16,20,9);

COMMIT;





--BLOQUE ANÓNIMO
DECLARE

BEGIN

END;
/



--FUNCION
CREATE OR REPLACE FUNCTION nombre_funcion ()
    RETURN tipo_dato
IS

BEGIN

END nombre_funcion;
/



--PROCEDIMIENTO ALMACENADO
CREATE OR REPLACE PROCEDURE nombre_procedimiento ()
IS

BEGIN

END nombre_procedimiento;
/




SELECT * FROM empleado;

SELECT
    COUNT(rutemp)
FROM empleado;

--FUNCION QUE CUENTE EMPLEADOS
CREATE OR REPLACE FUNCTION fn_cuenta_empleados
    RETURN NUMBER
IS
    v_cant_emp NUMBER;
BEGIN
    SELECT
        COUNT(rutemp)
    INTO v_cant_emp   
    FROM empleado;
    
    RETURN v_cant_emp;
    
END fn_cuenta_empleados;
/



--BLOQUE ANÓNIMO PARA PROBAR FUNCIÓN
DECLARE

BEGIN
    DBMS_OUTPUT.PUT_LINE(fn_cuenta_empleados);
END;
/

SET SERVEROUTPUT ON






--FUNCIÓN QUE CALCULA METAS

--asesorías por empleados
SELECT COUNT(ase.rutemp), ase.rutemp
    FROM ASESORIA ase JOIN EMPLEADO emp 
        ON ase.rutemp = emp.rutemp
      GROUP BY ase.rutemp;


SELECT *
FROM ASESORIA ase JOIN EMPLEADO emp 
        ON ase.rutemp = emp.rutemp;

CREATE OR REPLACE FUNCTION fn_calcula_metas
    (p_IdEmp NUMBER, p_desde DATE, p_hasta DATE)
    RETURN NUMBER
IS
    v_cant_metas NUMBER;
BEGIN
    --ASESORÍAS POR UN EMPLEADO EN UN PERIODO DETERMINADO
    SELECT COUNT(ase.rutemp)
        INTO v_cant_metas
    FROM ASESORIA ase JOIN EMPLEADO emp 
        ON ase.rutemp = emp.rutemp
    WHERE ase.inicio BETWEEN p_desde AND p_hasta
      AND emp.idemp = p_IdEmp
      GROUP BY ase.rutemp;
    
    RETURN v_cant_metas;
END fn_calcula_metas;
/


DECLARE

BEGIN
    DBMS_OUTPUT.PUT_LINE(fn_calcula_metas(11,'01/03/2020','31/03/2020'));
END;
/


--BONO SEGÚN METAS

SELECT * FROM porc_metas;





SELECT COUNT(ase.rutemp), emp.idemp
FROM ASESORIA ase JOIN EMPLEADO emp 
   ON ase.rutemp = emp.rutemp
WHERE ase.inicio BETWEEN '01/03/2020' AND '31/03/2020'
GROUP BY ase.rutemp, emp.idemp
ORDER BY 2;



--PROCEDIMIENTO QUE INDICA EL PORCENTAJE DE BONO SEGÚN METAS

SELECT *
FROM porc_metas
WHERE &var_meta BETWEEN cant_inf AND cant_sup;

SELECT porc_bonif_metas
FROM porc_metas
WHERE &var_meta BETWEEN cant_inf AND cant_sup;




CREATE OR REPLACE PROCEDURE sp_porcentaje_bono 
    (p_metas IN NUMBER)
IS
    v_porcentaje NUMBER;
BEGIN
    SELECT 
        porc_bonif_metas
    INTO v_porcentaje
    FROM porc_metas
    WHERE p_metas BETWEEN cant_inf AND cant_sup;
    
    DBMS_OUTPUT.PUT_LINE(v_porcentaje);

END sp_porcentaje_bono;
/


EXECUTE sp_porcentaje_bono(11);

EXEC sp_porcentaje_bono(1);




DECLARE

BEGIN
    sp_porcentaje_bono(1);
END;
/


CREATE OR REPLACE PROCEDURE sp_porcentaje_bono 
    (p_metas IN NUMBER, r_pbono OUT NUMBER)
IS
    
BEGIN
    SELECT 
        porc_bonif_metas
    INTO r_pbono
    FROM porc_metas
    WHERE p_metas BETWEEN cant_inf AND cant_sup;
    
END sp_porcentaje_bono;
/



EXEC sp_porcentaje_bono(1, porcentaje);  --YA NO FUNCIONA


DECLARE 
    porcentaje NUMBER;
BEGIN 
    sp_porcentaje_bono(1, porcentaje);
    
    DBMS_OUTPUT.PUT_LINE(porcentaje);
END ;
/








--PROCEDIMIENTO QUE CALCULA LA REMUNERACION

CREATE OR REPLACE PROCEDURE sp_genera_remuneracion
    (p_desde DATE, p_hasta DATE)
IS
    v_contador NUMBER(4):=1;
    v_cant_max NUMBER(4);
    v_cant_metas NUMBER(4);
    v_rutemp EMPLEADO.rutemp%TYPE;
    v_sueldo_base REMUNERACION.SUELDO_BASE%TYPE;
    v_afp REMUNERACION.AFP%TYPE;
    v_isapre REMUNERACION.ISAPRE%TYPE;
    v_liquido_a_pagar REMUNERACION.LIQUIDO_A_PAGAR%TYPE;
    r_valor_porcentaje NUMBER;
    v_bono_metas NUMBER;

BEGIN
    --DETERMINAR CANTIDAD DE EMPLEADOS 
    v_cant_max := fn_cuenta_empleados;
    
    -- POR CADA EMPLEADO, REALIZAR CÁLCULOS DE REMUNERACIONES 
    WHILE v_contador <= v_cant_max LOOP
        
        SELECT rutemp, sueldo_base
            INTO v_rutemp, v_sueldo_base
        FROM EMPLEADO
        WHERE idemp = v_contador;
     
        --CÁLCULO BONO METAS
        v_cant_metas := fn_calcula_metas(v_contador,p_desde,p_hasta);
      
        sp_porcentaje_bono(v_cant_metas,r_valor_porcentaje); 
      
        v_bono_metas := (v_sueldo_base * r_valor_porcentaje/100);  
   
        -- CÁLCULO ISAPRE       
        v_isapre := ((v_sueldo_base + v_bono_metas) * 7/100);
        
        v_afp := ((v_sueldo_base + v_bono_metas) * 13/100);
        
        -- CÁLCULO LÍQUIDO A PAGAR  
        v_liquido_a_pagar := (v_sueldo_base + v_bono_metas) - (v_afp + v_isapre);
   
        -- INSERTAR EN TABLA REMUNERACION MENSUAL 
        INSERT INTO REMUNERACION 
            VALUES (v_rutemp, EXTRACT(MONTH FROM p_hasta), EXTRACT(YEAR FROM p_hasta), 
                    v_sueldo_base, 0, v_bono_metas,
                    0,0,0,0, v_afp, v_isapre, v_liquido_a_pagar);

        v_contador := v_contador +1;
  END LOOP;
END sp_genera_remuneracion;
/

exec sp_genera_remuneracion('01/03/2020','31/03/2020');

SELECT * FROM REMUNERACION;



--BORRA LA TABLA ANTES DE GENERAR LA REMUNERACION
CREATE OR REPLACE PROCEDURE sp_genera_remuneracion
    (p_desde DATE, p_hasta DATE)
IS
    v_contador NUMBER(4):=1;
    v_cant_max NUMBER(4);
    v_cant_metas NUMBER(4);
    v_rutemp EMPLEADO.rutemp%TYPE;
    v_sueldo_base REMUNERACION.SUELDO_BASE%TYPE;
    v_afp REMUNERACION.AFP%TYPE;
    v_isapre REMUNERACION.ISAPRE%TYPE;
    v_liquido_a_pagar REMUNERACION.LIQUIDO_A_PAGAR%TYPE;
    r_valor_porcentaje NUMBER;
    v_bono_metas NUMBER;

BEGIN
    --DETERMINAR CANTIDAD DE EMPLEADOS 
    v_cant_max := fn_cuenta_empleados;
    
    --BORRADO DE TABLA
    EXECUTE IMMEDIATE 'TRUNCATE TABLE REMUNERACION';
    
    -- POR CADA EMPLEADO, REALIZAR CÁLCULOS DE REMUNERACIONES 
    WHILE v_contador <= v_cant_max LOOP
        
        SELECT rutemp, sueldo_base
            INTO v_rutemp, v_sueldo_base
        FROM EMPLEADO
        WHERE idemp = v_contador;
     
        --CÁLCULO BONO METAS
        v_cant_metas := fn_calcula_metas(v_contador,p_desde,p_hasta);
      
        sp_porcentaje_bono(v_cant_metas,r_valor_porcentaje); 
      
        v_bono_metas := (v_sueldo_base * r_valor_porcentaje/100);  
   
        -- CÁLCULO ISAPRE       
        v_isapre := ((v_sueldo_base + v_bono_metas) * 7/100);
        
        v_afp := ((v_sueldo_base + v_bono_metas) * 13/100);
        
        -- CÁLCULO LÍQUIDO A PAGAR  
        v_liquido_a_pagar := (v_sueldo_base + v_bono_metas) - (v_afp + v_isapre);
   
        -- INSERTAR EN TABLA REMUNERACION MENSUAL 
        INSERT INTO REMUNERACION 
            VALUES (v_rutemp, EXTRACT(MONTH FROM p_hasta), EXTRACT(YEAR FROM p_hasta), 
                    v_sueldo_base, 0, v_bono_metas,
                    0,0,0,0, v_afp, v_isapre, v_liquido_a_pagar);

        v_contador := v_contador +1;
  END LOOP;
END sp_genera_remuneracion;
/


exec sp_genera_remuneracion('01/03/2020','31/03/2020');
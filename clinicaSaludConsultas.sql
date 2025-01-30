/* ************************ EJERCICIO 1 ************************ */
/* Utilizando las tablas y campos necesarios que se adjuntan en el
script, se pide obtener las sentencias SQL de consulta que permitan realizar 
los siguientes apartados mediante MySQL: */

/* a) Obtener un listado de todos los médicos cuya especialidad sea “Cardiología”
y trabajen en clínicas de la provincia de Huelva. Ordenados por el número de
colegiado de mayor a menor. */
SELECT M.* 
FROM MEDICO M, CLINICA C
WHERE C.codigo = M.clinica
AND M.especialidad = "Cardiología"
AND C.provincia = "Huelva"
ORDER BY M.n_colegiado DESC;


/* b) Obtener por cada paciente, su número de seguridad social, DNI, nombre,
apellidos y el número de veces que han asistido a consulta durante el año 2022. */
SELECT P.NSS, P.DNI, P.nombre, P.apellidos, COUNT(CO.fecha_Consulta) AS Visitas
FROM PACIENTE P, CONSULTAS CO
WHERE CO.paciente = P.NSS
AND YEAR(CO.fecha_Consulta) = "2022"
GROUP BY P.NSS; /*en GROUP BY si no se especifica campo, mejor elegir uno que sea clave primaria */


/* c) Obtener un listado con el número de colegiado, nombre, apellidos y suma del
importe total de los médicos que hayan ganado más de 3000 euros de importe
total en las consultas. */
SELECT M.n_colegiado, M.nombre, M.apellidos, SUM(CO.importe) AS Ingresos
FROM MEDICO M, CONSULTAS CO
WHERE CO.medico = M.n_colegiado
/*AND (CO.importe) > 3000*/ /* Maaaaaaaaal */
GROUP BY M.n_colegiado; /* hasta aquí se ve la lista y se confirma que solo hay uno con +3000€*/

SELECT M.n_colegiado, M.nombre, M.apellidos, SUM(CO.importe) AS Ingresos
FROM MEDICO M, CONSULTAS CO
WHERE CO.medico = M.n_colegiado
GROUP BY M.n_colegiado
HAVING Ingresos>3000;        /* Having se usa para poner condiciones a grupos */

/* d) Obtener todos los datos de los pacientes menores de 3 años que hayan asistido a
consulta de médicos de la especialidad de Pediatría. */
SELECT P.* 
FROM PACIENTE P, MEDICO M, CONSULTAS CO
WHERE M.n_colegiado = CO.medico
AND P.NSS = CO.paciente
AND M.especialidad = 'Pediatría'
AND TRUNCATE(DATEDIFF(SYSDATE(),P.fecha_Nac)/365, 0)<3;

/* ************************ EJERCICIO 2 ************************ */
/* Teniendo en cuenta las mismas tablas del ejercicio anterior, debes
realizar las siguientes operaciones de actualización, inserción y borrado de
registros mediante las sentencias SQL apropiadas en MySQL: */

/* a) Inserta un nuevo paciente con NSS='156487569', DNI='26485695K', Nombre=
'Juan', Apellidos= 'López Alcántara, Fec_nac='28/10/1986' y Sexo='M'. */
INSERT INTO paciente VALUES('156487569','26485695K','Juan','López Alcántara','M','1986-10-28',NULL);

/* b) Actualiza el importe de las consultas realizadas por médicos de la especialidad
de 'Traumatología' incrementándolas en un 10%. */
UPDATE CONSULTAS C
SET importe = importe * 1.1
WHERE C.medico IN (SELECT M.n_colegiado FROM MEDICO M WHERE M.especialidad = 'Traumatología');
			/*cuando se usa IN, el SELECT debe llevar el campo que une a ambas tablas (la tabla
            del UPDATE que es CONSULTAS y la tabla del IN que es MEDICO. Ese campo es C.medico/M.n_colegiado) */		

/* c) Elimina todos los pacientes que lleven más de 2 años sin asistir a consulta
médica. */
		/* cuidado porque hay pacientes que llevan más de dos años sin asistir a una consulta pero sí que 
		han asistido a otra recientemente. Con el NOT IN y el DISTINCT hacemos que no se elimine el paciente
		por completo, si no solo las visitas antiguas a ciertas consultas. */

		/* primero veamos qué pacientes han estado en consulta en los últimos 2 años. */
		SELECT DISTINCT paciente
		FROM CONSULTAS
		WHERE TRUNCATE(DATEDIFF(SYSDATE(), fecha_consulta)/365,0)<=2;

DELETE FROM PACIENTE P
WHERE P.NSS NOT IN (SELECT DISTINCT CO.paciente FROM CONSULTAS CO
WHERE TRUNCATE(DATEDIFF(SYSDATE(), fecha_consulta)/365,0)<=2);
			
/* d) Incrementa en 20 euros el importe de las consultas que estén por debajo de la
media de los importes de todas las consultas. */
	/* Vemos la media de las consultas */
	SELECT AVG(importe) FROM CONSULTAS;
    
    /* vemos todas para comprobar cuáles estarían por debajo */
    SELECT * FROM CONSULTAS;

UPDATE CONSULTAS
SET importe = importe + 20
WHERE importe < (SELECT AVG(importe) FROM (SELECT * FROM CONSULTAS) AS TEMP); /* Importante explicación
					de esta parte del código: no se puede hacer un UPDATE en una tabla usando esa misma 
                    tabla en la subconsulta. Se puede pecar de ponerlo así y dará error (1093): 
                    WHERE importe < (SELECT AVG(importe) FROM CONSULTAS);
                    Se soluciona poniéndolo entre paréntesis y con alias, así "engañas" haciéndole creer
                    que se hace sobre el alias. */


/* Nota para evitar error 1175: */
	SET SQL_SAFE_UPDATES = 0;
	/*  El error se debe a que tu UPDATE está intentando modificar filas basándose en una subconsulta 
	y no en una clave primaria o única.
	Se activa para proteger la base de datos. */
	SET SQL_SAFE_UPDATES = 1;
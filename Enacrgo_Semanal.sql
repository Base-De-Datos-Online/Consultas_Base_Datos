/* *******************************
 *
 * Usuario SEMANA
 *
 * ******************************* */

-- CASO 1

SELECT 
  UPPER(first_name)       AS  nombre,
  LOWER(last_name)        AS apellido,
  CONCAT(email,'@gmail.com')  AS "Correo Electrónico",
  salary * 0.05           AS "Sueldo simulado",
  salary/3                AS sin_redondeo,
  ROUND(salary / 3,4)     AS redondeo,
  TRUNC(salary / 3,2)     AS truncar,
  FLOOR(salary / 3)     AS redondeo_hacia_abajo
FROM employees;


-- CASO 2


SELECT
    e.employee_id,
    e.first_name ||' '||e.last_name     AS "empleado",
    d.department_name,
    j.job_title,
    e.salary
FROM (employees e INNER JOIN departments d
    ON d.department_id=e.department_id)
        INNER JOIN jobs j
    ON j.job_id=e.job_id

MINUS
 
SELECT
    e.employee_id,
    e.first_name ||' '||e.last_name     AS "empleado",
    d.department_name,
    j.job_title,
    e.salary
 FROM (employees e INNER JOIN departments d
    ON d.department_id=e.department_id)
        INNER JOIN jobs j
    ON j.job_id=e.job_id
WHERE e.salary < ALL (  SELECT ROUND(AVG(salary))
                    FROM employees
                    GROUP BY department_id

                    )
;


-- CASO 3

CREATE OR REPLACE VIEW VW_PRUEBA AS
SELECT
    e.employee_id,
    e.first_name ||' '||e.last_name     AS "empleado",
    d.department_name,
    j.job_title,
    e.salary
 FROM (employees e INNER JOIN departments d
    ON d.department_id=e.department_id)
        INNER JOIN jobs j
    ON j.job_id=e.job_id
WHERE e.salary < ALL (  SELECT ROUND(AVG(salary))
                    FROM employees
                    GROUP BY department_id

                    )
;

SELECT  * FROM VW_PRUEBA;
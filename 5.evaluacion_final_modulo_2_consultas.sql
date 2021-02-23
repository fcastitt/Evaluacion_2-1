--Consulta 1 
SELECT ASISTNOMBRECOMPLETO , ASISTEDAD , ASISTCORREO  
FROM ASISTENTES 
WHERE  CAPACITACION_IDCAPACITACION in ( SELECT IDCAPACITACION   FROM CAPACITACION WHERE CLIENTE_RUTCLIENTE = 113388 );
 
--Consulta 2 
SELECT  v.*  , c.nombre , c.detalle , r.estado
FROM VISITA v , CHEQUEO C , REGISTROCHEQUEO R
WHERE v.VISLUGAR = 'VALPARAISO' and c.idchequeo = r.chequeo_idchequeo and v.idvisita = r.visita_idvisita;

--Consulta 3 
SELECT  a.* , u.USNOMBRE , u.USAPELLIDO , c.RUTCLIENTE , c.CLITELEFONO
FROM ACCIDENTE a , CLIENTE c , USUARIO u
WHERE  a.cliente_rutcliente = c.RUTCLIENTE 
and c.usuario_runusuario =  u.runusuario;


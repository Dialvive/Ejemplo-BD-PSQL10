# Ejemplo-BD-PSQL10
Base de datos normalizada basada en un caso de uso ficticio al estilo de una empresa de transporte privado. Escrito en PSQL 10 y documentado en LaTeX.

## Motivación
Se creó la base de datos 'Transportate' como proyecto integrador de la clase 'Fundamentos de Bases de Datos' en la Facultad de Ciencias, UNAM. 
Se comparte por este medio para los fines que se establecen en la licencia, pero principalmente educativos.

## Estílo de Código
Estandar PSQL

## Documentación sobre diseño y normalización
Consulte: [Documentación](https://github.com/Dialvive/Ejemplo-BD-PSQL10/tree/master/Entrega/DOC)

## Diagrama
![Diagrama relacional de tablas](https://github.com/Dialvive/Ejemplo-BD-PSQL10/blob/master/DOC/normalizacion/RN.png?raw=true)

## Tecnologías
- [PSQL 10](https://www.postgresql.org/download/)
- [PgAdmin 4](https://www.pgadmin.org/download/)

## Características
Base de datos con múltiples tablas normalizadas, archivos SQL separados y nombrados por función, documentación descriptiva sobre el proceso de creación y normalización de la BD.

## Instalación

### Requerido:
- Clonar el repositorio e instalar las tecnologías requeridas [PSQL 10](https://www.postgresql.org/download/) y [PgAdmin 4](https://www.pgadmin.org/download/).
- Inicializar PSQL en su shell, o usando PgAdmin4, verifique que los puertos utilizados estén disponibles.
- Ejecutar DDL.sql en el shell de PSQL o dentro de PgAdmin4 (el último caso requerirá que se crea la base de datos dentro de la herramienta, y luego se ejecute el resto de comandos del DDL.sql dentro de PgAdmin).
- Ejecutar procedimientos_almacenados.sql, funciones.sql, y disparadores.sql en el shell de PSQL o dentro de PgAdmin4.

### Opcional:
- Ejecutar DML.sql en el shell de PSQL o dentro de PgAdmin4 para poblar la BD.

## Como usar?
Instalar Tecnologías, realizar instalación descrita en el punto anterior, y después podrá realizar las inserciones o consultas deseadas desde PSQL shell, PgAdmin, o su herramienta preferida.

## Licencia
[Mozilla Public License 2.0](https://www.mozilla.org/en-US/MPL/2.0/)

MPL 2019 © [Diego Villalpando]()

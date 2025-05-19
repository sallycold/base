create schema Escuela;
use Escuela;

create table Alumnos (
    idAlumnos int primary key,
    nombre varchar(80),
    apellido varchar(80),
    curso int,
    IdOrientacion int,
    foreign key (curso) references Curso(idCurso),
    foreign key (IdOrientacion) references Orientacion(IdOrientacion)
);

create table Curso (
    idCurso int primary key,
    curso varchar(10)
);

create table Profe (
    idProfesor int primary key,
    nombre varchar(80),
    apellido varchar(80),
    grado_asig int,
    materia int,
    foreign key (materia) references Materias(idMateria),
    foreign key (grado_asig) references Curso(idCurso)
);

create table Salon (
    idSalon int primary key,
    curso int,
    foreign key (curso) references Curso(idCurso)
);

create table Orientacion (
    idOrientacion int primary key,
    nombre varchar(80)
);

create table Directivo (
    idDirectivos int primary key,
    cargo varchar(80),
    nombre varchar(80),
    problem varchar(80),
	idAlumnos int,
    foreign key (idAlumnos)  references Curso(idCurso)
);

create table Materias (
    idMateria int primary key,
    nombre varchar(80)
);

-- Insertar datos en las tablas
insert into Alumnos(idAlumnos, nombre, apellido, curso, idOrientacion) values
(1, "Valentina", "Gonzalez", 5, 2),
(2, "Susana", "Gimenez", 3, 1),
(3, "Marcos", "Manzilla", 2, 1),
(4, "Maximo", "Fernandez", 1, 1),  
(5, "Thiago", "Herrera", 2, 2);   

insert into Materias (idMateria, nombre) values
(1, "Geografia"),
(2, "Matematicas"),
(3, "Filosofia"),
(4, "Literatura"),
(5, "Ba.Datos"),
(6, "Historia"),
(7, "Programacion"),
(8, "Modelos y Sistemas"),
(9, "Ingles");

insert into Orientacion(idOrientacion, nombre) values
(1, "Multimedios"),
(2, "Programacion");

insert into Directivo(idDirectivos,cargo,nombre,problem ,idAlumnos) values
(1, "precector","Sr.Fabiola","faltas a clases",4),
(2, "director","Sr.Victor","Gestion Adninistrativa",2),
(3, "Orientacion","Sr.Lopez","informe sobre las carrera",1),
(4, "secretaria","Sr.Herrera", "consultas/quejas",3);


insert into Curso(idCurso, curso) values
(1, "1º1"),
(2, "2º2"),
(3, "3º1"),
(4, "4º4"),
(5, "5º2"),
(6, "5º3"),
(7, "6º2"),
(8, "6º3"),
(9, "7º2"),
(10, "7º3");

insert into Profe(idProfesor, nombre, apellido, grado_asig, materia) values
(1, "Yesica", "Galarza", 1, 2),
(2, "Cristian", "Sanchez", 3, 1),
(3, "Anibal", "Gonzales", 5, 7),
(5, "Maria", "Parreta", 5, 8),
(6, "Elena", "Monzon", 9, 9),
(7, "Walter", "Suden", 4, 6);

-- Consultar todas las tablas
select * from Directivo;
select * from Alumnos;
select * from Profe;
select * from Orientacion;
select * from Curso;
select * from Materias;
select * from Salon;


insert into Alumnos(idAlumnos, nombre, apellido, curso, idOrientacion) values
(12, 'Lara', 'Caceres', 3, 2);
-- insertar datos
insert into Profe(idProfesor, nombre, apellido, grado_asig, materia) values
(8, "Tomas", "Walf", 1, 2);
-- elimina tablas
drop table Salon;
-- modifica las filas 
update Alumnos set nombre ="Paola", apellido="Zarate" where idAlumnos=2;
update Alumnos set idOrientacion=2 where idAlumnos between 2 and 4;
-- agregar campo "Edad"
alter table Alumnos add Edad int;
-- si elimnar campo "curso"
alter table Alumnos drop curso;
-- mostrar profesores que no contengas en nombre y apellido una i
select idProfesor,nombre, apellido  from profe 
where nombre not like  "%i%" and apellido not like "%i%" group by idProfesor, apellido order by idProfesor desc;


update Alumnos set idOrientacion=1 where idAlumnos=5;
-- muestra el curso de los alumnos
select c.curso,a.nombre from alumnos a inner join Curso c on idCurso= a.curso;

-- muetra las orientaciones de los estudientes 
select  a.nombre, a.apellido, O.nombre as SuOrientacion from 
alumnos a left join orientacion O on o.idOrientacion= a.idOrientacion;

-- muestra a los profesores con sus materias y a los que no lo tienen tambien 
select p.nombre,p.apellido, m.nombre from profe p right join 
materias m  on m.idMateria= p.idProfesor;

-- muestra los profesores que no tienen una "o" en su nombre o apellido
select p.nombre, p.apellido, c.curso AS Nulos
from profe p
left join Curso c on p.grado_asig = c.idCurso
where p.nombre not like  "%o%" and p.apellido not like "%o%";

-- muestra los cursos auque no  tengan profesores
select c.curso, p.nombre as Profesor, p.apellido as Apellido_Profesor
from Curso c
left join Profe p on c.idCurso = p.grado_asig;

-- 
select c.curso, p.nombre as Profesor, p.apellido as Apellido_Profesor
from Curso c
right join Profe p on c.idCurso = p.grado_asig;

-- cuenta cantidades de profesores en cada curso
select c.curso, COUNT(p.idProfesor) as Total_Profesores
from profe p
join curso c on p.grado_asig = c.idCurso
group by c.curso;


select d.idDirectivos,d.cargo,d.nombre as nombre_directivo,d.problem,a.nombre
 as nombre_alumno,a.apellido as apellido_alumno,c.curso as nombre_curso
from
    Directivo d
left join 
    Alumnos a on d.idAlumnos = a.idAlumnos
left join 
    Curso c on a.curso = c.idCurso;


delimiter //
procedure Posib.conb()
begin
select c.curso, p.nombre as Profesor, p.apellido as Apellido_Profesor
from Curso c
cross join Profe p;
end
delimiter 
call  Posib.conb();


//delimiter
CREATE PROCEDURE Proble()
BEGIN
    SELECT a.idAlumnos,
    a.nombre AS NombreAlumno,
    a.apellido AS ApellidoAlumno,a.curso,
	a.IdOrientacion,
	c.curso AS NombreCurso,
	o.nombre AS NombreOrientacion,
	p.nombre AS NombreProfesor, 
	p.apellido AS ApellidoProfesor,
	m.nombre AS NombreMateria
    FROM Alumnos a
    LEFT JOIN Curso c ON a.curso = c.idCurso
    LEFT JOIN Orientacion o ON a.IdOrientacion = o.idOrientacion
    LEFT JOIN Profe p ON a.curso = p.grado_asig AND p.materia = a.IdOrientacion
    LEFT JOIN Materias m ON p.materia = m.idMateria;
END //
DELIMITER ;

-- muestra las posibles convinaciones
select c.curso, p.nombre as Profesor, p.apellido as Apellido_Profesor
FROM Curso c
cross join Profe p;


-- 
CREATE TABLE LogAlumnos (
    idLog INT PRIMARY KEY AUTO_INCREMENT, -- El id se pone automaticamente
    mensaje VARCHAR(255),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP 
);

DELIMITER //
CREATE TRIGGER InsertarAlumnos
AFTER INSERT ON Alumnos
FOR EACH ROW
BEGIN
    INSERT INTO LogAlumnos (mensaje)  
    VALUES (CONCAT('Se ha agregado el alumno: ', NEW.nombre, ' ', NEW.apellido)); -- si se desea eliminar ultiliza OLD en vez de NEW
END //
DELIMITER ;
INSERT INTO Alumnos (idAlumnos, nombre, apellido, curso, IdOrientacion) VALUES (9, 'Sofia', 'Martinez', 2, 1);
INSERT INTO Alumnos (idAlumnos, nombre, apellido, curso, IdOrientacion) VALUES (10, 'Lara', 'Caceres', 2, 2);
 SELECT * FROM LogAlumnos;


-- Otra forma de hacer lo mismo pero sin tabla 
DELIMITER //
CREATE PROCEDURE registrar_nombre_duplica()
BEGIN
    DECLARE nombre_duplicado VARCHAR(255);

    -- Generar los mensajes de los nombres duplicados
    SELECT 
        CONCAT('El alumno ', nombre, ' ', apellido, ' aparece ', COUNT(*), ' veces.') INTO nombre_duplicado
    FROM Alumnos
    GROUP BY nombre, apellido
    HAVING COUNT(*) > 1;

    -- Usar la variable de usuario
    SELECT nombre_duplicado;
END //
DELIMITER ;

CALL registrar_nombre_duplica();





--
DELIMITER //
CREATE PROCEDURE listar_alumnos_con_orientacion(
    IN p_idOrientacion INT
)
BEGIN
    SELECT a.nombre, a.apellido, o.nombre AS orientacion
    FROM Alumnos a
    JOIN Orientacion o ON a.idOrientacion = o.idOrientacion
    WHERE a.idOrientacion = p_idOrientacion;
END //
DELIMITER ;
CALL listar_alumnos_con_orientacion(2);
CALL listar_alumnos_con_orientacion(1);

--
CREATE TABLE LogNombresDuplicado (
    idLog INT PRIMARY KEY AUTO_INCREMENT, -- El id se pone automaticamente
    mensaje VARCHAR(255)
);
DELIMITER //
CREATE PROCEDURE registrar_nombre_duplica()
BEGIN
    INSERT INTO LogNombresDuplicado (mensaje)
    SELECT CONCAT('El alumno ', nombre, ' ', apellido, ' aparece ', COUNT(*), ' veces.')
    FROM Alumnos
    GROUP BY nombre, apellido
    HAVING COUNT(*) > 1;
END //
DELIMITER ;
CALL registrar_nombre_duplica();
SELECT * FROM LogNombresDuplicado; 

DELIMITER //
CREATE PROCEDURE mostrarAlumnosConProblema()
BEGIN
    SELECT a.idAlumnos,
           a.nombre AS NombreAlumno,
           a.apellido AS ApellidoAlumno,
           d.nombre AS NombreDirectivo,
           d.cargo AS CargoDirectivo,
           d.problem AS ProblemaReportado
    FROM Alumnos a
    INNER JOIN Directivo d ON a.idAlumnos = d.idAlumnos;
END //
DELIMITER ;
-- Ejecutar el procedimiento almacenado
CALL mostrarAlumnosConProblema();

-- FULL JOIN simulado entre Profe y Materias
SELECT p.idProfesor, p.nombre AS NombreProfesor, p.apellido AS ApellidoProfesor, m.idMateria, m.nombre AS NombreMateria
FROM Profe p
LEFT JOIN Materias m ON p.materia = m.idMateria
UNION
SELECT p.idProfesor, p.nombre AS NombreProfesor, p.apellido AS ApellidoProfesor, m.idMateria, m.nombre AS NombreMateria
FROM Profe p
RIGHT JOIN Materias m ON p.materia = m.idMateria;

https://1drv.ms/p/c/b4d23e0ca9aaa66d/Edaxh36e81lJsf_voxF_e2sBXhrUoM4Z23DrN6NMWae1aw

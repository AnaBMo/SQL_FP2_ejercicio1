drop database clinicsalud;

CREATE DATABASE clinicsalud CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
use clinicsalud;

create table clinica (
    codigo char(6),
    nombre varchar(35),
    direccion varchar(50),
    localidad varchar(35),
    provincia varchar(20),
    constraint primary key(codigo)
);

create  table paciente (
	NSS char(12),
    DNI char(9) unique,
    nombre varchar(30),
    apellidos varchar(50),
    sexo enum('M','F'),
    fecha_Nac date,
    historial longtext,
    constraint primary key(NSS)
);

create  table medico (
	n_colegiado char(9),
    nombre varchar(30),
    apellidos varchar(50),
    especialidad varchar(20),
    fecha_Alta Date,
    clinica char(6),	
    constraint primary key(n_colegiado),
    constraint fk_med_idc  foreign key (clinica) references clinica(codigo) on delete cascade on update cascade
);

create table consultas (
	medico char(9),
    paciente char(12),
    fecha_Consulta date,
    importe float,  	
    constraint primary key(medico,paciente,fecha_Consulta),
    constraint fk_con_idm foreign key (medico) references medico(n_colegiado) on delete cascade on update cascade,
    constraint fk_con_idp foreign key (paciente) references paciente(nss) on delete cascade on update cascade
);
	
    
INSERT INTO clinica VALUES('000001','Clínica del Carmen','Avda Italia 22','Huelva','Huelva');
INSERT INTO clinica VALUES('000002','Clínica Plaza de las Monjas','Plaza de las Monjas 2','Huelva','Huelva');
INSERT INTO clinica VALUES('000003','Grupo Pediátrico Uncibay','Calle Molina Lario 7, 2º','Málaga','Málaga');
INSERT INTO clinica VALUES('000004','Policlínica San Juan','Avda del Mediterráneo 20','Alhaurín de la Torre','Málaga');
INSERT INTO clinica VALUES('000005','Clínica HLA Santa Isabel','Calle Luis Montoto 100','Sevilla','Sevilla');
INSERT INTO clinica VALUES('000006','Centro médico Semud','Calle Ponce de León 1','Utrera','Sevilla');
INSERT INTO clinica VALUES('000007','Policlínica Úbeda','Calle Explanada 23 Bajo','Úbeda','Jaén');
INSERT INTO clinica VALUES('000008','Policlínica Santa María','Calle Santa María Soledad 13','Cádiz','Cádiz');
INSERT INTO clinica VALUES('000009','Policlínica Los Millares','Carrera del Duende 16','Almería','Almería');
INSERT INTO clinica VALUES('000010','Clínica El Brillante','Avda Brillante 64','Córdoba','Córdoba');
INSERT INTO clinica VALUES('000011','Vithas Rincón de la Victoria','Avda de la Torre 15','Rincón de la Victoria','Málaga');
INSERT INTO clinica VALUES('000012','Centro Médico Vithas Limonar','Calle La Era 6','Málaga','Málaga');


INSERT INTO paciente VALUES('048234231013','12322341E','Juan','González Fernández','M','1986-03-24',NULL);
INSERT INTO paciente VALUES('285543156276','67863423Z','Ramón','Rodríguez Núñez','M','1999-09-02',NULL);
INSERT INTO paciente VALUES('296755433362','02384234P','María','Martín Sánchez','F','1970-11-24',NULL);
INSERT INTO paciente VALUES('184376546134','98712234Y','Laura','Gutiérrez Albiol','F','2001-06-04',NULL);
INSERT INTO paciente VALUES('117775436758','64528976S','Inma','Domínguez Cerrato','F','1993-03-03',NULL);
INSERT INTO paciente VALUES('238712259124','34500232W','Jose','Torres Lopez','M','1980-03-24',NULL);
INSERT INTO paciente VALUES('147655600078','56434010Z','Luis','Miguel Casado','M','1998-08-01',NULL);
INSERT INTO paciente VALUES('215438967278','70725455H','Francisco','Heiver Jhons','M','2021-05-25',NULL);
INSERT INTO paciente VALUES('219127751986','34678891C','Salvador','Rubiales Perez','M','2015-08-02',NULL);
INSERT INTO paciente VALUES('296001902000','80092300K','Ascensión','Rodríguez Ruiz','F','2020-06-24',NULL);

INSERT INTO medico VALUES('414117320','Fernando','García Pérez-Sevillano','Endocrinología','2000-03-15','000001');
INSERT INTO medico VALUES('212305458','Belén','Hinojosa Jara','Alergología','1998-05-05','000001');
INSERT INTO medico VALUES('414112680','Rafael Fernando','Romero Garrido','Cardiología','2001-08-01','000002');
INSERT INTO medico VALUES('414115731','Pablo','Herrera Martín','Aparato Digestivo','2015-07-07','000002');
INSERT INTO medico VALUES('292904902','Manuel Ramón','Baca Cots','Pediatría','2018-09-03','000003');
INSERT INTO medico VALUES('292908760','Manuel','Rueda Ortiz','Otorrinolaringología','1999-04-17','000004');
INSERT INTO medico VALUES('414112290','Matilde','Zamorano del Río','Ginecología','2002-04-03','000005');
INSERT INTO medico VALUES('414106178','Rafael Carlos','López Jiménez','Oftalmología','1999-11-07','000006');
INSERT INTO medico VALUES('414105898','Miguel','Fashho Bayouk','Dermatología','2003-10-29','000006');
INSERT INTO medico VALUES('232303028','Pedro','Fuentes Peñas','Medicina General','2010-02-26','000007');
INSERT INTO medico VALUES('111105075','María del Rosario de Fátima','Ramírez Chamorro','Urología','2011-07-13','000008');
INSERT INTO medico VALUES('040403859','María Luisa','Morales Martínez','Nutrición','1995-12-31','000009');
INSERT INTO medico VALUES('141404656','Miguel Ángel','Martín Pérez','Neumología','1999-06-20','000010');
INSERT INTO medico VALUES('211108485','Antonio Enrique','Gómez Menchero','Cardiología','2005-10-09','000001');
INSERT INTO medico VALUES('414117017','Álvaro','Arce León','Cardiología','2008-09-29','000001');
INSERT INTO medico VALUES('292911024','Ester','Romero Escribano','Traumatología','2004-09-15','000004');
INSERT INTO medico VALUES('141403602','Antonio','Pineda Sicilia','Traumatología','2001-07-18','000010');
INSERT INTO medico VALUES('412104405','Francisco José','Lara Pulido','Traumatología','2017-03-19','000001');
INSERT INTO medico VALUES('212102841','Luisa','Mira Toscano','Pediatría','2000-03-19','000001');
INSERT INTO medico VALUES('294118197','Rubén Jesús','Gil Cardona','Pediatría','2001-05-07','000011');
INSERT INTO medico VALUES('292910421','Pablo','Cabezudo García','Neurología','2000-05-07','000012');

INSERT INTO consultas VALUES('414112680','048234231013','2020-03-15',45);
INSERT INTO consultas VALUES('414117017','238712259124','2023-02-14',110);
INSERT INTO consultas VALUES('211108485','215438967278','2020-05-03',95);
INSERT INTO consultas VALUES('292904902','296001902000','2023-02-11',80);
INSERT INTO consultas VALUES('292904902','296001902000','2022-12-01',70);
INSERT INTO consultas VALUES('292904902','296001902000','2023-03-08',80);
INSERT INTO consultas VALUES('212102841','219127751986','2020-05-17',35);
INSERT INTO consultas VALUES('294118197','215438967278','2021-08-01',35);
INSERT INTO consultas VALUES('412104405','048234231013','2022-06-13',40);
INSERT INTO consultas VALUES('141403602','147655600078','2021-11-11',45);
INSERT INTO consultas VALUES('292911024','117775436758','2022-06-02',55);
INSERT INTO consultas VALUES('212305458','048234231013','2021-12-15',65);
INSERT INTO consultas VALUES('111105075','285543156276','2023-04-19',60);
INSERT INTO consultas VALUES('292908760','296001902000','2021-04-19',100);
INSERT INTO consultas VALUES('292908760','296001902000','2021-06-30',100);
INSERT INTO consultas VALUES('292908760','296001902000','2022-05-18',120);
INSERT INTO consultas VALUES('292910421','296001902000','2020-05-23',80);
INSERT INTO consultas VALUES('292910421','296001902000','2021-04-10',85);
INSERT INTO consultas VALUES('292910421','296001902000','2022-04-01',90);
INSERT INTO consultas VALUES('292910421','296001902000','2022-06-11',90);
INSERT INTO consultas VALUES('292910421','296001902000','2023-03-30',95);
INSERT INTO consultas VALUES('414117320','296755433362','1998-01-15',95);
INSERT INTO consultas VALUES('414117320','296755433362','1998-06-15',95);
INSERT INTO consultas VALUES('414117320','296755433362','1999-02-01',100);
INSERT INTO consultas VALUES('414117320','296755433362','1999-07-01',100);
INSERT INTO consultas VALUES('414117320','296755433362','2000-01-15',120);
INSERT INTO consultas VALUES('414117320','296755433362','2000-05-30',120);
INSERT INTO consultas VALUES('414117320','296755433362','2000-09-15',120);
INSERT INTO consultas VALUES('414117320','296755433362','2001-03-10',150);
INSERT INTO consultas VALUES('414117320','296755433362','2001-09-20',150);
INSERT INTO consultas VALUES('414117320','296755433362','2002-02-14',170);
INSERT INTO consultas VALUES('414117320','296755433362','2002-07-22',170);
INSERT INTO consultas VALUES('414117320','296755433362','2005-05-11',200);
INSERT INTO consultas VALUES('414117320','296755433362','2005-06-15',200);
INSERT INTO consultas VALUES('414117320','296755433362','2005-07-01',200);
INSERT INTO consultas VALUES('414117320','296755433362','2006-07-15',220);
INSERT INTO consultas VALUES('414117320','296755433362','2007-06-30',225);
INSERT INTO consultas VALUES('414117320','296755433362','2008-05-01',230);
INSERT INTO consultas VALUES('414117320','296755433362','2009-05-22',235);
INSERT INTO consultas VALUES('414117320','184376546134','2023-01-10',250);
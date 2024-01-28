/*
Toate rezolvările se vor face sub forma de cod T-SQL (script T-SQL).

	 Se dă baza de date Universitate :
Orase
	- Id
	- Denumire
Grupa
	- Id
	- Denumire
Student
	- Id
	- Grupa la care aparține
	- Orașul de resedință
	- Nume
	- Prenume
Materie
	- Id
	- Nume
Note
	- Id
	- Student
	- Materia
	- Nota obținută

Coloanele Id sunt de tip identity, încep de la 1 și pasul este de 1.
Coloanele de tip string trebuie să suporte stocarea datelor cu caractere speciale.

*/

-- 1. Să se creeze baza de date "Universitate" cu collate-ul SQL_Romanian_CP1250_CS_AS

CREATE DATABASE Universitate COLLATE SQL_Romanian_CP1250_CS_AS;
USE Universitate;

-- 2. Să se creeze tabelele din baza "Universitate".

CREATE TABLE Orase
(
	Id 		 int PRIMARY KEY IDENTITY(1,1),
	Denumire nvarchar(20) NOT NULL
);

CREATE TABLE Grupa
(
	Id 		 int PRIMARY KEY IDENTITY(1,1),
	Denumire char NOT NULL
);

CREATE TABLE Student
(
	Id 		int PRIMARY KEY IDENTITY(1,1),
	GrupaId	int NOT NULL,
	OrasId	int NOT NULL,
	Nume 	nvarchar(20) NOT NULL,
	Prenume nvarchar(20) NOT NULL
);

CREATE TABLE Materie
(
	Id 	 int PRIMARY KEY IDENTITY(1,1),
	Nume nvarchar(20) NOT NULL
);

CREATE TABLE Note
(
	Id 		  int PRIMARY KEY IDENTITY(1,1),
	StudentId int NOT NULL,
	MaterieId int NOT NULL,
	Nota 	  int NOT NULL CHECK (Nota > 0 AND Nota <= 10)
);

-- 3. Să se realizeze integritatea bazei de date prin crearea de constrângeri pentru relațiile prezentate.

ALTER TABLE Student
ADD CONSTRAINT fkey_student_grupa
    FOREIGN KEY (GrupaId)
    REFERENCES Grupa (Id) ON DELETE CASCADE;

ALTER TABLE Student
ADD CONSTRAINT fkey_student_oras
    FOREIGN KEY (OrasId)
    REFERENCES Orase (Id) ON DELETE CASCADE;

ALTER TABLE Note
ADD CONSTRAINT fkey_nota_student
    FOREIGN KEY (StudentId)
    REFERENCES Student (Id) ON DELETE CASCADE;

ALTER TABLE Note
ADD CONSTRAINT fkey_nota_materie
    FOREIGN KEY (MaterieId)
    REFERENCES Materie (Id)ON DELETE CASCADE;

-- 4. Să se introducă în baza de date următoarele informații:

/*
Orașe:
Ploiești 
Pitești 
Constanța
București
Călărași 
Iași 
Slobozia 
Sibiu 
Cluj-Napoca 
Brașov 
Fetești 
Satu-Mare 
Oradea 
Cernavodă 
*/
INSERT INTO Orase VALUES
	(N'Ploiești'),
	(N'Pitești'),
	(N'Constanța'),
	(N'București'),
	(N'Călărași'),
	(N'Iași'),
	(N'Slobozia'),
	(N'Sibiu'),
	(N'Cluj-Napoca'),
	(N'Brașov'),
	(N'Fetești'),
	(N'Satu-Mare'),
	(N'Oradea'),
	(N'Cernavodă');

/*
Grupe:
A
B
C
D
*/
INSERT INTO Grupa VALUES ('A'), ('B'), ('C'),('D');

/*
Materii:
Geometrie 
Algebră 
Statistică 
Trigonometrie 
Muzică 
Desen 
Sport 
Filozofie 
Literatură 
Engleză 
Fizică 
Franceză
*/
INSERT INTO Materie VALUES
	(N'Geometrie'),
	(N'Algebră'),
	(N'Statistică'),
	(N'Trigonometrie'),
	(N'Muzică'),
	(N'Desen'),
	(N'Sport'),
	(N'Filozofie'),
	(N'Literatură'),
	(N'Engleză'),
	(N'Fizică'),
	(N'Franceză'),
	(N'Chimie');

/*
Studenți și notele de la examene:
Numele + prenumele, grupa la care aparține, orașul de resedință

		Student															Note								|				
																											|
Popescu	Mihai, grupa A, Ploiești					Chimie	 7			Fizică		4		Franceză	7	|	Fizică 6
Ionescu	Andrei, grupa A, București					Algebră	 5			Statistică	9		Muzică		6	|	Fizică 9, Chimie 10, Sport 8
Ionescu	Andreea, grupa A, Constanța					Sport	 1			Literatură	2		Franceză	9	|	Sport 5, Literatură 4, Literatură 7
Dinu Nicolae, grupa A, Călărași						Chimie	 8			Algebră		9		Statistică	10	|

															 												|
Constantin Ionuț, grupa B, Cernavodă				Algebră	 10			Sport		10		Fizică		8	|
Simion Mihai, grupa B, Iași							Fizică	 8			Algebră		8		Sport		3	|	Sport 3, Sport 1, Sport 1
Constantinescu Ana-Maria, grupa B, Cernavodă		Sport	 5			Fizică		8		Algebră		2	|	Algebră 5
Amăriuței Eugen, grupa B, Iași						Algebră	 6			Sport		10		Franceză	7	|	
Știrbei	Alexandru, grupa B, Sibiu					Chimie	 9			Fizică		2		Sport		1	|	Fizică 2, Fizică 5, Sport 6
															 												|
Dumitru	Angela, grupa C, Brașov						Desen	 9			Filozofie	7		Engleză		9	|
Dumitrache Ion, grupa C, Oradea						Desen	 8			Statistică	2		Filozofie	7	|	Statistică 6
Șerban Maria-Magdalena, grupa C, Oradea				Engleză	 7			Filozofie	4		Desen		8	|	Filozofie 4, Filozofie 4
Chelaru	Violeta, grupa C, Cluj-Napoca 				Franceză 1			Desen		3		Engleză		10	|	Franceză 6, Desen 1
Sandu Daniel, grupa C, Cluj-Napoca 					Desen	 3			Filozofie	9		Franceză	4	|	Desen 8, Franceză 5
															 												|
Marinache Alin, grupa D, Satu-Mare					Desen	 7			Fizică		8		Engleză		5	|
Panait Vasile, grupa D, Satu-Mare 					Sport	 5			Desen		7		Statistică	10	|	Fizică 8, Literatură 6, Filozofie 9
Popa Mirela, grupa D, Fetești						Engleză	 3			Filozofie	6		Desen		6	|	Engleză	6
Dascălu Daniel Ștefan, grupa D, Fetești				Fizică	 4			Franceză	9		Statistică	10	|	Fizică 2, Fizică 1, Fizică 3, Fizică 5
Georgescu Marian, grupa D, Fetești					Franceză 10			Engleză		10		Fizică		8	|
Dumitrașcu Marius, grupa D, Ploiești				Sport	 5			Algebră		6		Chimie		2	|	Chimie 2, Chimie 5	
Dinu Ionela, grupa D, București						Muzică	 9			Literatură	8		Sport		8	|

 ** Notele se introduc în ordinea din listă, ultima înregistrare reprezentând situația curentă la materia respectivă.

*/
INSERT INTO Student VALUES
	((SELECT Id FROM Grupa WHERE Denumire = 'A'), (SELECT Id FROM Orase WHERE Denumire = N'Ploiești'), N'Popescu', N'Mihai'),
	((SELECT Id FROM Grupa WHERE Denumire = 'A'), (SELECT Id FROM Orase WHERE Denumire = N'București'), N'Ionescu', N'Andrei'),
	((SELECT Id FROM Grupa WHERE Denumire = 'A'), (SELECT Id FROM Orase WHERE Denumire = N'Constanța'), N'Ionescu', N'Andreea'),
	((SELECT Id FROM Grupa WHERE Denumire = 'A'), (SELECT Id FROM Orase WHERE Denumire = N'Călărași'), N'Dinu', N'Nicolae'),

	((SELECT Id FROM Grupa WHERE Denumire = 'B'), (SELECT Id FROM Orase WHERE Denumire = N'Cernavodă'), N'Constantin', N'Ionuț'),
	((SELECT Id FROM Grupa WHERE Denumire = 'B'), (SELECT Id FROM Orase WHERE Denumire = N'Iași'), N'Simion', N'Mihai'),
	((SELECT Id FROM Grupa WHERE Denumire = 'B'), (SELECT Id FROM Orase WHERE Denumire = N'Cernavodă'), N'Constantinescu', N'Ana-Maria'),
	((SELECT Id FROM Grupa WHERE Denumire = 'B'), (SELECT Id FROM Orase WHERE Denumire = N'Iași'), N'Amăriuței', N'Eugen'),
	((SELECT Id FROM Grupa WHERE Denumire = 'B'), (SELECT Id FROM Orase WHERE Denumire = N'Sibiu'), N'Știrbei', N'Alexandru'),

	((SELECT Id FROM Grupa WHERE Denumire = 'C'), (SELECT Id FROM Orase WHERE Denumire = N'Brașov'), N'Dumitru', N'Angela'),
	((SELECT Id FROM Grupa WHERE Denumire = 'C'), (SELECT Id FROM Orase WHERE Denumire = N'Oradea'), N'Dumitrache', N'Ion'),
	((SELECT Id FROM Grupa WHERE Denumire = 'C'), (SELECT Id FROM Orase WHERE Denumire = N'Oradea'), N'Șerban', N'Maria-Magdalena'),
	((SELECT Id FROM Grupa WHERE Denumire = 'C'), (SELECT Id FROM Orase WHERE Denumire = N'Cluj-Napoca'), N'Chelaru', N'Violeta'),
	((SELECT Id FROM Grupa WHERE Denumire = 'C'), (SELECT Id FROM Orase WHERE Denumire = N'Cluj-Napoca'), N'Sandu', N'Daniel'),

	((SELECT Id FROM Grupa WHERE Denumire = 'D'), (SELECT Id FROM Orase WHERE Denumire = N'Satu-Mare'), N'Marinache', N'Alin'),
	((SELECT Id FROM Grupa WHERE Denumire = 'D'), (SELECT Id FROM Orase WHERE Denumire = N'Satu-Mare'), N'Panait', N'Panait'),
	((SELECT Id FROM Grupa WHERE Denumire = 'D'), (SELECT Id FROM Orase WHERE Denumire = N'Fetești'), N'Popa', N'Mirela'),
	((SELECT Id FROM Grupa WHERE Denumire = 'D'), (SELECT Id FROM Orase WHERE Denumire = N'Fetești'), N'Dascălu', N'Daniel Ștefan'),
	((SELECT Id FROM Grupa WHERE Denumire = 'D'), (SELECT Id FROM Orase WHERE Denumire = N'Fetești'), N'Georgescu', N'Marian'),
	((SELECT Id FROM Grupa WHERE Denumire = 'D'), (SELECT Id FROM Orase WHERE Denumire = N'Ploiești'), N'Dumitrașcu', N'Marius'),
	((SELECT Id FROM Grupa WHERE Denumire = 'D'), (SELECT Id FROM Orase WHERE Denumire = N'București'), N'Dinu', N'Ionela');

INSERT INTO Note VALUES
	(1, (SELECT Id FROM Materie WHERE Nume = N'Chimie'), 7),
	(1, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 4),
	(1, (SELECT Id FROM Materie WHERE Nume = N'Franceză'), 7),
	(1, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 6),

	(2, (SELECT Id FROM Materie WHERE Nume = N'Algebră'), 5),
	(2, (SELECT Id FROM Materie WHERE Nume = N'Statistică'), 9),
	(2, (SELECT Id FROM Materie WHERE Nume = N'Muzică'), 6),
	(2, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 9),
	(2, (SELECT Id FROM Materie WHERE Nume = N'Chimie'), 10),
	(2, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 8),

	(3, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 1),
	(3, (SELECT Id FROM Materie WHERE Nume = N'Literatură'), 2),
	(3, (SELECT Id FROM Materie WHERE Nume = N'Franceză'), 9),
	(3, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 5),
	(3, (SELECT Id FROM Materie WHERE Nume = N'Literatură'), 4),
	(3, (SELECT Id FROM Materie WHERE Nume = N'Literatură'), 7),

	(4, (SELECT Id FROM Materie WHERE Nume = N'Chimie'), 8),
	(4, (SELECT Id FROM Materie WHERE Nume = N'Algebră'), 9),
	(4, (SELECT Id FROM Materie WHERE Nume = N'Statistică'), 10),

	(5, (SELECT Id FROM Materie WHERE Nume = N'Algebră'), 10),
	(5, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 10),
	(5, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 8),

	(6, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 8),
	(6, (SELECT Id FROM Materie WHERE Nume = N'Algebră'), 8),
	(6, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 3),
	(6, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 3),
	(6, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 1),
	(6, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 1),

	(7, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 5),
	(7, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 8),
	(7, (SELECT Id FROM Materie WHERE Nume = N'Algebră'), 2),
	(7, (SELECT Id FROM Materie WHERE Nume = N'Algebră'), 5),

	(8, (SELECT Id FROM Materie WHERE Nume = N'Algebră'), 6),
	(8, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 10),
	(8, (SELECT Id FROM Materie WHERE Nume = N'Franceză'), 7),

	(9, (SELECT Id FROM Materie WHERE Nume = N'Chimie'), 9),
	(9, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 2),
	(9, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 1),
	(9, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 2),
	(9, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 5),
	(9, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 6),

	(10, (SELECT Id FROM Materie WHERE Nume = N'Desen'), 9),
	(10, (SELECT Id FROM Materie WHERE Nume = N'Filozofie'), 7),
	(10, (SELECT Id FROM Materie WHERE Nume = N'Engleză'), 9),

	(11, (SELECT Id FROM Materie WHERE Nume = N'Desen'), 8),
	(11, (SELECT Id FROM Materie WHERE Nume = N'Statistică'), 2),
	(11, (SELECT Id FROM Materie WHERE Nume = N'Filozofie'), 7),
	(11, (SELECT Id FROM Materie WHERE Nume = N'Statistică'), 6),

	(12, (SELECT Id FROM Materie WHERE Nume = N'Engleză'), 7),
	(12, (SELECT Id FROM Materie WHERE Nume = N'Filozofie'), 4),
	(12, (SELECT Id FROM Materie WHERE Nume = N'Desen'), 8),
	(12, (SELECT Id FROM Materie WHERE Nume = N'Filozofie'), 4),
	(12, (SELECT Id FROM Materie WHERE Nume = N'Filozofie'), 4),

	(13, (SELECT Id FROM Materie WHERE Nume = N'Franceză'), 1),
	(13, (SELECT Id FROM Materie WHERE Nume = N'Desen'), 3),
	(13, (SELECT Id FROM Materie WHERE Nume = N'Engleză'), 10),
	(13, (SELECT Id FROM Materie WHERE Nume = N'Franceză'), 6),
	(13, (SELECT Id FROM Materie WHERE Nume = N'Desen'), 1),

	(14, (SELECT Id FROM Materie WHERE Nume = N'Desen'), 3),
	(14, (SELECT Id FROM Materie WHERE Nume = N'Filozofie'), 9),
	(14, (SELECT Id FROM Materie WHERE Nume = N'Franceză'), 4),
	(14, (SELECT Id FROM Materie WHERE Nume = N'Desen'), 8),
	(14, (SELECT Id FROM Materie WHERE Nume = N'Franceză'), 5),

	(15, (SELECT Id FROM Materie WHERE Nume = N'Desen'), 7),
	(15, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 8),
	(15, (SELECT Id FROM Materie WHERE Nume = N'Engleză'), 5),

	(16, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 5),
	(16, (SELECT Id FROM Materie WHERE Nume = N'Desen'), 7),
	(16, (SELECT Id FROM Materie WHERE Nume = N'Statistică'), 10),
	(16, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 8),
	(16, (SELECT Id FROM Materie WHERE Nume = N'Literatură'), 6),
	(16, (SELECT Id FROM Materie WHERE Nume = N'Filozofie'), 9),

	(17, (SELECT Id FROM Materie WHERE Nume = N'Engleză'), 3),
	(17, (SELECT Id FROM Materie WHERE Nume = N'Filozofie'), 6),
	(17, (SELECT Id FROM Materie WHERE Nume = N'Desen'), 6),
	(17, (SELECT Id FROM Materie WHERE Nume = N'Engleză'), 6),

	(18, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 4),
	(18, (SELECT Id FROM Materie WHERE Nume = N'Franceză'), 9),
	(18, (SELECT Id FROM Materie WHERE Nume = N'Statistică'), 10),
	(18, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 2),
	(18, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 1),
	(18, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 3),
	(18, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 5),

	(19, (SELECT Id FROM Materie WHERE Nume = N'Franceză'), 10),
	(19, (SELECT Id FROM Materie WHERE Nume = N'Engleză'), 10),
	(19, (SELECT Id FROM Materie WHERE Nume = N'Fizică'), 8),

	(20, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 5),
	(20, (SELECT Id FROM Materie WHERE Nume = N'Algebră'), 6),
	(20, (SELECT Id FROM Materie WHERE Nume = N'Chimie'), 2),
	(20, (SELECT Id FROM Materie WHERE Nume = N'Chimie'), 2),
	(20, (SELECT Id FROM Materie WHERE Nume = N'Chimie'), 5),

	(21, (SELECT Id FROM Materie WHERE Nume = N'Muzică'), 9),
	(21, (SELECT Id FROM Materie WHERE Nume = N'Literatură'), 8),
	(21, (SELECT Id FROM Materie WHERE Nume = N'Sport'), 8);


-- 5. Să se afișeze numărul de orașe din provincie.
SELECT COUNT(*) Orase_Provincie FROM Orase WHERE Denumire != N'București';

-- 6. Să se afișeze numărul de materii la care s-au susținut examene.
SELECT COUNT(DISTINCT Nume) Numar_Materii
FROM Note INNER JOIN
	 Materie ON (Note.MaterieId = Materie.Id);

-- 7. Să se afișeze studenții în ordine alfabetică.
SELECT Nume + ' ' + Prenume
FROM Student
ORDER BY Nume, Prenume;

-- 8. Să se afișeze studenții cu 2 prenume (prenumele conține caracterul blanc sau - ( liniuță) ).
SELECT Nume, Prenume
FROM Student
WHERE (SELECT Count(*) FROM STRING_SPLIT(REPLACE(Prenume, '-', ' '), ' ')) = 2;

-- 9. Să se afișeze studenții din provincie.
SELECT Nume + ' ' + Prenume, Orase.Denumire
FROM Student INNER JOIN
	 Orase ON (Student.OrasId = Orase.Id)
WHERE Denumire != N'București';

-- 10. Să se afișeze orașele care nu au nici un student încris.
SELECT Denumire
FROM Orase
WHERE Id NOT IN (SELECT DISTINCT OrasId FROM Student);

-- 11. Să se afișeze grupele care au cel puțin 5 studenți.
SELECT Denumire
FROM Grupa
WHERE (SELECT COUNT(*) FROM Student WHERE Grupa.Id = Student.GrupaId) >= 5;

-- 12. Să se afișeze numele grupei care are cei mai mulți studenți.
SELECT Denumire
FROM Grupa
WHERE Id = (
	SELECT TOP 1 GrupaId
	FROM Student
	GROUP BY GrupaId
	ORDER BY COUNT(GrupaId) DESC
);

-- 13. Să se afișeze materiile la care nu s-a dat niciodată examen.
SELECT Nume
FROM Materie
WHERE Nume NOT IN
	(
		SELECT DISTINCT Nume
		FROM Note INNER JOIN
		Materie ON (Note.MaterieId = Materie.Id)
	);

-- 14. Să se afișeze studenții care au urmat și cursuri opționale ( au notă la mai mult de 3 materii ).
SELECT Nume + ' ' + Prenume Studenti
FROM Student INNER JOIN
	 Note ON (Student.Id = Note.StudentId)
GROUP BY Nume + ' ' + Prenume
HAVING COUNT(DISTINCT MaterieId) > 3;

-- 15. Să se calculeze media generală a fiecărui student ( vezi ** ).
SELECT Nume + ' ' + Prenume Studentul, Media
FROM Student INNER JOIN
(
	SELECT StudentId, AVG(CAST(Nota AS DECIMAL(10,2))) Media
	FROM 
	(
		SELECT StudentId, MaterieId, Nota, ROW_NUMBER() OVER(PARTITION BY StudentId, MaterieId ORDER BY Id DESC) as RN
		FROM Note
	)	n INNER JOIN
		Student ON (n.StudentId = Student.Id)
	WHERE RN = 1
	GROUP BY StudentId
) Mediile ON (Student.Id = Mediile.StudentId);

-- 16. Să se afișeze grupa care are media generală cea mai mare.
SELECT TOP 1 Denumire
FROM Grupa INNER JOIN
(
	SELECT GrupaId, AVG(Media) Media_Grupei
	FROM Student INNER JOIN
	(
		SELECT StudentId, AVG(CAST(Nota AS DECIMAL(10,2))) Media
		FROM 
		(
			SELECT StudentId, MaterieId, Nota, ROW_NUMBER() OVER(PARTITION BY StudentId, MaterieId ORDER BY Id DESC) as RN
			FROM Note
		)	n INNER JOIN
			Student ON (n.StudentId = Student.Id)
		WHERE RN = 1
		GROUP BY StudentId
	) Mediile ON (Student.Id = Mediile.StudentId)
	GROUP BY GrupaId
) m ON (Grupa.Id = m.GrupaId)
ORDER BY Media_Grupei DESC;

-- 17. Să se afișeze studenții bursieri ( care au media generală cel puțin 8,50 ).
SELECT Nume + ' ' + Prenume Bursier
FROM Student INNER JOIN
(
	SELECT StudentId, AVG(CAST(Nota AS DECIMAL(10,2))) Media
	FROM 
	(
		SELECT StudentId, MaterieId, Nota, ROW_NUMBER() OVER(PARTITION BY StudentId, MaterieId ORDER BY Id DESC) as RN
		FROM Note
	)	n INNER JOIN
		Student ON (n.StudentId = Student.Id)
	WHERE RN = 1
	GROUP BY StudentId
) Mediile ON (Student.Id = Mediile.StudentId)
WHERE Media >= 8.5;

-- 18. Să se afișeze studenții care nu au promovat materia "Chimie" de la prima examinare, dar au promovat ulterior.
SELECT Nume + ' ' + Prenume
FROM
(
    SELECT Nume, Prenume, StudentId, MaterieId, Nota, ROW_NUMBER() OVER(PARTITION BY StudentId, MaterieId ORDER BY Note.Id DESC) as RN
	FROM Note INNER JOIN
		 Student ON (Note.StudentId = Student.Id)
	WHERE MaterieId = (SELECT Id FROM Materie WHERE Nume = N'Chimie')
) q
GROUP BY Nume + ' ' + Prenume
HAVING COUNT(RN) > 1;

-- 19. Să se afișeze studentul care a susținut cele mai multe examinări la aceeași materie.
WITH Examinari
AS
(
	SELECT StudentId, MAX(Numar_Examinari) Examinari_Student
	FROM Student INNER JOIN
	(
		SELECT StudentId, MaterieId, COUNT(MaterieId) Numar_Examinari
		FROM Note INNER JOIN
			 Student ON (Note.StudentId = Student.Id)
		GROUP BY StudentId, MaterieId
	) q1 ON Student.Id = q1.StudentId
	GROUP BY StudentId
)
SELECT Nume, Prenume
FROM Student INNER JOIN
	 Examinari ON (Student.Id = Examinari.StudentId)
WHERE Examinari_Student = (SELECT MAX(Examinari_Student) FROM Examinari);

-- 20. Să se afișeze studenții și numărul de examinări la fiecare materie în parte.
SELECT Student.Nume + ' ' + Student.Prenume, Materie.Nume Materie, Numar_Examinari
FROM (
	SELECT StudentId, MaterieId, COUNT(MaterieId) Numar_Examinari
	FROM Note INNER JOIN
		Student ON (Note.StudentId = Student.Id)
	GROUP BY MaterieId, StudentId
	) q INNER JOIN
	Student ON (q.StudentId = Student.Id) INNER JOIN
	Materie ON (q.MaterieId = Materie.Id);

-- 21. Să se afișeze studenții repetenți (au picat cel puțin o materie ).
SELECT DISTINCT (Nume + ' ' + Prenume) Repetenti
FROM 
(
	SELECT StudentId, MaterieId, Nota, ROW_NUMBER() OVER(PARTITION BY StudentId, MaterieId ORDER BY Id DESC) as RN
	FROM Note
)	n INNER JOIN
	Student ON (n.StudentId = Student.Id)
WHERE RN = 1 AND Nota < 5;

-- 22. Să se mute toți repetenții într-o grupă nouă, grupa E. ( vezi pct. anterior)
INSERT INTO Grupa VALUES ('E');

UPDATE Student
SET GrupaId = (SELECT Id FROM Grupa WHERE Denumire = 'E')
WHERE Id IN (
	SELECT DISTINCT StudentId
	FROM
	(
		SELECT StudentId, MaterieId, Nota, ROW_NUMBER() OVER(PARTITION BY StudentId, MaterieId ORDER BY Id DESC) as RN
		FROM Note
	)	n INNER JOIN
		Student ON (n.StudentId = Student.Id)
	WHERE RN = 1 AND Nota < 5
);

-- 23. Cel mai slab student este exmatriculat. Să se șteargă studentul din baza de date.
WITH Medii
AS
(
	SELECT StudentId, AVG(CAST(Nota AS DECIMAL(10,2))) Media
	FROM 
	(
		SELECT StudentId, MaterieId, Nota, ROW_NUMBER() OVER(PARTITION BY StudentId, MaterieId ORDER BY Id DESC) as RN
		FROM Note
	)	n INNER JOIN
		Student ON (n.StudentId = Student.Id)
	WHERE RN = 1
	GROUP BY StudentId
)
DELETE FROM Student
WHERE Id = (
	SELECT StudentId
	FROM Student INNER JOIN
		 Medii ON (Student.Id = Medii.StudentId)
	WHERE Media = (SELECT MIN(Media) FROM Medii)
);

SELECT * FROM Student;

-- 24. Să se afișeze toți studenții care fac parte din aceeași familie ( au același nume de familie ), după modelul:
/*
	Nume		Prenume
	Ionescu		Andrei
	Ionescu		Andreea

	Rezultat afișat:

	Familia		Frații
	Ionescu		Andrei, Andreea
*/
SELECT Nume Familia, STRING_AGG(Prenume, ', ') Frații
FROM Student
GROUP BY Nume
HAVING COUNT(Nume) > 1;
USE master;

DROP DATABASE IF EXISTS SportEvent;
--DROP TABLE IF EXISTS Versus;
--DROP TABLE IF EXISTS Sportman;
--DROP TABLE IF EXISTS City;
--DROP TABLE IF EXISTS LocatedIn;
--DROP TABLE IF EXISTS ParticipateIn;
--DROP TABLE IF EXISTS Tournament;

CREATE DATABASE SportEvent;

USE SportEvent;

CREATE TABLE Sportman
(
	id int NOT NULL PRIMARY KEY IDENTITY,
	[name] NVARCHAR(50) NOT NULL
) AS NODE

CREATE TABLE Tournament
(
	id int NOT NULL PRIMARY KEY IDENTITY,
	[name] NVARCHAR(50) NOT NULL,
	[prize_pool] Money NULL,
) AS NODE

CREATE TABLE City
(
	id int NOT NULL PRIMARY KEY IDENTITY,
	[name] NVARCHAR(50) NOT NULL
) AS NODE

CREATE TABLE Versus (result NVARCHAR(1)) AS EDGE;

ALTER TABLE Versus
ADD CONSTRAINT CK_result CHECK (result in ('W','L','D'))

ALTER TABLE Versus 
ADD CONSTRAINT EC_Versus CONNECTION (Sportman TO Sportman);

CREATE TABLE ParticipateIn AS EDGE;
ALTER TABLE ParticipateIn 
ADD CONSTRAINT EC_ParticipateIn CONNECTION (Sportman TO Tournament);

CREATE TABLE HoldIn ([time] DATE) as EDGE;
ALTER TABLE HoldIn 
ADD CONSTRAINT EC_HoldIn CONNECTION (Tournament TO City);


INSERT INTO Sportman ([name]) VALUES
(N'Иванов'),
(N'Петров'),
(N'Смирнов'),
(N'Васильева'),
(N'Новикова'),
(N'Сидоров'),
(N'Попов'),
(N'Кузнецов'),
(N'Волкова'),
(N'Морозова');

INSERT INTO City ([name]) VALUES 
(N'Нью-Йорк'),
(N'Лондон'),
(N'Париж'),
(N'Токио'),
(N'Сидней'),
(N'Гонконг'),
(N'Рим'),
(N'Москва'),
(N'Берлин'),
(N'Амстердам');

INSERT INTO Tournament ([name], [prize_pool]) VALUES
(N'Чемпионат мира', 10000.00),
(N'Чемпионат Европы', 5000.00),
(N'Гранд-при', 20000.00),
(N'Open Australia', NULL),
(N'Олимпийские игры', 15000.00),
(N'Лига чемпиона', 8000.00),
(N'Паралимпиада', 3000.00),
(N'Физкульт-привет', 12000.00),
(N'Спорт - это жизнь', 6000.00),
(N'Азбука спорта', 9000.00);

INSERT INTO Versus ($from_id, $to_id, result)
VALUES 
((SELECT $node_id FROM Sportman WHERE id = 1),(SELECT $node_id FROM Sportman WHERE id = 2),'L'),
((SELECT $node_id FROM Sportman WHERE id = 1),(SELECT $node_id FROM Sportman WHERE id = 3),'D'),
((SELECT $node_id FROM Sportman WHERE id = 1),(SELECT $node_id FROM Sportman WHERE id = 5),'W'),
((SELECT $node_id FROM Sportman WHERE id = 1),(SELECT $node_id FROM Sportman WHERE id = 6),'W'),
((SELECT $node_id FROM Sportman WHERE id = 2),(SELECT $node_id FROM Sportman WHERE id = 8),'D'),
((SELECT $node_id FROM Sportman WHERE id = 3),(SELECT $node_id FROM Sportman WHERE id = 4),'D'),
((SELECT $node_id FROM Sportman WHERE id = 3),(SELECT $node_id FROM Sportman WHERE id = 9),'D'),
((SELECT $node_id FROM Sportman WHERE id = 4),(SELECT $node_id FROM Sportman WHERE id = 5),'W'),
((SELECT $node_id FROM Sportman WHERE id = 4),(SELECT $node_id FROM Sportman WHERE id = 10),'D'),
((SELECT $node_id FROM Sportman WHERE id = 5),(SELECT $node_id FROM Sportman WHERE id = 6),'L'),
((SELECT $node_id FROM Sportman WHERE id = 6),(SELECT $node_id FROM Sportman WHERE id = 3),'W'),
((SELECT $node_id FROM Sportman WHERE id = 6),(SELECT $node_id FROM Sportman WHERE id = 8),'W'),
((SELECT $node_id FROM Sportman WHERE id = 6),(SELECT $node_id FROM Sportman WHERE id = 10),'W'),
((SELECT $node_id FROM Sportman WHERE id = 7),(SELECT $node_id FROM Sportman WHERE id = 1),'L'),
((SELECT $node_id FROM Sportman WHERE id = 7),(SELECT $node_id FROM Sportman WHERE id = 9),'L'),
((SELECT $node_id FROM Sportman WHERE id = 9),(SELECT $node_id FROM Sportman WHERE id = 2),'D'),
((SELECT $node_id FROM Sportman WHERE id = 10),(SELECT $node_id FROM Sportman WHERE id = 2),'W'),
((SELECT $node_id FROM Sportman WHERE id = 10),(SELECT $node_id FROM Sportman WHERE id = 5),'L'),
((SELECT $node_id FROM Sportman WHERE id = 10),(SELECT $node_id FROM Sportman WHERE id = 3),'W');

INSERT INTO ParticipateIn ($from_id, $to_id)
VALUES 
((SELECT $node_id FROM Sportman WHERE id = 1),(SELECT $node_id FROM Tournament WHERE id = 1)),
((SELECT $node_id FROM Sportman WHERE id = 2),(SELECT $node_id FROM Tournament WHERE id = 1)),
((SELECT $node_id FROM Sportman WHERE id = 6),(SELECT $node_id FROM Tournament WHERE id = 1)),
((SELECT $node_id FROM Sportman WHERE id = 8),(SELECT $node_id FROM Tournament WHERE id = 1)),

((SELECT $node_id FROM Sportman WHERE id = 1),(SELECT $node_id FROM Tournament WHERE id = 2)),
((SELECT $node_id FROM Sportman WHERE id = 3),(SELECT $node_id FROM Tournament WHERE id = 2)),
((SELECT $node_id FROM Sportman WHERE id = 4),(SELECT $node_id FROM Tournament WHERE id = 2)),
((SELECT $node_id FROM Sportman WHERE id = 5),(SELECT $node_id FROM Tournament WHERE id = 2)),
((SELECT $node_id FROM Sportman WHERE id = 6),(SELECT $node_id FROM Tournament WHERE id = 2)),

((SELECT $node_id FROM Sportman WHERE id = 3),(SELECT $node_id FROM Tournament WHERE id = 3)),
((SELECT $node_id FROM Sportman WHERE id = 9),(SELECT $node_id FROM Tournament WHERE id = 3)),
((SELECT $node_id FROM Sportman WHERE id = 2),(SELECT $node_id FROM Tournament WHERE id = 3)),
((SELECT $node_id FROM Sportman WHERE id = 7),(SELECT $node_id FROM Tournament WHERE id = 3)),

((SELECT $node_id FROM Sportman WHERE id = 4),(SELECT $node_id FROM Tournament WHERE id = 4)),
((SELECT $node_id FROM Sportman WHERE id = 10),(SELECT $node_id FROM Tournament WHERE id = 4)),
((SELECT $node_id FROM Sportman WHERE id = 5),(SELECT $node_id FROM Tournament WHERE id = 4)),

((SELECT $node_id FROM Sportman WHERE id = 6),(SELECT $node_id FROM Tournament WHERE id = 5)),
((SELECT $node_id FROM Sportman WHERE id = 10),(SELECT $node_id FROM Tournament WHERE id = 5)),
((SELECT $node_id FROM Sportman WHERE id = 3),(SELECT $node_id FROM Tournament WHERE id = 5)),

((SELECT $node_id FROM Sportman WHERE id = 7),(SELECT $node_id FROM Tournament WHERE id = 6)),
((SELECT $node_id FROM Sportman WHERE id = 1),(SELECT $node_id FROM Tournament WHERE id = 6)),

((SELECT $node_id FROM Sportman WHERE id = 2),(SELECT $node_id FROM Tournament WHERE id = 7)),
((SELECT $node_id FROM Sportman WHERE id = 10),(SELECT $node_id FROM Tournament WHERE id = 7));


INSERT INTO HoldIn ($from_id, $to_id, [time])
VALUES 
((SELECT $node_id FROM Tournament WHERE id = 1),(SELECT $node_id FROM City WHERE id = 1),'2022-11-29'),
((SELECT $node_id FROM Tournament WHERE id = 2),(SELECT $node_id FROM City WHERE id = 1),'1990-01-15'),
((SELECT $node_id FROM Tournament WHERE id = 3),(SELECT $node_id FROM City WHERE id = 2),'2024-04-09'),
((SELECT $node_id FROM Tournament WHERE id = 4),(SELECT $node_id FROM City WHERE id = 3),'2023-09-23'),
((SELECT $node_id FROM Tournament WHERE id = 5),(SELECT $node_id FROM City WHERE id = 4),'2021-01-01'),
((SELECT $node_id FROM Tournament WHERE id = 6),(SELECT $node_id FROM City WHERE id = 5),'2000-04-10'),
((SELECT $node_id FROM Tournament WHERE id = 7),(SELECT $node_id FROM City WHERE id = 6),'2024-03-27'),
((SELECT $node_id FROM Tournament WHERE id = 8),(SELECT $node_id FROM City WHERE id = 7),'2025-12-12'),
((SELECT $node_id FROM Tournament WHERE id = 9),(SELECT $node_id FROM City WHERE id = 8),'2025-11-11'),
((SELECT $node_id FROM Tournament WHERE id = 10),(SELECT $node_id FROM City WHERE id = 9),'2024-09-01'),
((SELECT $node_id FROM Tournament WHERE id = 1),(SELECT $node_id FROM City WHERE id = 10),'2026-01-01');


--ввести всех противник одного спортсмена
DECLARE @Name NVARCHAR(50) = N'Иванов'
SELECT S1.name, S2.name as opponent, result
FROM Sportman as S1
	, VERSUS
	, Sportman as S2
WHERE MATCH(S1-(VERSUS)->S2) AND S1.name = @Name

--в каком турнире играли противники одного из спортсменов
DECLARE @Name NVARCHAR(50) = N'Иванов'
SELECT DISTINCT S2.name as opponent, STRING_AGG(T.name, ', ') as [tournament]
FROM Sportman as S1
	, VERSUS as V
	, Sportman as S2
	, ParticipateIn as P
	, Tournament as T
WHERE MATCH(S1-(V)->S2-(P)->T) AND S1.name = @Name
GROUP BY S2.name

--Какой из городов принимал больше всего турниров и вывести количетво
SELECT TOP(1) WITH TIES C.name, COUNT(*) as [num]
FROM Tournament as T
	, HoldIn as H
	, City as C
WHERE MATCH(T-(H)->C)
Group by C.name
ORDER BY COUNT(*) desc


--В каких из городов играл соперники одного из спортсменов
DECLARE @Name NVARCHAR(50) = N'Иванов'
SELECT DISTINCT S2.name as opponent,C.name
FROM Sportman as S1
	, VERSUS as V
	, Sportman as S2
	, ParticipateIn as P
	, Tournament as T
	, HoldIn as H
	, City as C
WHERE MATCH(S1-(V)->S2-(P)->T-(H)->C) AND S1.name = @Name

--Кому проигровали соперники одного из спортсменов
DECLARE @Name NVARCHAR(50) = N'Иванов'
SELECT S2.name, S3.name as oppenent ,V1.result
FROM Sportman as S1
	, VERSUS as V
	, Sportman as S2
	, VERSUS as V1,
	Sportman as S3
WHERE MATCH(S1-(V)->S2-(V1)->S3) AND S1.name = @Name and V1.result = 'L'

-- Ввести соперника соперника и т.д. одного из спортсменов 
DECLARE @Name NVARCHAR(50) = N'Иванов'
SELECT 
    S1.name
    , STRING_AGG(S2.name , '->') WITHIN GROUP (GRAPH PATH) AS Oppenents
FROM Sportman AS S1
	, VERSUS FOR PATH AS V
	, Sportman FOR PATH AS S2
WHERE MATCH(SHORTEST_PATH(S1( -(V)->S2 ) + )) and S1.name = @Name

--Показать спортсменов, которые игради дург с другом за 2 шага
DECLARE @Name NVARCHAR(50) = N'Иванов'
SELECT 
    S1.name
    , STRING_AGG(S2.name , '->') WITHIN GROUP (GRAPH PATH) AS Oppenents
FROM Sportman AS S1
	, VERSUS FOR PATH AS V
	, Sportman FOR PATH AS S2
WHERE MATCH(SHORTEST_PATH(S1( -(V)->S2 ){1,2})) and S1.name = @Name































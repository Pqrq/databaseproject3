DROP DATABASE IF EXISTS VolleyDB;
CREATE DATABASE VolleyDB;
USE VolleyDB;

CREATE TABLE DBManager (
username VARCHAR(100),
password VARCHAR(100),
PRIMARY KEY (username)
);

CREATE TABLE User (
username VARCHAR(100),
password VARCHAR(100),
name VARCHAR(100),
surname VARCHAR(100),
PRIMARY KEY (username)
);
CREATE TABLE Player (
username VARCHAR(100),
date_of_birth DATE,
height INT,
weight INT,
PRIMARY KEY (username)
/*,FOREIGN KEY (username) REFERENCES User(username)*/
);
CREATE TABLE Positions (
position_id INT,
position_name VARCHAR(100),
PRIMARY KEY (position_id)
);
CREATE TABLE Nation (
nationality VARCHAR(3),
PRIMARY KEY (nationality)
);
CREATE TABLE Coaches (
username VARCHAR(100),
nationality VARCHAR(3) NOT NULL,
PRIMARY KEY (username)/*,
FOREIGN KEY (username) REFERENCES User(username),
FOREIGN KEY (nationality) REFERENCES Nation(nationality)*/
);
CREATE TABLE Juries (
username VARCHAR(100),
nationality VARCHAR(3) NOT NULL,
PRIMARY KEY (username)/*,
FOREIGN KEY (username) REFERENCES User(username),
FOREIGN KEY (nationality) REFERENCES Nation(nationality)*/
);
CREATE TABLE Channel (
channel_id INT,
channel_name VARCHAR(100) unique,
PRIMARY KEY (channel_id)
);
CREATE TABLE Team (
team_id INT,
channel_id INT NOT NULL,
team_name VARCHAR(100),
coach_username VARCHAR(100) NOT NULL,
contract_start DATE,
contract_finish DATE,
PRIMARY KEY (team_id)/*,
FOREIGN KEY (channel_id) REFERENCES Channel(channel_id)*/
);
CREATE TABLE Stadium (
stadium_id INT,
stadium_name VARCHAR(100) UNIQUE,
stadium_country VARCHAR(3) NOT NULL,
PRIMARY KEY (stadium_id)/*,
FOREIGN KEY (stadium_country) REFERENCES Nation(nationality)*/
);
CREATE TABLE MatchSessions (
    session_id INT AUTO_INCREMENT,
    date DATE,
    team_id INT NOT NULL,
    assigned_jury_username VARCHAR(100) NOT NULL,
    time_slot INT,
    stadium_id INT NOT NULL,
    rating FLOAT,
    PRIMARY KEY (session_id),
    CHECK (time_slot <= 3 AND time_slot >=1)
    /*,
    FOREIGN KEY (team_id) REFERENCES Team(team_id),
    FOREIGN KEY (assigned_jury_username) REFERENCES Juries(username),
    FOREIGN KEY (stadium_id) REFERENCES Stadium(stadium_id)*/
); 

CREATE TABLE PlayerTeams (
username VARCHAR(100),
team_id INT,
PRIMARY KEY (username, team_id)/*,
FOREIGN KEY (username) REFERENCES Player(username),
FOREIGN KEY (team_id) REFERENCES Team(team_id)*/
);
CREATE TABLE PlayerPositions (
username VARCHAR(100),
position_id INT,
PRIMARY KEY (username, position_id)/*,
FOREIGN KEY (username) REFERENCES Player(username),
FOREIGN KEY (position_id) REFERENCES Positions(position_id)*/
);
CREATE TABLE SessionSquads(
username VARCHAR(100),
session_id INT,
position_id INT,
PRIMARY KEY (username, session_id)/*,
FOREIGN KEY (username) REFERENCES Player(username),
FOREIGN KEY (session_id) REFERENCES MatchSessions(session_id),
FOREIGN KEY (position_id) REFERENCES Positions(position_id)*/
);

-- DB Managers
INSERT INTO DBManager (username, password) VALUES ('Kevin','Kevin');
INSERT INTO DBManager (username, password) VALUES ('Bob','Bob');
INSERT INTO DBManager (username, password) VALUES ('sorunlubirarkadas','muvaffakiyetsizleştiricileştiriveremeyebileceklerimizdenmişsinizcesine');

-- Player's positions
INSERT INTO PlayerPositions (username, position_id) VALUES ('g_orge', '0');
INSERT INTO PlayerPositions (username, position_id) VALUES ('g_orge', '3');
INSERT INTO PlayerPositions (username, position_id) VALUES ('c_ozbay', '1');
INSERT INTO PlayerPositions (username, position_id) VALUES ('m_vargas', '2');
INSERT INTO PlayerPositions (username, position_id) VALUES ('h_baladin', '3');
INSERT INTO PlayerPositions (username, position_id) VALUES ('a_kalac', '4');
INSERT INTO PlayerPositions (username, position_id) VALUES ('ee_dundar', '4');
INSERT INTO PlayerPositions (username, position_id) VALUES ('z_gunes', '4');
INSERT INTO PlayerPositions (username, position_id) VALUES ('i_aydin', '1');
INSERT INTO PlayerPositions (username, position_id) VALUES ('i_aydin', '3');
INSERT INTO PlayerPositions (username, position_id) VALUES ('e_sahin', '1');
INSERT INTO PlayerPositions (username, position_id) VALUES ('e_sahin', '3');
INSERT INTO PlayerPositions (username, position_id) VALUES ('e_karakurt', '2');
INSERT INTO PlayerPositions (username, position_id) VALUES ('e_karakurt', '3');
INSERT INTO PlayerPositions (username, position_id) VALUES ('s_akoz', '0');
INSERT INTO PlayerPositions (username, position_id) VALUES ('k_akman', '0');
INSERT INTO PlayerPositions (username, position_id) VALUES ('k_akman', '4');
INSERT INTO PlayerPositions (username, position_id) VALUES ('d_cebecioglu', '3');
INSERT INTO PlayerPositions (username, position_id) VALUES ('d_cebecioglu', '4');
INSERT INTO PlayerPositions (username, position_id) VALUES ('a_aykac', '0');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_2826', '2');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_2826', '1');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_9501', '0');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_9501', '4');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_3556', '1');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_3556', '0');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_7934', '4');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_7934', '2');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_4163', '3');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_4163', '0');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_2835', '2');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_2835', '3');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_8142', '1');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_8142', '3');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_2092', '4');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_2092', '2');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_3000', '1');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_3000', '4');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_8323', '3');
INSERT INTO PlayerPositions (username, position_id) VALUES ('user_8323', '2');

INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('g_orge', '0', '0');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('c_ozbay', '0', '1');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('m_vargas', '0', '2');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('h_baladin', '0', '3');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('a_kalac', '0', '4');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('ee_dundar', '0', '4');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('c_ozbay', '1', '1');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('m_vargas', '1', '2');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('i_aydin', '1', '1');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('a_kalac', '1', '4');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('s_akoz', '1', '0');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('d_cebecioglu', '1', '3');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('g_orge', '2', '3');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('m_vargas', '2', '2');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('c_ozbay', '2', '1');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('a_kalac', '2', '4');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('s_akoz', '2', '0');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('a_aykac', '2', '0');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('ee_dundar', '3', '4');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('h_baladin', '3', '3');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('z_gunes', '3', '4');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('i_aydin', '3', '3');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('e_karakurt', '3', '2');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('k_akman', '3', '0');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('user_2826', '4', '2');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('user_9501', '4', '0');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('user_3556', '4', '1');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('user_7934', '4', '4');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('user_4163', '4', '3');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('user_2835', '4', '2');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('user_2826', '5', '1');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('user_9501', '5', '4');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('user_3556', '5', '0');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('user_7934', '5', '2');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('user_4163', '5', '0');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('user_2835', '5', '3');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('g_orge', '6', '0');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('m_vargas', '6', '2');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('c_ozbay', '6', '1');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('a_kalac', '6', '4');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('e_karakurt', '6', '3');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('a_aykac', '6', '0');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('g_orge', '7', '3');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('m_vargas', '7', '2');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('c_ozbay', '7', '1');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('a_kalac', '7', '4');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('e_karakurt', '7', '2');
INSERT INTO SessionSquads (username, session_id, position_id) VALUES ('a_aykac', '7', '0');

-- Match Sessions
INSERT INTO MatchSessions (date, team_id, assigned_jury_username, time_slot, stadium_id, rating) VALUES (str_to_date('10.03.2024','%d.%m.%Y'), '0', 'o_ozcelik', '1', '0', '4.5');
INSERT INTO MatchSessions (date, team_id, assigned_jury_username, time_slot, stadium_id, rating) VALUES (str_to_date('03.04.2024','%d.%m.%Y'), '1', 'o_ozcelik', '1', '1', '4.9');
INSERT INTO MatchSessions (date, team_id, assigned_jury_username, time_slot, stadium_id, rating) VALUES (str_to_date('03.04.2024','%d.%m.%Y'), '0', 'o_ozcelik', '3', '1', '4.4');
INSERT INTO MatchSessions (date, team_id, assigned_jury_username, time_slot, stadium_id, rating) VALUES (str_to_date('03.04.2024','%d.%m.%Y'), '2', 'm_sevinc', '2', '2', '4.9');
INSERT INTO MatchSessions (date, team_id, assigned_jury_username, time_slot, stadium_id, rating) VALUES (str_to_date('03.04.2023','%d.%m.%Y'), '3', 'e_sener', '2', '2', '4.5');
INSERT INTO MatchSessions (date, team_id, assigned_jury_username, time_slot, stadium_id, rating) VALUES (str_to_date('27.05.2023','%d.%m.%Y'), '3', 's_engin', '1', '1', '4.4');
INSERT INTO MatchSessions (date, team_id, assigned_jury_username, time_slot, stadium_id, rating) VALUES (str_to_date('01.09.2022','%d.%m.%Y'), '0', 'm_sevinc', '1', '1', '4.6');
INSERT INTO MatchSessions (date, team_id, assigned_jury_username, time_slot, stadium_id, rating) VALUES (str_to_date('02.05.2023','%d.%m.%Y'), '0', 'o_ozcelik', '3', '2', '4.7');
INSERT INTO MatchSessions (date, team_id, assigned_jury_username, time_slot, stadium_id, rating) VALUES (str_to_date('10.03.2024','%d.%m.%Y'), '1', 'o_ozcelik', '1', '0', '4.5');

-- Juries
INSERT INTO User (username, password, name, surname)
VALUES
    ('o_ozcelik', 'ozlem.0347', 'Özlem', 'Özçelik'),
    ('m_sevinc', 'mehmet.0457', 'Mehmet', 'Sevinç'),
    ('e_sener', 'ertem.4587', 'Ertem', 'Şener'),
    ('s_engin', 'sinan.6893', 'Sinan', 'Engin');

INSERT INTO Juries (username, nationality)
VALUES
    ('o_ozcelik', 'TR'),
    ('m_sevinc', 'TR'),
    ('e_sener', 'TR'),
    ('s_engin', 'TR');

-- Positions
INSERT INTO Positions (position_id, position_name) VALUES ('0', 'Libero');
INSERT INTO Positions (position_id, position_name) VALUES ('1', 'Setter');
INSERT INTO Positions (position_id, position_name) VALUES ('2', 'Opposite hitter');
INSERT INTO Positions (position_id, position_name) VALUES ('3', 'Outside hitter');
INSERT INTO Positions (position_id, position_name) VALUES ('4', 'Middle blocker');

-- Coaches
INSERT INTO User (username, password, name, surname)
VALUES
    ('d_santarelli', 'santa.really1', 'Daniele', 'Santarelli'),
    ('g_guidetti', 'guidgio.90', 'Giovanni', 'Guidetti'),
    ('f_akbas', 'a.fatih55', 'Ferhat', 'Akbaş'),
    ('m_hebert', 'm.hebert45', 'Mike', 'Hebert'),
    ('o_deriviere', 'oliviere_147', 'Oliviere', 'Deriviere'),
    ('a_derune', 'aderune_147', 'Amicia', 'DeRune');

-- Insertions into the Coaches table
INSERT INTO Coaches (username, nationality)
VALUES
    ('d_santarelli', 'ITA'),
    ('g_guidetti', 'ITA'),
    ('f_akbas', 'TR'),
    ('m_hebert', 'US'),
    ('o_deriviere', 'FR'),
    ('a_derune', 'FR');

-- Teams
INSERT INTO Team (team_id, channel_id, team_name, coach_username, contract_start, contract_finish) VALUES ('0', '0', 'Women A', 'd_santarelli', str_to_date('25.12.2021','%d.%m.%Y'), str_to_date('12.12.2025','%d.%m.%Y'));
INSERT INTO Team (team_id, channel_id, team_name, coach_username, contract_start, contract_finish) VALUES ('1', '1', 'Women B', 'g_guidetti', str_to_date('11.09.2021','%d.%m.%Y'), str_to_date('11.09.2026','%d.%m.%Y'));
INSERT INTO Team (team_id, channel_id, team_name, coach_username, contract_start, contract_finish) VALUES ('2', '0', 'U19', 'f_akbas', str_to_date('10.08.2021','%d.%m.%Y'), str_to_date('10.08.2026','%d.%m.%Y'));
INSERT INTO Team (team_id, channel_id, team_name, coach_username, contract_start, contract_finish) VALUES ('3', '1', 'Women B', 'f_akbas', str_to_date('10.08.2000','%d.%m.%Y'), str_to_date('10.08.2015','%d.%m.%Y'));
INSERT INTO Team (team_id, channel_id, team_name, coach_username, contract_start, contract_finish) VALUES ('4', '1', 'Women C', 'm_hebert', str_to_date('01.04.2024','%d.%m.%Y'), str_to_date('21.07.2026','%d.%m.%Y'));
INSERT INTO Team (team_id, channel_id, team_name, coach_username, contract_start, contract_finish) VALUES ('5', '2', 'U19', 'o_deriviere', str_to_date('10.08.2015','%d.%m.%Y'), str_to_date('09.08.2020','%d.%m.%Y'));
INSERT INTO Team (team_id, channel_id, team_name, coach_username, contract_start, contract_finish) VALUES ('6', '2', 'U19', 'a_derune', str_to_date('10.08.2005','%d.%m.%Y'), str_to_date('10.08.2010','%d.%m.%Y'));

-- Players' teams
INSERT INTO PlayerTeams (username, team_id) VALUES ('g_orge', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('c_ozbay', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('c_ozbay', '1');
INSERT INTO PlayerTeams (username, team_id) VALUES ('m_vargas', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('m_vargas', '1');
INSERT INTO PlayerTeams (username, team_id) VALUES ('h_baladin', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('h_baladin', '2');
INSERT INTO PlayerTeams (username, team_id) VALUES ('a_kalac', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('a_kalac', '1');
INSERT INTO PlayerTeams (username, team_id) VALUES ('ee_dundar', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('ee_dundar', '2');
INSERT INTO PlayerTeams (username, team_id) VALUES ('z_gunes', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('z_gunes', '2');
INSERT INTO PlayerTeams (username, team_id) VALUES ('i_aydin', '1');
INSERT INTO PlayerTeams (username, team_id) VALUES ('i_aydin', '2');
INSERT INTO PlayerTeams (username, team_id) VALUES ('e_sahin', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('e_karakurt', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('e_karakurt', '2');
INSERT INTO PlayerTeams (username, team_id) VALUES ('s_akoz', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('s_akoz', '1');
INSERT INTO PlayerTeams (username, team_id) VALUES ('k_akman', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('k_akman', '2');
INSERT INTO PlayerTeams (username, team_id) VALUES ('d_cebecioglu', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('d_cebecioglu', '1');
INSERT INTO PlayerTeams (username, team_id) VALUES ('a_aykac', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_2826', '2');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_2826', '3');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_9501', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_9501', '3');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_3556', '2');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_3556', '3');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_7934', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_7934', '3');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_4163', '1');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_4163', '3');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_2835', '2');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_2835', '3');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_8142', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_8142', '3');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_2092', '2');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_2092', '3');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_3000', '2');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_3000', '3');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_8323', '0');
INSERT INTO PlayerTeams (username, team_id) VALUES ('user_8323', '3');

-- Players
INSERT INTO User (username, password, name, surname) VALUES ('g_orge', 'Go.1993', 'Gizem', 'Örge');
INSERT INTO User (username, password, name, surname) VALUES ('c_ozbay', 'Co.1996', 'Cansu', 'Özbay');
INSERT INTO User (username, password, name, surname) VALUES ('m_vargas', 'Mv.1999', 'Melissa', 'Vargas');
INSERT INTO User (username, password, name, surname) VALUES ('h_baladin', 'Hb.2007', 'Hande', 'Baladın');
INSERT INTO User (username, password, name, surname) VALUES ('a_kalac', 'Ak.1995', 'Aslı', 'Kalaç');
INSERT INTO User (username, password, name, surname) VALUES ('ee_dundar', 'Eed.2008', 'Eda Erdem', 'Dündar');
INSERT INTO User (username, password, name, surname) VALUES ('z_gunes', 'Zg.2008', 'Zehra', 'Güneş');
INSERT INTO User (username, password, name, surname) VALUES ('i_aydin', 'Ia.2007', 'İlkin', 'Aydın');
INSERT INTO User (username, password, name, surname) VALUES ('e_sahin', 'Es.2001', 'Elif', 'Şahin');
INSERT INTO User (username, password, name, surname) VALUES ('e_karakurt', 'Ek.2006', 'Ebrar', 'Karakurt');
INSERT INTO User (username, password, name, surname) VALUES ('s_akoz', 'Sa.1991', 'Simge', 'Aköz');
INSERT INTO User (username, password, name, surname) VALUES ('k_akman', 'Ka.2006', 'Kübra', 'Akman');
INSERT INTO User (username, password, name, surname) VALUES ('d_cebecioglu', 'Dc.2007', 'Derya', 'Cebecioğlu');
INSERT INTO User (username, password, name, surname) VALUES ('a_aykac', 'Aa.1996', 'Ayşe', 'Aykaç');
INSERT INTO User (username, password, name, surname) VALUES ('user_2826', 'P.45825', 'Brenda', 'Schulz');
INSERT INTO User (username, password, name, surname) VALUES ('user_9501', 'P.99695', 'Erika', 'Foley');
INSERT INTO User (username, password, name, surname) VALUES ('user_3556', 'P.49595', 'Andrea', 'Campbell');
INSERT INTO User (username, password, name, surname) VALUES ('user_7934', 'P.24374', 'Beatrice', 'Bradley');
INSERT INTO User (username, password, name, surname) VALUES ('user_4163', 'P.31812', 'Betsey', 'Lenoir');
INSERT INTO User (username, password, name, surname) VALUES ('user_2835', 'P.51875', 'Martha', 'Lazo');
INSERT INTO User (username, password, name, surname) VALUES ('user_8142', 'P.58665', 'Wanda', 'Ramirez');
INSERT INTO User (username, password, name, surname) VALUES ('user_2092', 'P.16070', 'Eileen', 'Ryen');
INSERT INTO User (username, password, name, surname) VALUES ('user_3000', 'P.73005', 'Stephanie', 'White');
INSERT INTO User (username, password, name, surname) VALUES ('user_8323', 'P.33562', 'Daenerys', 'Targaryen');

INSERT INTO Player (username, date_of_birth, height, weight)
VALUES
    ('g_orge', '1993-04-26', '170', '59'),
    ('c_ozbay', '1996-10-17', '182', '78'),
    ('m_vargas', '1999-10-16', '194', '76'),
    ('h_baladin', '2007-09-01', '190', '81'),
    ('a_kalac', '1995-12-13', '185', '73'),
    ('ee_dundar', '2008-06-22', '188', '74'),
    ('z_gunes', '2008-07-07', '197', '88'),
    ('i_aydin', '2007-01-05', '183', '67'),
    ('e_sahin', '2001-01-19', '190', '68'),
    ('e_karakurt', '2006-01-17', '196', '73'),
    ('s_akoz', '1991-04-23', '168', '55'),
    ('k_akman', '2006-10-13', '200', '88'),
    ('d_cebecioglu', '2007-10-24', '187', '68'),
    ('a_aykac', '1996-02-27', '176', '57'),
    ('user_2826', '2002-12-13', '193', '80'),
    ('user_9501', '1995-12-21', '164', '62'),
    ('user_3556', '1996-04-26', '185', '100'),
    ('user_7934', '1997-05-28', '150', '57'),
    ('user_4163', '1993-05-07', '156', '48'),
    ('user_2835', '2001-05-20', '173', '71'),
    ('user_8142', '1994-01-03', '183', '94'),
    ('user_2092', '2004-06-21', '188', '60'),
    ('user_3000', '2002-05-19', '193', '74'),
    ('user_8323', '2006-09-16', '222', '74');

-- Stadiums
INSERT INTO Stadium (stadium_id, stadium_name, stadium_country) VALUES ('0','Burhan Felek Voleybol Salonu','TR');
INSERT INTO Stadium (stadium_id, stadium_name, stadium_country) VALUES ('1','GD Voleybol Arena','TR');
INSERT INTO Stadium (stadium_id, stadium_name, stadium_country) VALUES ('2','Copper Box Arena','UK');

-- Channels
INSERT INTO Channel (channel_id, channel_name) VALUES ('0','BeIN Sports');
INSERT INTO Channel (channel_id, channel_name) VALUES ('1','Digiturk');
INSERT INTO Channel (channel_id, channel_name) VALUES ('2','TRT');

DELIMITER //

/* Usernames must be different than preexisting database managers’ usernames. */
DROP TRIGGER IF EXISTS Check_User_Username; //
CREATE TRIGGER Check_User_Username
BEFORE INSERT ON User
FOR EACH ROW
BEGIN
    IF exists(select 1 from DBManager where username = NEW.username limit 1) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Username already exists in DBManager table.';
    END IF;
END; //

/* No new managers can be added out of the already given ones. */
DROP TRIGGER IF EXISTS Check_New_Manager_Addition;//
CREATE TRIGGER Check_New_Manager_Addition
BEFORE INSERT ON DBManager
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'New managers cannot be added beyond the existing ones.';
END;//

/* Cannot play in matches where there are time conflicts.*/
DROP TRIGGER IF EXISTS Player_Time_conflict;//
create trigger Player_Time_conflict
before insert on SessionSquads
for each row
begin
    if exists(select 1
    from (select date, time_slot 
    from MatchSessions M
    right join 
    (select * from SessionSquads P where P.username = NEW.username) as playerTeam
    on playerTeam.session_id = M.session_id) M1,
    (select * from Matchsessions M3 where M3.session_id = NEW.session_id) M2
    where M1.date = M2.date and ABS(M1.time_slot-M2.time_slot) < 2 limit 1) then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Time conflict for player.';
    end if;
end;//

/* In a match, he/she can only play in a position within the positions he/she can play (is registered). */
DROP TRIGGER IF EXISTS Player_Position_Check;//
create trigger Player_Position_Check
before insert on SessionSquads
for each row
begin
    if not exists(select 1 from PlayerPositions P where NEW.username = P.username and NEW.position_id = P.position_id limit 1) then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Player can not play at that position.';
    end if;
end;// 

/* Being in an agreement with more than one team at a time is not possible for coaches. 
   Each team is led by just one coach.*/
DROP TRIGGER IF EXISTS Contract_Conflict_Check;//
create trigger Contract_Conflict_Check
before insert on Team
for each row
begin
    if exists(select 1 from Team T where ((T.coach_username = NEW.coach_username AND 
    T.team_name != NEW.team_name) OR (T.coach_username != NEW.coach_username AND 
    T.team_name = NEW.team_name)) AND 
    ((T.contract_start <= NEW.contract_start AND NEW.contract_start < T.contract_finish) OR 
    (T.contract_start < NEW.contract_finish AND NEW.contract_finish <= T.contract_finish))) then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Coaches can not direct different teams.';
    end if;
end;//

/* There must be 6 entries(rows) in this table, meaning a squad is created with 6 different players. */
DROP TRIGGER IF EXISTS Max_Player_Number_In_Squad; //
create trigger Max_Player_Number_In_Squad
before insert on SessionSquads
FOR EACH row
begin
    if (select count(*) from SessionSquads S where S.session_id = NEW.session_id) >= 6 then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'There should be at max 6 players in a squad.';
    end if;
end; //

/* No two match sessions can overlap, both in terms of stadium and playing time. */
DROP TRIGGER IF EXISTS Check_Stadium_Conflict;//
create trigger Check_Stadium_Conflict
before insert on MatchSessions
for each row
begin
    if exists(select 1 from MatchSessions M where NEW.stadium_id = M.stadium_id and M.date =NEW.date and ABS(M.time_slot-NEW.time_slot) < 2) then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'There can not be matches within the same place and same time.';
    end if;
end; //


DELIMITER ;











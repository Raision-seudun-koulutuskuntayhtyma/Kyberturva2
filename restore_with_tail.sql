-- ESIMERKKI TIETOKANNAN HÄNTÄLOKIN LUOMISESTA JA TÄYSVARMISTUKSEN JA HÄNTÄLOKIN PALAUTUKSESTA
-- Siirry hallintatietokantaan
USE master;
GO
-- Yritä ottaa tuhoutunut tietokanta ONLINE-tilaan
ALTER DATABASE Laiterekisteri SET ONLINE;
GO

-- Varmuuskopioi tapahtumaloki ->LaiterekisteriTailLog-log tiedostoon
-- Tapahtumaloki tuhotaan aina täysvarmistuksen ottamisen jälkeen, joten lokissa on vain uusia tapahtumia
-- Varaudutaan virheisiin CONTINUE_AFTER_ERROR-määreellä -> jatkaa suoritusta virheistä huolimatta.
BACKUP LOG Laiterekisteri
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\LaiterekisteriTailLog.log'
WITH CONTINUE_AFTER_ERROR;
GO

-- Palautetaan viimeinen täysvarmistus tietodostosta (normaali viimeisin täysvarmistus Laiterekisteri.bak)
RESTORE DATABASE Laiterekisteri
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\Laiterekisteri.bak'
WITH NORECOVERY;
GO

-- Palautetaan häntäloki 
RESTORE LOG Laiterekisteri
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\LaiterekisteriTailLog.log';
GO

/*
Script de déploiement pour DemoDb

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DemoDb"
:setvar DefaultFilePrefix "DemoDb"
:setvar DefaultDataPath "C:\Users\mihadadene\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB"
:setvar DefaultLogPath "C:\Users\mihadadene\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'L''opération suivante a été générée à partir d''un fichier journal de refactorisation 80166b92-3592-4d01-8709-43259c6cb2ca';

PRINT N'Renommer [dbo].[Person].[Id] en PersonId';


GO
EXECUTE sp_rename @objname = N'[dbo].[Person].[Id]', @newname = N'PersonId', @objtype = N'COLUMN';


GO
PRINT N'Modification de [dbo].[FullPerson]...';


GO
ALTER VIEW [dbo].[FullPerson]
	AS 
	SELECT [p].[PersonId] as [PersonId], [p].[FirstNAme], [p].[LastName], 
	[a].[Id] as AddressId, [a].[StreetAdress], 
	[a].[City], [a].[State], [a].[ZipCode]
	from dbo.Person p
	LEFT JOIN dbo.Address a ON  p.[PersonId] = a.PersonId
GO
PRINT N'Modification de [dbo].[spPerson_FilterByLastName]...';


GO
ALTER PROCEDURE [dbo].[spPerson_FilterByLastName]
	@LastName nvarchar(50)
AS
BEGIN
	SELECT [PersonId], [FirstNAme], [LastName] 
	FROM dbo.Person 
	WHERE LastName = @LastName;
end
GO
-- Étape de refactorisation pour mettre à jour le serveur cible avec des journaux de transactions déployés
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '80166b92-3592-4d01-8709-43259c6cb2ca')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('80166b92-3592-4d01-8709-43259c6cb2ca')

GO

GO
PRINT N'Mise à jour terminée.';


GO

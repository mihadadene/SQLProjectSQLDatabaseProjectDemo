CREATE VIEW [dbo].[FullPerson]
	AS 
	SELECT [p].[PersonId] as [PersonId], [p].[FirstName], [p].[LastName], 
	[a].[Id] as AddressId, [a].[StreetAdress], 
	[a].[City], [a].[State], [a].[ZipCode]
	from dbo.Person p
	LEFT JOIN dbo.Address a ON  p.[PersonId] = a.PersonId
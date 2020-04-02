CREATE PROCEDURE [dbo].[spPerson_FilterByLastName]
	@LastName nvarchar(50)
AS
BEGIN
	SELECT [PersonId], [FirstNAme], [LastName] 
	FROM dbo.Person 
	WHERE LastName = @LastName;
end

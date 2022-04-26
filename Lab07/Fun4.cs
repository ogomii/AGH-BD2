using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void Fun4(SqlInt32 id)
    {
        using (SqlConnection connection = new SqlConnection("context connection=true"))
        {
            SqlCommand command = new SqlCommand(
            @"select p.LastName + ';' + p.MiddleName + ';' + p.FirstName + ';' + a.AddressLine1 from Person.Person p
            join Person.BusinessEntityAddress ba on p.BusinessEntityID = ba.AddressID
            join Person.Address a on ba.AddressID = a.AddressID
            where p.BusinessEntityID = @id;", connection);
            command.Parameters.Add("@id", SqlDbType.Int).Value = id;

            connection.Open();
            SqlContext.Pipe.ExecuteAndSend(command);
            connection.Close();
        }
    }
};


using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void Fun3(SqlInt32 id)
    {
        using (SqlConnection connection = new SqlConnection("context connection=true"))
        {
            connection.Open();
            SqlCommand command = new SqlCommand(
            @"select p.LastName + ';' + p.FirstName + ';' + CONVERT(varchar, DATEDIFF(year, e.BirthDate, GETDATE())) from Person.Person p
            join HumanResources.Employee e on p.BusinessEntityID = e.BusinessEntityID
            where p.BusinessEntityID = @id;", connection);
            command.Parameters.Add("@id", SqlDbType.Int).Value = id;

            try
            {
                SqlDataReader rdr = command.ExecuteReader();
                SqlContext.Pipe.Send(rdr);
            }
            catch (SqlException e)
            {
                SqlContext.Pipe.Send(e.Message.ToString());
            }
            finally
            {
                connection.Close();
            }
        }
    }
};


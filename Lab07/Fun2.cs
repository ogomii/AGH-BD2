using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void Fun2(SqlDateTime date, SqlInt32 age)
    {
        using (SqlConnection connection = new SqlConnection("context connection=true"))
        {
            connection.Open();
            SqlCommand command = new SqlCommand(
            @"select p.LastName, p.FirstName, ea.EmailAddress, DATEDIFF(year, e.BirthDate, GETDATE()) from Person.Person p
            join Person.EmailAddress ea on p.BusinessEntityID = ea.BusinessEntityID
            join HumanResources.Employee e on p.BusinessEntityID = e.BusinessEntityID
            where @age <= DATEDIFF(year, e.BirthDate, CONVERT(DATE, @date))
            order by 4;", connection);
            command.Parameters.Add("@age", SqlDbType.Int).Value = age;
            command.Parameters.Add("@date", SqlDbType.DateTime).Value = date;

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


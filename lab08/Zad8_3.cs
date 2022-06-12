using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    private class FakturaRes
    {
        public SqlInt32 Symbol;
        public SqlMoney Wartosc;
        public SqlDateTime Data;

        public FakturaRes( SqlInt32 symbol, SqlMoney wartosc, SqlDateTime data)
        {
            Symbol = symbol;
            Wartosc = wartosc;
            Data = data;
        }
    }

    public static void FakturaFillRow(object result, out SqlInt32 symbol, out SqlMoney wartosc, out SqlDateTime data)
    {
        FakturaRes faktura = (FakturaRes)result;
        symbol = faktura.Symbol;
        wartosc = faktura.Wartosc;
        data = faktura.Data;
    }

    [SqlFunction(DataAccess = DataAccessKind.Read,
                  FillRowMethodName = "FakturaFillRow",
                  TableDefinition = "symbol int, wartosc money, data datetime")]

    public static IEnumerable Zad8_3()
    {
        ArrayList res = new ArrayList();

        using (SqlConnection connection = new SqlConnection("context connection=true"))
        {
            connection.Open();

            using (SqlCommand selectFaktura =
                new SqlCommand("SELECT ProductId, UnitPrice, ModifiedDate from Sales.SalesOrderDetail", connection))
            {
                using (SqlDataReader aReader = selectFaktura.ExecuteReader())
                {
                    while (aReader.Read())
                    {
                        res.Add(new FakturaRes(aReader.GetSqlInt32(0), aReader.GetSqlMoney(1), aReader.GetSqlDateTime(2))); 
                    }
                }
            }
        }
        return res;
    }

};


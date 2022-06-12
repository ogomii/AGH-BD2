using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;


[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedAggregate(Format.Native)]
public struct Zad8_1
{
    public void Init()
    {
        str = "";
    }

    public void Accumulate(SqlString stringToBeAdded)
    {
        str += stringToBeAdded;
    }

    public void Merge(Zad8_1 Group)
    {
        str += Group.str;
    }

    public SqlString Terminate()
    {
        return str;
    }

    private SqlString str;

}

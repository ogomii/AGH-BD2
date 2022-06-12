using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedType(Format.Native)]
public struct Zad8_2 : INullable
{
    public override string ToString()
    {
        return pesel.ToString();
    }

    public bool IsNull
    {
        get
        {
            m_Null = pesel == 0 ? true : false;
            return m_Null;
        }
    }
    
    public static Zad8_2 Null
    {
        get
        {
            Zad8_2 h = new Zad8_2();
            h.m_Null = true;
            return h;
        }
    }

    public static Zad8_2 Parse(SqlString s)
    {
        if (s.IsNull)
            return Null;
        Zad8_2 u = new Zad8_2();

        try
        {
            u.pesel = Int64.Parse(s.Value);
        }
        catch (Exception e)
        {
            throw e;
        }

        if ( u.getPeselLength() != 11 )
        {
            throw new Exception("Pesel length is not correct");
        }

        return u;
    }

    // This is a place-holder method
    public int getPeselLength()
    {
        if (pesel <= 0)
        {
            throw new ArgumentOutOfRangeException();
        }
        return (int)Math.Floor(Math.Log10(pesel)) + 1;
    }

    // This is a place-holder static method
    public static SqlString Method2()
    {
        //Insert method code here
        return new SqlString("Hello");
    }

    // This is a place-holder field member
    public Int64 pesel;
    private bool m_Null;
}



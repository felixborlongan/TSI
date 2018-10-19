using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace TSI.Connection
{
    public class SqlCommandMaster
    {
        public static SqlCommand CreateSqlCommand(string storedProcedureName, SqlConnection dbConnection)
        {
            return new SqlCommand(storedProcedureName, dbConnection);
        }
    }
}
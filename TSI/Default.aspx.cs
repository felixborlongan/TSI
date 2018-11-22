using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TSI.Models;
using System.Data;
using System.Web.Services;
using System.Web.Script.Services;
using TSI.Connection;
using TSI.Helpers;

namespace TSI
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie session = Request.Cookies["TSI-LOGIN"];
                     
            if (session == null)
            {
                Response.Redirect("Login.aspx");
            }
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static List<Employee> GetEmployees()
        {
            List<Employee> Employees = new List<Employee>();

            using (var dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
            {
                if (dbConnection.State == ConnectionState.Open)
                    dbConnection.Close();

                dbConnection.Open();

                using (var cmd = new SqlCommand("spGetEmployees", dbConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        var data = new Employee
                        {
                            ID = int.Parse(reader["ID"].ToString()),
                            Code = reader["Code"].ToString(),
                            First_Name = reader["First_Name"].ToString(),
                            Last_Name = reader["Last_Name"].ToString(),
                            Contact_No = reader["Contact_No"].ToString(),
                            Address = reader["Address"].ToString(),
                            Date_Hired = reader["Date_Hired"].ToString()
                        };
                        Employees.Add(data);

                    }
                    reader.Close();
                }
         
                foreach (Employee emp in Employees)
                {
                    emp.Devices = new List<Models.Device>();

                    using (SqlCommand cmd1 = new SqlCommand("spGetDevicesByEmployeeID", dbConnection))
                    {
                        cmd1.CommandType = CommandType.StoredProcedure;

                        cmd1.Parameters.AddWithValue("@employeeID", emp.ID);

                        SqlDataReader reader1 = cmd1.ExecuteReader();

                        while (reader1.Read())
                        {
                            Models.Device device = new Models.Device
                            {
                                ID = int.Parse(reader1["ID"].ToString()),
                                Code = reader1["Code"].ToString(),
                                Name = reader1["Name"].ToString(),
                                TypeID = int.Parse(reader1["TypeID"].ToString()),
                                TypeName = reader1["TypeName"].ToString()
                            };
                            emp.Devices.Add(device);
                        }
                        reader1.Close();
                    }            
                }
            }
            return Employees;
        }

        [WebMethod]
        public static void CreateEmployee(string Code, string First_Name, string Last_Name, string Contact_No, string Address, string Date_Hired, string[] Devices)
        {
            int createdID = 0;

            using (var dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
            {
                if (dbConnection.State == ConnectionState.Open)
                    dbConnection.Close();

                dbConnection.Open();

                using (var cmd = new SqlCommand("spInsertEmployee", dbConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Code", Code);
                    cmd.Parameters.AddWithValue("@First_Name", First_Name);
                    cmd.Parameters.AddWithValue("@Last_Name", Last_Name);
                    cmd.Parameters.AddWithValue("@Contact_No", Contact_No);
                    cmd.Parameters.AddWithValue("@Address", Address);
                    cmd.Parameters.AddWithValue("@Date_Hired", Date_Hired);
                    createdID = int.Parse(cmd.ExecuteScalar().ToString());
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch (SqlException sqlException)
                    {
                        sqlException.ToString();
                    }
                }
            }
            TagDevices(createdID, Devices);
        }

        private static void TagDevices(int createdID, string[] devices)
        {         
            using (SqlConnection dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ToString()))
            {
                if (dbConnection.State == ConnectionState.Open)
                    dbConnection.Close();
                dbConnection.Open();

                foreach (string device in devices)
                {
                    using (SqlCommand cmd = new SqlCommand("spInsertEmployeeDevices", dbConnection))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@employee_id", createdID);
                        cmd.Parameters.AddWithValue("@device_id", int.Parse(device));

                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }

        [WebMethod]
        public static Employee FindEmployee(int id)
        {
            var employeeData = new Employee();

            using (var dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
            {
                if (dbConnection.State == ConnectionState.Open)
                    dbConnection.Close();

                dbConnection.Open();

                using (var cmd = new SqlCommand("spGetEmployeeById", dbConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id", id);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        employeeData.ID = int.Parse(reader["ID"].ToString());
                        employeeData.Code = reader["Code"].ToString();
                        employeeData.First_Name = reader["First_Name"].ToString();
                        employeeData.Last_Name = reader["Last_Name"].ToString();
                        employeeData.Contact_No = reader["Contact_No"].ToString();
                        employeeData.Address = reader["Address"].ToString();
                        employeeData.Date_Hired = reader["Date_Hired"].ToString();
                    }
                }
            }
            employeeData.Devices = GetEmployeeDevices(id);

            return employeeData;
        }

        private static List<Models.Device> GetEmployeeDevices(int id)
        {
            List<Models.Device> devices = new List<Models.Device>();
            
            using (SqlConnection dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
            {
                if (dbConnection.State == ConnectionState.Open)
                    dbConnection.Close();
                dbConnection.Open();

                using (SqlCommand cmd = new SqlCommand("spGetDevicesByEmployeeID", dbConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@employeeID", id);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Models.Device data = new Models.Device
                        {
                            ID = int.Parse(reader["ID"].ToString()),
                            Name = reader["Name"].ToString(),
                            TypeID = int.Parse(reader["TypeID"].ToString()),
                            TypeName = reader["TypeName"].ToString(),
                            Code = reader["Code"].ToString()    
                        };
                        devices.Add(data);
                    }
                }
            }
            return devices;
        }

        [WebMethod]
        public static void EditEmployee(int Id, string Code, string First_Name, string Last_Name, string Contact_No, string Address, string Date_Hired, string[] Devices)
        {
            using (SqlConnection dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ToString()))
            {
                if (dbConnection.State == ConnectionState.Open)
                    dbConnection.Close();

                dbConnection.Open();

                using (SqlCommand cmd = new SqlCommand("spEditEmployee", dbConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Id", Id);
                    cmd.Parameters.AddWithValue("@Code", Code);
                    cmd.Parameters.AddWithValue("@First_Name", First_Name);
                    cmd.Parameters.AddWithValue("@Last_Name", Last_Name);
                    cmd.Parameters.AddWithValue("@Contact_No", Contact_No);
                    cmd.Parameters.AddWithValue("@Address", Address);
                    cmd.Parameters.AddWithValue("@Date_Hired", Date_Hired);

                    cmd.ExecuteNonQuery();
                }
            }
            EditEmployeeDevices(Id, Devices);
        }

        private static void EditEmployeeDevices(int id, string[] devices)
        {
            using (SqlConnection dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
            {
                if (dbConnection.State == ConnectionState.Open)
                    dbConnection.Close();
                dbConnection.Open();

                using (SqlCommand getEmployeeDevicesCommand = new SqlCommand("spGetDevicesByEmployeeID", dbConnection))
                {
                    getEmployeeDevicesCommand.CommandType = CommandType.StoredProcedure;

                    getEmployeeDevicesCommand.Parameters.AddWithValue("@employeeID", id);

                    SqlDataReader reader = getEmployeeDevicesCommand.ExecuteReader();
                    
                    if (reader.FieldCount > 0)
                    {
                        reader.Close();

                        using (SqlCommand deleteEmployeeDevicesCommand = new SqlCommand("spDeleteEmployeeDevicesByEmployeeID", dbConnection))
                        {
                            deleteEmployeeDevicesCommand.CommandType = CommandType.StoredProcedure;

                            deleteEmployeeDevicesCommand.Parameters.AddWithValue("@employeeID", id);

                            deleteEmployeeDevicesCommand.ExecuteNonQuery();
                        }
                        foreach (string device in devices)
                        {
                            using (SqlCommand cmd = new SqlCommand("spInsertEmployeeDevices", dbConnection))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;

                                cmd.Parameters.AddWithValue("@employee_id", id);
                                cmd.Parameters.AddWithValue("@device_id", int.Parse(device));

                                cmd.ExecuteNonQuery();
                            }
                        }
                    }
                    else
                    {
                        foreach (string device in devices)
                        {
                            using (SqlCommand cmd = new SqlCommand("spInsertEmployeeDevices", dbConnection))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;

                                cmd.Parameters.AddWithValue("@employee_id", id);
                                cmd.Parameters.AddWithValue("@device_id", int.Parse(device));

                                cmd.ExecuteNonQuery();
                            }
                        }
                    }
                }          
            }
        }

        [WebMethod]
        public static void DeleteEmployee(int id)
        {
            SqlConnection dbConnection = ConnectionMaster.CreateConnection();

            if (dbConnection.State == ConnectionState.Open)
                dbConnection.Close();
            dbConnection.Open();

            SqlCommand cmd = SqlCommandMaster.CreateSqlCommand("spDeleteEmployee", dbConnection);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@id", id);

            cmd.ExecuteNonQuery();
        }
        [WebMethod]
        public static void ExportEmployee(int id)
        {
            Employee emp = new Employee();

            using (SqlConnection dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
            {
                if (dbConnection.State == ConnectionState.Open)
                    dbConnection.Close();
                dbConnection.Open();

                using (SqlCommand cmd = new SqlCommand("spGetEmployeeById", dbConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id", id);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        emp.ID = int.Parse(reader["ID"].ToString());
                        emp.Code = reader["Code"].ToString();
                        emp.First_Name = reader["First_Name"].ToString();
                        emp.Last_Name = reader["Last_Name"].ToString();
                        emp.Contact_No = reader["Contact_No"].ToString();
                        emp.Address = reader["Address"].ToString();
                        emp.Date_Hired = reader["Date_Hired"].ToString();

                        emp.Devices = GetEmployeeDevices(id);
                    }
                }
            }
            ExcelGenerator excelGenerator = new ExcelGenerator(emp);

            excelGenerator.Generate();
        }
    }
}
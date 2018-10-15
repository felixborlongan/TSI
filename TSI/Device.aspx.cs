using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using TSI.Models;

namespace TSI
{
    public partial class Device : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static List<Models.Device> GetDevices()
        {
            List<Models.Device> devices = new List<Models.Device>();

            using (SqlConnection dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
            {
                if (dbConnection.State == System.Data.ConnectionState.Open)
                    dbConnection.Close();

                dbConnection.Open();

                using (SqlCommand cmd = new SqlCommand("spGetDevices", dbConnection))
                {
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Models.Device data = new Models.Device
                        {
                            ID = int.Parse(reader["ID"].ToString()),
                            Code = reader["Code"].ToString(),
                            Name = reader["Name"].ToString(),
                            TypeID = int.Parse(reader["DeviceID"].ToString()),
                            TypeName = reader["DeviceQualification"].ToString()
                        };
                        devices.Add(data);
                    }
                }
            }
            return devices;
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static List<DeviceType> GetDeviceTypes()
        {
            List<DeviceType> deviceTypes = new List<DeviceType>();

            using (SqlConnection dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
            {
                if (dbConnection.State == System.Data.ConnectionState.Open)
                    dbConnection.Close();

                dbConnection.Open();

                using (SqlCommand cmd = new SqlCommand("spGetDeviceTypes", dbConnection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        DeviceType data = new DeviceType
                        {
                            ID = int.Parse(reader["ID"].ToString()),
                            Name = reader["Name"].ToString()
                        };
                        deviceTypes.Add(data);
                    }
                }        
            }
            return deviceTypes;
        }
        [WebMethod]
        public static void CreateDevice(string DeviceCode, string DeviceName, int DeviceType)
        {
            using (SqlConnection dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
            {
                if (dbConnection.State == System.Data.ConnectionState.Open)
                    dbConnection.Close();

                dbConnection.Open();

                using (SqlCommand cmd = new SqlCommand("spInsertDevice", dbConnection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DeviceCode", DeviceCode);
                    cmd.Parameters.AddWithValue("@DeviceName", DeviceName);
                    cmd.Parameters.AddWithValue("@DeviceType", DeviceType);

                    cmd.ExecuteNonQuery();
                }
            }
        }

        [WebMethod]
        public static Models.Device FindDevice(int id)
        {
            Models.Device device = new Models.Device();

            using (SqlConnection dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ToString()))
            {
                if (dbConnection.State == System.Data.ConnectionState.Open)
                    dbConnection.Close();

                dbConnection.Open();

                using (SqlCommand cmd = new SqlCommand("spFindDevice", dbConnection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id", id);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        device.ID = int.Parse(reader["ID"].ToString());
                        device.Name = reader["Name"].ToString();
                        device.TypeID = int.Parse(reader["TypeID"].ToString());
                        device.Code = reader["Code"].ToString();
                        device.TypeName = reader["DeviceQualification"].ToString();
                    }
                }
            }
            return device;
        }

        [WebMethod]
        public static void EditDevice(int ID, string DeviceCode, string DeviceName, int DeviceType)
        {
            using (SqlConnection dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
            {
                if (dbConnection.State == System.Data.ConnectionState.Open)
                    dbConnection.Close();
                dbConnection.Open();

                using (SqlCommand cmd = new SqlCommand("spEditDevice", dbConnection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id", ID);
                    cmd.Parameters.AddWithValue("@devicecode", DeviceCode);
                    cmd.Parameters.AddWithValue("@devicename", DeviceName);
                    cmd.Parameters.AddWithValue("@devicetype", DeviceType);

                    cmd.ExecuteNonQuery();
                }
            }
        }

        [WebMethod]
        public static void DeleteDevice(int id)
        {
            using (SqlConnection dbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
            {
                if (dbConnection.State == System.Data.ConnectionState.Open)
                    dbConnection.Close();
                dbConnection.Open();

                using (SqlCommand cmd = new SqlCommand("spDeleteDevice", dbConnection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id", id);

                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}
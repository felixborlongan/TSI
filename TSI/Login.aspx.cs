using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using TSI.Models;

namespace TSI
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void button1_Click(object sender, EventArgs e)
        {
            string username = userTextbox.Text;
            string password = passTextbox.Text;
            Models.User user = new Models.User();

            using (SqlConnection dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
            {
                if (dbConn.State == ConnectionState.Open)
                    dbConn.Close();
                dbConn.Open();

                using (SqlCommand cmd = new SqlCommand("spLogin", dbConn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@username", username);
                    cmd.Parameters.AddWithValue("@password", password);

                    SqlDataReader reader =  cmd.ExecuteReader();

                    while(reader.Read())
                    { 
                        user.ID = Convert.ToInt32(reader["ID"].ToString());
                        user.Username = reader["Username"].ToString();
                        user.Password = reader["Password"].ToString();
                    }

                    if (user.ID > 0)
                    {
                        // store user data to a custom principal object
                        CustomPrincipalSerializeModel modelSerialize = new CustomPrincipalSerializeModel();
                        modelSerialize.UserID = user.ID;
                        modelSerialize.UserName = user.Username;

                        // convert the object to a JSON

                        JavaScriptSerializer serializer = new JavaScriptSerializer();
                        string userData = serializer.Serialize(modelSerialize);

                        // make forms authentication ticket containing the values of the JSON
                        FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1, user.Username, DateTime.Now, DateTime.Now.AddDays(2), true, userData, FormsAuthentication.FormsCookiePath);

                        // encrypt the ticket
                        string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                        // store to a cookie the encrypted ticket
                        HttpCookie faCookie = new HttpCookie("TSI-LOGIN", encryptedTicket);
                        faCookie.Expires = DateTime.Now.AddDays(2);
                        Response.Cookies.Add(faCookie);

                        Response.Redirect("Default.aspx");
                    }
                    else
                    {
                        userliteral.Text = "We can't find your credentials";
                    }
                }
            }
        }
    }
}
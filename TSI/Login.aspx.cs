using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TSI
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void button1_Click(object sender, EventArgs e)
        {
            var username = userTextbox.Text;
            var password = passTextbox.Text;
            var counter = 0;

            if (username == "admin" && password == "system")
            {
                Response.Redirect("Default.aspx");
            }
            else
            {
                counter++;
                if (counter == 3)
                {
                    this.ClientScript.RegisterClientScriptBlock(this.GetType(), "Close", "window.close()", true);
                }
            }
        }
    }
}
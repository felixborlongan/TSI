using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.SessionState;
using TSI.Models;

namespace TSI
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
        protected void Application_PostAuthenticateRequest(Object sender, EventArgs e)
        {
            HttpCookie authCookie = Request.Cookies["TSI-LOGIN"];

            if (authCookie != null)
            {
                try
                {
                    FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);

                    JavaScriptSerializer serializer = new JavaScriptSerializer();

                    CustomPrincipalSerializeModel serializeModel = serializer.Deserialize<CustomPrincipalSerializeModel>(authTicket.UserData);

                    Custom2IPrincipal newUser = new Custom2IPrincipal(authTicket.Name);

                    newUser.UserId = serializeModel.UserID;
                    newUser.UserName = serializeModel.UserName;
                    newUser.RoleId = serializeModel.RoleId;

                    HttpContext.Current.User = newUser;
                }
                catch
                {
                    FormsAuthentication.SignOut();
                }
            }
        }
    }
}
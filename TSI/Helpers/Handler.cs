using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace TSI
{
    /// <summary>
    /// Summary description for ServeFile
    /// </summary>
    public class Handler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            System.Web.HttpRequest request = System.Web.HttpContext.Current.Request;
            string path = request.QueryString["path"];
            byte[] fileBytes = File.ReadAllBytes(path);
            context.Response.ContentType = "application/octet-stream";
            context.Response.AddHeader("Content-Disposition", "attachment; filename=qasda.xlsx");
            context.Response.BinaryWrite(fileBytes);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
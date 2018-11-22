using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;

namespace TSI.Models
{
    public class User
    {
        public int ID { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
    }
    public class CustomPrincipalSerializeModel
    {
        public int UserID { get; set; }
        public string UserName { get; set; }
        public string FullName { get; set; }
        public string PhotoPath { get; set; }
        public string UserKey { get; set; }
        public bool isAdmin { get; set; }
        public long RoleId { get; set; }
        public int UserType { get; set; }
    }

    interface CustomIPrincipal : IPrincipal
    {
        int UserId { get; set; }
        string UserName { get; set; }
        string FullName { get; set; }
        string PhotoPath { get; set; }
    }

    public class Custom2IPrincipal : CustomIPrincipal
    {
        public IIdentity Identity { get; private set; }

        public bool IsInRole(string role) { return false; }

        public Custom2IPrincipal(String UserId)
        {
            this.Identity = new GenericIdentity(UserId);
        }

        public int UserId { get; set; }
        public string UserName { get; set; }
        public string FullName { get; set; }
        public string PhotoPath { get; set; }
        public string UserKey { get; set; }
        public bool isAdmin { get; set; }
        public long RoleId { get; set; }
    }
}
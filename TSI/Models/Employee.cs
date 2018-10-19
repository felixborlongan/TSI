using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TSI.Models
{
    public class Employee
    {
        public int ID { get; set; }
        public string Code { get; set; }
        public string First_Name { get; set; }
        public string Last_Name { get; set; }
        public string Contact_No { get; set; }
        public string Address { get; set; }
        public string Date_Hired { get; set; }
        public List<Device> Devices { get; set; }
        public string Full_Name
        {
            get
            {
                return $"{First_Name + " " + Last_Name}";
            }
        }
    }
}
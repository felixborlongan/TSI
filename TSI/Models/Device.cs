using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TSI.Models
{
    public class Device
    {
        public int ID { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public int TypeID { get; set; }
        public string TypeName { get; set; }
    }
}
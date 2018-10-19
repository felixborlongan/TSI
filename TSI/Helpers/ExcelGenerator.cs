using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OfficeOpenXml;
using TSI.Models;
using System.IO;

namespace TSI.Helpers
{
    public class ExcelGenerator
    {
        private readonly Random _rnd;
        private readonly Employee _employee;
        public ExcelGenerator(Employee emp)
        {
            _employee = emp;
            _rnd = new Random();
        }
        public void Generate()
        {
            var path = HttpContext.Current.Server.MapPath("Excels/" + GenerateHashedFileName() + ".xlsx");
            var fi = new FileInfo(HttpContext.Current.Server.MapPath("Excels/test.xlsx"));
            using (var p = new ExcelPackage(fi))
            {
                //A workbook must have at least on cell, so lets add one... 
                var ws = p.Workbook.Worksheets[1];
                //To set values in the spreadsheet use the Cells indexer.

                ws.Cells[$"{COLUMNS.ID + 2}"].Value = _employee.ID;
                ws.Cells[$"{COLUMNS.CODE + 2}"].Value = _employee.Code;
                ws.Cells[$"{COLUMNS.FULL_NAME + 2}"].Value = _employee.Full_Name;
                ws.Cells[$"{COLUMNS.CONTACT_NUMBER + 2}"].Value = _employee.Contact_No;
                ws.Cells[$"{COLUMNS.ADDRESS + 2}"].Value = _employee.Address;
                ws.Cells[$"{COLUMNS.DATE_HIRED + 2}"].Value = _employee.Date_Hired.Split(' ')[0];
                var devices = _employee.Devices.Select(xz => xz.Name).ToList();
                ws.Cells[$"{COLUMNS.DEVICES + 2}"].Value = string.Join(", ", devices);

                //Save the new workbook. We haven't specified the filename so use the Save as method.
                p.SaveAs(new FileInfo(path));
            }
            //implement download file
            //Download(path);
        }
        private string GenerateHashedFileName()
        {
            char[] chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".ToCharArray();
            string hashedFilename = "";

            for (int i = 0; i <= 10; i++)
            {
                int randomInt = _rnd.Next(chars.Length);

                hashedFilename += chars[randomInt].ToString();
            }
            return hashedFilename;
        }
        private void Download(string path)
        {
            string FileName = _employee.Full_Name; // It's a file name displayed on downloaded file on client side.

        }
    }
    public static class COLUMNS
    {
        public static string ID = "A";
        public static string CODE = "B";
        public static string FULL_NAME = "C";
        public static string CONTACT_NUMBER = "D";
        public static string ADDRESS = "E";
        public static string DATE_HIRED = "F";
        public static string DEVICES = "G";
    }
}
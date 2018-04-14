using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using MySql.Data.MySqlClient;

namespace WebService
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {

        [WebMethod]
        public bool Confirmation(string code)
        {
            using (var conn = new MySqlConnection(""))
            {
                conn.Open();

                using (var cmd = new MySqlCommand("SELECT booking_id FROM Booking WHERE code = @code", conn))
                {
                    cmd.Parameters.Add("@code", code);
                    using (var reader = cmd.ExecuteReader())
                        if (reader.HasRows)
                            return true;
                    return false;
                }
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Car_Rental
{
    public partial class BookingSecond : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["checkSecond"] != "true")
                Response.Redirect("MainPage.aspx");

            Session.Remove("checkSecond");
        }
    }
}
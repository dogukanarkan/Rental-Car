using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Car_Rental
{
    public partial class ManagerPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] == null)
                Response.Redirect("ManagerLogin.aspx");

            if (Session["login"].ToString() == "Manager")
                Panel1.Visible = true;
        }
    }
}
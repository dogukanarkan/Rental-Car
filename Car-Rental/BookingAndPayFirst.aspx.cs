using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Car_Rental
{
    public partial class ConfirmationBooking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] == null)
                Response.Redirect("MainPage.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Confirmation.WebService1 webService = new Confirmation.WebService1();

            if (webService.Confirmation(bookingCodeTextBox.Text))
            {
                Session.Add("bookingCode", bookingCodeTextBox.Text);

                Response.Redirect("BookingAndPaySecond.aspx");
            }
            else
                Response.Write("<div class='alert alert-primary alert-dismissible fade show' role='alert'>"
                        + "Rezervasyon bulunamadı. Lütfen rezervasyon kodunu kontrol ediniz."
                        + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                        + "<span aria-hidden='true'>&times;</span>"
                        + "</button>"
                        + "</div>");
        }
    }
}
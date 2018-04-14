using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Globalization;


namespace Car_Rental
{
    public partial class BookingOperation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["checkError"] != null && Session["checkError"].ToString() == "true" && Request.UrlReferrer != null && Request.UrlReferrer.ToString() == "http://localhost:51880/BookingOperations.aspx")
            {
                Session.Remove("checkError");

                Response.Write("<div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                    + "Bilgiler eşleşmiyor veya rezervasyon bulunamadı. Lütfen bilgilerinizi kontrol ediniz."
                    + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                    + "<span aria-hidden='true'>&times;</span>"
                    + "</button>"
                    + "</div>");
            }

            if (Session["checkBooking"] != null && Session["checkBooking"].ToString() == "true")
            {
                Session.Remove("checkBooking");

                Response.Write("<div class='alert alert-primary alert-dismissible fade show' role='alert'>"
                    + "Rezervasyonunuz iptal edilmiştir."
                    + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                    + "<span aria-hidden='true'>&times;</span>"
                    + "</button>"
                    + "</div>");
            }
            else if (Session["checkBooking"] != null && Session["checkBooking"].ToString() == "false")
            {
                Session.Remove("checkBooking");

                Response.Write("<div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                    + "Rezervasyonun iptal süresi geçmiştir, iptal edilemez."
                    + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                    + "<span aria-hidden='true'>&times;</span>"
                    + "</button>"
                    + "</div>");
            }
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            using (var conn = new MySqlConnection(""))
            {
                conn.Open();

                using (var cmd = new MySqlCommand("SELECT * FROM Booking JOIN Customer ON Booking.customer_id = Customer.customer_id "
                    + "WHERE code = @code AND identity_number = @identity_number", conn))
                {
                    cmd.Parameters.Add("@code", bookingCodeTextBox.Text);
                    cmd.Parameters.Add("@identity_number", identityNumberTextBox.Text);

                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            Session["checkError"] = "false";
                            Panel1.Visible = true;
                        }
                        else
                        {
                            Session["checkError"] = "true";
                            Response.Redirect(Request.RawUrl);
                        }
                    }
                }
            }
        }

        protected void Delete_Click(object sender, EventArgs e)
        {
            string strStartTime = " ";

            using (var conn = new MySqlConnection(""))
            {
                conn.Open();

                using (var cmd = new MySqlCommand("SELECT start_time FROM Booking WHERE code = @code", conn))
                {
                    cmd.Parameters.Add("@code", bookingCodeTextBox.Text);

                    using (var reader = cmd.ExecuteReader())
                        if (reader.HasRows)
                            if (reader.Read())
                                strStartTime = reader["start_time"].ToString();
                }
            }

            DateTime startTime = Convert.ToDateTime(strStartTime);

            if (startTime < DateTime.Now)
            {
                Session["checkBooking"] = "false";
                Response.Redirect(Request.RawUrl);
            }
            else
            {
                Panel1.Visible = false;

                MySqlConnection connectionDelete1;
                MySqlConnection connectionUpdate1;
                MySqlConnection connectionSelect1;

                string myConnectionString = "";

                string customerId = " ", carId = " ";

                connectionSelect1 = new MySqlConnection(myConnectionString);
                connectionSelect1.Open();

                MySqlCommand commandSelect1 = new MySqlCommand("SELECT car_id, customer_id FROM Booking WHERE code = @code", connectionSelect1);
                commandSelect1.Parameters.Add("@code", bookingCodeTextBox.Text);
                MySqlDataReader reader1 = commandSelect1.ExecuteReader();

                if (reader1.HasRows)
                    if (reader1.Read())
                    {
                        carId = reader1["car_id"].ToString();
                        customerId = reader1["customer_id"].ToString();
                    }

                connectionDelete1 = new MySqlConnection(myConnectionString);
                connectionDelete1.Open();

                MySqlCommand commandDelete1 = new MySqlCommand("DELETE FROM Booking WHERE code = @code", connectionDelete1);
                commandDelete1.Parameters.Add("@code", bookingCodeTextBox.Text);
                commandDelete1.ExecuteNonQuery();

                connectionUpdate1 = new MySqlConnection(myConnectionString);
                connectionUpdate1.Open();

                MySqlCommand commandUpdate1 = new MySqlCommand("UPDATE Car SET availability = 'YES' WHERE car_id = @car_id", connectionUpdate1);
                commandUpdate1.Parameters.Add("@car_id", carId);
                commandUpdate1.ExecuteNonQuery();

                Session["checkBooking"] = "true";
                Response.Redirect(Request.RawUrl);
            }
        }
    }
}
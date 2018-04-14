using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace Car_Rental
{
    public partial class BookingAndPaySecond : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] == null)
                Response.Redirect("MainPage.aspx");

            bookingCodeTextBox.Text = Session["bookingCode"].ToString();
        }

        protected void Search_Click(object sender, EventArgs e)
        {
            Session.Add("bookingCode", bookingCodeTextBox.Text);

            Response.Redirect("BookingAndPaySecond.aspx");
        }

        protected void Payment_Click(object sender, EventArgs e)
        {
            string myConnectionString = "";

            MySqlConnection connectionSelect1;
            MySqlConnection connectionUpdate1;
            MySqlConnection connectionUpdate2;

            try
            {
                connectionSelect1 = new MySqlConnection(myConnectionString);
                connectionSelect1.Open();

                MySqlCommand commandSelect1 = new MySqlCommand("SELECT Booking.booking_id, car_id, status FROM Booking "
                    + "JOIN Invoice ON Booking.booking_id = Invoice.booking_id WHERE code = @code", connectionSelect1);
                commandSelect1.Parameters.Add(new MySqlParameter("@code", Session["bookingCode"]));
                MySqlDataReader reader1 = commandSelect1.ExecuteReader();

                string booking_id = " ", car_id = " ";

                if (reader1.HasRows)
                    while (reader1.Read())
                    {
                        booking_id = reader1["booking_id"].ToString();
                        car_id = reader1["car_id"].ToString();
                    }

                if (reader1["status"].ToString() == "Unpaid")
                    Response.Write("<div class='alert alert-primary alert-dismissible fade show' role='alert'>"
                        + "Ödeme gerçekleşmiştir."
                        + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                        + "<span aria-hidden='true'>&times;</span>"
                        + "</button>"
                        + "</div>");
                else if (reader1["status"].ToString() == "Paid")
                    Response.Write("<div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                        + "Bu fatura zaten ödenmiş."
                        + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                        + "<span aria-hidden='true'>&times;</span>"
                        + "</button>"
                        + "</div>");

                connectionUpdate1 = new MySqlConnection(myConnectionString);
                connectionUpdate1.Open();

                MySqlCommand commandUpdate1 = new MySqlCommand("UPDATE Invoice SET payment_type = @payment_type, status = 'Paid', date = NOW() WHERE booking_id = @booking_id", connectionUpdate1);
                commandUpdate1.Parameters.Add(new MySqlParameter("@payment_type", paymentTypeList.SelectedValue));
                commandUpdate1.Parameters.Add(new MySqlParameter("@booking_id", booking_id));
                commandUpdate1.ExecuteNonQuery();

                connectionUpdate1.Close();

                connectionUpdate2 = new MySqlConnection(myConnectionString);
                connectionUpdate2.Open();

                MySqlCommand commandUpdate2 = new MySqlCommand("UPDATE Car SET availability = 'YES' WHERE car_id = @car_id", connectionUpdate2);
                commandUpdate2.Parameters.Add(new MySqlParameter("@car_id", car_id));
                commandUpdate2.ExecuteNonQuery();

                connectionUpdate2.Close();
            }
            catch (MySqlException ex)
            {
                
            }
        }
    }
}
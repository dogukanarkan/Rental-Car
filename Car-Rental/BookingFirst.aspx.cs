using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace Car_Rental
{
    public partial class Booking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["checkFirst"] != "true")
                Response.Redirect("MainPage.aspx");

            if (!IsPostBack)
                using (var conn = new MySqlConnection(""))
                {
                    conn.Open();

                    using (var cmd = new MySqlCommand("SELECT code, name, description, cost_per_day FROM Insurance", conn))
                    using (var reader = cmd.ExecuteReader())
                        if (reader.HasRows)
                            while (reader.Read())
                                insuranceList.Items.Add(reader["name"].ToString() + "       " + reader["cost_per_day"].ToString() + " TL");

                    conn.Close();
                }
        }

        protected void CalculateButton_Click(object sender, EventArgs e)
        {
            MySqlConnection connectionSelect1;
            string myConnectionString = "";

            double discount = 0, fee = 0;

            using (var conn = new MySqlConnection(""))
            {
                conn.Open();

                using (var cmd = new MySqlCommand("SELECT coupon_id, discount_percentage, expiry_date FROM Coupon WHERE code = @code", conn))
                {
                    cmd.Parameters.Add("@code", CouponCodeTextBox.Text);
                    using (var reader = cmd.ExecuteReader())
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                if (Convert.ToDateTime(reader["expiry_date"]) > DateTime.Now)
                                {
                                    Session["couponId"] = reader["coupon_id"];
                                    discount = Convert.ToDouble(reader["discount_percentage"]);
                                }
                            }
                        }
                        else if (CouponCodeTextBox.Text == "")
                            Session["couponId"] = null;
                        else
                        {
                            Session["couponId"] = null;
                            discount = 0.0;
                            Response.Write("<div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                                + "Bu kupon kodu geçersizdir."
                                + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                                + "<span aria-hidden='true'>&times;</span>"
                                + "</button>"
                                + "</div>");
                        }
                }
                conn.Close();
            }

            connectionSelect1 = new MySqlConnection(myConnectionString);
            connectionSelect1.Open();

            MySqlCommand commandSelect1 = new MySqlCommand("SELECT cost_per_day FROM Car WHERE car_id = @car_id", connectionSelect1);
            commandSelect1.Parameters.Add(new MySqlParameter("@car_id", Request.QueryString["carId"]));
            MySqlDataReader reader1 = commandSelect1.ExecuteReader();

            double cost_per_day = 0;

            if (reader1.Read())
                cost_per_day = Convert.ToDouble(reader1["cost_per_day"]);

            fee = cost_per_day * Convert.ToDouble(Session["rentalTime"]);

            for (int i = 0; i < insuranceList.Items.Count; i++)
                if (insuranceList.Items[i].Selected)
                {
                    using (var conn = new MySqlConnection(""))
                    {
                        conn.Open();

                        using (var cmd = new MySqlCommand("SELECT cost_per_day FROM Insurance WHERE insurance_id = @insurance_id", conn))
                        {
                            cmd.Parameters.Add("@insurance_id", i + 1);
                            using (var reader = cmd.ExecuteReader())
                                if (reader.HasRows)
                                    while (reader.Read())
                                        fee += Convert.ToDouble(reader["cost_per_day"]) * Convert.ToDouble(Session["rentalTime"]);

                            conn.Close();
                        }
                    }

                }

            Session["discountAmount"] = fee * discount;
            fee = fee * (1.0 - discount);
            FeeLabel.Text = fee.ToString() + " TL";
            Session["totalAmount"] = fee;
        }

        protected void nextButton_Click(object sender, EventArgs e)
        {
            Panel1.Visible = true;
        }

        protected void bookingButton_Click(object sender, EventArgs e)
        {
            MySqlConnection connectionSelect1;
            MySqlConnection connectionSelect2;
            MySqlConnection connectionSelect3;
            MySqlConnection connectionInsert1;
            MySqlConnection connectionInsert2;
            MySqlConnection connectionInsert3;
            MySqlConnection connectionInsert4;
            MySqlConnection connectionUpdate1;

            string myConnectionString = "";

            connectionInsert1 = new MySqlConnection(myConnectionString);
            connectionInsert1.Open();

            MySqlCommand commandInsert1 = new MySqlCommand("INSERT INTO Address(province, district, street, zipcode) "
                + "VALUES(@province, @district, @street, @zipcode)", connectionInsert1);
            commandInsert1.Parameters.Add(new MySqlParameter("@province", provinceTextBox.Text));
            commandInsert1.Parameters.Add(new MySqlParameter("@district", districtTextBox.Text));
            commandInsert1.Parameters.Add(new MySqlParameter("@street", streetTextBox.Text));
            commandInsert1.Parameters.Add(new MySqlParameter("@zipcode", zipcodeTextBox.Text));
            commandInsert1.ExecuteNonQuery();

            string addressId = " ";

            connectionSelect1 = new MySqlConnection(myConnectionString);
            connectionSelect1.Open();

            MySqlCommand commandSelect1 = new MySqlCommand("SELECT MAX(address_id) AS address_id FROM Address", connectionSelect1);
            MySqlDataReader reader1 = commandSelect1.ExecuteReader();

            if (reader1.HasRows)
                if (reader1.Read())
                    addressId = reader1["address_id"].ToString();

            connectionInsert2 = new MySqlConnection(myConnectionString);
            connectionInsert2.Open();

            MySqlCommand commandInsert2 = new MySqlCommand("INSERT INTO Customer(address_id, identity_number, first_name, last_name, date_birth, "
                + "phone, mail) VALUES(@address_id, @identity_number, @first_name, @last_name, @date_birth, @phone, @mail)", connectionInsert2);
            commandInsert2.Parameters.Add(new MySqlParameter("@address_id", addressId));
            commandInsert2.Parameters.Add(new MySqlParameter("@identity_number", identityTextBox.Text));
            commandInsert2.Parameters.Add(new MySqlParameter("@first_name", nameTextBox.Text));
            commandInsert2.Parameters.Add(new MySqlParameter("@last_name", surnameTextBox.Text));
            commandInsert2.Parameters.Add(new MySqlParameter("@date_birth", birthDateTextBox.Text));
            commandInsert2.Parameters.Add(new MySqlParameter("@phone", phoneTextBox.Text));
            commandInsert2.Parameters.Add(new MySqlParameter("@mail", mailTextBox.Text));
            commandInsert2.ExecuteNonQuery();

            string customerId = " ";

            connectionSelect2 = new MySqlConnection(myConnectionString);
            connectionSelect2.Open();

            MySqlCommand commandSelect2 = new MySqlCommand("SELECT MAX(customer_id) AS customer_id FROM Customer", connectionSelect2);
            MySqlDataReader reader2 = commandSelect2.ExecuteReader();

            if (reader2.HasRows)
                if (reader2.Read())
                    customerId = reader2["customer_id"].ToString();

            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var stringChars = new char[10];
            var random = new Random();

            for (int i = 0; i < stringChars.Length; i++)
                stringChars[i] = chars[random.Next(chars.Length)];

            var code = new String(stringChars);
            Session["bookingCode"] = code;
            Session["phone"] = phoneTextBox.Text;

            connectionInsert3 = new MySqlConnection(myConnectionString);
            connectionInsert3.Open();

            MySqlCommand commandInsert3 = new MySqlCommand("INSERT INTO Booking(car_id, customer_id, code, rental_time, start_time, end_time) "
                + "VALUES(@car_id, @customer_id, @code, @rental_time, @start_time, @end_time)", connectionInsert3);
            commandInsert3.Parameters.Add(new MySqlParameter("@car_id", Request.QueryString["carId"]));
            commandInsert3.Parameters.Add(new MySqlParameter("@customer_id", customerId));
            commandInsert3.Parameters.Add(new MySqlParameter("@code", code));
            commandInsert3.Parameters.Add(new MySqlParameter("@rental_time", Session["rentalTime"]));
            commandInsert3.Parameters.Add(new MySqlParameter("@start_time", Session["startDate"] + " " + Session["startTime"]));
            commandInsert3.Parameters.Add(new MySqlParameter("@end_time", Session["endDate"] + " " + Session["endTime"]));
            commandInsert3.ExecuteNonQuery();

            string bookingId = " ";

            connectionSelect3 = new MySqlConnection(myConnectionString);
            connectionSelect3.Open();

            MySqlCommand commandSelect3 = new MySqlCommand("SELECT MAX(booking_id) AS booking_id FROM Booking", connectionSelect3);
            MySqlDataReader reader3 = commandSelect3.ExecuteReader();

            if (reader3.HasRows)
                if (reader3.Read())
                    bookingId = reader3["booking_id"].ToString();

            for (int i = 0; i < insuranceList.Items.Count; i++)
                if (insuranceList.Items[i].Selected)
                {
                    using (var conn = new MySqlConnection(""))
                    {
                        conn.Open();

                        using (var cmd = new MySqlCommand("INSERT INTO InsuranceBooking(insurance_id, booking_id) VALUES(@insurance_id, @booking_id)", conn))
                        {
                            cmd.Parameters.Add("@insurance_id", i + 1);
                            cmd.Parameters.Add("@booking_id", bookingId);
                            cmd.ExecuteNonQuery();

                            conn.Close();
                        }
                    }

                }

            connectionInsert4 = new MySqlConnection(myConnectionString);
            connectionInsert4.Open();

            MySqlCommand commandInsert4 = new MySqlCommand("INSERT INTO Invoice(booking_id, coupon_id, discount_amount, total_amount) "
                + "VALUES(@booking_id, @coupon_id, @discount_amount, @total_amount)", connectionInsert4);
            commandInsert4.Parameters.Add(new MySqlParameter("@booking_id", bookingId));
            commandInsert4.Parameters.Add(new MySqlParameter("@coupon_id", Session["couponId"]));
            commandInsert4.Parameters.Add(new MySqlParameter("@discount_amount", Session["discountAmount"]));
            commandInsert4.Parameters.Add(new MySqlParameter("@total_amount", Session["totalAmount"]));
            commandInsert4.ExecuteNonQuery();

            connectionUpdate1 = new MySqlConnection(myConnectionString);
            connectionUpdate1.Open();

            MySqlCommand commandUpdate1 = new MySqlCommand("UPDATE Car SET availability = 'NO' WHERE car_id = @car_id", connectionUpdate1);
            commandUpdate1.Parameters.Add(new MySqlParameter("@car_id", Request.QueryString["carId"]));
            commandUpdate1.ExecuteNonQuery();

            Session.Remove("checkFirst");
            Session["checkSecond"] = "true";
            Response.Redirect("BookingSecond.aspx");
        }
    }
}
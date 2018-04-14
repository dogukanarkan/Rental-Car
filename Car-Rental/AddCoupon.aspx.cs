using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace Car_Rental
{
    public partial class AddCoupon : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] == null)
                Response.Redirect("MainPage.aspx");
        }

        MySqlConnection connectionSelect;
        MySqlConnection connectionInsert;

        protected void Button1_Click(object sender, EventArgs e)
        {
            string myConnectionString = "";

            try
            {
                connectionSelect = new MySqlConnection(myConnectionString);
                connectionSelect.Open();

                MySqlCommand commandSelect = new MySqlCommand("SELECT code FROM Coupon WHERE code = " + "@code", connectionSelect);
                commandSelect.Parameters.Add(new MySqlParameter("@code", codeTextBox.Text));
                MySqlDataReader reader = commandSelect.ExecuteReader();

                if (reader.HasRows)
                    Response.Write("<div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                        + "Bu kupon kodu daha önceden eklenmiştir. Lütfen başka bir kod ekleyiniz."
                        + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                        + "<span aria-hidden='true'>&times;</span>"
                        + "</button>"
                        + "</div>");
                else
                    Response.Write("<div class='alert alert-primary alert-dismissible fade show' role='alert'>"
                        + "Kupon eklenmiştir."
                        + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                        + "<span aria-hidden='true'>&times;</span>"
                        + "</button>"
                        + "</div>");

                connectionInsert = new MySqlConnection(myConnectionString);
                connectionInsert.Open();

                MySqlCommand commandInsert = new MySqlCommand("addCouponSP", connectionInsert);
                commandInsert.Parameters.Add(new MySqlParameter("codeSP", codeTextBox.Text));
                commandInsert.Parameters.Add(new MySqlParameter("discount_percentageSP", discountTextBox.Text));
                commandInsert.Parameters.Add(new MySqlParameter("expiry_dateSP", ExpiryDate.SelectedDate.ToString("yyyy-MM-dd") + " " + ExpiryTime.SelectedValue.ToString()));
                commandInsert.Parameters.Add(new MySqlParameter("descriptionSP", descriptionTextBox.Text));
                commandInsert.CommandType = CommandType.StoredProcedure;
                commandInsert.ExecuteNonQuery();
            }
            catch (MySqlException ex)
            {

            }
            finally
            {
                codeTextBox.Text = discountTextBox.Text = descriptionTextBox.Text = string.Empty;

                connectionInsert.Close();
                connectionSelect.Close();
            }
        }
    }
}
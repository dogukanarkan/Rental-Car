using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace Car_Rental
{
    public partial class AddCar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] == null)
                Response.Redirect("MainPage.aspx");

            if (!IsPostBack)
            {
                using (var conn = new MySql.Data.MySqlClient.MySqlConnection(""))
                {
                    branchList.Items.Clear();
                    branchList.ClearSelection();

                    conn.Open();

                    using (var cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT * FROM Branch", conn))
                    {
                        using (var reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                branchList.Items.Add("Şube Seçiniz");

                                while (reader.Read())
                                {
                                    branchList.Items.Add(Convert.ToString(reader["name"]));
                                }
                            }
                        }
                    }
                }
            }
        }

        MySqlConnection connectionSelect1;
        MySqlConnection connectionSelect2;
        MySqlConnection connectionSelect3;
        MySqlConnection connectionSelect4;
        MySqlConnection connectionInsert1;
        MySqlConnection connectionInsert2;
        MySqlConnection connectionInsert3;

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (branchList.SelectedValue == "Şube Seçiniz")
                Response.Write("<div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                    + "Lütfen şubeyi seçiniz."
                    + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                    + "<span aria-hidden='true'>&times;</span>"
                    + "</button>"
                    + "</div>");
            else if (transmissionList.SelectedValue == "Vites Türü")
                Response.Write("<div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                    + "Lütfen vites seçiniz."
                    + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                    + "<span aria-hidden='true'>&times;</span>"
                    + "</button>"
                    + "</div>");
            else
            {
                string myConnectionString = "";

                try
                {
                    connectionSelect1 = new MySqlConnection(myConnectionString);
                    connectionSelect1.Open();

                    MySqlCommand commandSelect1 = new MySqlCommand("SELECT model_id FROM Model WHERE brand_name = @textBrand AND model_name = @textModel", connectionSelect1);
                    commandSelect1.Parameters.Add(new MySqlParameter("@textBrand", brandTextBox.Text));
                    commandSelect1.Parameters.Add(new MySqlParameter("@textModel", modelTextBox.Text));
                    MySqlDataReader reader1 = commandSelect1.ExecuteReader();

                    if (!reader1.HasRows)
                    {
                        connectionInsert1 = new MySqlConnection(myConnectionString);
                        connectionInsert1.Open();

                        MySqlCommand commandInsert1 = new MySqlCommand("INSERT INTO Model(brand_name, model_name) VALUES(@brand_name, @model_name)", connectionInsert1);
                        commandInsert1.Parameters.Add(new MySqlParameter("@brand_name", brandTextBox.Text));
                        commandInsert1.Parameters.Add(new MySqlParameter("@model_name", modelTextBox.Text));
                        commandInsert1.ExecuteNonQuery();

                        connectionInsert1.Close();
                    }

                    connectionSelect2 = new MySqlConnection(myConnectionString);
                    connectionSelect2.Open();

                    MySqlCommand commandSelect2 = new MySqlCommand("SELECT model_id FROM Model WHERE brand_name = @textBrand AND model_name = @textModel", connectionSelect2);
                    commandSelect2.Parameters.Add(new MySqlParameter("@textBrand", brandTextBox.Text));
                    commandSelect2.Parameters.Add(new MySqlParameter("@textModel", modelTextBox.Text));
                    MySqlDataReader reader2 = commandSelect2.ExecuteReader();

                    string modelId = " ";

                    if (reader2.Read())
                        modelId = reader2["model_id"].ToString();

                    connectionInsert2 = new MySqlConnection(myConnectionString);
                    connectionInsert2.Open();

                    MySqlCommand commandInsert2 = new MySqlCommand("INSERT INTO CarDetail(model_id, engine_power, model_year, mileage, color, transmission, door, seat) VALUES "
                        + "(@model_id, @engine_power, @model_year, @mileage, @color, @transmission, @door, @seat)", connectionInsert2);
                    commandInsert2.Parameters.Add(new MySqlParameter("@model_id", modelId));
                    commandInsert2.Parameters.Add(new MySqlParameter("@engine_power", engineTextBox.Text));
                    commandInsert2.Parameters.Add(new MySqlParameter("@model_year", yearTextBox.Text));
                    commandInsert2.Parameters.Add(new MySqlParameter("@mileage", mileageTextBox.Text));
                    commandInsert2.Parameters.Add(new MySqlParameter("@color", colorTextBox.Text));
                    commandInsert2.Parameters.Add(new MySqlParameter("@transmission", transmissionList.SelectedValue));
                    commandInsert2.Parameters.Add(new MySqlParameter("@door", doorTextBox.Text));
                    commandInsert2.Parameters.Add(new MySqlParameter("@seat", seatTextBox.Text));
                    commandInsert2.ExecuteNonQuery();

                    connectionInsert2.Close();

                    connectionSelect3 = new MySqlConnection(myConnectionString);
                    connectionSelect3.Open();

                    MySqlCommand commandSelect3 = new MySqlCommand("SELECT MAX(car_detail_id) AS Max FROM CarDetail", connectionSelect3);
                    MySqlDataReader reader3 = commandSelect3.ExecuteReader();

                    string carDetailId = " ";

                    if (reader3.Read())
                        carDetailId = reader3["Max"].ToString();

                    string imageName = carDetailId + ".jpg";
                    imageUpload.SaveAs(Server.MapPath("/Images/Cars/" + imageName));

                    connectionSelect4 = new MySqlConnection(myConnectionString);
                    connectionSelect4.Open();

                    MySqlCommand commandSelect4 = new MySqlCommand("SELECT branch_id FROM Branch WHERE name = @name", connectionSelect4);
                    commandSelect4.Parameters.Add(new MySqlParameter("@name", branchList.SelectedItem));
                    MySqlDataReader reader4 = commandSelect4.ExecuteReader();

                    string branchId = " ";

                    if (reader4.Read())
                        branchId = reader4["branch_id"].ToString();

                    connectionInsert3 = new MySqlConnection(myConnectionString);
                    connectionInsert3.Open();

                    MySqlCommand commandInsert3 = new MySqlCommand("INSERT INTO Car(car_detail_id, branch_id, plate, cost_per_day, image_url) VALUES "
                        + "(@car_detail_id, @branch_id, @plate, @cost_per_day, @image_url)", connectionInsert3);
                    commandInsert3.Parameters.Add(new MySqlParameter("@car_detail_id", carDetailId));
                    commandInsert3.Parameters.Add(new MySqlParameter("@branch_id", branchId));
                    commandInsert3.Parameters.Add(new MySqlParameter("@plate", plateTextBox.Text));
                    commandInsert3.Parameters.Add(new MySqlParameter("@cost_per_day", costTextBox.Text));
                    commandInsert3.Parameters.Add(new MySqlParameter("@image_url", "/Images/Cars/" + imageName));
                    commandInsert3.ExecuteNonQuery();

                    Response.Write("<div class='alert alert-primary alert-dismissible fade show' role='alert'>"
                            + "Araç eklenmiştir."
                            + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                            + "<span aria-hidden='true'>&times;</span>"
                            + "</button>"
                            + "</div>");
                }
                catch (MySqlException ex)
                {

                }
                finally
                {
                    brandTextBox.Text = modelTextBox.Text = plateTextBox.Text = engineTextBox.Text = yearTextBox.Text =
                        mileageTextBox.Text = colorTextBox.Text = doorTextBox.Text = seatTextBox.Text = costTextBox.Text = string.Empty;

                }
            }
        }
    }
}
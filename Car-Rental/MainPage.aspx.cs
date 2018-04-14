using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Car_Rental
{
    public partial class MainPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

        protected void Button1_Click(object sender, EventArgs e)
        {          
            if (startDate.SelectedDate > endDate.SelectedDate || startDate.SelectedDate < DateTime.Now)
                Response.Write("<div class='alert alert-primary alert-dismissible fade show' role='alert'>"
                    + "Lütfen tarihleri kontrol ediniz."
                    + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                    + "<span aria-hidden='true'>&times;</span>"
                    + "</button>"
                    + "</div>");
            else if(branchList.SelectedValue == "Şube Seçiniz")
                Response.Write("<div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                    + "Lütfen şubeyi seçiniz."
                    + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                    + "<span aria-hidden='true'>&times;</span>"
                    + "</button>"
                    + "</div>");
            else
            {
                Session.Add("checkFirst", "true");
                Session.Add("branch", branchList.SelectedValue);
                Session.Add("startDate", startDate.SelectedDate.ToString("yyyy-MM-dd"));
                Session.Add("endDate", endDate.SelectedDate.ToString("yyyy-MM-dd"));
                Session.Add("rentalTime", (endDate.SelectedDate - startDate.SelectedDate).TotalDays);
                Session.Add("startTime", startTime.SelectedValue);
                Session.Add("endTime", endTime.SelectedValue);

                Response.Redirect("BookingFirst.aspx");
            }
        }
    }
}
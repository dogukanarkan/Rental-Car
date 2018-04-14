using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace Car_Rental
{
    public partial class ManagerLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            MySqlConnection connectionSelect1;

            string myConnectionString = "";

            connectionSelect1 = new MySqlConnection(myConnectionString);
            connectionSelect1.Open();

            MySqlCommand commandSelect1 = new MySqlCommand("SELECT access_level FROM Employee WHERE mail = @mail AND password = @password", connectionSelect1);
            commandSelect1.Parameters.Add(new MySqlParameter("@mail", mailTextBox.Text));
            commandSelect1.Parameters.Add(new MySqlParameter("@password", passwordTextBox.Text));
            MySqlDataReader reader1 = commandSelect1.ExecuteReader();

            if (reader1.HasRows)
            {
                if (reader1.Read())
                {
                    Session["login"] = reader1["access_level"];
                    Response.Redirect("ManagerPage.aspx");
                }
            }
            else
                Response.Write("<div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                    + "Bilgilerinizi kontrol ediniz."
                    + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                    + "<span aria-hidden='true'>&times;</span>"
                    + "</button>"
                    + "</div>");

        }
    }
}
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
    public partial class EmployeeOperations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] == null)
                Response.Redirect("MainPage.aspx");

            if (Session["login"].ToString() == "Employee")
                Response.Redirect("ManagerPage.aspx");

            if (Request.UrlReferrer != null)
            {
                if (Request.UrlReferrer.ToString() == "http://carrentalwebapp.azurewebsites.net/EmployeeOperations.aspx")
                {
                    var employee_id = Request.QueryString["EmployeeId"];

                    MySqlConnection connection;
                    string myConnectionString = "";

                    connection = new MySqlConnection(myConnectionString);
                    connection.Open();

                    string sql = "deleteEmployeeSP";

                    MySqlCommand cmd = new MySqlCommand(sql, connection);
                    cmd.Parameters.Add("employeeID", employee_id);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();

                    Response.Write("<div class='alert alert-primary alert-dismissible fade show' role='alert'>"
                        + "Personel sistemden silinmiştir."
                        + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                        + "<span aria-hidden='true'>&times;</span>"
                        + "</button>"
                        + "</div>");

                    connection.Close();
                }
            }
        }

        protected void addButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEmployee.aspx");
        }
    }
}
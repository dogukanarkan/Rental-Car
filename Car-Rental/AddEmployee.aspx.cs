using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using System.IO;


namespace Car_Rental
{
    public partial class AddEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] == null)
                Response.Redirect("MainPage.aspx");

            if(Session["login"].ToString() == "Employee")
                Response.Redirect("ManagerPage.aspx");

            if (!IsPostBack)
            {
                MySqlConnection connection2;

                string myConnectionString = "";

                connection2 = new MySqlConnection(myConnectionString);
                connection2.Open();

                string sql2 = "SELECT name FROM Branch";

                MySqlCommand cmd2 = new MySqlCommand(sql2, connection2);
                cmd2.Parameters.Add("@branch_id", BranchList.SelectedIndex + 1);
                MySqlDataReader reader2 = cmd2.ExecuteReader();

                BranchList.Items.Add("Şube Seçiniz");

                while (reader2.Read())
                    BranchList.Items.Add(reader2["name"].ToString());

            }
        }

        MySqlConnection connectionInsert1;
        MySqlConnection connectionInsert2;
        MySqlConnection connectionSelect1;
        MySqlConnection connectionSelect2;

        protected void addEmployeeButton_Click(object sender, EventArgs e)
        {         
            try
            {         
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

                MySqlCommand commandInsert2 = new MySqlCommand("INSERT INTO Employee(address_id, branch_id, identity_number, first_name, last_name, "
                   + "phone, mail, password, salary, access_level) VALUES(@address_id, @branch_id, @identity_number, @first_name, @last_name, @phone, "
                   + " @mail, @password, @salary, @access_level)", connectionInsert2);
                commandInsert2.Parameters.Add(new MySqlParameter("@address_id", addressId));
                commandInsert2.Parameters.Add(new MySqlParameter("@branch_id", BranchList.SelectedIndex));
                commandInsert2.Parameters.Add(new MySqlParameter("@identity_number", employeeIDTextBox.Text));
                commandInsert2.Parameters.Add(new MySqlParameter("@first_name", employeeFNameTextBox.Text));
                commandInsert2.Parameters.Add(new MySqlParameter("@last_name", employeeLNameTextBox.Text));
                commandInsert2.Parameters.Add(new MySqlParameter("@phone", employeePhoneTextBox.Text));
                commandInsert2.Parameters.Add(new MySqlParameter("@mail", employeeMailTextBox.Text));
                commandInsert2.Parameters.Add(new MySqlParameter("@password", employeePasswordTextBox.Text));
                commandInsert2.Parameters.Add(new MySqlParameter("@salary", salaryTextBox.Text));
                commandInsert2.Parameters.Add(new MySqlParameter("@access_level", accessLevelList.SelectedValue));
                commandInsert2.ExecuteNonQuery();


                string employeeId = " ";

                connectionSelect2 = new MySqlConnection(myConnectionString);
                connectionSelect2.Open();

                MySqlCommand commandSelect2 = new MySqlCommand("SELECT MAX(employee_id) AS employee_id FROM Employee", connectionSelect2);
                MySqlDataReader reader2 = commandSelect2.ExecuteReader();

                if (reader2.HasRows)
                    if (reader2.Read())
                        employeeId = reader2["employee_id"].ToString();


                Response.Write("<div class='alert alert-primary alert-dismissible fade show' role='alert'>"
                       + "Personel eklenmiştir."
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
                provinceTextBox.Text = districtTextBox.Text = streetTextBox.Text = zipcodeTextBox.Text =
                employeeIDTextBox.Text= employeeFNameTextBox.Text = employeeLNameTextBox.Text = employeePhoneTextBox.Text=
                employeePasswordTextBox.Text = employeePasswordTextBox2.Text= salaryTextBox.Text=  string.Empty;
                BranchList.ClearSelection();
                accessLevelList.ClearSelection();

                 connectionInsert1.Close();
                 connectionInsert2.Close();
                 connectionSelect1.Close();
                 connectionSelect2.Close();
            }

        }
    }
}
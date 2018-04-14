<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterPage.Master" AutoEventWireup="true" CodeBehind="Branches.aspx.cs" Inherits="Car_Rental.Branches" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>

    <%
        MySql.Data.MySqlClient.MySqlConnection connection;
        string myConnectionString = "";
        int count = 0;

        try
        {
            connection = new MySql.Data.MySqlClient.MySqlConnection(myConnectionString);
            connection.Open();
            string sql = "SELECT name, phone, province, district, street, zipcode FROM Branch, Address " +
                "WHERE Branch.address_id = Address.address_id " +
                "ORDER BY branch_id ASC";
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(sql, connection);
            MySql.Data.MySqlClient.MySqlDataReader reader = cmd.ExecuteReader();

            Response.Write("<br><br><div class='container'>"
                + "<h2 align='center'>Şubelerimiz</h2>"
                + "<br /> <br />"
                + "<div class='card-deck'>");

            if (reader.HasRows)
                while (reader.Read())
                {
                    string[] splitStreet = Convert.ToString(reader["street"]).Split('/');
                    string check = " ";

                    if (splitStreet.Length == 1)
                        check = " ";
                    else
                        check = splitStreet[1];

                    if (count++ % 3 == 0)
                        Response.Write("<br> <br>");

                    Response.Write("<div style='margin-bottom:50px' class='col-xl-4 col-lg-6 col-md-6 col-sm-12'>"
                    + "<div class='card'>"
                    + "<img class='card-img-top' src='Images/Navbar-Brand.png' width='468' height='250' alt='Card image cap'>"
                    + "<div class='card-body'>"
                    + "<h4 class='card-title'>" + reader["name"] + "</h4>"
                    + "<p class='card-text'> Telefon: " + reader["phone"] + "</p>"
                    + "<p class='card-text'> Adres: " + reader["street"] + " " + reader["district"] + "/" + reader["province"] + " " + reader["zipcode"] + "</p>"
                    + "</div>"
                    + "<div style='text-align:center' class='card-footer'>"
                    + "<a href='https://www.google.com.tr/maps/place/"
                    + reader["province"] + " " + reader["district"] + " " + splitStreet[0] + " "
                    + check + "' class='btn btn-primary' target='_blank'>Haritada Görüntüle</a>"
                    + "</div>"
                    + "</div>"
                    + "</div>");
                }

            Response.Write("</div> </div>");

            connection.Close();
        }
        catch (MySql.Data.MySqlClient.MySqlException ex)
        {
           
        }
    %>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterPage.Master" AutoEventWireup="true" CodeBehind="Campaigns.aspx.cs" Inherits="Car_Rental.Campaigns" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>

    <%
        MySql.Data.MySqlClient.MySqlConnection connection;
        string myConnectionString = "";

        try
        {
            connection = new MySql.Data.MySqlClient.MySqlConnection(myConnectionString);
            connection.Open();
            string sql = "allCouponsSP";
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(sql, connection);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            MySql.Data.MySqlClient.MySqlDataReader reader = cmd.ExecuteReader();

            Response.Write("<br><br><div class='container'>"
                + "<h2 align='center'>Kampanyalar</h2>"
                + "<br />");

            if (reader.HasRows)
                while (reader.Read())
                {
                    Response.Write("<br><div class='card text-center'>"
                    + "<div class='card-header'>"
                    + "<p class='font-weight-bold'> Kupon Kodu: " + reader["code"] + "</p>"
                    + "</div>"
                    + "<div class='card-body'>"
                    + "<h4 class='card-title'>İndirim Oranı: " + Convert.ToDouble(reader["discount_percentage"]) * 100 + "%</h4>"
                    + "<p class='card-text'>" + reader["description"] + "</p>"
                    + "</div>"
                    + "<div class='card-footer text-muted'>"
                    + "Son Geçerlilik Süresi: " + reader["expiry_date"]
                    + "</div>"
                    + "</div>");
                }

            Response.Write("</div>");

            connection.Close();
        }
        catch (MySql.Data.MySqlClient.MySqlException ex)
        {

        }
    %>

    <br />
    <br />
</asp:Content>

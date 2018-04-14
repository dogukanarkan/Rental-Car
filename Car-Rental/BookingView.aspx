<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementMasterPage.Master" AutoEventWireup="true" CodeBehind="BookingView.aspx.cs" Inherits="Car_Rental.BookingView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%
        MySql.Data.MySqlClient.MySqlConnection connection;
        string myConnectionString = "";

        try
        {
            connection = new MySql.Data.MySqlClient.MySqlConnection(myConnectionString);
            connection.Open();

            string sql = "SELECT Booking.booking_id, code, start_time, end_time, first_name, last_name, Customer.phone, name, plate, image_url, brand_name, model_name "
                    + "FROM Booking JOIN Customer ON Booking.customer_id = Customer.customer_id JOIN Car ON Booking.car_id = Car.car_id "
                    + "JOIN Branch ON Car.branch_id = Branch.branch_id JOIN CarDetail ON Car.car_detail_id = CarDetail.car_detail_id JOIN Model ON CarDetail.model_id = Model.model_id ORDER BY Booking.booking_id";
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(sql, connection);
            MySql.Data.MySqlClient.MySqlDataReader reader = cmd.ExecuteReader();

            Response.Write("<br><br><div class='container'>"
                + "<h2 align='center'>Rezervasyonlar</h2>"
                + "<br /><br />"
                + "<div id='accordion' role='tablist'>");

            if (reader.HasRows)
                while (reader.Read())
                    Response.Write("<div class='card'>"
                        + "<div class='card-header' role='tab' id='heading" + reader["booking_id"] + "'>"
                        + "<h5 class='mb-0'>"
                        + "<a class='collapsed' data-toggle='collapse' href='#collapse" + reader["booking_id"] + "' aria-expanded='false' aria-controls='collapseThree'>"
                        + "#" + reader["booking_id"] + " " + reader["first_name"] + " " + reader["last_name"] + " @" + reader["code"]
                        + "</a>"
                        + "</h5>"
                        + "</div>"
                        + "<div id='collapse" + reader["booking_id"] + "' class='collapse' role='tabpanel' aria-labelledby='heading" + reader["booking_id"] + "' data-parent='#accordion'>"
                        + "<img class='rounded mx-auto d-block' src='" + reader["image_url"] + "' style='width:444px; height:250px;' />"
                        + "<div class='card-body'>"
                        + "<table class='table'>"
                        + "<thead class='thead-light'>"
                        + "<tr>"
                        + "<th scope='col'>Marka</th>"
                        + "<th scope='col'>Model</th>"
                        + "<th scope='col'>Plaka</th>"
                        + "<th scope='col'>Şube</th>"
                        + "</tr>"
                        + "</thead>"
                        + "<tbody>"
                        + "<tr>"
                        + "<td>" + reader["brand_name"] + "</td>"
                        + "<td>" + reader["model_name"] + "</td>"
                        + "<td>" + reader["plate"] + "</td>"
                        + "<td>" + reader["name"] + "</td>"
                        + "</tr>"
                        + "</tbody>"
                        + "</table>"
                        + "<table class='table'>"
                        + "<thead class='thead-light'>"
                        + "<tr>"
                        + "<th scope='col'>Telefon</th>"
                        + "<th scope='col'>Başlangıç Tarihi</th>"
                        + "<th scope='col'>Bitiş Tarihi</th>"
                        + "</tr>"
                        + "</thead>"
                        + "<tbody>"
                        + "<tr>"
                        + "<td>" + reader["phone"] + "</td>"
                        + "<td>" + reader["start_time"] + "</td>"
                        + "<td>" + reader["end_time"] + "</td>"
                        + "</tr>"
                        + "</tbody>"
                        + "</table>"
                        + "</div>"
                        + "</div>"
                        + "</div>");

            Response.Write("</div></div>");

            connection.Close();
        }
        catch (MySql.Data.MySqlClient.MySqlException ex)
        {

        }
    %>
    <br />
    <div class="container">
        <asp:Button ID="Button1" runat="server" Text="Çıktı Al" CssClass="btn btn-primary float-right" OnClick="Button1_Click" />
    </div>
    <br />
    <br />
    <br />
    <br />

    <asp:Panel ID="Panel1" Visible="false" runat="server">
        <h1 align='center'>Rezervasyon Listesi</h1>
        <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    </asp:Panel>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementMasterPage.Master" AutoEventWireup="true" CodeBehind="InvoiceView.aspx.cs" Inherits="Car_Rental.InvoiceView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%
        MySql.Data.MySqlClient.MySqlConnection connection;
        string myConnectionString = "";

        try
        {
            connection = new MySql.Data.MySqlClient.MySqlConnection(myConnectionString);
            connection.Open();

            string sql = "SELECT invoice_id, first_name, last_name, date, status, payment_type, discount_amount, total_amount, phone FROM Invoice "
                + "JOIN Booking ON Invoice.booking_id = Booking.booking_id JOIN Customer ON Booking.customer_id = Customer.customer_id ORDER BY invoice_id";
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(sql, connection);
            MySql.Data.MySqlClient.MySqlDataReader reader = cmd.ExecuteReader();

            Response.Write("<br><br><div class='container'>"
                + "<h2 align='center'>Faturalar</h2>"
                + "<br /><br />"
                + "<div id='accordion' role='tablist'>");

            if (reader.HasRows)
                while (reader.Read())
                    Response.Write("<div class='card'>"
                        + "<div class='card-header' role='tab' id='heading" + reader["invoice_id"] + "'>"
                        + "<h5 class='mb-0'>"
                        + "<a class='collapsed' data-toggle='collapse' href='#collapse" + reader["invoice_id"] + "' aria-expanded='false' aria-controls='collapseThree'>"
                        + "#" + reader["invoice_id"] + " " + reader["first_name"] + " " + reader["last_name"]
                        + "</a>"
                        + "</h5>"
                        + "</div>"
                        + "<div id='collapse" + reader["invoice_id"] + "' class='collapse' role='tabpanel' aria-labelledby='heading" + reader["invoice_id"] + "' data-parent='#accordion'>"
                        + "<div class='card-body'>"
                        + "<table class='table'>"
                        + "<thead class='thead-light'>"
                        + "<tr>"
                        + "<th scope='col'>Tarih</th>"
                        + "<th scope='col'>Ödeme Türü</th>"
                        + "<th scope='col'>Durum</th>"
                        + "<th scope='col'>İndirim Ücreti</th>"
                        + "<th scope='col'>Toplam Ücret</th>"
                        + "<th scope='col'>Müşteri Telefonu</th>"
                        + "</tr>"
                        + "</thead>"
                        + "<tbody>"
                        + "<tr>"
                        + "<td>" + reader["date"] + "</td>"
                        + "<td>" + reader["payment_type"] + "</td>"
                        + "<td>" + reader["status"] + "</td>"
                        + "<td>" + reader["discount_amount"] + " TL</td>"
                        + "<td>" + reader["total_amount"] + " TL</td>"
                        + "<td>" + reader["phone"] + "</td>"
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

    <asp:Panel ID="Panel1" Visible="false" runat="server">
        <h1 align='center'>Fatura Listesi</h1>
        <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    </asp:Panel>
</asp:Content>

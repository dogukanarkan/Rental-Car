<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementMasterPage.Master" AutoEventWireup="true" CodeBehind="BookingAndPaySecond.aspx.cs" Inherits="Car_Rental.BookingAndPaySecond" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />
    <br />
    <div class="container">
        <h2 align="center">Rezervasyon ve Ödeme İşlemleri</h2>
        <br />
        <br />
        <br />
        <div class="form-group row">
            <label for="bookingCodeTextBox" class="col-sm-2 col-form-label">Rezervasyon Kodu:</label>
            <div class="col-sm-8">
                <asp:TextBox ID="bookingCodeTextBox" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
            <div class="col-sm-2">
                <asp:Button ID="Search" runat="server" CssClass="btn btn-primary btn-block" Text="Sorgula" OnClick="Search_Click" />
            </div>
        </div>
        <br />
        <br />

        <%

            MySql.Data.MySqlClient.MySqlConnection connectionSelect1;

            string myConnectionString = "";

            try
            {
                connectionSelect1 = new MySql.Data.MySqlClient.MySqlConnection(myConnectionString);
                connectionSelect1.Open();

                MySql.Data.MySqlClient.MySqlCommand commandSelect1 = new MySql.Data.MySqlClient.MySqlCommand("SELECT identity_number, first_name, last_name, status "
                    + "FROM Customer JOIN Booking ON Customer.customer_id = Booking.customer_id "
                    + "JOIN Invoice ON Booking.booking_id = Invoice.booking_id WHERE code = @code", connectionSelect1);
                commandSelect1.Parameters.Add(new MySql.Data.MySqlClient.MySqlParameter("@code", Session["bookingCode"]));
                MySql.Data.MySqlClient.MySqlDataReader reader1 = commandSelect1.ExecuteReader();

                if (reader1.HasRows)
                    while (reader1.Read())
                    {

        %>

        <div align="center">
            <div class="card" style="width: 40rem;">
                <div class="card-header">
                    <div class="form-group row">
                        <label class="col-sm-12 col-form-label">Müşterinin </label>
                    </div>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">
                        <div class="form-group row">
                            <label class="col-sm-5 col-form-label">Kimlik Numarası: </label>
                            <div class="col-sm-7">
                                <input type="text" readonly class="form-control-plaintext" value="<% Response.Write(reader1["identity_number"]); %>">
                            </div>
                        </div>
                    </li>
                    <li class="list-group-item">
                        <div class="form-group row">
                            <label class="col-sm-5 col-form-label">Adı Soyadı: </label>
                            <div class="col-sm-7">
                                <input type="text" readonly class="form-control-plaintext" value="<% Response.Write(reader1["first_name"] + " " + reader1["last_name"]); %>">
                            </div>
                        </div>
                    </li>
                    <li class="list-group-item">
                        <div class="form-group row">
                            <label class="col-sm-5 col-form-label">Ödeme Durumu: </label>
                            <div class="col-sm-7">
                                <input type="text" readonly class="form-control-plaintext" value="<% 
                                    if (reader1["status"].ToString() == "Unpaid")
                                        Response.Write("Ödenmedi");
                                    else if (reader1["status"].ToString() == "Paid")
                                        Response.Write("Ödendi");
                                    %>">
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <br />
        <br />
        <br />
        <div class="form-group row justify-content-md-center">
            <asp:DropDownList ID="paymentTypeList" runat="server" CssClass="form-control col-sm-4">
                <asp:ListItem Value="Credit Card">Ödeme Türü</asp:ListItem>
                <asp:ListItem Value="Credit Card">Kredi Kartı</asp:ListItem>
                <asp:ListItem Value="Cash">Nakit</asp:ListItem>
            </asp:DropDownList>
            <div class="col-sm-2">
                <asp:Button ID="Payment" runat="server" CssClass="btn btn-primary btn-block" Text="Ödemeyi Onayla" OnClick="Payment_Click" />
            </div>
        </div>

        <%

                    }
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {

            }

        %>
    </div>

</asp:Content>

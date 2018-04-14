<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterPage.Master" AutoEventWireup="true" CodeBehind="BookingOperations.aspx.cs" Inherits="Car_Rental.BookingOperation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />
    <br />
    <div class="container">
        <h2 align="center">Rezervasyon İşlemleri</h2>
        <br />
        <br />
        <br />
        <div class="col-md-8 offset-md-3">
            <div class="form-group row">
                <label for="bookingCodeTextBox" class="col-xl-3 col-form-label">Rezervasyon Kodu:</label>
                <div class="col-xl-6">
                    <asp:TextBox ID="bookingCodeTextBox" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red" ControlToValidate="bookingCodeTextBox"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group row">
                <label for="identityNumberTextBox" class="col-xl-3 col-form-label">TC Kimlik Numarası:</label>
                <div class="col-xl-6">
                    <asp:TextBox ID="identityNumberTextBox" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red" ControlToValidate="identityNumberTextBox"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <br />
        <asp:Button ID="SearchButton" runat="server" CssClass="btn btn-primary btn-lg btn-block" Text="Sorgula" OnClick="SearchButton_Click" />
    </div>

    <asp:Panel ID="Panel1" Visible="false" runat="server">
        <br />
        <br />
        <br />
        <br />
        <div class="container">
            <h2 id="bookingInformation" align="center">Rezervasyon Bilgileri</h2>
            <br />
            <br />
            <%
                using (var conn1 = new MySql.Data.MySqlClient.MySqlConnection(""))
                {
                    conn1.Open();

                    using (var cmd1 = new MySql.Data.MySqlClient.MySqlCommand("SELECT first_name, last_name, name, start_time, end_time, brand_name, model_name, image_url, total_amount "
                        + "FROM Booking JOIN Customer ON Booking.customer_id = Customer.customer_id JOIN Invoice ON Booking.booking_id = Invoice.booking_id "
                        + "JOIN Car ON Booking.car_id = Car.car_id JOIN Branch ON Car.branch_id = Branch.branch_id JOIN CarDetail ON Car.car_detail_id = CarDetail.car_detail_id "
                        + "JOIN Model ON CarDetail.model_id = Model.model_id WHERE Booking.code = @code", conn1))
                    {
                        cmd1.Parameters.Add("@code", bookingCodeTextBox.Text);

                        using (var reader1 = cmd1.ExecuteReader())
                            if (reader1.HasRows)
                                if (reader1.Read())
                                {
            %>

            <div class="card">
                <div class="card-body">
                    <% Image1.ImageUrl = reader1["image_url"].ToString(); %>
                    <asp:Image ID="Image1" class="rounded mx-auto d-block" Style="width: 444px; height: 250px;" runat="server" />
                    <br />
                    <h4 class="card-title" align="center"><% Response.Write(reader1["brand_name"] + " " + reader1["model_name"]); %></h4>
                    <br />
                    <div class="form-group row">
                        <label for="nameSurname" class="col-xl-3 col-form-label"><strong>Müşteri Adı Soyadı:</strong></label>
                        <label id="nameSurname" class="col-xl-5 col-form-label"><% Response.Write(reader1["first_name"] + " " + reader1["last_name"]); %></label>
                    </div>
                    <div class="form-group row">
                        <label for="startDate" class="col-xl-3 col-form-label"><strong>Rezervasyon Başlangıç Tarihi:</strong></label>
                        <label id="startDate" class="col-xl-5 col-form-label"><% Response.Write(reader1["start_time"]); %></label>
                    </div>
                    <div class="form-group row">
                        <label for="endDate" class="col-xl-3 col-form-label"><strong>Rezervasyon Bitiş Tarihi:</strong></label>
                        <label id="endDate" class="col-xl-5 col-form-label"><% Response.Write(reader1["end_time"]); %></label>
                    </div>
                    <div class="form-group row">
                        <label for="branch" class="col-xl-3 col-form-label"><strong>Kiralandığı Şube:</strong></label>
                        <label id="branch" class="col-xl-5 col-form-label"><% Response.Write(reader1["name"]); %></label>
                    </div>
                    <%
                        using (var conn2 = new MySql.Data.MySqlClient.MySqlConnection(""))
                        {
                            int count = 0;
                            conn2.Open();

                            using (var cmd2 = new MySql.Data.MySqlClient.MySqlCommand("SELECT name FROM Insurance JOIN InsuranceBooking ON Insurance.insurance_id = InsuranceBooking.insurance_id "
                                + "JOIN Booking ON InsuranceBooking.booking_id = Booking.booking_id WHERE Booking.code = @code", conn2))
                            {
                                cmd2.Parameters.Add("@code", bookingCodeTextBox.Text);

                                using (var reader2 = cmd2.ExecuteReader())
                                {
                                    if (reader2.HasRows)
                                    {
                                        while (reader2.Read())
                                        {
                                            if (count++ == 0)
                                                Response.Write("<div class='form-group row'>"
                                                    + "<label for='insurance' class='col-xl-3 col-form-label'><strong>Seçilen Sigortalar:</strong></label>"
                                                    + "<label id='insurance' class='col-xl-5 col-form-label'>" + reader2["name"] + "</label>"
                                                    + "</div>");
                                            else
                                                Response.Write("<div class='form-group row'>"
                                                    + "<label for='insurance' class='col-xl-3 col-form-label'></label>"
                                                    + "<label id='insurance' class='col-xl-5 col-form-label'>" + reader2["name"] + "</label>"
                                                    + "</div>");
                                        }
                                    }
                                    else
                                        Response.Write("<div class='form-group row'>"
                                                    + "<label for='insurance' class='col-xl-3 col-form-label'><strong>Seçilen Sigortalar:</strong></label>"
                                                    + "<label id='insurance' class='col-xl-5 col-form-label'>Yok</label>"
                                                    + "</div>");
                                }
                            }
                        }
                    %>
                    <div class="form-group row">
                        <label for="fee" class="col-xl-3 col-form-label"><strong>Ücret:</strong></label>
                        <label id="fee" class="col-xl-5 col-form-label"><% Response.Write(reader1["total_amount"] + " TL"); %></label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xl-4 mx-auto">
                        <asp:Button ID="Delete" CssClass="btn btn-primary btn-lg btn-block" runat="server" Text="Rezervasyonu İptal Et" OnClick="Delete_Click" />
                    </div>
                </div>
            </div>
            <%
                            }
                    }
                }
            %>
        </div>
        <br />
        <br />
        <br />
        <br />
    </asp:Panel>

</asp:Content>

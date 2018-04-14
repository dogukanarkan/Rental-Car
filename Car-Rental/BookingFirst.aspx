<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterPage.Master" AutoEventWireup="true" CodeBehind="BookingFirst.aspx.cs" Inherits="Car_Rental.Booking" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%
        MySql.Data.MySqlClient.MySqlConnection connectionSelect1;
        MySql.Data.MySqlClient.MySqlConnection connectionSelect2;
        MySql.Data.MySqlClient.MySqlConnection connectionSelect3;

        string myConnectionString = "";

        try
        {
            connectionSelect1 = new MySql.Data.MySqlClient.MySqlConnection(myConnectionString);
            connectionSelect1.Open();

            MySql.Data.MySqlClient.MySqlCommand commandSelect1 = new MySql.Data.MySqlClient.MySqlCommand("SELECT branch_id FROM Branch WHERE name = @name", connectionSelect1);
            commandSelect1.Parameters.Add(new MySql.Data.MySqlClient.MySqlParameter("@name", Session["branch"]));
            MySql.Data.MySqlClient.MySqlDataReader reader1 = commandSelect1.ExecuteReader();

            string branch_id = " ";

            if (reader1.Read())
                branch_id = reader1["branch_id"].ToString();

            connectionSelect2 = new MySql.Data.MySqlClient.MySqlConnection(myConnectionString);
            connectionSelect2.Open();

            MySql.Data.MySqlClient.MySqlCommand commandSelect2 = new MySql.Data.MySqlClient.MySqlCommand("SELECT Car.car_id, cost_per_day, image_url, engine_power, model_year, mileage, color, transmission, door, seat, brand_name, model_name " +
                "FROM Car JOIN CarDetail ON Car.car_detail_id = CarDetail.car_detail_id JOIN Model ON CarDetail.model_id = Model.model_id " +
                "WHERE Car.availability = 'YES' AND Car.branch_id = @branch_id ORDER BY car_id", connectionSelect2);
            commandSelect2.Parameters.Add(new MySql.Data.MySqlClient.MySqlParameter("@branch_id", branch_id));
            MySql.Data.MySqlClient.MySqlDataReader reader2 = commandSelect2.ExecuteReader();

            connectionSelect3 = new MySql.Data.MySqlClient.MySqlConnection(myConnectionString);
            connectionSelect3.Open();

            MySql.Data.MySqlClient.MySqlCommand commandSelect3 = new MySql.Data.MySqlClient.MySqlCommand("SELECT Car.car_id, cost_per_day, image_url, engine_power, model_year, mileage, color, transmission, door, seat, brand_name, model_name " +
                "FROM Car  JOIN CarDetail ON Car.car_detail_id = CarDetail.car_detail_id JOIN Model ON CarDetail.model_id = Model.model_id " +
                "JOIN Booking ON Car.car_id = Booking.car_id WHERE Car.availability = 'NO' AND Car.branch_id = @branch_id AND @startTime > Booking.end_time ORDER BY car_id", connectionSelect3);
            commandSelect3.Parameters.Add(new MySql.Data.MySqlClient.MySqlParameter("@branch_id", branch_id));
            commandSelect3.Parameters.Add(new MySql.Data.MySqlClient.MySqlParameter("@startTime", Session["startDate"] + " " + Session["startTime"]));
            MySql.Data.MySqlClient.MySqlDataReader reader3 = commandSelect3.ExecuteReader();

            Response.Write("<br><br><div class='container'>"
                    + "<h2 align='center'>Rezervasyon</h2>"
                    + "<br /> <br />"
                    + "<h5 class='text-primary' id='car'>Araç Seçimi</h5>"
                    + "<br />"
                    + "<div class='card-deck'>");

            if (Request.UrlReferrer != null)
            {
                if (Request.UrlReferrer.ToString() == "http://carrentalwebapp.azurewebsites.net/MainPage.aspx")
                {
                    if (reader2.HasRows)
                        while (reader2.Read())
                            Response.Write("<div style='margin-bottom: 50px' class='col-xl-6 col-lg-6 col-md-12 col-sm-12'>"
                                + "<div class='card'>"
                                + "<img class='card-img-top' src='" + reader2["image_url"] + "' alt='Card image' style='width: 100%'>"
                                + "<div class='card-body'>"
                                + "<h4 class='card-title' align='center'>" + reader2["brand_name"] + " " + reader2["model_name"] + "</h4>"
                                + "<p class='card-text'>"
                                + "<div class='row'>"
                                + "<div class='col align-self-start'>"
                                + "<strong>Motor Gücü: </strong>" + reader2["engine_power"]
                                + "</div>"
                                + "<div class='col align-self-end'>"
                                + "<strong>Model Yılı: </strong>" + reader2["model_year"]
                                + "</div>"
                                + "</div>"
                                + "<div class='row'>"
                                + "<div class='col align-self-start'>"
                                + "<strong>Vites: </strong>" + reader2["transmission"]
                                + "</div>"
                                + "<div class='col align-self-end'>"
                                + "<strong>Kilometre: </strong>" + reader2["mileage"]
                                + "</div>"
                                + "</div>"
                                + "<div class='row'>"
                                + "<div class='col align-self-start'>"
                                + "<strong>Koltuk: </strong>" + reader2["seat"]
                                + "</div>"
                                + "<div class='col align-self-end'>"
                                + "<strong>Kapı: </strong>" + reader2["door"]
                                + "</div>"
                                + "</div>"
                                + "<div class='row'>"
                                + "<div class='col align-self-start'>"
                                + "<strong>Renk: </strong>" + reader2["color"]
                                + "</div>"
                                + "<div class='col align-self-end'>"
                                + "<strong>Günlük Ücreti: </strong>" + reader2["cost_per_day"] + " TL"
                                + "</div>"
                                + "</div>"
                                + "</p>"
                                + "<div class='row'>"
                                + "<div class='col-auto mr-auto'></div>"
                                + "<div class='col-auto'>"
                                + "<a class='btn btn-primary' href='BookingFirst.aspx?carId=" + reader2["car_id"] + "'>Seç</a>"
                                + "</div>"
                                + "</div>"
                                + "</div>"
                                + "</div>"
                                + "</div>");

                    if (reader3.HasRows)
                        while (reader3.Read())
                            Response.Write("<div style='margin-bottom: 50px' class='col-xl-6 col-lg-6 col-md-12 col-sm-12'>"
                                + "<div class='card'>"
                                + "<img class='card-img-top' src='" + reader3["image_url"] + "' alt='Card image' style='width: 100%'>"
                                + "<div class='card-body'>"
                                + "<h4 class='card-title' align='center'>" + reader3["brand_name"] + " " + reader3["model_name"] + "</h4>"
                                + "<p class='card-text'>"
                                + "<div class='row'>"
                                + "<div class='col align-self-start'>"
                                + "<strong>Motor Gücü: </strong>" + reader3["engine_power"]
                                + "</div>"
                                + "<div class='col align-self-end'>"
                                + "<strong>Model Yılı: </strong>" + reader3["model_year"]
                                + "</div>"
                                + "</div>"
                                + "<div class='row'>"
                                + "<div class='col align-self-start'>"
                                + "<strong>Vites: </strong>" + reader3["transmission"]
                                + "</div>"
                                + "<div class='col align-self-end'>"
                                + "<strong>Kilometre: </strong>" + reader3["mileage"]
                                + "</div>"
                                + "</div>"
                                + "<div class='row'>"
                                + "<div class='col align-self-start'>"
                                + "<strong>Koltuk: </strong>" + reader3["seat"]
                                + "</div>"
                                + "<div class='col align-self-end'>"
                                + "<strong>Kapı: </strong>" + reader3["door"]
                                + "</div>"
                                + "</div>"
                                + "<div class='row'>"
                                + "<div class='col align-self-start'>"
                                + "<strong>Renk: </strong>" + reader3["color"]
                                + "</div>"
                                + "<div class='col align-self-end'>"
                                + "<strong>Günlük Ücreti: </strong>" + reader3["cost_per_day"] + " TL"
                                + "</div>"
                                + "</div>"
                                + "</p>"
                                + "<div class='row'>"
                                + "<div class='col-auto mr-auto'></div>"
                                + "<div class='col-auto'>"
                                + "<a class='btn btn-primary' href='BookingFirst.aspx?carId=" + reader3["car_id"] + "'>Seç</a>"
                                + "</div>"
                                + "</div>"
                                + "</div>"
                                + "</div>"
                                + "</div>");
                    Response.Write("</div>");
                }
                else
                {
                    using (var conn = new MySql.Data.MySqlClient.MySqlConnection(""))
                    {
                        conn.Open();

                        using (var cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT cost_per_day, image_url, engine_power, model_year, mileage, color, transmission, door, seat, brand_name, model_name "
                            + "FROM Car JOIN CarDetail ON Car.car_detail_id = CarDetail.car_detail_id JOIN Model ON CarDetail.model_id = Model.model_id "
                            + "WHERE Car.car_id = @car_id ORDER BY car_id", conn))
                        {
                            cmd.Parameters.Add("@car_id", Request.QueryString["carId"]);

                            using (var reader4 = cmd.ExecuteReader())
                                if (reader4.HasRows)
                                    while (reader4.Read())
                                        Response.Write("<div style='margin-bottom: 50px' class='col-xl-6 col-lg-6 col-md-12 col-sm-12'>"
                                            + "<div class='card'>"
                                            + "<img class='card-img-top' src='" + reader4["image_url"] + "' alt='Card image' style='width: 100%'>"
                                            + "<div class='card-body'>"
                                            + "<h4 class='card-title' align='center'>" + reader4["brand_name"] + " " + reader4["model_name"] + "</h4>"
                                            + "<p class='card-text'>"
                                            + "<div class='row'>"
                                            + "<div class='col align-self-start'>"
                                            + "<strong>Motor Gücü: </strong>" + reader4["engine_power"]
                                            + "</div>"
                                            + "<div class='col align-self-end'>"
                                            + "<strong>Model Yılı: </strong>" + reader4["model_year"]
                                            + "</div>"
                                            + "</div>"
                                            + "<div class='row'>"
                                            + "<div class='col align-self-start'>"
                                            + "<strong>Vites: </strong>" + reader4["transmission"]
                                            + "</div>"
                                            + "<div class='col align-self-end'>"
                                            + "<strong>Kilometre: </strong>" + reader4["mileage"]
                                            + "</div>"
                                            + "</div>"
                                            + "<div class='row'>"
                                            + "<div class='col align-self-start'>"
                                            + "<strong>Koltuk: </strong>" + reader4["seat"]
                                            + "</div>"
                                            + "<div class='col align-self-end'>"
                                            + "<strong>Kapı: </strong>" + reader4["door"]
                                            + "</div>"
                                            + "</div>"
                                            + "<div class='row'>"
                                            + "<div class='col align-self-start'>"
                                            + "<strong>Renk: </strong>" + reader4["color"]
                                            + "</div>"
                                            + "<div class='col align-self-end'>"
                                            + "<strong>Günlük Ücreti: </strong>" + reader4["cost_per_day"] + " TL"
                                            + "</div>"
                                            + "</div>"
                                            + "</p>"
                                            + "</div>"
                                            + "</div>"
                                            + "</div>");
                            Response.Write("</div>");
                        }

                        conn.Close();
                    }
                }
            }
    %>

    <h5 class="text-primary" id="insurance">Sigorta Seçimi</h5>
    <br />
    <asp:CheckBoxList ID="insuranceList" runat="server"></asp:CheckBoxList>
    <br />
    <br />
    <div class="form-group row">
        <h5 class="col-sm-1 text-primary" id="coupon">Kupon</h5>
        <div class="col-sm-3">
            <asp:TextBox ID="CouponCodeTextBox" CssClass="form-control" runat="server"></asp:TextBox>
        </div>
    </div>
    <br />
    <br />
    <asp:ScriptManager runat="server" ID="sm">
    </asp:ScriptManager>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="form-group row">
                <h5 class="col-sm-2 text-primary" id="fee">Toplam Ücret</h5>
                <div class="col-sm-2">
                    <asp:Label ID="FeeLabel" runat="server" Text=""></asp:Label>
                </div>
                <div class="col-sm-2">
                    <asp:Button ID="CalculateButton" runat="server" CssClass="btn btn-primary btn-block" Text="Hesapla" OnClick="CalculateButton_Click" />
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />

    <%
            Response.Write("</div>");
        }
        catch (MySql.Data.MySqlClient.MySqlException ex)
        {

        }
    %>

    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="container">
                <asp:Button ID="nextButton" CssClass="btn btn-primary btn-lg btn-block" runat="server" Text="İleri" OnClick="nextButton_Click" />
            </div>
            <asp:Panel ID="Panel1" Visible="false" runat="server">
                <br />
                <br />
                <div class="container">
                    <h2 id="personalInformation" align="center">Kişisel Bilgiler</h2>
                    <br />
                    <br />
                    <asp:TextBox ID="nameTextBox" placeholder="Ad" CssClass="form-control" runat="server"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="surnameTextBox" placeholder="Soyad" CssClass="form-control" runat="server"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="identityTextBox" placeholder="TC Kimlik Numarası" CssClass="form-control" runat="server"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="phoneTextBox" placeholder="Telefon Numarası" CssClass="form-control" runat="server"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="mailTextBox" placeholder="Mail Adresi" CssClass="form-control" runat="server"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="birthDateTextBox" placeholder="Doğum Tarihi(yyyy-mm-dd)" CssClass="form-control" runat="server"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="streetTextBox" placeholder="Adres" CssClass="form-control" runat="server"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="provinceTextBox" placeholder="İl" CssClass="form-control" runat="server"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="districtTextBox" placeholder="İlçe" CssClass="form-control" runat="server"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="zipcodeTextBox" placeholder="Posta Kodu" CssClass="form-control" runat="server"></asp:TextBox>
                    <br />
                    <br />
                    <div class="text-center">
                        <asp:Button ID="bookingButton" CssClass="btn btn-primary btn-lg btn-block" runat="server" Text="Rezervasyon Yap" OnClick="bookingButton_Click" />
                    </div>
                </div>
                <br />
                <br />
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

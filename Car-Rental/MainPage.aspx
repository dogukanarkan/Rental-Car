<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterPage.Master" AutoEventWireup="true" CodeBehind="MainPage.aspx.cs" Inherits="Car_Rental.MainPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />
    <br />
    <div class="container">
        <h2 align="center">Araç Kiralama</h2>
        <br />
        <br />
        <br />
        <asp:DropDownList ID="branchList" runat="server" CssClass="form-control">
        </asp:DropDownList>
        <br />
        <br />
        <div class="row">
            <div align="center" class="col">
                <h5>Kira Başlangıç Tarihi</h5>
                <asp:Calendar ID="startDate" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </div>
            <div align="center" class="col">
                <h5>Kira Bitiş Tarihi</h5>
                <asp:Calendar ID="endDate" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </div>
        </div>
        <br />
        <br />
        <div class="row">
            <div align="center" class="col">
                <asp:DropDownList ID="startTime" runat="server" CssClass="form-control" Height="35px" Width="135px">
                    <asp:ListItem Value="00:00:00">Saat Seçiniz</asp:ListItem>
                    <asp:ListItem Value="00:00:00">00:00</asp:ListItem>
                    <asp:ListItem Value="01:00:00">01:00</asp:ListItem>
                    <asp:ListItem Value="02:00:00">02:00</asp:ListItem>
                    <asp:ListItem Value="03:00:00">03:00</asp:ListItem>
                    <asp:ListItem Value="04:00:00">04:00</asp:ListItem>
                    <asp:ListItem Value="05:00:00">05:00</asp:ListItem>
                    <asp:ListItem Value="06:00:00">06:00</asp:ListItem>
                    <asp:ListItem Value="07:00:00">07:00</asp:ListItem>
                    <asp:ListItem Value="08:00:00">08:00</asp:ListItem>
                    <asp:ListItem Value="09:00:00">09:00</asp:ListItem>
                    <asp:ListItem Value="10:00:00">10:00</asp:ListItem>
                    <asp:ListItem Value="11:00:00">11:00</asp:ListItem>
                    <asp:ListItem Value="12:00:00">12:00</asp:ListItem>
                    <asp:ListItem Value="13:00:00">13:00</asp:ListItem>
                    <asp:ListItem Value="14:00:00">14:00</asp:ListItem>
                    <asp:ListItem Value="15:00:00">15:00</asp:ListItem>
                    <asp:ListItem Value="16:00:00">16:00</asp:ListItem>
                    <asp:ListItem Value="17:00:00">17:00</asp:ListItem>
                    <asp:ListItem Value="18:00:00">18:00</asp:ListItem>
                    <asp:ListItem Value="19:00:00">19:00</asp:ListItem>
                    <asp:ListItem Value="20:00:00">20:00</asp:ListItem>
                    <asp:ListItem Value="21:00:00">21:00</asp:ListItem>
                    <asp:ListItem Value="22:00:00">22:00</asp:ListItem>
                    <asp:ListItem Value="23:00:00">23:00</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div align="center" class="col">
                <asp:DropDownList ID="endTime" runat="server" CssClass="form-control" Height="35px" Width="135px">
                    <asp:ListItem Value="00:00:00">Saat Seçiniz</asp:ListItem>
                    <asp:ListItem Value="00:00:00">00:00</asp:ListItem>
                    <asp:ListItem Value="01:00:00">01:00</asp:ListItem>
                    <asp:ListItem Value="02:00:00">02:00</asp:ListItem>
                    <asp:ListItem Value="03:00:00">03:00</asp:ListItem>
                    <asp:ListItem Value="04:00:00">04:00</asp:ListItem>
                    <asp:ListItem Value="05:00:00">05:00</asp:ListItem>
                    <asp:ListItem Value="06:00:00">06:00</asp:ListItem>
                    <asp:ListItem Value="07:00:00">07:00</asp:ListItem>
                    <asp:ListItem Value="08:00:00">08:00</asp:ListItem>
                    <asp:ListItem Value="09:00:00">09:00</asp:ListItem>
                    <asp:ListItem Value="10:00:00">10:00</asp:ListItem>
                    <asp:ListItem Value="11:00:00">11:00</asp:ListItem>
                    <asp:ListItem Value="12:00:00">12:00</asp:ListItem>
                    <asp:ListItem Value="13:00:00">13:00</asp:ListItem>
                    <asp:ListItem Value="14:00:00">14:00</asp:ListItem>
                    <asp:ListItem Value="15:00:00">15:00</asp:ListItem>
                    <asp:ListItem Value="16:00:00">16:00</asp:ListItem>
                    <asp:ListItem Value="17:00:00">17:00</asp:ListItem>
                    <asp:ListItem Value="18:00:00">18:00</asp:ListItem>
                    <asp:ListItem Value="19:00:00">19:00</asp:ListItem>
                    <asp:ListItem Value="20:00:00">20:00</asp:ListItem>
                    <asp:ListItem Value="21:00:00">21:00</asp:ListItem>
                    <asp:ListItem Value="22:00:00">22:00</asp:ListItem>
                    <asp:ListItem Value="23:00:00">23:00</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <br />
        <br />
        <div class="text-center">
            <asp:Button ID="Button1" CssClass="btn btn-primary btn-lg" Width="215" runat="server" Text="Ara" OnClick="Button1_Click" />
        </div>
        <br />
        <br />
        <br />
        <br />
    </div>

    <%
        using (var conn = new MySql.Data.MySqlClient.MySqlConnection(""))
        {
            bool flag = true;

            conn.Open();

            Response.Write("<div id='carouselExampleControls' class='carousel slide' data-ride='carousel'>"
                + "<div class='carousel-inner'>");
            using (var cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT brand_name, model_name, cost_per_day, image_url FROM Car, CarDetail, Model "
                + "WHERE Model.model_id = CarDetail.model_id AND CarDetail.car_detail_id = Car.car_detail_id", conn))
            using (var reader = cmd.ExecuteReader())
                if (reader.HasRows)
                    while (reader.Read())
                    {
                        Response.Write("<div class='carousel-item");

                        if (flag)
                        {
                            Response.Write(" active");
                            flag = false;
                        }

                        Response.Write("'>"
                            + "<img class='d-block w-100' width='1920px' height='1080px' src='" + reader["image_url"] + "'>"
                            + "<div class='carousel-caption d-none d-md-block'>"
                            + "<h1>" + reader["brand_name"] + " " + reader["model_name"] + "</h1>"
                            + "<h5>Günlük Ücreti: " + reader["cost_per_day"] + " TL </h5>"
                            + "</div>"
                            + "</div>");
                    }

            Response.Write("<a class='carousel-control-prev' href='#carouselExampleControls' role='button' data-slide='prev'>"
                + "<span class='carousel-control-prev-icon' aria-hidden='true'></span>"
                + " <span class='sr-only'>Previous</span>"
                + "</a>"
                + "<a class='carousel-control-next' href='#carouselExampleControls' role='button' data-slide='next'>"
                + "<span class='carousel-control-next-icon' aria-hidden='true'></span>"
                + "<span class='sr-only'>Next</span>"
                + "</a>"
                + "</div>"
                + "</div>");
        }
    %>

</asp:Content>

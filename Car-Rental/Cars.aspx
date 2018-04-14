<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementMasterPage.Master" AutoEventWireup="true" CodeBehind="Cars.aspx.cs" Inherits="Car_Rental.CarOperations" %>

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

            string sql;

            if (Session["branchId"] != null && Session["branchId"].ToString() != "0")
            {
                sql = "SELECT car_id, brand_name, model_name, Model.model_id, engine_power, model_year, mileage, color, transmission, door, seat, image_url, cost_per_day "
                    + "FROM Model, CarDetail, Car WHERE Model.model_id = CarDetail.model_id AND "
                    + "CarDetail.car_detail_id = Car.car_detail_id AND branch_id = @branch_id";
            }
            else
            {
                sql = "SELECT car_id, brand_name, model_name, Model.model_id, engine_power, model_year, mileage, color, transmission, door, seat, image_url, cost_per_day "
                    + "FROM Model, CarDetail, Car WHERE Model.model_id = CarDetail.model_id AND "
                    + "CarDetail.car_detail_id = Car.car_detail_id";
            }

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(sql, connection);

            if (Session["branchId"] != null)
                cmd.Parameters.Add("@branch_id", Session["branchId"]);

            MySql.Data.MySqlClient.MySqlDataReader reader = cmd.ExecuteReader();

            Response.Write("<br><br><div class='container'>"
                    + "<h2 align='center'>Araçlar</h2>"
                    + "<br /> <br />");
    %>

    <asp:DropDownList ID="BranchList" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="BranchList_SelectedIndexChanged"></asp:DropDownList>
    <br />
    <br />

    <%
            Response.Write("<div class='card-deck'>");

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    Response.Write("<div style='margin-bottom: 50px' class='col-xl-6 col-lg-6 col-md-12 col-sm-12'>"
                        + "<div class='card'>"
                        + "<img class='card-img-top' src='" + reader["image_url"] + "' alt='Card image' style='width: 100%'>"
                        + "<div class='card-body'>"
                        + "<h4 class='card-title' align='center'>" + reader["brand_name"] + " " + reader["model_name"] + "</h4>"
                        + "<p class='card-text'>"
                        + "<div class='row'>"
                        + "<div class='col align-self-start'>"
                        + "<strong>Motor Gücü: </strong>" + reader["engine_power"]
                        + "</div>"
                        + "<div class='col align-self-end'>"
                        + "<strong>Model Yılı: </strong>" + reader["model_year"]
                        + "</div>"
                        + "</div>"
                        + "<div class='row'>"
                        + "<div class='col align-self-start'>"
                        + "<strong>Vites: </strong>" + reader["transmission"]
                        + "</div>"
                        + "<div class='col align-self-end'>"
                        + "<strong>Kilometre: </strong>" + reader["mileage"]
                        + "</div>"
                        + "</div>"
                        + "<div class='row'>"
                        + "<div class='col align-self-start'>"
                        + "<strong>Koltuk: </strong>" + reader["seat"]
                        + "</div>"
                        + "<div class='col align-self-end'>"
                        + "<strong>Kapı: </strong>" + reader["door"]
                        + "</div>"
                        + "</div>"
                        + "<div class='row'>"
                        + "<div class='col align-self-start'>"
                        + "<strong>Renk: </strong>" + reader["color"]
                        + "</div>"
                        + "<div class='col align-self-end'>"
                        + "<strong>Günlük Ücreti: </strong>" + reader["cost_per_day"] + " TL"
                        + "</div>"
                        + "</div>"
                        + "</p>"
                        + "<div class='row'>"
                        + "<div class='col-auto mr-auto'></div>"
                        + "<div class='col-auto'>"
                        + "<a class='btn btn-primary' href='Cars.aspx?carId=" + reader["car_id"] + "'>Sil</a>"
                        + "</div>"
                        + "</div>"
                        + "</div>"
                        + "</div>"
                        + "</div>");
                }
            }
            Response.Write("</div> </div>");

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
        <h1 align='center'>Araç Listesi</h1>
        <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    </asp:Panel>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementMasterPage.Master" AutoEventWireup="true" CodeBehind="AddCoupon.aspx.cs" Inherits="Car_Rental.AddCoupon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />
    <br />
    <div class="container">
        <h2 align="center">Kupon Ekleme</h2>
        <br />
        <br />
        <br />
        Kupon Kodu:
        <asp:TextBox ID="codeTextBox" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="codeTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        İndirim Oranı:
        <asp:TextBox ID="discountTextBox" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="*Lütfen 0 ile 1 arasında bir sayı giriniz." ControlToValidate="discountTextBox" ForeColor="Red" MinimumValue="0.1" MaximumValue="1"></asp:RangeValidator>
        <br />
        Son Geçerlilik Zamanı:
        <asp:Calendar ID="ExpiryDate" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
            <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
            <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <SelectedDayStyle BackColor="#333399" ForeColor="White" />
            <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
            <TodayDayStyle BackColor="#CCCCCC" />
        </asp:Calendar>
        <br />
        <asp:DropDownList ID="ExpiryTime" runat="server" CssClass="form-control" Height="35px" Width="135px">
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
        <br />
        Açıklaması:
        <asp:TextBox ID="descriptionTextBox" CssClass="form-control" TextMode="multiline" Rows="5" runat="server" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="descriptionTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        <div class="text-center">
            <asp:Button ID="Button1" CssClass="btn btn-primary btn-lg btn-block" runat="server" Text="Ekle" OnClick="Button1_Click" />
        <br />
        </div>
    </div>

</asp:Content>

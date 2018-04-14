<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterPage.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Car_Rental.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <br />
        <br />
        <p align="center">Aşağıdaki formu doldurarak bizimle iletişime geçebilirsiniz. En kısa sürede tarafınıza geri dönüş yapılacaktır.</p>
        <br />
        <br />
        İsim Soyisim:
        <asp:TextBox ID="nameTextBox" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="nameTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        Telefon:
        <asp:TextBox ID="phoneTextBox" TextMode="Phone" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="phoneTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        E-mail:
        <asp:TextBox ID="mailTextBox" TextMode="Email" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="mailTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        Mesajınız:
        <asp:TextBox ID="messageTextBox" CssClass="form-control" TextMode="multiline" Rows="5" runat="server" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="messageTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        <div class="text-center">
            <asp:Button ID="Button1" CssClass="btn btn-primary btn-lg btn-block" runat="server" Text="Gönder" OnClick="Button1_Click" />
        </div>
    </div>

</asp:Content>

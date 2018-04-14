<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementMasterPage.Master" AutoEventWireup="true" CodeBehind="ManagerLogin.aspx.cs" Inherits="Car_Rental.ManagerLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="Panel1" runat="server" DefaultButton="Button1">
        <div class="container">
            <br />
            <br />
            E-mail:
        <asp:TextBox ID="mailTextBox" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red" ControlToValidate="mailTextBox"></asp:RequiredFieldValidator>
            <br />
            Parola:
        <asp:TextBox ID="passwordTextBox" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red" ControlToValidate="passwordTextBox"></asp:RequiredFieldValidator>
            <br />
            <asp:Button ID="Button1" CssClass="btn btn-primary btn-lg btn-block" runat="server" Text="Giriş" OnClick="Button1_Click" />
        </div>

        <br />
        <br />
        <br />
        <div class="text-center">
            <asp:AdRotator ID="AdRotator1" runat="server" AdvertisementFile="~/AdRotator.xml" />
        </div>
    </asp:Panel>
</asp:Content>

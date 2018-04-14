<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementMasterPage.Master" AutoEventWireup="true" CodeBehind="BookingAndPayFirst.aspx.cs" Inherits="Car_Rental.ConfirmationBooking" %>

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
                <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary btn-block" Text="Sorgula" OnClick="Button1_Click" />
            </div>
        </div>
        <br />
        <br />
    </div>

</asp:Content>

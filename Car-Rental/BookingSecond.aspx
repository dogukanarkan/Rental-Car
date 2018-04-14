<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterPage.Master" AutoEventWireup="true" CodeBehind="BookingSecond.aspx.cs" Inherits="Car_Rental.BookingSecond" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />
    <br />
    <div class="container">
        <h2 align="center">Rezervasyonunuz gerçekleştirildi!</h2>
        <br />
        <br />
        <br />
        <h5 align="center">Rezervasyon kodunuz: <% Response.Write(Session["bookingCode"]); %></h5>
        <br />
        <h5 align="center">Sistemin yoğunluğuna göre en yakın sürede rezervasyon teyiti için <% Response.Write(Session["phone"]); %> numarası ile iletişime geçeceğiz.</h5>
    </div>
</asp:Content>

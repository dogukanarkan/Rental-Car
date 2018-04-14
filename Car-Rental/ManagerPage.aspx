<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementMasterPage.Master" AutoEventWireup="true" CodeBehind="ManagerPage.aspx.cs" Inherits="Car_Rental.ManagerPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container ">
        <br />
        <br />
        <div class="row">
            <div class=" align-content-lg-stretch">
                <a class="btn btn-primary btn-lg " href="Cars.aspx">Araç Görüntüleme/Silme </a>
            </div>
        </div>
        <br />
        <br />
        <div class="row">
            <div class=" align-content-lg-stretch">
                <a class="btn btn-primary btn-lg " href="Campaigns.aspx">Kupon Görüntüleme </a>
                <a class="btn btn-primary btn-lg " href="BookingView.aspx">Rezervasyon Görüntüleme </a>
                <a class="btn btn-primary btn-lg " href="InvoiceView.aspx">Fatura Görüntüleme </a>
            </div>
        </div>
        <br />
        <br />
        <div class="row">
            <div class=" align-content-lg-stretch ">
                <a class="btn btn-primary btn-lg " href="AddCoupon.aspx">Kupon Ekleme</a>
                <a class="btn btn-primary btn-lg " href="AddCar.aspx">Araç Ekleme </a>
                <a class="btn btn-primary btn-lg " href="MainPage.aspx">Rezervasyon Ekleme </a>
            </div>
        </div>
        <br />
        <br />
        <div class="row">
            <div class=" align-content-lg-stretch card-columns">
                <a class="btn btn-primary btn-lg " href="BookingAndPayFirst.aspx">Rezervasyon Onaylama </a>
            </div>
        </div>
        <br />
        <br />
        <asp:Panel ID="Panel1" Visible="false" runat="server">
            <div class=" align-content-lg-stretch">
                <a class="btn btn-primary btn-lg " href="EmployeeOperations.aspx">Personel İşlemleri</a>
            </div>
        </asp:Panel>

        <br />
        <br />
    </div>
</asp:Content>

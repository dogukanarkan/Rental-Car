<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementMasterPage.Master" AutoEventWireup="true" CodeBehind="AddEmployee.aspx.cs" Inherits="Car_Rental.AddEmployee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <h2 align="center">+Personel Ekleme</h2>
        <br />
        <br />
        Adı:
        <asp:TextBox ID="employeeFNameTextBox" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="employeeFNameTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        Soyadı:
        <asp:TextBox ID="employeeLNameTextBox" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="employeeLNameTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        TC Kimlik Numarası:
        <asp:TextBox ID="employeeIDTextBox" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="employeeIDTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        Telefon Numarası:
        <asp:TextBox ID="employeePhoneTextBox" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="employeePhoneTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        Mail Adresi:
        <asp:TextBox ID="employeeMailTextBox" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="employeeMailTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        Şifre:
        <asp:TextBox ID="employeePasswordTextBox" CssClass="form-control" type="password" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="employeePasswordTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        Şifreyi Tekrar Giriniz:
        <asp:TextBox ID="employeePasswordTextBox2" CssClass="form-control" type="password" runat="server"></asp:TextBox>
        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="employeePasswordTextBox" ControlToValidate="employeePasswordTextBox2" ErrorMessage="*Girdiğiniz şifreler aynı değil." ForeColor="Red"></asp:CompareValidator>
        <br />
        Çalışacağı Birim:
        <asp:DropDownList ID="BranchList" CssClass="form-control" runat="server"></asp:DropDownList>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="BranchList" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        Maaş Ücreti:
        <asp:TextBox ID="salaryTextBox" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="salaryTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        Erişim Seviyesi:
        <asp:DropDownList ID="accessLevelList" CssClass="form-control" runat="server">
            <asp:ListItem Value="Manager">Erişim Seviyesi seçiniz</asp:ListItem>
            <asp:ListItem Value="Manager">Yönetici</asp:ListItem>
            <asp:ListItem Value="Employee">Çalışan</asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="accessLevelList" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        Adres Bilgileri:
        <asp:TextBox ID="streetTextBox" placeholder="Adres" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="streetTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        <asp:TextBox ID="provinceTextBox" placeholder="İl" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="provinceTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        <asp:TextBox ID="districtTextBox" placeholder="İlçe" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="districtTextBox" ForeColor="Red"></asp:RequiredFieldValidator>      
        <br />
        <asp:TextBox ID="zipcodeTextBox" placeholder="Posta Kodu" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="*Bu alan boş bırakılamaz." ControlToValidate="zipcodeTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />

        <div class="text-center">
            <asp:Button ID="addEmployeeButton" CssClass="btn btn-info btn-block" runat="server" Text="Personeli Ekle" OnClick="addEmployeeButton_Click" />
        </div>
        <br />
        <br />




    </div>
</asp:Content>

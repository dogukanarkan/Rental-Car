<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementMasterPage.Master" AutoEventWireup="true" CodeBehind="AddCar.aspx.cs" Inherits="Car_Rental.AddCar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />
    <br />
    <div class="container">
        <h2 align="center">Araç Ekleme</h2>
        <br />
        <br />
        <br />
        <asp:DropDownList ID="branchList" runat="server" CssClass="form-control"></asp:DropDownList>       
        
        <br />
        <asp:TextBox ID="brandTextBox" placeholder="Marka" CssClass="form-control" runat="server"></asp:TextBox>
        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="brandTextBox" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red"></asp:RequiredFieldValidator>--%>
        <br />
        <asp:TextBox ID="modelTextBox" placeholder="Model" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="modelTextBox" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        <asp:TextBox ID="plateTextBox" placeholder="Plaka" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="plateTextBox" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red"></asp:RequiredFieldValidator>       
        <br />
        <asp:TextBox ID="engineTextBox" placeholder="Motor Gücü" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="engineTextBox" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red"></asp:RequiredFieldValidator>       

        <br />
        <asp:DropDownList ID="transmissionList" runat="server" CssClass="form-control">
            <asp:ListItem Value="Automatic">Vites Türü</asp:ListItem>
            <asp:ListItem Value="Automatic">Otomatik</asp:ListItem>
            <asp:ListItem Value="Manual">Düz</asp:ListItem>
        </asp:DropDownList>
        <br />
        <asp:TextBox ID="yearTextBox" placeholder="Üretim Yılı" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="yearTextBox" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red"></asp:RequiredFieldValidator>       
        <br />
        <asp:TextBox ID="mileageTextBox" placeholder="Kilometre" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="mileageTextBox" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red"></asp:RequiredFieldValidator>       
        <br />
        <asp:TextBox ID="colorTextBox" placeholder="Renk" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="colorTextBox" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red"></asp:RequiredFieldValidator>       
        <br />
        <asp:TextBox ID="doorTextBox" placeholder="Kapı Sayısı" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="doorTextBox" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red"></asp:RequiredFieldValidator>       
        <br />
        <asp:TextBox ID="seatTextBox" placeholder="Koltuk Sayısı" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="seatTextBox" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red"></asp:RequiredFieldValidator>       
        <br />
        <asp:TextBox ID="costTextBox" placeholder="Günlük Kiralama Ücreti" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="costTextBox" ErrorMessage="*Bu alan boş bırakılamaz." ForeColor="Red"></asp:RequiredFieldValidator>       
        <br />
        <div align="center">
            <asp:FileUpload ID="imageUpload" runat="server" />
        </div>
        <br />
        <br />
        <div class="text-center">
            <asp:Button ID="Button1" CssClass="btn btn-primary btn-lg btn-block" runat="server" Text="Ekle" OnClick="Button1_Click" />
        </div>
    </div>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementMasterPage.Master" AutoEventWireup="true" CodeBehind="EmployeeOperations.aspx.cs" Inherits="Car_Rental.EmployeeOperations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2 align="center">Çalışan İşlemleri</h2>
        <br />
  
        <asp:Button ID="addButton" runat="server" CssClass="btn btn-primary btn-lg btn-info" Text="+Personel Ekle" OnClick="addButton_Click" />
        <br />
        <%
            MySql.Data.MySqlClient.MySqlConnection connection;
            string myConnectionString = "";
            
            try
            {
                connection = new MySql.Data.MySqlClient.MySqlConnection(myConnectionString);
                connection.Open();
                string sql;

                sql = "SELECT * FROM Employee JOIN Branch ON Employee.branch_id=Branch.branch_id ";

                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(sql, connection);
                MySql.Data.MySqlClient.MySqlDataReader reader = cmd.ExecuteReader();    
     
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {

                        Response.Write("<br/> <div class='card border-info'>"
                        + "<div class='card-body'>"             
                        + "<h5 class='card-title' align='left'>" + reader["first_name"] + " " + reader["last_name"] + "</h5>"
                        + "<p class='card-text'>"
                        + "<div class='row'>"
                        + "<div class='col align-self-start'>"
                        + "<strong> Çalıştığı Şube: </strong>" + reader["name"]+"  "
                        + "<strong> Telefon: </strong>" + reader["phone"]+"  "
                        + "<strong> Mail: </strong>" + reader["mail"]+"  "
                        + "<strong> Maaş: </strong>" + reader["salary"]+"  "
                        + "<strong> Erişim Tipi: </strong>" + reader["access_level"]+"  "   
                        + "</div>"                                              
                        + "<a class='btn btn-primary btn-danger' href='EmployeeOperations.aspx?EmployeeId=" + reader["employee_id"] + "'> Personeli Sil </a>"                                                                                                                   
                        + "</div>"  
                        + "</div>"                                            
                        + "</div>");
                    }
                }

                connection.Close();
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                
            }
        %>
    </div>

</asp:Content>

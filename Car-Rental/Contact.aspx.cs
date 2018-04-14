using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

namespace Car_Rental
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SmtpClient smtp = new SmtpClient();
            smtp.Port = 587;
            smtp.Host = "smtp.yandex.com.tr";
            smtp.UseDefaultCredentials = false;
            smtp.EnableSsl = true;
            smtp.Credentials = new System.Net.NetworkCredential("contact.rentalcar@dogukanarkan.com", "rentalcarcontact");
            MailMessage message = new MailMessage("contact.rentalcar@dogukanarkan.com", "contact.rentalcar@dogukanarkan.com");
            message.Subject = "İletişim formu:" + nameTextBox.Text;
            message.Body = "Formu gönderen kişinin: \n\n"
                + "Adı Soyadı:" + nameTextBox.Text + "\n"
                + "Telefon numarası:" + phoneTextBox.Text + "\n"
                + "Email Adresi:" + mailTextBox.Text + "\n"
                + "Mesajı:" + messageTextBox.Text;
            smtp.Send(message);

            nameTextBox.Text = phoneTextBox.Text = mailTextBox.Text = messageTextBox.Text = string.Empty;

            Response.Write("<div class='alert alert-primary alert-dismissible fade show' role='alert'>"
                + "Mesajınız gönderilmiştir."
                + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                + "<span aria-hidden='true'>&times;</span>"
                + "</button>"
                + "</div>");
        }
    }
}
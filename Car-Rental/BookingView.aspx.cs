using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.IO;

namespace Car_Rental
{
    public partial class BookingView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] == null)
                Response.Redirect("MainPage.aspx");

            string myConString = "";

            MySqlConnection connection = new MySqlConnection(myConString);

            MySqlCommand command = new MySqlCommand("SELECT booking_id AS 'Rezervasyon Numarası', code AS 'Rezervasyon Kodu', start_time AS 'Başlangıç Tarihi', "
                + "end_time AS 'Bitiş Tarihi', brand_name AS Marka, model_name AS Model, plate AS Plaka, first_name AS 'Müşteri Adı', last_name AS 'Müşteri Soyadı' "
                + "FROM Booking JOIN Customer ON Booking.customer_id = Customer.customer_id JOIN Car ON Booking.car_id = Car.car_id "
                + "JOIN CarDetail ON Car.car_detail_id = CarDetail.car_detail_id JOIN Model ON CarDetail.model_id = Model.model_id ORDER BY booking_id", connection);

            connection.Open();

            DataTable dataTable = new DataTable();
            MySqlDataAdapter reader = new MySqlDataAdapter(command);

            reader.Fill(dataTable);

            GridView1.DataSource = dataTable;
            GridView1.DataBind();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Panel1.Visible = true;
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=Rezervasyonlar.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            Panel1.RenderControl(hw);
            StringReader sr = new StringReader(sw.ToString());
            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();
            htmlparser.Parse(sr);
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
        }
    }
}
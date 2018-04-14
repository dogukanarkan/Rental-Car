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
    public partial class CarOperations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] == null)
                Response.Redirect("MainPage.aspx");

            string myConString = "";

            MySqlConnection connection2 = new MySqlConnection(myConString);

            MySqlCommand command = new MySqlCommand("SELECT car_id AS 'Araç Numarası', brand_name AS Marka, model_name AS Model, engine_power AS 'Motor Gücü', model_year AS Yıl, mileage AS Kilometre, color AS Renk, transmission AS Vites, door AS Kapı, seat AS Koltuk, plate AS Plaka, cost_per_day AS 'Günlük Ücreti' FROM Car JOIN CarDetail ON Car.car_detail_id = CarDetail.car_detail_id JOIN Model ON CarDetail.model_id = Model.model_id ", connection2);

            connection2.Open();

            DataTable dataTable = new DataTable();
            MySqlDataAdapter reader = new MySqlDataAdapter(command);

            reader.Fill(dataTable);

            GridView1.DataSource = dataTable;
            GridView1.DataBind();

            if (!IsPostBack)
            {
                MySqlConnection connection3;
                string myConnectionString = "";

                connection3 = new MySqlConnection(myConnectionString);
                connection3.Open();

                string sql2 = "SELECT name FROM Branch";

                MySqlCommand cmd2 = new MySqlCommand(sql2, connection3);
                cmd2.Parameters.Add("@branch_id", BranchList.SelectedIndex + 1);
                MySqlDataReader reader2 = cmd2.ExecuteReader();

                BranchList.Items.Add("Tüm araçlar");

                while (reader2.Read())
                    BranchList.Items.Add(reader2["name"].ToString());
            }

            if (Request.UrlReferrer != null)
            {
                if (Request.UrlReferrer.ToString() == "http://localhost:51880/Cars.aspx")
                {
                    if (Request.QueryString["carId"] != null)
                    {
                        var car_id = Request.QueryString["carId"];

                        MySqlConnection connection;
                        string myConnectionString = "";

                        connection = new MySqlConnection(myConnectionString);
                        connection.Open();

                        string sql = "DELETE FROM CarDetail WHERE car_detail_id = @car_id";

                        MySqlCommand cmd = new MySqlCommand(sql, connection);
                        cmd.Parameters.Add("@car_id", car_id);
                        cmd.ExecuteNonQuery();

                        Response.Write("<div class='alert alert-primary alert-dismissible fade show' role='alert'>"
                            + "Araç silinmiştir."
                            + "<button type = 'button' class='close' data-dismiss='alert' aria-label='Close'>"
                            + "<span aria-hidden='true'>&times;</span>"
                            + "</button>"
                            + "</div>");

                        connection.Close();
                    }
                }
            }
        }

        protected void BranchList_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["branchId"] = BranchList.SelectedIndex;
        }

        public override void VerifyRenderingInServerForm(Control control)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Panel1.Visible = true;
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=Araçlar.pdf");
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

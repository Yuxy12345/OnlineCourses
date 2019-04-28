using System;
using System.IO;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddBook : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            preview.ImageUrl = "~/icons/AddImg.jpg";
            SqlConnection con = new SqlConnection("Server=localhost;Initial Catalog=OnlineCourse;Integrated Security=True;");
            try
            {
                con.Open();
                string sql = "select * from ClassType";
                SqlCommand com = new SqlCommand(sql, con);
                SqlDataReader reader = com.ExecuteReader();
                Type.DataSource = reader;
                Type.DataTextField = "TypeName";
                Type.DataValueField = "TypeID";
                Type.DataBind();
                reader.Close();
                if (Request["ClassID"] != null)
                {
                    Title = title.InnerText = "修改书籍信息";
                    sql = "SELECT * FROM Classes WHERE ClassID={0}";
                    sql = string.Format(sql, Request["ClassID"]);
                    SqlDataAdapter da = new SqlDataAdapter(sql, con);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "Classes");
                    DataRowView row = ds.Tables["Classes"].DefaultView[0];
                    ClassID.Value = row["ClassID"].ToString();
                    ClassName.Text = row["ClassName"].ToString();
                    Type.SelectedValue = row["TypeID"].ToString();
                    ClassImg.Value = preview.ImageUrl = row["ClassImg"].ToString();
                    VideoAddress.Value = row["VideoAddress"].ToString();
                    Price.Text = row["Price"].ToString();
                    Author.Text = row["Teacher"].ToString();
                    Introduction.Text = Server.HtmlDecode(row["Introduction"].ToString());
                }
                else
                {
                    preview.ImageUrl = "~/icons/AddImg.jpg";
                    Title = title.InnerText = "添加书籍";
                }
            }
            catch (Exception ex)
            {
                Commom commom = new Commom();
                commom.ShowErrorPage(Response, Server.UrlEncode(ex.Message), Server.UrlEncode(ex.StackTrace), false);
            }
            finally
            {
                con.Close();
            }
        }
        
    }

    protected void Exit_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("login.aspx");
    }

    protected void Submit(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection("Server=localhost;Initial Catalog=OnlineCourse;Integrated Security=True;");
        string path = Server.MapPath("~/image");
        string path0 = Server.MapPath("~/video");
        string fileName= DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString()
            + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString()
            + DateTime.Now.Millisecond.ToString();
        string fileName1 = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString()
            + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString()
            + DateTime.Now.Millisecond.ToString();
        if (FileUpload.HasFile)

         {
            if (!Directory.Exists(path)) Directory.CreateDirectory(path);
            string[] temp = FileUpload.FileName.Split('.');
            fileName = fileName + "." + temp[temp.Length - 1];
            path += "/" + fileName;
            FileUpload.SaveAs(path);
        }
        if (FileUpload0.HasFile)
        {
            if (!Directory.Exists(path0)) Directory.CreateDirectory(path0);
            string[] temp = FileUpload0.FileName.Split('.');
            fileName = fileName + "." + temp[temp.Length - 1];
            path0 += "/" + fileName;
            FileUpload0.SaveAs(path0);
        }
        try
        {
            con.Open();
            string sql;
            if (title.InnerText.Equals("添加书籍"))
            {
                sql = "insert into Classes(ClassName,ClassImg,Price,TypeID,Introduction,Teacher,VideoAddress,IsOnSale) " +
                "values('{0}','{1}','{2}',{3},'{4}','{5}','{6}','{7}')";
                sql = string.Format(sql, ClassName.Text, "~/image/" + fileName, Price.Text,Type.SelectedValue,Server.HtmlEncode(Introduction.Text),Author.Text,
                   "~/video/" + fileName1, Sale.SelectedValue);
                SqlCommand com = new SqlCommand(sql, con);
                com.ExecuteNonQuery();
            }
            else
            {
                sql = "UPDATE Classes SET ClassName='{0}',ClassImg='{1}',Price='{2}',TypeID={3},Introduction='{4}',Teacher='{5}',VideoAddress='{6}' WHERE ClassID={7}";
                sql = string.Format(sql, ClassName.Text, FileUpload.HasFile ? "~/image/" + fileName : ClassImg.Value, Price.Text,
                    Type.SelectedValue, Server.HtmlEncode(Introduction.Text), Author.Text, FileUpload0.HasFile ? "~/video/" + fileName1 : VideoAddress.Value, ClassID.Value);
                SqlCommand com = new SqlCommand(sql, con);
                com.ExecuteNonQuery();
            }
            Response.Redirect("~/BookManager.aspx", false);
        }
        catch(Exception ex)
        {
            Commom commom = new Commom();
            commom.ShowErrorPage(Response, Server.UrlEncode(ex.Message), Server.UrlEncode(ex.StackTrace), false);
        }
        finally
        {
            con.Close();
        }
    }

    protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
    {

    }
}
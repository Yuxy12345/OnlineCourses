using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;

public partial class img_register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void submit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection("Server=localhost;Initial Catalog=OnlineCourse;Integrated Security=True;");
        try
        {
            con.Open();
            string path = Server.MapPath("~/UserImg");
            string fileName = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString()
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
            string sql= "Insert Into Users(UserName,Pwd,Tel,UserImg)" +
                "values('{0}',{1},'{2}','{3}')";
            sql = string.Format(sql, UserName.Text, PassWord.Text,Tel.Text, "~/UserImg/"+fileName);
            SqlCommand com = new SqlCommand(sql, con);
            com.ExecuteNonQuery();
            Response.Redirect("RegSuccessful.aspx",false);
        }
        catch (Exception ex)
        {
            Commom commom = new Commom();
            commom.ShowErrorPage(Response, Server.UrlEncode(ex.Message), Server.UrlEncode(ex.StackTrace), true);
        }
        finally
        {
            con.Close();
        }
    }

    
    
}
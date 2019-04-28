using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Search_Click(object sender, EventArgs e)
    {
        if(SearchBook.Text!="")
        {
            SqlConnection con = new SqlConnection("Server=localhost;Initial Catalog=OnlineCourse;Integrated Security=True;");
            try
            {
                con.Open();
                string sql = "select Classes.ClassID as ClassID,ClassName,ClassImg,Price,Classes.TypeID,TypeName,Num " +
                    "from Classes,ClassType where ClassName like '%{0}%' and Classes.TypeID=ClassType.TypeID";
                sql = string.Format(sql, SearchBook.Text);
                SqlCommand com = new SqlCommand(sql, con);
                SqlDataReader res = com.ExecuteReader();
                SearchList.DataSource = res;
                SearchList.DataBind();
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

    protected void Unnamed_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BookInfo.aspx?BookID=" + ((HiddenField)((Button)sender).Parent.FindControl("ID")).Value);
    }
}
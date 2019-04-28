using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class TypeListDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCourseConnectionString"].ConnectionString);
            try
            {
                conn.Open();
                string selectSql = "SELECT * FROM ClassType WHERE TypeID={0}";
                selectSql = string.Format(selectSql, Request["TypeID"].ToString());
                SqlDataAdapter da = new SqlDataAdapter(selectSql, conn);
                DataSet ds = new DataSet();
                da.Fill(ds, "ClassType");
                DataRowView dr = ds.Tables["ClassType"].DefaultView[0];
                TypeName.InnerText = dr["TypeName"].ToString();
                
            }
            catch (Exception ex)
            {
                Commom commom = new Commom();
                commom.ShowErrorPage(Response, Server.UrlEncode(ex.Message), Server.UrlEncode(ex.StackTrace), false);
            }
            finally
            {
                conn.Close();
            }
        }
    }

    protected void Unnamed_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BookInfo.aspx?BookID=" + ((HiddenField)((Button)sender).Parent.FindControl("ID")).Value);
    }
}
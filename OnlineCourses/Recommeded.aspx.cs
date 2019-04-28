using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class Recommeded : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void AddRecommand()
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCourses"].ConnectionString);
        connection.Open();
        
    }

    protected void Unnamed_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/ClassInfo.aspx?ClassID=" + ((HiddenField)((Button)sender).Parent.FindControl("ID")).Value);
    }
}
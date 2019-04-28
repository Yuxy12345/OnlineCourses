using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BookManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            GridView1.DataKeyNames = new string[] { "ClassID" };
        }
    }

    protected void Search_Click(object sender, EventArgs e)
    {
        if (!SearchBookName.Text.Equals(""))
            SqlDataSource1.SelectCommand = "SELECT Classes.ClassID, Classes.ClassName, Classes.Teacher, Classes.ClassImg, Classes.Price, ClassType.TypeName, Classes.Num, Classes.UpdateTime " +
                "FROM Classes INNER JOIN ClassType ON Classes.TypeID = ClassType.TypeID " +
                "WHERE ClassName LIKE '%" + SearchBookName.Text + "%' ORDER BY Classes.UpdateTime DESC";
        else SqlDataSource1.SelectCommand = "SELECT Classes.ClassID, Classes.ClassName, Classes.Teacher, Classes.ClassImg, Classes.Price, ClassType.TypeName, Classes.Num, Classes.UpdateTime " +
                "FROM Classes INNER JOIN ClassType ON Classes.TypeID = ClassType.TypeID ORDER BY Classes.UpdateTime DESC";
    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        string url = "~/BookEditor.aspx?ClassID={0}";
        url = string.Format(url, GridView1.DataKeys[e.RowIndex].Value);
        Response.Redirect(url);
    }
}
    
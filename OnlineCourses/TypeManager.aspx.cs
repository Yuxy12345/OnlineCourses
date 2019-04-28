using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class TypeManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void Search_Click(object sender, EventArgs e)
    {
        if (SearchBookType.Text != "")
            SqlDataSource1.SelectCommand = "SELECT * FROM ClassType WHERE TypeName like '%" + SearchBookType.Text + "%'";

        else SqlDataSource1.SelectCommand = "SELECT * FROM ClassType";
        ListView1.DataBind();
    }

   
}
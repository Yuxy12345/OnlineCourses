using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RegFailed : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ErrorText.Text = Server.UrlDecode(Request["ErrorMsg"].ToString());
            Position.Text = Server.UrlDecode(Request["ErrorPos"].ToString());
            if(Request["HasTitleBar"].ToString().Equals("False"))
            {
                title.Visible = false;
            }
        }
    }

}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MainFrame : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserName"] != null)
        {
            User.Text = Session["UserName"].ToString();
            loginUser.Visible = true;
            NotLogin.Visible = false;
            UserImg.ImageUrl = Session["Pic"].ToString();
            UserImg.ToolTip = User.Text;
        }
        else
        {
            loginUser.Visible = false;
            NotLogin.Visible = true;
            ShoppingItems.Visible = false;
        }
    }

    protected void Exit_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("login.aspx");
    }

    protected void Option_Click(object sender, EventArgs e)
    {
        Button button = (Button)sender;
        Recommeded.CssClass = "topButton";
        Search.CssClass = "topButton";
        ShoppingItems.CssClass = "topButton";
        switch (button.ID)
        {
            case "ManagerTools":
                content.Src = "ManagerTools.aspx";
                break;
            case "Recommeded":
                content.Src = "Recommeded.aspx";
                Recommeded.CssClass = "topButton activeFunc";
                break;
            case "BookList":
                content.Src = "TypeList.aspx";
                break;
            case "Search":
                content.Src = "Search.aspx";
                Search.CssClass = "topButton activeFunc";
                break;
            case "ShoppingItems":
                content.Src = "Shopping.aspx";
                ShoppingItems.CssClass = "topButton activeFunc";
                break;
        }

    }

    protected void User_Click(object sender, EventArgs e)
    {
        Recommeded.CssClass = "topButton";
        Search.CssClass = "topButton";
        ShoppingItems.CssClass = "topButton";
        content.Src = "UserCenter.aspx";
    }
    
}
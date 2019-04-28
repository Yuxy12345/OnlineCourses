using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OrderManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Details")
        {
            string url = "HistoryOrder.aspx?OrderID={0}";
            url = string.Format(url, e.CommandArgument.ToString());
            Response.Redirect(url);
        }
    }

    protected void Unnamed_Click(object sender, ImageClickEventArgs e)
    {
        Page.ClientScript.RegisterClientScriptBlock(GetType(), "this", "<script>history.go(-2);</script>");
    }

    protected void Search_Click(object sender, EventArgs e)
    {
        if (SearchBookName.Text != "")
            OrderDataSource.SelectCommand = "SELECT Orders.OrderID, OrderTime, Users.UserName  FROM Orders INNER JOIN Users ON Users.UserID=Orders.OrderID WHERE(IsPaid = 1) AND UserName LIKE '%" + SearchBookName.Text+"%' ORDER BY OrderTime DESC";

        else OrderDataSource.SelectCommand = "SELECT Orders.OrderID, Orders.OrderTime, " +
                "Users.UserName " +
                "FROM Orders INNER JOIN Users ON Orders.OrderID = Users.UsersID " +
                "WHERE (Orders.IsPaid = 1) " +
                "ORDER BY Orders.OrderTime DESC";
        GridView2.DataBind();
    }
}
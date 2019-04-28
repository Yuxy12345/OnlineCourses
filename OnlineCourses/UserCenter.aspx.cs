using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserCenter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Write("<script>alert('您的登录信息失效，请重新登录！');" +
                "top.location.href = 'login.aspx';</script>");
        }

        if (Request.Cookies["Signed"] != null)
        {
            Sign.Enabled = false;
            Sign.Text = "今天已签到";
        }
        else
        {
            Sign.Enabled = true;
            Sign.Text = "签到";
        }
    }

    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if(e.CommandName=="Details")
        {
            string url = "HistoryOrder.aspx?OrderID={0}";
            url=string.Format(url, e.CommandArgument.ToString());
            Response.Redirect(url);
        }
    }

    protected void DetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        if(e.NewValues["Pwd"]==null)
        {
            UserInfoSource.UpdateCommand = "UPDATE [Users] SET [Tel] = @Tel WHERE [UserID] = @UserID";
        }
    }

    protected void sign_Click(object sender, EventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCourseConnectionString"].ConnectionString);
        try
        {
            connection.Open();
            string sql = "UPDATE Users SET Cash = Cash + 50 WHERE UserID={0}";
            sql = string.Format(sql, Session["UserID"]);
            SqlCommand command = new SqlCommand(sql, connection);
            command.ExecuteNonQuery();
            HttpCookie signed = new HttpCookie("Signed");
            signed.Value = "1";
            signed.Expires = DateTime.Now.AddDays(1);
            Response.Cookies.Add(signed);
            DetailsView.DataBind();
            Response.Write("<script>alert('签到成功！');</script>");
        }
        catch (Exception)
        {
            Response.Write("<script>alert('签到失败！');</script>");
        }
        finally
        {
            connection.Close();
        }
    }
}
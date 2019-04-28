using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Login(object sender,EventArgs e)
    {
        SqlDataReader UserInfo;
        int res;
        string Pwd;
        SqlConnection con = new SqlConnection("Server=localhost;Initial Catalog=OnlineCourse;Integrated Security=True;");
        try
        {
            con.Open();
            string sql = "select ManagerID from Managers " +
                "where ManagerName='{0}'";
            sql = string.Format(sql, UserName.Text);
            SqlCommand com = new SqlCommand(sql, con);
            object r = com.ExecuteScalar();
            if (r != null)
            {
                res = (int)r;
                sql = "select Pwd,Tel from Managers " +
                    "where ManagerID='{0}'";
                sql = string.Format(sql, res);
                com = new SqlCommand(sql, con);
                UserInfo = com.ExecuteReader();
                UserInfo.Read();
                Pwd = UserInfo["Pwd"].ToString();
                if (Pwd == PassWord.Text)
                {
                    Session["ManagerName"] = UserName.Text;
                    Session["ManagerID"] = res;
                    Session["Pwd"] = UserInfo["Pwd"];
                    Session["Tel"] = UserInfo["Tel"];
                    UserInfo.Close();
                    Response.Redirect("ManagerTools.aspx",false);
                }
                else
                {
                    errMsg.Style["display"] = "inline-block";
                    info.Text = "密码错误，请重新输入！";
                }
            }
            else
            {
                errMsg.Style["display"] = "inline-block";
                info.Text = "该用户不存在！";
            }
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
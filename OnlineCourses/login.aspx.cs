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
        string rightPwd;
        SqlConnection con = new SqlConnection("Server=localhost;Initial Catalog=OnlineCourse;Integrated Security=True;");
        try
        {
            con.Open();
            string sql = "select UserID from Users " +
                "where UserName='{0}'";
            sql = string.Format(sql, UserName.Text);
            SqlCommand com = new SqlCommand(sql, con);
            object r = com.ExecuteScalar();
            if (r != null)
            {
                res = (int)r;
                sql = "select Pwd,UserImg from Users " +
                    "where UserID='{0}'";
                sql = string.Format(sql, res);
                com = new SqlCommand(sql, con);
                UserInfo = com.ExecuteReader();
                UserInfo.Read();
                rightPwd = UserInfo["Pwd"].ToString();
                if (rightPwd == PassWord.Text)
                {
                    Session["UserName"] = UserName.Text;
                    Session["UserID"] = res;
                    Session["Pic"] = UserInfo["UserImg"];
                  
                    UserInfo.Close();
                    sql = "SELECT OrderID FROM Orders WHERE IsPaid=0 AND UserID='" + res + "'";
                    com = new SqlCommand(sql, con);
                    object shoppingID = com.ExecuteScalar();
                    if (shoppingID == null)
                    {
                        sql = "INSERT INTO Orders(UserID) VALUES('{0}')";
                        sql = string.Format(sql,res);
                        com = new SqlCommand(sql, con);
                        com.ExecuteNonQuery();
                        sql = "SELECT OrderID FROM Orders WHERE IsPaid=0 AND UserID='" + res + "'";
                        com = new SqlCommand(sql, con);
                        Session["ShoppingID"] = com.ExecuteScalar().ToString();
                    }
                    else
                    {
                        Session["ShoppingID"] = shoppingID.ToString();
                    }
                    Response.Redirect("MainFrame.aspx",false);
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
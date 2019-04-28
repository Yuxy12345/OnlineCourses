using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class ClassInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && Request["ClassID"] != null)
        {
            BookID.Value = Request["ClassID"].ToString();

            buy.Disabled = false;
            watch.Disabled = true;

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCourseConnectionString"].ConnectionString);
            try
            {
                con.Open();
                string sql = "SELECT Classes.*, ClassType.TypeName " +
                    "FROM Classes, ClassType WHERE Classes.ClassID={0} and Classes.TypeID=ClassType.TypeID";
                sql = string.Format(sql, BookID.Value);
                SqlCommand com = new SqlCommand(sql, con);
                SqlDataReader res = com.ExecuteReader();
                res.Read();
                TypeID.Value = res["TypeID"].ToString();
                BookName.Text = res["ClassName"].ToString();
                Title = BookName.Text;
                BookType.Text = res["TypeName"].ToString();
                preview.ImageUrl = res["ClassImg"].ToString();
                Price.Text = res["Price"].ToString();
                Sum.Text = res["Num"].ToString();
                Introduction.Text = res["Introduction"].ToString();
                Author.Text = res["Teacher"].ToString();
                res.Close();
                if (Session["UserID"] != null)
                {
                    sql = "SELECT * FROM MyClasses WHERE UserID={0} AND ClassID={1}";
                    sql = string.Format(sql, Session["UserID"], Request["ClassID"]);
                    com = new SqlCommand(sql, con);
                    res = com.ExecuteReader();
                    if(!res.Read())
                    {
                        buy.Style["display"] = "initial";
                        watch.Style["display"] = "none";
                        watch.Disabled = true;
                    }
                    else
                    {
                        buy.Style["display"] = "none";
                        buy.Disabled = true;
                        watch.Style["display"] = "initial";
                    }
                    res.Close();
                    sql = "SELECT DetailID FROM ShoppingView WHERE UserID={0} AND ClassID={1}";
                    sql = string.Format(sql, Session["UserID"].ToString(), BookID.Value);
                    com = new SqlCommand(sql, con);
                    object n;
                    if ((n = com.ExecuteScalar()) != null)
                    {
                        IsShopping.Value = "1";
                    }
                    else
                    {
                        IsShopping.Value = "0";
                    }
                }
                else
                {
                    buy.Style["display"] = "initial";
                    watch.Style["display"] = "none";
                }
            }
            catch (Exception ex)
            {
                Commom commom = new Commom();
                commom.ShowErrorPage(Response, Server.UrlEncode(ex.Message), Server.UrlEncode(ex.StackTrace), false);
            }
            finally
            {
                con.Close();
            }
        }
    }

    protected void Exit_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("login.aspx");
    }

    protected void Unnamed_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/ClassInfo.aspx?ClassID=" + ((HiddenField)((Button)sender).Parent.FindControl("ID")).Value);
    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Write("<script>alert('您还没有登录或登录信息失效，请登陆后再购买！');" +
                "top.location.href='login.aspx';</script>");
        }
        else
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCourseConnectionString"].ConnectionString);
            try
            {
                conn.Open();
                if (IsShopping.Value.Equals("0"))
                {
                    string sql = "INSERT INTO OrderDetails(OrderID,ClassID) VALUES({0},{1})";
                    sql = string.Format(sql, Session["ShoppingID"], Request["ClassID"]);
                    SqlCommand com = new SqlCommand(sql, conn);
                    com.ExecuteNonQuery();
                    Response.Write("<script>alert('添加购物车成功！');</script>");
                }
                else
                {
                    Response.Write("<script>alert('该课程已添加到购物车中！');</script>");
                }
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

    protected void CommentsSource_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Write("<script>alert('您还没有登录或登录信息失效，请登陆后再评论！');</script>");
            e.Cancel = true;
        }
    }

    protected void CommentsSource_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        Response.Write("<script>alert('提交评论成功！');</script>");
    }

    protected void Watch_Click(object sender, EventArgs e)
    {
        if(Session["UserID"] != null)
        {
            Response.Redirect("VideoPlay.aspx?ClassID=" + Request["ClassID"]);
        }
        else
        {
            Response.Write("<script>alert('您的登录信息失效，请登陆后观看！');</script>");
        }
    }


    protected void AllComments_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        TextBox replyContent = (TextBox)e.Item.FindControl("ReplyInputContent");
        Button replyButton = (Button)e.Item.FindControl("Reply");
        switch (e.CommandName)
        {
            case "Reply":
                if (Session["UserID"] != null)
                {
                    HiddenField replyID = (HiddenField)e.Item.FindControl("CommentID");
                    SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCourse"].ConnectionString);
                    try
                    {
                        connection.Open();
                        string sql = "INSERT INTO Comments(UserID,ClassID,Content,ReplyCommentID) VALUES ({0},{1},'{2}',{3})";
                        sql = string.Format(sql, Session["UserID"], Request["ClassID"], replyContent.Text, replyID.Value);
                        SqlCommand command = new SqlCommand(sql, connection);
                        command.ExecuteNonQuery();
                        replyContent.Text = "";
                        AllComments.DataBind();
                    }
                    catch (Exception ex)
                    {
                        new Commom().ShowErrorPage(Response, Server.UrlEncode(ex.Message), Server.UrlEncode(ex.StackTrace), true);
                    }
                    finally
                    {
                        connection.Close();
                    }
                }
                else
                {
                    Response.Write("<script>alert('您还没有登录或登录信息失效，请登陆后评论！');</script>");
                }
                break;
        }
    }


    protected void AllComments_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        if(Session["UserID"]==null)
        {
            Response.Write("<script>alert('您还没有登录或登录信息失效，请登陆后评论！');</script>");
            e.Cancel = true;
        }
    }
}
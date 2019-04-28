using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class VideoPlay : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TalkWindow.Src = "TalkWindow.aspx?ClassID=" + Request["ClassID"];
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCourse"].ConnectionString);
        try
        {
            connection.Open();
            string sql = "SELECT Classes.ClassID,ClassName,Teacher,TypeName,UpdateTime,Num,VideoAddress " +
                "FROM Classes,ClassType " +
                "WHERE Classes.TypeID=ClassType.TypeID AND Classes.ClassID=" + Request["ClassID"];
            SqlCommand command = new SqlCommand(sql,connection);
            SqlDataReader reader = command.ExecuteReader();
            reader.Read();
            ClassName.InnerText = reader["ClassName"].ToString();
            ClassType.Text = reader["TypeName"].ToString();
            UpdateTime.Text = reader["UpdateTime"].ToString();
            Teacher.Text = reader["Teacher"].ToString();
            OwnNum.Text = reader["Num"].ToString();
            videoplay.Src = reader["VideoAddress"].ToString();
            reader.Close();
            sql = "SELECT Count(DanMuID) FROM DanMu WHERE ClassID={0}";
            sql = string.Format(sql, Request["ClassID"]);
            command = new SqlCommand(sql, connection);
            DanMuNum.Text=command.ExecuteScalar().ToString();
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

    protected void sendDanMu_ServerClick(object sender, EventArgs e)
    {
        
        if (Session["UserID"] != null)
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCourse"].ConnectionString);
            int ct = (int)double.Parse(currentTime.Value);
            connection.Open();
            string sql = "INSERT INTO DanMu(ClassID,UserID,Content,VideoTime) VALUES({1},{2},'{3}',{4})";
            sql = string.Format(sql, Request["ClassID"], Session["UserID"], DanMuToSend.Value,ct);
            SqlCommand command = new SqlCommand(sql, connection);
            command.ExecuteNonQuery();
            DanMuToSend.Value = "";
        }
        else
        {
            Response.Write("<script>alert('您的登录信息失效，请登陆后发送弹幕！');</script>");
        }
    }

    protected void Unnamed_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        HyperLink link = (HyperLink)e.Item.FindControl("link");
        HiddenField classID = (HiddenField)e.Item.FindControl("ClassID");
        link.NavigateUrl = "~/ClassInfo.aspx?ClassID=" + classID.Value;
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
                    Response.Write("<script>alert('您的登录信息失效，请登陆后评论！');</script>");
                }
                break;
        }
    }

    protected void send_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] != null)
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCourseConnectionString"].ConnectionString);
            try
            {
                connection.Open();
                string sql = "INSERT INTO Talks(ClassID, UserID, [Content]) VALUES ({0}, {1}, '{2}')";
                sql = string.Format(sql, Request["ClassID"], Session["UserID"], Input.Text);
                SqlCommand command = new SqlCommand(sql, connection);
                command.ExecuteNonQuery();
                Input.Text = "";
            }
            catch(Exception)
            {
                Response.Write("<script>alert('发送失败，请稍后再试！');</script>");
            }
            finally
            {
                connection.Close();
            }
        }
        else
        {
            Response.Write("<script>alert('您的登录信息失效，请登陆后参与讨论！');</script>");
        }
        
    }
}
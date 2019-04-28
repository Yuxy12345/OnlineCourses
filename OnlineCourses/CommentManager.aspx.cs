using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TypeMnager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Search_Click(object sender, EventArgs e)
    {
        if (SearchBookName.Text != "")
            SqlDataSource1.SelectCommand = "SELECT Comments.CommentID,Users.UserName,Classes.ClassName,Comments.Content FROM Classes,Users,Comments  where Classes.ClassID=Comments.ClassID and Comments.UserID=Users.UserID and ClassName like '%" + SearchBookName.Text + "%' ";
           

        else SqlDataSource1.SelectCommand = "SELECT Comments.CommentID,UserName,ClassName,Comments.Content FROM Classes,Users,Comments  where Comments.ClassID=Classes.ClassID and Comments.UserID=Users.UserID ";
               
        GridView1.DataBind();
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        if (SearchBookName0.Text != "")
            SqlDataSource2.SelectCommand = "SELECT Talks.TalkID,Users.UserName,Classes.ClassName,Talks.Content FROM Classes,Users,Talks  where Classes.ClassID=Talks.ClassID and Talks.UserID=Users.UserID and ClassName like '%" + SearchBookName0.Text + "%' ";


        else SqlDataSource2.SelectCommand = "SELECT Talks.TalkID,UserName,ClassName,Talks.Content FROM Classes,Users,Talks  where Talks.ClassID=Classes.ClassID and Talks.UserID=Users.UserID ";

        GridView2.DataBind();
    }
}
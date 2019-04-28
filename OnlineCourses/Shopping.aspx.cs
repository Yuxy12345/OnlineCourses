using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public partial class Shopping : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Write("<script>alert('您的登录信息失效，请登陆后使用！');" +
                "top.location.href='login.aspx';</script>");
        }
        else if (!IsPostBack)
        {
            GridView1.DataKeyNames = new string[] { "ClassID" };
            GetShopping();
        }
    }

    protected void GetShopping()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCourseConnectionString"].ConnectionString);
        try
        {
            conn.Open();
            string selectSql = "SELECT * FROM ShoppingView WHERE UserID={0}";
            selectSql = string.Format(selectSql, Session["UserID"].ToString());
            SqlDataAdapter da = new SqlDataAdapter(selectSql, conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "Shopping");
            GridView1.DataSource = ds;
            GridView1.DataBind();
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

    protected void Num_TextChanged(object sender, EventArgs e)
    {
        CalcSum(CalcPrice());
    }

    protected double[] CalcPrice()
    {
        double singPri;
        double[] sumPrice=new double[GridView1.Rows.Count];
        
        for(int i=0;i<GridView1.Rows.Count;i++)
        {
            singPri = double.Parse(((Label)GridView1.Rows[i].FindControl("Price")).Text);
           
            sumPrice[i] = singPri;
            ((Label)GridView1.Rows[i].FindControl("Price")).Text=sumPrice[i].ToString();
        }
        return sumPrice;
    }

    protected void CalcSum(double[] sumPrice)
    {
        double sum=0;
        foreach(double i in sumPrice)
        {
            sum += i;
        }
        Sum.Text = sum.ToString();
    }

    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        CalcSum(CalcPrice());
    }

    protected void Clear_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCourseConnectionString"].ConnectionString);
        try
        {
            conn.Open();
            string sql = "DELETE FROM OrderDetails WHERE OrderID={0}";
            sql = string.Format(sql, Session["ShoppingID"].ToString());
            SqlCommand com = new SqlCommand(sql, conn);
            com.ExecuteNonQuery();
            GetShopping();
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

    protected void Buy_Click(object sender, EventArgs e)
    {
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCourseConnectionString"].ConnectionString);
        try
        {
            string sql = "select UserName,Cash from Users where UserName='"+Session["UserName"].ToString()+"'";
            Conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(sql,Conn);
            DataSet ds = new DataSet();
            da.Fill(ds,"用户表");
            DataRowView drv = ds.Tables["用户表"].DefaultView[0];
            string Price = Convert.ToString(drv.Row["Cash"]);
            if (Convert.ToDouble(Price) < Convert.ToDouble(Sum.Text.Trim()))
            {
                Response.Write("<script>alert('您的余额不足，请重新充值后再购买！');</script>");
            }
            else
            {
                string sql1 = "update Users set Cash='" + (Convert.ToDouble(Price) - Convert.ToDouble(Sum.Text)) + "'where UserName='" + Session["UserName"].ToString() + "'";

                SqlCommand Comm = new SqlCommand(sql1, Conn);
                Comm.ExecuteNonQuery();
                string sql3 = "UPDATE Orders SET IsPaid=1, OrderTime=Getdate() WHERE UserID={0} AND IsPaid=0";
                sql3 = string.Format(sql3, Session["UserID"]);
                SqlCommand com = new SqlCommand(sql3, Conn);
                com.ExecuteNonQuery();
                for (int i = 0; i < GridView1.Rows.Count; i++)
                {
                    sql = "UPDATE Classes SET Num = Num + 1 WHERE ClassID={0}";
                    sql = string.Format(sql, ((HiddenField)GridView1.Rows[i].FindControl("ClassID")).Value);
                    com = new SqlCommand(sql, Conn);
                    com.ExecuteNonQuery();
                    sql = "INSERT INTO MyClasses (ClassID, UserID) VALUES ({0}, {1})";
                    sql = string.Format(sql, ((HiddenField)GridView1.Rows[i].FindControl("ClassID")).Value, Session["UserID"]);
                    com = new SqlCommand(sql,Conn);
                    com.ExecuteNonQuery();
                }
                sql = "INSERT INTO Orders(UserID) VALUES('{0}')";
                sql = string.Format(sql, Session["UserID"]);
                com = new SqlCommand(sql, Conn);
                com.ExecuteNonQuery();
                sql = "SELECT OrderID FROM Orders WHERE IsPaid=0 AND UserID='" + Session["UserID"] + "'";
                com = new SqlCommand(sql, Conn);
                Session["ShoppingID"] = com.ExecuteScalar().ToString();
                
                GetShopping();
                Response.Write("<script>alert('支付成功！');</script>");
            }
        }
        catch(Exception ex)
        {
            Commom commom = new Commom();
            commom.ShowErrorPage(Response, Server.UrlEncode(ex.Message), Server.UrlEncode(ex.StackTrace), false);
        }
        finally
        {
            Conn.Close();
        }
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCourseConnectionString"].ConnectionString);
        try
        {
            conn.Open();
            string sql = "DELETE FROM OrderDetails WHERE ClassID={0}";
            sql = string.Format(sql, GridView1.DataKeys[e.RowIndex].Value.ToString());
            SqlCommand com = new SqlCommand(sql, conn);
            com.ExecuteNonQuery();
            GetShopping();
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
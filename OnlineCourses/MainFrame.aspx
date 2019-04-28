<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MainFrame.aspx.cs" Inherits="MainFrame" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>推荐</title>
    <link href="css/FrameStyle.css" rel="stylesheet" />
    <script src="js/JavaScript.js"></script>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" /> 

    <script type="text/javascript">
        window.onload = function () {
            this.document.title = document.getElementById("content").contentWindow.document.title + " - 梦之队云课堂";
        }
        
    </script>
</head>
<body>
    <form runat="server">
        <div class="title">
            <a href="#">
                <h1>梦之队云课堂</h1>
            </a>
            <ul>
                <li>
                    <asp:Button ID="Recommeded" CssClass="topButton activeFunc" runat="server" Text="推荐" OnClick="Option_Click"></asp:Button></li>
                <li>
                    <asp:Button ID="Search" CssClass="topButton" runat="server" Text="搜索" OnClick="Option_Click"></asp:Button></li>
                <li>
                    <asp:Button ID="ShoppingItems" CssClass="topButton" runat="server" Text="查看购物车" OnClick="Option_Click"></asp:Button></li>
            </ul>
            <div runat="server" id="loginUser" visible="false">
                <asp:ImageButton ID="UserImg" CssClass="userimg" runat="server" ToolTip="用户名" ImageUrl="~/img/web.png" OnClick="User_Click"/>
                <asp:Button ID="User" CssClass="topButton" runat="server" Text="用户名" OnClick="User_Click"></asp:Button>
                <asp:Button ID="Exit" CssClass="topButton" runat="server" Text="退出" OnClientClick="return ExitAlert()" OnClick="Exit_Click"></asp:Button>
                <asp:Button CssClass="mobile" runat="server" Text="☰"></asp:Button>
            </div>
            <div runat="server" id="NotLogin">
                <asp:Button ID="Login" CssClass="topButton" runat="server" Text="登录" PostBackUrl="~/login.aspx"></asp:Button>
            </div>
        </div>
        <div class="panel"> 
            <iframe runat="server" id="content" class="content" src="Recommeded.aspx" frameborder="0" onchange="setTitle(this)">
            </iframe>
        </div>
    </form>
</body>
</html>

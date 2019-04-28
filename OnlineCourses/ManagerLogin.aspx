<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManagerLogin.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>管理员登录</title>
    <link href="css/FrameStyle.css" rel="stylesheet" />
    <link href="css/RegisterStyle.css" rel="stylesheet" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="title">
            <a href="#">
                <h1>管理员登录</h1>
            </a>
            <div>
                <a href="login.aspx" class="a">
                    <input type="button" value="返回用户登录" class="topButton" />
                </a>
            </div>
        </div>
        <div class="panel">
            <div class="leftImg">
            </div>
            <div class="regContents">
                <div class="regBox">
                    <h2 class="regText">登录你的账户</h2>
                    <div id="errMsg" style="display:none" runat="server">
                        <img src="img/error.png" width="15" height="15"/>
                        <asp:Label runat="server" ID="info" ForeColor="Red"></asp:Label>
                    </div>
                    <asp:Panel runat="server" DefaultButton="LoginButton">
                        <asp:TextBox ID="UserName" CssClass="input" runat="server" placeholder="用户名" autocomplete="off" />
                        <br />
                        <br />
                        <asp:TextBox class="input" TextMode="Password" ID="PassWord" runat="server" placeholder="密码" />
                        <br />
                        <br />
                        <asp:Button ID="LoginButton" CssClass="submit" Text="登录" runat="server" OnClick="Login" />
                    </asp:Panel>
                </div>
            </div>
        </div>

    </form>
</body>
</html>

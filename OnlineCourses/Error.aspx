<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="RegFailed" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>很抱歉，服务器出错了！</title>
    <link href="css/FrameStyle.css" rel="stylesheet" />
    <link href="css/RegisterStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="title" id="title" runat="server">
            <a href="#">
                <h1>欢迎使用网上书城</h1>
            </a>
            <div>
                <a href="login.aspx" class="a">
                    <input type="button" value="登录" class="topButton" />
                </a>
            </div>
        </div>
        <div class="panel">
            <div class="leftImg">
            </div>
            <div class="regContents">
                <div class="regBox" style="width:460px;font-weight:bold">
                    <img src="img/error.jfif" width="50" height="50" />
                    <h2 class="regText">抱歉，服务器出错了，请稍后重试</h2>
                    <br />
                    错误信息：<br />
                    <asp:Label ID="ErrorText" runat="server" Font-Bold="false"></asp:Label>
                    <br />
                    所在位置：<br />
                    <asp:Label ID="Position" runat="server" Font-Bold="false"></asp:Label>
                    <br />
                    <asp:Button runat="server" Text="返回" CssClass="submit" OnClientClick="window.history.back(-1);" />
                </div>
            </div>
        </div>

    </form>
</body>
</html>

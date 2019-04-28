<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegSuccessful.aspx.cs" Inherits="RegSuccessful" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>注册成功</title>
    <link href="css/FrameStyle.css" rel="stylesheet" />
    <link href="css/RegisterStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="title">
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
                <div class="regBox">
                    <img src="img/OK.jfif" width="50" height="50" />
                    <h2 class="regText">注册成功！</h2>
                    <br />
                    <asp:Button runat="server" PostBackUrl="~/login.aspx" Text="去登录" CssClass="submit" />
                    
                </div>
            </div>
        </div>

    </form>
</body>
</html>

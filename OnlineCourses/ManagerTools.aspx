<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManagerTools.aspx.cs" Inherits="ManagerTools" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>管理员工具</title>
    <link href="css/ManagerTools.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <h2>管理员工具</h2>
        <hr />
        <a class="ToolItem" href="BookManager.aspx">
            <img class="ToolImg" src="icons/Book.jpg" />
            <br />
            课程管理
        </a>
        <a class="ToolItem" href="TypeManager.aspx">
            <img class="ToolImg" src="icons/Type.jpg" />
            <br />
            课程类型管理
        </a>
        <a class="ToolItem" href="CommentManager.aspx">
            <img class="ToolImg" src="icons/Comments.jpg" />
            <br />
            评论与讨论管理
        </a>
        <a class="ToolItem" href="OrderManager.aspx">
            <img class="ToolImg" src="icons/Orders.jpg" />
            <br />
            订单管理
        </a>
    </form>
</body>
</html>

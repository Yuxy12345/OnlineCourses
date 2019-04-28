<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>搜索</title>
    <link href="css/RegisterStyle.css" rel="stylesheet" />
    <link href="css/BookItemStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2 style="margin-left: 50px">搜索课程</h2>
            <hr />
            <div style="padding: 40px; text-align: center">
                <asp:TextBox ID="SearchBook" CssClass="input" runat="server" placeholder="请输入课程名"></asp:TextBox>
                <asp:Button ID="SearchButton" CssClass="submit" Width="150px" runat="server" Text="搜索" OnClick="Search_Click" />
                <br /><br />
                <asp:ListView ID="SearchList" runat="server">
                    <ItemTemplate>
                        <div class="item">
                            <asp:ImageButton ID="Pic" runat="server" Width="100" Height="100" ImageUrl='<%# Eval("ClassImg") %>' />
                            <div style="display: inline-block; text-align: left">
                                <asp:HiddenField ID="ID" runat="server" Value='<%# Eval("ClassID") %>' />
                                <asp:Label ID="Name" style="overflow:hidden" runat="server" Width="170" Height="40" Font-Bold="true" Text='<%# Eval("ClassName") %>'></asp:Label><br />
                                <asp:Label ID="Type" runat="server" Width="170" Text='<%# Eval("TypeName") %>'></asp:Label><br />
                                ￥
                                <asp:Label ID="Price" Font-Bold="true" runat="server" Width="150" Text='<%# Eval("Price") %>'></asp:Label><br />
                                <asp:Button runat="server" Text="查看详情" OnClick="Unnamed_Click" />
                            </div>
                        </div>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div id="itemPlaceHolder" runat="server" style="background-color: white;margin:20px;">
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
            </div>
        </div>
    </form>
</body>
</html>

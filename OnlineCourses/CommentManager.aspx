<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CommentManager.aspx.cs" Inherits="TypeMnager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="js/JavaScript.js"></script>
    <title>评论与讨论管理</title>
    <style type="text/css">
        .auto-style1 {
            height: 744px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ImageButton runat="server" Width="60px" Height="60px" PostBackUrl="~/ManagerTools.aspx" ImageUrl="~/icons/Back.jpg" />
            <h2 style="margin-left: 50px; font-size: 30px; display:inline-block; vertical-align:bottom">评论管理</h2>
            <hr />
            <div style="padding: 40px; text-align: center" class="auto-style1">
                搜索课程名：<asp:TextBox ID="SearchBookName" runat="server" placeholder="请输入课程名"></asp:TextBox>
                <asp:Button ID="Search" runat="server" Text="搜索" OnClick="Search_Click" />

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>"
                    DeleteCommand="DELETE FROM Comments WHERE CommentID=@CommentID"
                    SelectCommand="SELECT Comments.CommentID,UserName,ClassName,Content FROM Comments,Users,Classes where Classes.ClassID=Comments.ClassID and Comments.UserID=Users.UserID ">
                    <DeleteParameters>
                        <asp:Parameter Name="CommentID" />
                    </DeleteParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView1" Style="margin: 20px 0; display: inline-block" runat="server"
                    AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" 
                    DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" AllowSorting="True">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="CommentID" ItemStyle-Width="100" HeaderText="评论ID" InsertVisible="False" ReadOnly="True" SortExpression="CommentID" >
<ItemStyle Width="100px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="UserName" ItemStyle-Width="100" HeaderText="用户名" SortExpression="UserName" >
<ItemStyle Width="100px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="ClassName" ItemStyle-Width="150" HeaderText="课程名" SortExpression="ClassName" >
<ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Content" ItemStyle-Width="150" HeaderText="评论内容" SortExpression="Content" >
<ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
                <br />
                <br />
                <br />
                <br />
                搜索课程名：<asp:TextBox ID="SearchBookName0" runat="server" placeholder="请输入课程名" ></asp:TextBox>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="搜索一下" />

                <br />
                <br />
                <asp:GridView ID="GridView2" Style="margin: 20px 0; display: inline-block" runat="server"
                    AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="TalkID"
                    DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" AllowSorting="True">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="TalkID" ItemStyle-Width="100" HeaderText="讨论ID" InsertVisible="False" ReadOnly="True" SortExpression="TalkID" />
                        <asp:BoundField DataField="UserName" ItemStyle-Width="100" HeaderText="用户名" SortExpression="UserName" />
                        <asp:BoundField DataField="ClassName" ItemStyle-Width="150" HeaderText="课程名" SortExpression="ClassName" />
                        <asp:BoundField DataField="Content" ItemStyle-Width="150" HeaderText="讨论内容" SortExpression="Content" />
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>" 
                    SelectCommand="SELECT Talks.TalkID,UserName,ClassName,Content FROM Talks,Users,Classes where Classes.ClassID=Talks.ClassID and Talks.UserID=Users.UserID" 
                    DeleteCommand="DELETE FROM Talks WHERE TalkID=@TalkID"
                    >
                    <DeleteParameters>
                        <asp:Parameter Name="TalkID" />
                    </DeleteParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </form>
</body>
</html>

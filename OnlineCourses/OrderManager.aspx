<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrderManager.aspx.cs" Inherits="OrderManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>订单管理</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ImageButton runat="server" Width="60px" Height="60px" OnClick="Unnamed_Click" ToolTip="返回上一页" ImageUrl="~/icons/Back.jpg" />
            <h2 style="margin-left: 50px; font-size: 30px; display:inline-block; vertical-align:bottom">订单管理</h2>
            <hr />
            <div style="padding: 40px; text-align: center">
                搜索用户：<asp:TextBox ID="SearchBookName" runat="server" placeholder="请输入用户名"></asp:TextBox>
                <asp:Button ID="Search" runat="server" Text="搜索" OnClick="Search_Click" />
                <asp:SqlDataSource ID="OrderDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>"
                    SelectCommand="SELECT Orders.OrderID, Orders.OrderTime, Users.UserName FROM Orders INNER JOIN Users ON Orders.OrderID = Users.UserID WHERE (Orders.IsPaid = 1) ORDER BY Orders.OrderTime DESC" 
                    DeleteCommand="DELETE FROM Orders WHERE (OrderID = @OrderID)">
                    <DeleteParameters>
                        <asp:Parameter Name="OrderID" />
                    </DeleteParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView2" runat="server" Style="display:inline-block;text-align:left" AutoGenerateColumns="False" DataKeyNames="OrderID" CellPadding="4" ForeColor="#333333" GridLines="None" DataSourceID="OrderDataSource" AllowPaging="True" OnRowCommand="GridView2_RowCommand">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="100" HeaderText="订单ID" >
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("OrderID") %>'></asp:Label>
                            </ItemTemplate>

                            <ItemStyle Width="100px"></ItemStyle>
                        </asp:TemplateField>
                        <asp:BoundField DataField="UserName" HeaderText="订单用户" SortExpression="UserName" />
                        <asp:BoundField ItemStyle-Width="200" DataField="OrderTime" HeaderText="订单时间" SortExpression="OrderTime" ItemStyle-HorizontalAlign="Center">
                            <ItemStyle HorizontalAlign="Center" Width="200px"></ItemStyle>
                        </asp:BoundField>
                        <asp:ButtonField CommandName="Delete" Text="删除订单" />
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
            </div>
        </div>
    </form>
</body>
</html>

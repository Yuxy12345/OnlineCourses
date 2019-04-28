<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BookManager.aspx.cs" Inherits="BookManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ImageButton runat="server" Width="60px" Height="60px" PostBackUrl="~/ManagerTools.aspx" ImageUrl="~/icons/Back.jpg" />
            <h2 style="margin-left: 50px; font-size: 30px; display:inline-block; vertical-align:bottom">课程管理</h2>
            <hr />
            <div style="padding: 40px; text-align: center">
                <asp:Button ID="AddBook" runat="server" style="margin-right:150px" Text="添加课程" 
                    PostBackUrl="~/BookEditor.aspx"  />
                搜索课程名：<asp:TextBox ID="SearchBookName" style="margin:0 20px" runat="server" placeholder="请输入课程名"></asp:TextBox>
                <asp:Button ID="Search" runat="server" Text="搜索" OnClick="Search_Click" />

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>"
                    DeleteCommand="DELETE FROM Classes WHERE ClassID=@ClassID"
                    
                    SelectCommand="SELECT Classes.ClassID, Classes.ClassName, Classes.ClassImg, Classes.Price, Classes.Teacher, ClassType.TypeName, Classes.Num, Classes.UpdateTime FROM Classes INNER JOIN ClassType ON Classes.TypeID = ClassType.TypeID ORDER BY Classes.UpdateTime DESC">
                    <DeleteParameters>
                        <asp:Parameter Name="ClassID" />
                    </DeleteParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView1" Style="margin: 20px 0; display: inline-block" runat="server"
                    AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ClassID"
                    DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" OnRowUpdating="GridView1_RowUpdating">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="ClassID" ItemStyle-Width="100" HeaderText="书籍ID" InsertVisible="False" ReadOnly="True" SortExpression="ClassID" />
                        <asp:ImageField DataImageUrlField="ClassImg" HeaderText="图片" ItemStyle-Width="120px">
                        </asp:ImageField>
                        <asp:BoundField DataField="ClassName" ItemStyle-Width="100" HeaderText="书名" ItemStyle-Font-Bold="true" SortExpression="ClassName" />
                        <asp:BoundField DataField="Teacher" ItemStyle-Width="100px" HeaderText="老师" SortExpression="Teacher" />
                        <asp:BoundField DataField="TypeName" HeaderText="类型" SortExpression="TypeName" />
                        <asp:BoundField DataField="Price" ItemStyle-Width="150" HeaderText="价格" SortExpression="Price" />
                        <asp:BoundField DataField="UpdateTime" HeaderText="更新时间" SortExpression="UpdateTime" />
                        <asp:ButtonField Text="修改" ButtonType="Link" CommandName="Update" />
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
            </div>
        </div>
    </form>
</body>
</html>

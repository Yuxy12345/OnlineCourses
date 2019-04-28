<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserCenter.aspx.cs" Inherits="UserCenter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>个人中心</title>
    <link href="css/UserCenter.css" rel="stylesheet" />
    <script src="js/JavaScript.js"></script>
    <script type="text/javascript">
        window.onload = UserInfo;
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:SqlDataSource ID="UserInfoSource" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>"
            SelectCommand="SELECT UserID, UserName, Cash, Pwd, UserImg, Tel FROM Users WHERE (UserID = @UserID)"
            UpdateCommand="UPDATE [Users] SET [Pwd] = @Pwd,[Tel] = @Tel WHERE [UserID] = @UserID"
            DeleteCommand="DELETE FROM [Users] WHERE [UserID] = @UserID"
            InsertCommand="INSERT INTO [Users] ([UserName],  [Pwd], [UserImg], [Tel]) VALUES (@UserName, @Pwd,  @UserImg, @Tel)">
            <DeleteParameters>
                <asp:Parameter Name="UserID" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="UserName" Type="String" />
                <asp:Parameter Name="Pwd" />
                <asp:Parameter Name="UserImg" />
                <asp:Parameter Name="Tel" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Pwd" />
                <asp:Parameter Name="Tel" Type="String" />
                <asp:Parameter Name="UserID" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Button ID="Sign" runat="server" style="margin-left:200px" OnClick="sign_Click" /> 
        <asp:DetailsView ID="DetailsView" runat="server" AutoGenerateRows="False" GridLines="None" OnItemUpdating="DetailsView_ItemUpdating" DataKeyNames="UserID" DataSourceID="UserInfoSource">
            <Fields>
                <asp:TemplateField>
                    <ItemTemplate>
                        <div class="panel">
                            <asp:Image CssClass="UserImg" ID="UserImg" runat="server" ImageUrl='<%# Eval("UserImg") %>' />
                            <div id="UserInfo" class="UserInfo">
                                <h2 class="UserName" id="UserName" runat="server"><%# Eval("UserName") %></h2>
                                <asp:Button ID="Edit" runat="server" Text="修改个人资料" CommandName="Edit" />
                                <br />
                                欢乐豆：
                                    <asp:Label ID="Cash" runat="server" Text='<%# Eval("Cash") %>'></asp:Label>
                                <br />
                                电话：
                                    <asp:Label ID="Tel" runat="server" Text='<%# Eval("Tel") %>'></asp:Label>
                                <br />
                            </div>
                        </div>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Image CssClass="UserImg" ID="UserImg" runat="server" ImageUrl='<%# Eval("UserImg") %>' />
                        <div id="UserInfo" class="UserInfo">
                            <h2 class="UserName" id="UserName" runat="server"><%# Eval("UserName") %></h2>
                            <asp:Button ID="Update" runat="server" Text="确认修改" CommandName="Update" />
                            <asp:Button ID="Cancel" runat="server" Text="取消" CommandName="Cancel" />
                            <br />
                            密码：(如果不修改则两项均置空）<br />
                            <asp:TextBox ID="Passwd" runat="server" TextMode="Password" Text='<%# Bind("Pwd") %>'></asp:TextBox>
                            <br />
                            确认密码：<br />
                            <asp:TextBox ID="Confirm" runat="server" TextMode="Password"></asp:TextBox>
                            <br />
                            <asp:CompareValidator ID="CompareValidator1" ControlToCompare="Passwd" Style="color: red" Operator="Equal" ControlToValidate="Confirm" runat="server" Display="Dynamic" ErrorMessage="CompareValidator">
                                <img src="img/error.png" width="15" height="15"/>输入的密码不一致
                            </asp:CompareValidator>
                            <br />
                            
                          
                            电话：
                            <asp:TextBox ID="Tel" runat="server" Text='<%# Bind("Tel") %>'></asp:TextBox>
                            <br />
                            <asp:RegularExpressionValidator ID="REValidator1" CssClass="Validator" runat="server" Style="color: red" ControlToValidate="Tel" ValidationExpression="(0\d{2,3}-\d{8})|\d{11}" ErrorMessage="电话号码格式不正确">
                        <img src="img/error.png" width="15" height="15"/>电话号码格式不正确
                            </asp:RegularExpressionValidator>
                            <br />
                        </div>
                    </EditItemTemplate>
                </asp:TemplateField>
            </Fields>
        </asp:DetailsView>

        <hr />
        <h2>我的课程评价</h2>
        <asp:SqlDataSource ID="OrderDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>"
            SelectCommand="SELECT Comments.CommentID, [ClassName],[Content] FROM [Comments],[Classes] WHERE Comments.ClassID=Classes.ClassID AND UserID=@UserID" DeleteCommand="DELETE from  Comments  WHERE (CommentID = @CommentID)" UpdateCommand="UPDATE Comments SET Content= @Content  WHERE (CommentID = @CommentID)">
            <DeleteParameters>
                <asp:Parameter Name="CommentID" />
            </DeleteParameters>
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Content" />
                <asp:Parameter Name="CommentID" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="CommentID" CellPadding="4" ForeColor="#333333" GridLines="None" DataSourceID="OrderDataSource" AllowPaging="True" OnRowCommand="GridView2_RowCommand">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField ItemStyle-Width="20" DataField="CommentID" HeaderText="评论ID" SortExpression="CommentID" ItemStyle-HorizontalAlign="Center" InsertVisible="False" ReadOnly="True">
                <ItemStyle HorizontalAlign="Center" Width="200px" />
                </asp:BoundField>
                <asp:BoundField ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="IsProcessed" ReadOnly="true" DataField="ClassName" HeaderText="课程名" SortExpression="ClassName" >
                <ItemStyle CssClass="IsProcessed" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Content" HeaderText="评论内容" SortExpression="Content" />
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
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
        <hr />
        <h2>我的课程讨论</h2>
        <asp:SqlDataSource ID="CommentsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>"
            DeleteCommand="DELETE FROM [Talks] WHERE [TalkID] = @TalkID"
            SelectCommand="SELECT Talks.TalkID, Classes.ClassName, Talks.[Content] FROM Talks INNER JOIN Classes ON Talks.ClassID = Classes.ClassID WHERE (Talks.UserID = @UserID)"
            UpdateCommand="UPDATE [Talks] SET [Content] = @Content WHERE [TalkID] = @TalkID">
            <DeleteParameters>
                <asp:Parameter Name="TalkID" />
            </DeleteParameters>
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Content" />
                <asp:Parameter Name="TalkID" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="TalkID" DataSourceID="CommentsDataSource" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="TalkID" ItemStyle-Width="100" HeaderText="讨论ID" InsertVisible="False" ReadOnly="True" SortExpression="TalkID">
                <ItemStyle Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="ClassName" ReadOnly="true" ItemStyle-Width="200" HeaderText="课程名" SortExpression="ClassName" >
                <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="Content" ItemStyle-Width="200" HeaderText="内容" SortExpression="Content" ItemStyle-HorizontalAlign="Center">
                <ItemStyle HorizontalAlign="Center" Width="200px" />
                </asp:BoundField>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
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
        <hr />
        <h2>我的课程</h2>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>"
            SelectCommand="SELECT MyClasses.MyclassID, [ClassName],[ClassImg] FROM [MyClasses],[Classes] WHERE MyClasses.ClassID=Classes.ClassID AND UserID=@UserID">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None" DataKeyNames="MyclassID">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="MyclassID" ItemStyle-Width="100" HeaderText="MyclassID" InsertVisible="False" ReadOnly="True" SortExpression="MyclassID">
                <ItemStyle Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="ClassName" ItemStyle-Width="200" HeaderText="ClassName" SortExpression="ClassName">
                <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:CommandField/>
                <asp:ImageField DataImageUrlField="ClassImg" HeaderText="图片">
                </asp:ImageField>
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

    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClassInfo.aspx.cs" Inherits="ClassInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="css/BookInfoStyle.css" rel="stylesheet" />
    <link href="css/FrameStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="Contents">
            <div class="left">
                <div class="BookInfo">
                    <asp:Image ID="preview" CssClass="Image" runat="server" />
                    <div>
                        <asp:HiddenField runat="server" id="BookID" />
                        <asp:HiddenField runat="server" id="TypeID" />
                        <asp:HiddenField runat="server" ID="IsShopping" />
                        <h2>
                            <asp:Label ID="BookName" runat="server" Font-Bold="true" Width="390"></asp:Label></h2>
                        <br />
                        <asp:Label Font-Bold="true" ID="BookType" runat="server" Width="300"></asp:Label><br />
                        <br />
                        主讲人：<asp:Label ID="Author" runat="server" Width="300"></asp:Label><br />
                        <br />
                        总销量：<asp:Label ID="Sum" runat="server" Width="300"></asp:Label><br />
                        <br />
                        <span id="buy" runat="server">￥
                            <asp:Label CssClass="TextBox" ForeColor="Red" Font-Bold="true" ID="Price" runat="server"></asp:Label>
                            <br />
                            <asp:Button ID="Add" CssClass="BuyButton" runat="server" Width="120" Height="30" Text="添加到购物车" OnClick="Submit_Click" OnClientClick="return OrderNum.value>0;" /><br />
                            <br />
                        </span>
                        <span id="watch" runat="server">
                            <asp:Button ID="WatchButton" CssClass="BuyButton" runat="server" Width="120" Height="30" Text="进入课程" OnClick="Watch_Click"/>
                        </span>
                    </div>
                </div>
                <hr />
                <h2>简要介绍</h2>
                <asp:Label ID="Introduction" runat="server"></asp:Label>
                <hr />
                <h2>评论</h2>
                <div class="comments">
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>" 
                    SelectCommand="SELECT Comment1.CommentID, User1.UserName, User2.UserName AS ReplyUserName, Comment1.ClassID, Comment1.[Content], Comment1.CommentTime, Comment2.[Content] AS ReplyContent FROM Comments AS Comment1 LEFT OUTER JOIN Comments AS Comment2 ON Comment1.ReplyCommentID = Comment2.CommentID FULL OUTER JOIN Users AS User1 ON Comment1.UserID = User1.UserID FULL OUTER JOIN Users AS User2 ON Comment2.UserID = User2.UserID WHERE (Comment1.ClassID = @ClassID)" 
                    InsertCommand="INSERT INTO Comments(ClassID, UserID, [Content]) VALUES (@ClassID, @UserID, @Content)">
                    <InsertParameters>
                        <asp:QueryStringParameter Name="ClassID" QueryStringField="ClassID" Type="Int32" />
                        <asp:SessionParameter Name="UserID" SessionField="UserID" />
                        <asp:Parameter Name="Content" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ClassID" QueryStringField="ClassID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:ListView ID="AllComments" runat="server" InsertItemPosition="FirstItem" DataSourceID="SqlDataSource2" OnItemInserting="AllComments_ItemInserting" OnItemCommand="AllComments_ItemCommand">
                    <ItemTemplate>
                        <div class="CommentsItem" style="text-align:left">
                            <asp:HiddenField ID="CommentID" runat="server" Value='<%# Eval("CommentID") %>' />
                            <asp:Label ID="CommentUser" runat="server" Font-Bold="true" Text='<%# Eval("UserName") %>'></asp:Label>&nbsp;&nbsp;
                            <asp:Label ID="CommentTime" runat="server" Text='<%# Eval("CommentTime") %>'></asp:Label>
                            <div style="margin:30px; background-color:#D0D0D0">
                                <div>
                                    <asp:Label ID="ReplyUser" Font-Bold="true" runat="server" Text='<%# Eval("ReplyUserName") %>'></asp:Label>
                                </div>
                                <asp:Label ID="ReplyContent" runat="server" Text='<%# Eval("ReplyContent") %>'></asp:Label>
                            </div>
                            <asp:Label ID="Content" runat="server" Text='<%# Eval("Content") %>'></asp:Label>
                            <br />
                            <asp:TextBox ID="ReplyInputContent" runat="server" style="width:600px; margin:10px" Rows="2" TextMode="MultiLine" placeholder="输入回复内容"></asp:TextBox>
                            <br />
                            <asp:Button ID="Reply" style="margin-left:20px; margin-bottom:10px" CssClass="SaveButton" runat="server" Text="回复" CommandName="Reply" />
                        </div>
                    </ItemTemplate>
                    <InsertItemTemplate>
                        <div class="EditComment">
                            <asp:TextBox ID="Content" CssClass="Text" TextMode="MultiLine" runat="server" placeholder="请输入您对此书的评论" Text='<%# Bind("Content") %>'></asp:TextBox>
                            <br />
                            <asp:Button ID="Submit" CssClass="SaveButton" runat="server" CommandName="Insert" Text="提交评论" />
                        </div>
                    </InsertItemTemplate>
                    <EmptyItemTemplate>
                        还没有评论呢，快来抢沙发呀！
                    </EmptyItemTemplate>
                    <EmptyDataTemplate>
                        还没有评论呢，快来抢沙发呀！
                    </EmptyDataTemplate>
                </asp:ListView>
            </div>
        </div>
            <div class="CommonTypeBooks">
                <h3>同类课程</h3>
                <asp:SqlDataSource ID="CommonTypeBooksSource" runat="server"
                    ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>"
                    SelectCommand="SELECT Top(5) * FROM [Classes] WHERE ([TypeID] = @TypeID) ORDER BY [Num] DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="TypeID" Name="TypeID" PropertyName="value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:ListView ID="CommonBookType" runat="server" DataSourceID="CommonTypeBooksSource" Style="display: inline-block">
                    <ItemTemplate>
                        <div class="item">
                            <asp:Image ID="Pic" runat="server" Width="100" Height="60" style="vertical-align:super" ImageUrl='<%# Eval("ClassImg") %>' />
                            <div style="display: inline-block">
                                <asp:HiddenField ID="ID" runat="server" value='<%# Eval("ClassID") %>' />
                                <asp:Label ID="Name" style="overflow:hidden" runat="server" Width="170" Height="35" Font-Bold="true" Text='<%# Eval("ClassName") %>'></asp:Label><br />
                                <asp:Label ID="Author" runat="server" Width="100" style="max-height:20px;overflow:hidden" Text='<%# Eval("Teacher") %>'></asp:Label><br />
                                <asp:Button runat="server" CssClass="SaveButton" Text="查看详情" OnClick="Unnamed_Click"/>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>
    </form>
</body>
</html>

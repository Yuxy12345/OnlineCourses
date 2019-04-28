<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VideoPlay.aspx.cs" Inherits="VideoPlay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="css/VideoPlayStyle.css" rel="stylesheet" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align:center">
            <h2 id="ClassName" runat="server">课程标题</h2>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            讲师：<asp:Label ID="Teacher" runat="server"></asp:Label>
            <br />
            <asp:Label ID="ClassType" runat="server" Style="margin: 10px 20px 10px 100px" Text="类型"></asp:Label>
            <asp:Label ID="UpdateTime" runat="server" Text="更新时间"></asp:Label>
            <br />
            <asp:Label ID="OwnNum" runat="server" Style="margin: 10px 0 0 100px" Text="123" />
            人拥有
            <asp:Label ID="DanMuNum" runat="server" Style="margin-left: 20px" Text="456" />
            条弹幕
            <div class="wrap flex-column">
                <div class="box">
                    <video id="videoplay" runat="server" allowfullscreen="true" width="100%" height="100%" controls="controls" controllist="nodownload">
                        您的浏览器暂不受支持，请更换浏览器
                    </video>
                </div>

                <div class="send flex-row">
                    <asp:HiddenField ID="currentTime" runat="server" />
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <asp:UpdatePanel ID="UpdatePanel1" style="width:100%;text-align:center" runat="server" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <input id="DanMuToSend" runat="server" type="text" class="con" placeholder="弹幕发送[]~(^v^)~*" />
                            <input type="button" id="sendDanMu" runat="server" class="send-btn" value="发送" onserverclick="sendDanMu_ServerClick"/>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

            <div class="commontype">
                <h2>同类推荐</h2>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>" 
                    SelectCommand="SELECT Classes.ClassID, Classes.ClassName, Classes.ClassImg FROM Classes INNER JOIN ClassType ON Classes.TypeID = ClassType.TypeID WHERE (ClassType.TypeName = @TypeName AND Classes.ClassID != @ClassID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ClassType" Name="TypeName" PropertyName="Text" />
                        <asp:QueryStringParameter Name="ClassID" QueryStringField="ClassID" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:ListView runat="server" Style="margin: 10px 100px" DataSourceID="SqlDataSource1" OnItemDataBound="Unnamed_ItemDataBound">
                    <ItemTemplate>
                        <div style="display: inline-block; padding: 10px; border:1.5px solid black; border-radius:6px">
                            <asp:HyperLink ID="link" runat="server">
                                <asp:HiddenField ID="ClassID" runat="server" Value='<%# Eval("ClassID") %>' />
                                <asp:Image ID="RecClassPic" ImageUrl='<%# Eval("ClassImg") %>' runat="server" Width="160" Height="90" />
                                <br />
                                <asp:Label ID="RecClassName" runat="server" Text='<%# Eval("ClassName") %>'></asp:Label>
                            </asp:HyperLink>
                            
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
                <h2>课程讨论区</h2>
            <iframe id="TalkWindow" runat="server" width="500" height="400">
            </iframe>
            <br />
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:Panel runat="server" DefaultButton="send">
                        <asp:TextBox ID="Input" runat="server" placeholder="输入讨论内容"></asp:TextBox>
                        <asp:Button ID="send" runat="server" Text="发送" OnClick="send_Click" />
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
            
            <div class="comments" style="text-align:center">
                <h2 id="CommentNum" runat="server">评论</h2>
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
                <asp:ListView ID="AllComments" runat="server" InsertItemPosition="FirstItem" DataSourceID="SqlDataSource2" OnItemCommand="AllComments_ItemCommand">
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
                            <asp:TextBox ID="ReplyInputContent" runat="server" style="width:600px; margin:10px" Rows="2" TextMode="MultiLine" ></asp:TextBox>
                            <asp:Button ID="Reply" CssClass="SaveButton" runat="server" Text="回复" CommandName="Reply" />
                        </div>
                    </ItemTemplate>
                    <InsertItemTemplate>
                        <div class="EditComment">
                            <asp:TextBox ID="Content" CssClass="Text" TextMode="MultiLine" runat="server" Text='' placeholder="请输入您对此书的评论"></asp:TextBox>
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
        
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>" 
            SelectCommand="SELECT * FROM [DanMu] WHERE ([ClassID] = @ClassID) ORDER BY VideoTime">
            <SelectParameters>
                <asp:QueryStringParameter Name="ClassID" QueryStringField="ClassID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        
        <asp:DataList ID="DanMuList" runat="server" style="display:none" DataKeyField="DanMuID" DataSourceID="SqlDataSource3">
            <ItemTemplate>
                <asp:Label ID="DanMuIDLabel" CssClass="DanMuIDLabel" runat="server" Text='<%# Eval("DanMuID") %>' />
                <br />
                <asp:Label ID="UserIDLabel" CssClass="UserIDLabel" runat="server" Text='<%# Eval("UserID") %>' />
                <br />
                <asp:Label ID="ClassIDLabel" CssClass="ClassIDLabel" runat="server" Text='<%# Eval("ClassID") %>' />
                <br />
                <asp:Label ID="ContentLabel" CssClass="ContentLabel" runat="server" Text='<%# Eval("Content") %>' />
                <br />
                <asp:Label ID="VideoTimeLabel" CssClass="VideoTimeLabel" runat="server" Text='<%# Eval("VideoTime") %>' />
                <br />
                <asp:Label ID="isPlayed" CssClass="isPlayed" runat="server" Text="0"></asp:Label>
                <br />
            </ItemTemplate>
        </asp:DataList>
            <!--
            该页面弹幕实现和视频窗口样式来自Chen_s
            https://www.cnblogs.com/Chenshuai7/p/7091508.html
            -->
            <script src="js/DanMu.js"></script>
    </form>
</body>
</html>

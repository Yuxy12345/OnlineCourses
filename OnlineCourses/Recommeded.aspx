<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Recommeded.aspx.cs" Inherits="Recommeded" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>推荐课程</title>
    <link href="css/FrameStyle.css" rel="stylesheet" />
    <link href="css/BookItemStyle.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/Cooldog.css" />
    <link rel="stylesheet" href="css/iconfont.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align:center">
            <div style="display: block">
                <div style="display:inline-block;margin:10px">
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>" SelectCommand="SELECT * FROM [ClassType]"></asp:SqlDataSource>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TypeID" DataSourceID="SqlDataSource4" ShowHeader="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:HyperLinkField DataTextField="TypeName" ItemStyle-Width="300" ItemStyle-Height="28" DataNavigateUrlFormatString="~/TypeListDetails.aspx?TypeID={0}" DataNavigateUrlFields="TypeID" >
<ItemStyle Height="28px" Width="300px"></ItemStyle>
                            </asp:HyperLinkField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" Font-Size="15"/>
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F5F7FB" />
                        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                        <SortedDescendingCellStyle BackColor="#E9EBEF" />
                        <SortedDescendingHeaderStyle BackColor="#4870BE" />
                    </asp:GridView>
                </div>
                <div class="Cooldog_container" style="display:inline-block; vertical-align:top">
                    <div class="Cooldog_content">
                        <ul>
                            <li class="p1">
                                <a id="link1" runat="server" href="ClassInfo.aspx?ClassID=1">
                                    <asp:Image ID="Rec1" runat="server" src="image/1.jpg" alt="" />
                                </a>
                            </li>
                            <li class="p2">
                                <a id="link2" runat="server" href="ClassInfo.aspx?ClassID=2">
                                    <asp:Image ID="Rec2" runat="server" src="image/2.jpg" alt="" />
                                </a>
                            </li>
                            <li class="p3">
                                <a id="link3" runat="server" href="ClassInfo.aspx?ClassID=3">
                                    <asp:Image ID="Rec3" runat="server" src="image/3.jpg" alt="" />
                                </a>
                            </li>
                            <li class="p4">
                                <a id="link4" runat="server" href="ClassInfo.aspx?ClassID=4">
                                    <asp:Image ID="Rec4" runat="server" src="image/4.png" alt="" />
                                </a>
                            </li>
                            <li class="p5">
                                <a id="link5" runat="server" href="ClassInfo.aspx?ClassID=5">
                                    <asp:Image ID="Rec5" runat="server" src="image/5.jpg" alt="" />
                                </a>
                            </li>
                            <li class="p5">
                                <a id="link6" runat="server" href="ClassInfo.aspx?ClassID=6">
                                    <asp:Image ID="Rec6" runat="server" src="image/6.jpg" alt="" />
                                </a>
                            </li>
                            <li class="p5">
                                <a id="link7" runat="server" href="ClassInfo.aspx?ClassID=7">
                                    <asp:Image ID="Rec7" runat="server" src="image/7.jpg" alt="" />
                                </a>
                            </li>
                        </ul>
                    </div>
                    <a href="javascript:;" class="btn_left">
                        <i class="iconfont icon-zuoyoujiantou"></i>
                    </a>
                    <a href="javascript:;" class="btn_right">
                        <i class="iconfont icon-zuoyoujiantou-copy-copy"></i>
                    </a>
                    <div class="buttons clearfix">
                        <a href="javascript:;" class="color"></a>
                        <a href="javascript:;"></a>
                        <a href="javascript:;"></a>
                        <a href="javascript:;"></a>
                        <a href="javascript:;"></a>
                        <a href="javascript:;"></a>
                        <a href="javascript:;"></a>
                    </div>
                </div>
            </div>

            <script type="text/javascript" src="js/jquery.min.js"></script>
            <script type="text/javascript" src="js/Cooldog.js"></script>
            <br />
            <div style="display:block;margin-top:20px">
                <h2 style="margin-left: 50px;text-align:left">最新课程</h2>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>"
                    SelectCommand="select top(6) Classes.ClassID as ClassID,ClassName,ClassImg,Price,UpdateTime FROM Classes ORDER BY UpdateTime Desc"></asp:SqlDataSource>
                <asp:ListView ID="NewList" runat="server" DataSourceID="SqlDataSource1">
                    <ItemTemplate>
                        <div class="item">
                            <asp:Image ID="Pic" Style="margin-right: 10px" runat="server" Width="266" Height="150" ImageUrl='<%# Eval("ClassImg") %>' />
                            <div style="display: inline-block; vertical-align: super">
                                <asp:HiddenField ID="ID" runat="server" Value='<%# Eval("ClassID") %>' />
                                <asp:Label ID="Name" Style="overflow: hidden" runat="server" Width="170" Height="40" Font-Bold="true" Text='<%# Eval("ClassName") %>'></asp:Label><br />
                                <asp:Label ID="Type" runat="server" Width="170" Text='<%# Eval("UpdateTime") %>'></asp:Label><br />
                                ￥
                            <asp:Label ID="Price" Font-Bold="true" runat="server" Width="150" Text='<%# Eval("Price") %>'></asp:Label><br />
                                <asp:Button runat="server" CssClass="SaveButton" Text="查看详情" OnClick="Unnamed_Click" />
                            </div>
                        </div>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div id="itemPlaceHolder" runat="server" style="background-color: white">
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
                <h2 style="margin-left: 50px;text-align:left">最多购买</h2>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>"
                    SelectCommand="SELECT TOP(6) Classes.ClassID, Classes.ClassName, Classes.Price, Classes.ClassImg, Classes.Num, ClassType.TypeName AS ClassType FROM Classes INNER JOIN ClassType ON Classes.TypeID = ClassType.TypeID ORDER BY Classes.Num DESC"></asp:SqlDataSource>
                <asp:ListView ID="MostBuyList" runat="server" DataSourceID="SqlDataSource2">
                    <ItemTemplate>
                        <div class="item">
                            <asp:Image ID="Pic" Style="margin-right: 10px" runat="server" Width="266" Height="150" ImageUrl='<%# Eval("ClassImg") %>' />
                            <div style="display: inline-block; vertical-align: super">
                                <asp:HiddenField ID="ID" runat="server" Value='<%# Eval("ClassID") %>' />
                                <asp:Label ID="Name" runat="server" Width="170" Height="40" Font-Bold="true" Text='<%# Eval("ClassName") %>'></asp:Label><br />
                                <asp:Label ID="Type" runat="server" Width="170" Text='<%# Eval("ClassType") %>'></asp:Label><br />
                                ￥
                            <asp:Label ID="Price" Font-Bold="true" runat="server" Width="150" Text='<%# Eval("Price") %>'></asp:Label><br />
                                <asp:Button runat="server" CssClass="SaveButton" Text="查看详情" OnClick="Unnamed_Click" />
                            </div>
                        </div>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div id="itemPlaceHolder" runat="server" style="background-color: white">
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
                <h2 style="margin-left: 50px;text-align:left">最多评论</h2>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>"
                    SelectCommand="SELECT TOP (6) Classes.ClassID, Classes.ClassName, Classes.ClassImg, Classes.Price, COUNT(Comments.CommentID) AS CommentCount FROM Classes INNER JOIN Comments ON Classes.ClassID = Comments.ClassID GROUP BY Classes.ClassID, Classes.ClassName, Classes.ClassImg, Classes.Price ORDER BY CommentCount DESC"></asp:SqlDataSource>
                <asp:ListView ID="MostCommentList" runat="server" DataSourceID="SqlDataSource3">
                    <ItemTemplate>
                        <div class="item">
                            <asp:Image ID="Pic" Style="margin-right: 10px" runat="server" Width="266" Height="150" ImageUrl='<%# Eval("ClassImg") %>' />
                            <div style="display: inline-block; vertical-align: super">
                                <asp:HiddenField ID="ID" runat="server" Value='<%# Eval("ClassID") %>' />
                                <asp:Label ID="Name" runat="server" Width="170" Height="40" Font-Bold="true" Text='<%# Eval("ClassName") %>'></asp:Label><br />
                                评论数：<asp:Label ID="Type" runat="server" Width="80" Text='<%# Eval("CommentCount") %>'></asp:Label><br />
                                ￥
                            <asp:Label ID="Price" Font-Bold="true" runat="server" Width="150" Text='<%# Eval("Price") %>'></asp:Label><br />
                                <asp:Button runat="server" CssClass="SaveButton" Text="查看详情" OnClick="Unnamed_Click" />
                            </div>
                        </div>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div id="itemPlaceHolder" runat="server" style="background-color: white">
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
            </div>
        </div>
    </form>
</body>
</html>

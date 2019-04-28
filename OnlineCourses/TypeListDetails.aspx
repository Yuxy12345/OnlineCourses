<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TypeListDetails.aspx.cs" Inherits="TypeListDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="css/BookItemStyle.css" rel="stylesheet" />
    <link href="css/FrameStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ImageButton runat="server" Width="60px" Height="60px" PostBackUrl="~/Recommeded.aspx" ImageUrl="~/icons/Back.jpg" />
            <h2 id="TypeName" style="display:inline-block; vertical-align:top" class="TypeName" runat="server">TypeName</h2>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>" 
            SelectCommand="SELECT * FROM Classes WHERE ([TypeID] = @TypeID)" >
            <SelectParameters>
                <asp:QueryStringParameter Name="TypeID" QueryStringField="TypeID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:ListView ID="NewList" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <div class="item">
                        <asp:ImageButton ID="Pic" runat="server" Width="266" Height="150" ImageUrl='<%# Eval("ClassImg") %>' />
                        <div style="display:inline-block">
                            <asp:HiddenField ID="ID" runat="server" value='<%# Eval("ClassID") %>' />
                            <asp:Label ID="Name" style="overflow:hidden" runat="server" Width="170" Height="40" Font-Bold="true" Text='<%# Eval("ClassName") %>'></asp:Label><br />
                            销量：<asp:Label ID="Num" runat="server" Width="130" Text='<%# Eval("Num") %>'></asp:Label><br />
                            ￥ <asp:Label ID="Price" Font-Bold="true" runat="server" Width="150" Text='<%# Eval("Price") %>'></asp:Label><br />
                            <asp:Button runat="server" CssClass="SaveButton" Text="查看详情" OnClick="Unnamed_Click"/>
                        </div>
                    </div>
                </ItemTemplate>
                <LayoutTemplate>
                    <div id="itemPlaceHolder" runat="server" style="background-color:white">
                    </div>
                </LayoutTemplate>
            </asp:ListView>
    </form>
</body>
</html>

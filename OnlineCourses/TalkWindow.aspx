<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TalkWindow.aspx.cs" Inherits="TalkWindow" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body onload="window.scrollTo(0,document.body.scrollHeight); ">
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Interval="2000" ></asp:Timer>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server" >
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="Timer1" />
                </Triggers>
                <ContentTemplate>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>" 
                        SelectCommand="SELECT TOP (50) Users.UserName, Users.UserImg, Talks.[Content], Talks.TalkTime FROM Talks INNER JOIN Users ON Talks.UserID = Users.UserID WHERE (Talks.ClassID = @ClassID) ORDER BY Talks.TalkTime">
                        <InsertParameters>
                            <asp:QueryStringParameter Name="ClassID" QueryStringField="ClassID" />
                            <asp:SessionParameter Name="UserID" SessionField="UserID" />
                            <asp:ControlParameter Name="Content" ControlID="Content" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ClassID" QueryStringField="ClassID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:ListView ID="ListView1" style="height:400px;" runat="server" DataSourceID="SqlDataSource4">
                        <ItemTemplate>
                            <div style="margin:25px; border-radius:3px; border:1px solid blue; ">
                                <asp:Image ID="UserIcon" runat="server" style="width:30px; height:30px; border-radius: 25px; border:1px solid blue" ImageUrl='<%# Eval("UserImg") %>' />
                                <asp:Label ID="UserName" runat="server" style="font-weight:bold; font-size:23px; vertical-align:top" Text='<%# Eval("UserName") %>'></asp:Label>
                                <br />
                                <asp:Label ID="Content" runat="server" style="min-width:50px" Text='<%# Eval("Content") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>

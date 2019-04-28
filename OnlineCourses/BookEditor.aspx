<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BookEditor.aspx.cs" Inherits="AddBook" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="css/FrameStyle.css" rel="stylesheet" />
    <link href="css/AddBookStyle.css" rel="stylesheet" />
    <script src="js/JavaScript.js"></script>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="panel" style="font-size:22px;">
            <asp:ImageButton runat="server" Width="60px" Height="60px" PostBackUrl="~/BookManager.aspx" style="margin:10px"  ImageUrl="~/icons/Back.jpg" />
            <h2 id="title" runat="server" style="margin-left: 50px; font-size: 30px; display:inline-block; vertical-align:bottom"></h2>
            <hr />
            <div style="text-align:center;">
            <asp:Image id="preview" runat="server" class="Image" title="点击添加图片" onclick="SelectFile()"/>
            <div style="display:inline-block;vertical-align:middle">
                <asp:HiddenField ID="ClassID" runat="server" />
                <asp:HiddenField ID="ClassImg" runat="server" /> 
                <asp:HiddenField ID="VideoAddress" runat="server" />
                <asp:TextBox CssClass="TextBox" ID="ClassName" runat="server" placeholder="课程名称"></asp:TextBox>
                <br />
                <asp:TextBox CssClass="TextBox" ID="Author" runat="server" placeholder="老师"></asp:TextBox>
                <br />
                <asp:TextBox CssClass="TextBox" ID="Price" runat="server" placeholder="定价"></asp:TextBox>
                <br />
                选择是否销售：<br />
                <asp:DropDownList CssClass="TextBox" ID="Sale" runat="server">
                    <asp:ListItem>-请选择已有类型-</asp:ListItem>
                    <asp:ListItem Value="1">销售</asp:ListItem>
                    <asp:ListItem Value="0">不销售</asp:ListItem>
                </asp:DropDownList>
                <br />
                <br />
                <br />
                <br />
                视频地址：<br />
                <asp:FileUpload ID="FileUpload0" runat="server" CssClass="TextBox"/>
                <br />
                封面图片：<br />
                <asp:FileUpload ID="FileUpload" runat="server" CssClass="TextBox" oninput="ShowPreview(this)"/>
                <br />
                课程类型：<br />
                <asp:DropDownList CssClass="TextBox" ID="Type" runat="server">
                    <asp:ListItem>-请选择已有类型-</asp:ListItem>
                </asp:DropDownList>
                <br />
                简要介绍：<br />
                <asp:TextBox ID="Introduction" runat="server" CssClass="TextBox" Height="120" TextMode="MultiLine" placeholder="请输入对该书的简要介绍"></asp:TextBox> 
                <br />
                <asp:Button CssClass="Button" ID="OK" runat="server" Text="提交" OnClick="Submit" />
            </div>
            </div>
            
        </div>
    </form>
</body>
</html>

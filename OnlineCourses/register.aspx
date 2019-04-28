<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="img_register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>注册</title>
    <link href="css/FrameStyle.css" rel="stylesheet" />
    <link href="css/RegisterStyle.css" rel="stylesheet" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
    <script src="js/JavaScript.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="title">
            <a href="#">
                <h1>欢迎注册</h1>
            </a>
            <div>
                <a href="login.aspx" class="a">
                    <input type="button" value="登录" class="topButton" />
                </a>
            </div>
        </div>
        <div class="panel">
            <div class="leftImg" style="min-height: 580px;">
            </div>
            <div class="regContents">
                <div class="regBox">
                    <h2 class="regText">注册你的账户</h2>
                    <br />
                    <div id="ManagerLogin" visible="false" runat="server" style="display: inline-block;margin-bottom:20px">
                        <img src="img/error.png" width="15" height="15" />
                        <span class="Validator">要想注册管理员账户，请先输入已有管理员的账号密码：</span><br />
                        <asp:TextBox ID="ManagerName" CssClass="input" runat="server" placeholder="管理员用户名" /><br />
                        <asp:TextBox class="input" TextMode="Password" ID="ManagerPasswd" runat="server" placeholder="管理员密码" />
                    </div>
                    <br />
                    <asp:TextBox ID="UserName" CssClass="input" runat="server" placeholder="用户名" />
                    <br />
                    <asp:RequiredFieldValidator ID="Validator1" CssClass="Validator" runat="server" ControlToValidate="UserName" Display="Dynamic" ErrorMessage="用户名不能为空">
                        <img src="img/error.png" width="15" height="15"/>用户名不能为空
                    </asp:RequiredFieldValidator>
                    <br />
                    <asp:TextBox class="input" TextMode="Password" ID="PassWord" runat="server" placeholder="密码" />
                    <br />
                    <asp:RequiredFieldValidator ID="Validator2" CssClass="Validator" runat="server" ControlToValidate="PassWord" Display="Dynamic" ErrorMessage="密码不能为空">
                        <img src="img/error.png" width="15" height="15"/>密码不能为空
                    </asp:RequiredFieldValidator>
                    <br />
                    <asp:TextBox class="input" TextMode="Password" ID="ConfirmPwd" runat="server" placeholder="确认密码" />
                    <br />
                    <asp:RequiredFieldValidator ID="Validator3" CssClass="Validator" runat="server" ControlToValidate="ConfirmPwd" Display="Dynamic" ErrorMessage="确认密码不能为空">
                        <img src="img/error.png" width="15" height="15"/>确认密码不能为空
                    </asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" CssClass="Validator" ControlToValidate="ConfirmPwd" ControlToCompare="PassWord" Display="Dynamic" ErrorMessage="输入的密码不一致">
                        <img src="img/error.png" width="15" height="15"/>输入的密码不一致
                    </asp:CompareValidator>
                    <br />
                    头像：
                    <img id="preview" class="preview" src="icons/AddImg.jpg" onclick="SelectFile()" />
                    <asp:FileUpload ID="FileUpload" AllowMultiple="false" CssClass="input upload" runat="server" oninput="ShowPreview(this)" />
                    <br />
                    <asp:RequiredFieldValidator ID="PicValidator" runat="server" CssClass="Validator" ControlToValidate="FileUpload" Display="Dynamic" ErrorMessage="未选择头像">
                        <img src="img/error.png" width="15" height="15"/>请选择一个头像
                    </asp:RequiredFieldValidator>
                    <br />
                    <br />
                    <asp:TextBox class="input" ID="Tel" runat="server" placeholder="电话号码" autocomplete="off" />
                    <br />
                    <asp:RegularExpressionValidator ID="REValidator1" CssClass="Validator" runat="server" ControlToValidate="Tel" ValidationExpression="(0\d{2,3}-\d{8})|\d{11}" ErrorMessage="电话号码格式不正确">
                        <img src="img/error.png" width="15" height="15"/>电话号码格式不正确
                    </asp:RegularExpressionValidator>
                    <br />
                    <br />
                    <asp:ValidationSummary ID="ValidationSummary" runat="server" HeaderText="输入的信息有如下问题，请修改后重试:" DisplayMode="List" ShowMessageBox="true" ShowSummary="false" />
                    <asp:Button ID="register" CssClass="submit" Text="立即注册" runat="server" OnClick="submit_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>

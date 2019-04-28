<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Shopping.aspx.cs" Inherits="Shopping" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>购物车</title>
    <link href="css/FrameStyle.css" rel="stylesheet" />
    <style>
        .BookInfo {
            display: inline-block;
            vertical-align: top;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2 style="margin-left: 100px; font-size: 30px;">购物车</h2>
        <hr />
        <div style="padding: 40px; text-align: center">
            <asp:GridView ID="GridView1" runat="server" Style="display:inline-block;text-align:left" 
                AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" 
                ForeColor="#333333" GridLines="None" OnDataBound="GridView1_DataBound"
                OnRowDeleting="GridView1_RowDeleting" DataKeyNames="DetailID">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="商品" ItemStyle-Width="400">
                        <ItemTemplate>
                            <asp:HiddenField ID="ClassID" runat="server" Value='<%# Eval("ClassID") %>' />
                            <asp:Image ID="Img" runat="server" Width="120px" ImageUrl='<%# Eval("ClassImg") %>' />
                            <div class="BookInfo">
                                <asp:Label ID="BookName" Font-Bold="true" runat="server" Text='<%# Eval("ClassName") %>'></asp:Label>
                                <br />
                                <br />
                                <asp:Label ID="BookType" runat="server" Text='<%# Eval("TypeName") %>'></asp:Label>
                            </div>
                        </ItemTemplate>

                    <ItemStyle Width="400px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="单价" ItemStyle-Width="100" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            ￥<asp:Label ID="Price" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                        </ItemTemplate>

                    <ItemStyle HorizontalAlign="Center" Width="100px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:ButtonField CommandName="Delete" HeaderText="操作" ShowHeader="True" Text="删除" ItemStyle-Width="50">
                    <ItemStyle Width="50px"></ItemStyle>
                    </asp:ButtonField>
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <EmptyDataTemplate>
                    <div style="text-align:center">
                        <img class="auto-style1" width="100" height="100" src="icons/gwc.jpg" />
                        <br />
                        购物车里空空如也呢~
                    </div>
                </EmptyDataTemplate>
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <br />
            <asp:Button ID="Clear" runat="server" CssClass="SaveButton" Width="100px" Height="30px" style="margin-right:150px" Text="清空购物车" OnClientClick="return confirm('确定清空购物车吗？');" OnClick="Clear_Click"></asp:Button>
            总金额： ￥<asp:Label ID="Sum" ForeColor="Red" runat="server" ></asp:Label>
            <asp:Button ID="Buy" CssClass="BuyButton" Width="100px" Height="30px" runat="server" Text="立即购买" OnClick="Buy_Click" />
        </div>
    </form>
</body>
</html>

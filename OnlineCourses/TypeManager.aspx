<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TypeManager.aspx.cs" Inherits="TypeManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>类型管理</title>
    
    <script src="js/JavaScript.js"></script>
    <style>
        .upload {
            display:none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ImageButton runat="server" Width="60px" ImageUrl="~/icons/Back.jpg" Height="60px" PostBackUrl="~/ManagerTools.aspx"  />
            <h2 style="margin-left: 50px; font-size: 30px; display:inline-block; vertical-align:bottom">类型管理</h2>
            <hr />
            <div style="padding: 40px; text-align: center">
                搜索类型名：<asp:TextBox ID="SearchBookType" runat="server" placeholder="请输入类型名"></asp:TextBox>
                <asp:Button ID="Search" runat="server" Text="搜索" OnClick="Search_Click" />
                <br />
                <asp:HiddenField ID="IsPicChanged" runat="server" />
                <asp:FileUpload ID="FileUpload1" CssClass="upload" runat="server" oninput="ShowPreview1(this)"/>
                <asp:FileUpload ID="FileUpload2" CssClass="upload" runat="server" oninput="ShowPreview2(this)" />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCourseConnectionString %>"
                    DeleteCommand="DELETE FROM [ClassType] WHERE [TypeID] = @TypeID"
                    SelectCommand="SELECT * FROM [ClassType]"
                    InsertCommand="INSERT INTO [ClassType] ([TypeName]) VALUES (@TypeName)"
                    
                    UpdateCommand="UPDATE [ClassType] SET [TypeName] = @TypeName WHERE [TypeID] = @TypeID">
                    <DeleteParameters>
                        <asp:Parameter Name="TypeID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TypeName" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TypeName" Type="String" />
                        <asp:Parameter Name="TypeID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:ListView ID="ListView1" runat="server" DataKeyNames="TypeID"
                    DataSourceID="SqlDataSource1"                 
                   >
                    <EditItemTemplate>
                        <tr style="">
                            <td>
                                <asp:Label ID="TypeID" runat="server" Text='<%# Eval("TypeID") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="TypeName" runat="server" Text='<%# Bind("TypeName") %>' />
                            </td>
                            
                            <td>
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="更新" /><br />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="取消" />
                            </td>
                        </tr>
                    </EditItemTemplate>
                    <AlternatingItemTemplate>
                        <tr style="background-color: #87B0FF;">
                            <td>
                                <asp:Label ID="TypeID" runat="server" Text='<%# Eval("TypeID") %>' />
                            </td>
                            <td>
                                <asp:Label ID="TypeName" runat="server" Text='<%# Eval("TypeName") %>' />
                            </td>
                           
                            <td>
                                <asp:Button ID="InsertButton" runat="server" CommandName="Edit" Text="编辑" /><br />
                                <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="删除" />
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                    <LayoutTemplate>
                        <table runat="server" style="display: inline-block;margin:20px">
                            <tr runat="server">
                                <td runat="server">
                                    <table id="itemPlaceholderContainer" runat="server" border="0"
                                        style="background-color: #FFFFFF; border-collapse:collapse; font-family: Verdana, Arial, Helvetica, sans-serif;">
                                        <tr runat="server" style="background-color: #507CD1; color: white;">
                                            <th runat="server" style="width:100px">类型ID</th>
                                            <th runat="server" style="width:200px">类型名</th>                                         
                                            <th runat="server" style="width:100px">操作</th>
                                        </tr>
                                        <tr id="itemPlaceholder" runat="server">
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td runat="server"
                                    style="text-align: center; background-color: #507CD1; font-family: Verdana, Arial, Helvetica, sans-serif; color: white;">
                                    <asp:DataPager ID="DataPager1" runat="server">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button"  ShowFirstPageButton="True"
                                                ShowLastPageButton="True" />
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <InsertItemTemplate>
                        <tr style="">
                            <td>
                                新增类型
                            </td>
                            <td>
                                <asp:TextBox ID="TypeName" runat="server" Text='<%# Bind("TypeName") %>' />
                            </td>
                          
                            <td>
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="插入" /><br />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="取消" />
                            </td>
                        </tr>
                    </InsertItemTemplate>
                    <SelectedItemTemplate>
                        <tr style="background-color: white; font-weight: bold; color: #FFFFFF;">
                            <td>
                                <asp:Label ID="TypeID" runat="server" Text='<%# Eval("TypeID") %>' />
                            </td>
                            <td>
                                <asp:Label ID="TypeName" runat="server" Text='<%# Eval("TypeName") %>' />
                            </td>
                           
                            <td>
                                <asp:Button ID="InsertButton" runat="server" CommandName="Edit" Text="编辑" /><br />
                                <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="删除" />
                            </td>
                        </tr>
                    </SelectedItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server"
                            style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                            <tr>
                                <td>未返回数据。</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr style="background-color: #EFF3FB; color: #000000;">
                            <td>
                                <asp:Label ID="TypeID" runat="server" Text='<%# Eval("TypeID") %>' />
                            </td>
                            <td>
                                <asp:Label ID="TypeName" runat="server" Text='<%# Eval("TypeName") %>' />
                            </td>
                         
                            <td> 
                                <asp:Button ID="InsertButton" runat="server" CommandName="Edit" Text="编辑" /><br />
                                <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="删除" />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>
    </form>
</body>
</html>

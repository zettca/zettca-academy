<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Profile.aspx.vb" Inherits="Profile" %>
<%@ MasterType virtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
    table { margin: 0 auto; }
    p { position: relative; top: -50px;  left: 20px; }
    .tableInfos { border-collapse: separate; border-spacing: 10px 5px; }
    .userProfile div { display: block; }
    .basicArea { float: left; }
    .basicArea div { float: left; margin: 0px 10px; }
    .badgeArea { float: right; }
    .gimeSpace { margin-bottom: 24px; }
    
    .userProfile
    {
        width: 90%;
        height: 150px;
        margin: 20px auto;
        padding: 20px;
        box-shadow: 0 0 2px 2px silver;
        border-radius: 10px;
    }
    .profile-block
    {
        width: 450px;
        min-height: 200px;
        margin: 10px auto 100px;
        padding: 0px;
        display: block;
        border-top: 1px solid silver;
        border-radius: 5px;
    }    
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
    <div class="userProfile">
        <div class="basicArea">
            <div>
                <asp:Image ID="imgBasicAvatar" runat="server" Height="128px" />
            </div>
            <div>
                <asp:Label ID="lblUsername" runat="server" Font-Size="20px" CssClass="gimeSpace"></asp:Label><br />
                <asp:Label ID="lblJoinDate" runat="server"></asp:Label>
                <br /> <br />
                <table class="tableInfos">
                    <tr>
                        <th>Exercices</th>
                        <th>Score</th>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblExeSolved" runat="server"></asp:Label></td>
                        <td><asp:Label ID="lblScore" runat="server"></asp:Label></td>
                    </tr>
                </table>
            </div>
            <asp:SqlDataSource ID="dsCalculate" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"></asp:SqlDataSource>
        </div>
        <div class="badgeArea">
            <asp:ListView ID="lvBadges" runat="server" DataSourceID="dsBadgesGV">
                <EmptyDataTemplate>
                    <table style="">
                        <tr>
                            <td>You have no badges.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <td runat="server" style="width:64px;">
                        <img src="resources/image/badge/<%# Eval("ImageURL") %>" alt="<%# Eval("Title") %>" title="<%# Eval("Title") %>. <%# Eval("Description") %>" width="64"/>
                        <br />
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;x <%# Eval("ammount") %></label>
                    </td>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server" style="width:300px;">
                        <tr ID="itemPlaceholderContainer" runat="server">
                            <td ID="itemPlaceholder" runat="server">
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
            <asp:SqlDataSource ID="dsBadgesGV" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT tableBadges.Title, tableBadges.Description, tableBadges.ImageURL, tableBadgesUsers.ammount, tableBadgesUsers.idUser FROM tableBadgesUsers INNER JOIN tableBadges ON tableBadgesUsers.idBadge = tableBadges.idBadge WHERE (idUser = @IDU)">
                <SelectParameters>
                    <asp:SessionParameter Name="IDU" SessionField="ID" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
    <br /> <br />
    <asp:Panel ID="panProfileSettings" runat="server">
        <asp:Panel ID="panUpdateBasic" runat="server" CssClass="profile-block" DefaultButton="btnUpdateBasic">
            <p>Basic Settings</p>
            <table>
                <tr>
                    <td align="right"><asp:Label ID="l1" runat="server" Text="Real Name:" AssociatedControlID="txtRealName"></asp:Label></td>
                    <td><asp:TextBox ID="txtRealName" placeholder="Username" runat="server" style="width:180px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="right">Username:</td>
                    <td><asp:TextBox ID="txtUsername" placeholder="Email" runat="server" Enabled="False" style="width:180px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="right">Email:</td>
                    <td><asp:TextBox ID="txtEmail" placeholder="Real Name" runat="server" Enabled="False" style="width:180px;"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="right" colspan="2"><asp:Button ID="btnUpdateBasic" CssClass="btn-class" runat="server" Text="Update Profile" /></td>
                </tr>
            </table>
            <asp:SqlDataSource ID="dsBasic" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT [idUser], [username], [realname] FROM [User]" 
                UpdateCommand="UPDATE tableUsers SET [RealName] = @Name WHERE (idUser = @ID)">
                <UpdateParameters>
                    <asp:ControlParameter ControlID="txtRealName" Name="Name" 
                        PropertyName="Text" />
                    <asp:SessionParameter Name="ID" SessionField="ID" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:Panel>
        <asp:Panel ID="panUpdatePassword" runat="server" CssClass="profile-block" DefaultButton="btnUpdatePass">
            <p>Password Settings</p>
            <table>
                <tr>
                    <td align="right"><asp:Label ID="l2" runat="server" Text="Old Password:" AssociatedControlID="txtPassOld"></asp:Label></td>
                    <td><asp:TextBox ID="txtPassOld" placeholder="Old Password" TextMode="Password" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="right"><asp:Label ID="l3" runat="server" Text="New Password:" AssociatedControlID="txtPassNew1"></asp:Label></td>
                    <td><asp:TextBox ID="txtPassNew1" placeholder="New Password 1" TextMode="Password" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="right"><asp:Label ID="l4" runat="server" Text="Repeat Password:" AssociatedControlID="txtPassNew2"></asp:Label></td>
                    <td><asp:TextBox ID="txtPassNew2" placeholder="New Password 2" TextMode="Password" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="right" colspan="2">
                        <asp:Button ID="btnUpdatePass" CssClass="btn-class" runat="server" Text="Update Password" />
                        <asp:Label ID="lblUpdatePassErrors" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
            </table>
            <asp:SqlDataSource ID="dsPassword" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT * FROM [User]" 
                UpdateCommand="UPDATE tableUsers SET Password = @Pass WHERE (idUser = @ID)">
                <UpdateParameters>
                    <asp:ControlParameter ControlID="txtPassNew1" Name="Pass" 
                        PropertyName="Text" />
                    <asp:SessionParameter Name="ID" SessionField="ID" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:Panel>
        <asp:Panel ID="panUpdateAvatar" runat="server" CssClass="profile-block">
            <p>Avatar Settings</p>
            <div style="float:left;">
                <asp:Image ID="imgAvatar" runat="server" Width="128" />
            </div>
            <div style="float: left; margin: 15px;">
                Update Image: <br />
                <asp:FileUpload ID="fuAvatar" runat="server" /> <br /> <br />
                <asp:Button ID="btnUploadAvatar" runat="server" CssClass="btn-class" Text="Update Avatar" />
                <asp:Label ID="lblAvatarErrors" runat="server" ForeColor="Red"></asp:Label>
            </div>
            <asp:HiddenField ID="hfAvatarName" runat="server" />
            <asp:SqlDataSource ID="dsAvatar" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                UpdateCommand="UPDATE tableUsers SET Avatar = @Avatar WHERE (Username = @User )">
                <UpdateParameters>
                    <asp:ControlParameter ControlID="hfAvatarName" Name="Avatar" 
                        PropertyName="Value" />
                    <asp:SessionParameter Name="User" SessionField="User" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:Panel>
        <asp:Panel ID="panAdmin" runat="server" CssClass="profile-block">
            <p>Admin Area</p>
            Hello dude! Looks like you're a <b><%= Session("Role")%></b>.
            <br />
            Therefore, you have access to <a href="admin.aspx">Admin CP</a>.
        </asp:Panel>
    </asp:Panel>
</asp:Content>


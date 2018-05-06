<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
    input[type=text], input[type=password] { width: 180px; }
    .goRight { float: right; }
    .panRecover { margin: 20px 0; }
    .logres
    {
        float: left;
        display: block;
        margin: 20px 60px;
    }
    .askRecover:hover { cursor: pointer; text-decoration: underline; }
    .askRecover
    {
        color: #009;
        border: 0;
        display: inline;
        font-size: 14px;
        font-family: inherit;
        background: transparent;
        vertical-align: middle;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
    <div>
        <asp:Panel ID="panLogin" runat="server" DefaultButton="btnLogin" CssClass="logres">
            Login onto your account: <br />
            <table>
                <tr>
                    <td><asp:TextBox ID="txtLogUsername" placeholder="Username" runat="server"></asp:TextBox></td>
                    <td><asp:RequiredFieldValidator ID="fvLogUser" runat="server" ErrorMessage="Username is required." ToolTip="Username is required." ControlToValidate="txtLogUsername" ValidationGroup="vgLogin" ForeColor="Red">*</asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtLogPassword" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox></td>
                    <td><asp:RequiredFieldValidator ID="fvLogPass" runat="server" ErrorMessage="Password is required." ToolTip="Password is required." ControlToValidate="txtLogPassword" ValidationGroup="vgLogin" ForeColor="Red">*</asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblLoginErrors" runat="server" ForeColor="Red" Font-Size="12px"></asp:Label>
                        <asp:ValidationSummary ID="vsLogin" runat="server" ValidationGroup="vgLogin" Font-Size="12px" ForeColor="Red" DisplayMode="List" />
                    </td>
                </tr>
                <tr>
                    <td><asp:Button ID="btnLogin" CssClass="btn-class goRight" runat="server" Text="Login" ValidationGroup="vgLogin" /></td>
                </tr>
                <tr>
                    <td><asp:Button ID="btnRecovere" runat="server" CssClass="askRecover" Text="Forgot Password?" /></td>
                </tr>
            </table>
            <asp:SqlDataSource ID="dsLogin" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT * FROM [tableUsers] WHERE ([Username] = @Username)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtLogUsername" Name="Username" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="panRecover" runat="server" DefaultButton="btnRecover" CssClass="panRecover">
                <table>
                    <tr>
                        <td><asp:TextBox ID="txtRecUsername" placeholder="Username" runat="server"></asp:TextBox></td>
                        <td><asp:RequiredFieldValidator ID="fvRecUser" runat="server" ErrorMessage="Username is required." ToolTip="Username is required." ControlToValidate="txtRecUsername" ValidationGroup="vgRecover" ForeColor="Red">*</asp:RequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblRecoverNotice" runat="server" ForeColor="Red" Font-Size="12px"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="right"><asp:Button ID="btnRecover" CssClass="btn-class" runat="server" Text="Recover Password" ValidationGroup="vgRecover" /></td>
                    </tr>
                </table>
                <asp:SqlDataSource ID="dsRecover" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                    SelectCommand="SELECT * FROM [tableUsers] WHERE ([Username] = @Username)" 
                    UpdateCommand="UPDATE tableUsers SET Password = @NP WHERE (Username = @User )">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtRecUsername" Name="Username" 
                            PropertyName="Text" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:SessionParameter DefaultValue="" Name="NP" SessionField="NewPass" />
                        <asp:ControlParameter ControlID="txtRecUsername" DefaultValue="" Name="User" 
                            PropertyName="Text" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </asp:Panel>
        </asp:Panel>
        <asp:Panel ID="panRegister" runat="server" DefaultButton="btnRegister" CssClass="logres">
            Register a new account: <br />
            <table>
                <tr>
                    <td><asp:TextBox ID="txtRegUsername" placeholder="Username" runat="server"></asp:TextBox></td>
                    <td><asp:RequiredFieldValidator ID="fvRegUser" runat="server" ErrorMessage="Username is required." ToolTip="Username is required." ControlToValidate="txtRegUsername" ValidationGroup="vgRegister" ForeColor="Red">*</asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtRegPassword1" placeholder="Password" runat="server" TextMode="password"></asp:TextBox></td>
                    <td><asp:RequiredFieldValidator ID="fvRegPass1" runat="server" ErrorMessage="Password is required." ToolTip="Password is required." ControlToValidate="txtRegPassword1" ValidationGroup="vgRegister" ForeColor="Red">*</asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtRegPassword2" placeholder="Repeat Password" runat="server" TextMode="password"></asp:TextBox></td>
                    <td>
                        <asp:RequiredFieldValidator ID="fvRegPass2" runat="server" ErrorMessage="Password is required." ToolTip="Password is required." ControlToValidate="txtRegPassword2" ValidationGroup="vgRegister" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="fvRegPass3" runat="server" ErrorMessage="Passwords must match." ToolTip="Passwords must match." ControlToValidate="txtRegPassword2" ControlToCompare="txtRegPassword1" ValidationGroup="vgRegister" ForeColor="Red">*</asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtRegEmail" placeholder="Email" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:RequiredFieldValidator ID="fvRegEmail1" runat="server" ErrorMessage="Email is required." ToolTip="Email is required." ControlToValidate="txtRegEmail" ValidationGroup="vgRegister" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="fvRegEmail2" runat="server" ErrorMessage="Email not valid." ToolTip="Email not valid." ControlToValidate="txtRegEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="vgRegister" ForeColor="Red">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txtRegRealName" placeholder="Real Name" runat="server"></asp:TextBox></td>
                    <td><asp:RequiredFieldValidator ID="fvRegName" runat="server" ErrorMessage="Real Name is required." ToolTip="Real Name is required." ControlToValidate="txtRegRealName" ValidationGroup="vgRegister" ForeColor="Red">*</asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRegisterErrors" runat="server" ForeColor="Red" Font-Size="12px"></asp:Label>
                        <asp:ValidationSummary ID="vsRegister" runat="server" ValidationGroup="vgRegister" Font-Size="12px" ForeColor="Red" DisplayMode="List" />
                    </td>
                </tr>
                <tr>
                    <td align="right"><asp:Button ID="btnRegister" CssClass="btn-class" runat="server" Text="Register" ValidationGroup="vgRegister" /></td>
                </tr>
            </table>
            <asp:SqlDataSource ID="dsRegister" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                InsertCommand="INSERT INTO tableUsers(Username, Password, Email, RealName, RegDate) VALUES (@Username, @Password, @Email, @RealName, @RegDate)" 
                SelectCommand="SELECT * FROM [tableUsers] WHERE ([Username] = @Username)">
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtRegUsername" Name="Username" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtRegPassword1" Name="Password" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtRegEmail" Name="Email" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtRegRealName" Name="RealName" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="hfTimeDate" DefaultValue="" Name="RegDate" 
                        PropertyName="Value" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="hfUserRegistered" Name="Username" 
                        PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="hfTimeDate" runat="server" />
            <asp:HiddenField ID="hfUserRegistered" runat="server" />
        </asp:Panel>
    </div>
</asp:Content>


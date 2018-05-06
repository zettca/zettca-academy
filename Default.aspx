<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

<asp:Content ID="ContentContent" ContentPlaceHolderID="cphContent" Runat="Server">
    <div style="height:50px;">
        <img src="resources/image/web/academy-old.png" style="float:left;" />
        <div>
            <span style="float: left; font-size: 14px;">ZETTCA Academy is a place where you can put your brain up to date, by solving exercices.<br />
            We offer a ton of exercices, sorted by Class. Pick something to start practicing...</span>
        </div>
    </div>
    <a id="aLogin" runat="server" class="box-menu" href="Login.aspx">
        <p>It looks like you aren't logged...</p>
        <p>Click here to login or register!</p>
    </a>
    <a id="aExercices" runat="server" class="box-menu" href="Exercices.aspx">
        <p>Start practicing now!</p>
        <p>CLICK HERE to start solving.</p>
    </a>
    <a id="aProfile" runat="server" class="box-menu" href="Profile.aspx">
        <br /><p>Click here to access your profile.</p>
    </a>
    <a id="aAdmin" runat="server" class="box-menu" href="Admin.aspx">
        <p>You have Admin Privileges</p>
        <p>You can access ACP here.</p>
    </a>
</asp:Content>


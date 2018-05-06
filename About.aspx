<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="About.aspx.vb" Inherits="About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
<style type="text/css">
    h2 { margin-top: 50px; }
    .Badge:hover { background-color: #CCC; }
    .Badge
    {
        float: left;
        padding: 8px;
        margin: 12px;
        width: 160px;
        height: 160px;
        text-align: center;
        box-shadow: 0px 0px 3px 1px;
        border-radius: 5px;
    }
    .scoreInfo tr:hover { cursor: default; background-color:#CCC; }
    .scoreInfo, .scoreInfo td { padding: 2px; border: 1px solid black; }
    .scoreInfo { font-size:18px; border-collapse:collapse; }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
<h2>Website access by Role</h2>
<div class="accordine" style="width:300px;">
    <h2>Guest Users</h2>
    <ul>
        <li>Solve Exercices</li>
        <li>View Highscores</li>
    </ul>
    <h2>Registred Users</h2>
    <ul>
        <li>Profile Access</li>
        <li>Solve Exercices</li>
        <li>View Highscores</li>
        <li>Badges and Score</li>
    </ul>
    <h2>Administrator Users</h2>
    <ul>
        <li>Profile Access</li>
        <li>Solve Exercices</li>
        <li>View Highscores</li>
        <li>Badges and Score</li>
        <li>Manage Users</li>
        <li>Insert Exercices</li>
        <li>Manage Exercices</li>
    </ul>
</div>

<h2>Exercice Score</h2>
<p>In ZETTCA Academy, the Score Awarded to the User is color-coded.</p>
<table class="scoreInfo">
    <tr>
        <td style="background-color:Green;">GREEN</td>
        <td>Total Score</td>
        <td>If you <u>answered correctly on the first try</u></td>
    </tr>
    <tr>
        <td style="background-color:Yellow;">YELLOW</td>
        <td>Half Score</td>
        <td>If you <u>asked for the hint</u> or <u>answered wrong at least once</u></td>
    </tr>
    <tr>
        <td style="background-color:Orange;">ORANGE</td>
        <td>50 Score</td>
        <td>If your <u>already solved the exercice</u></td>
    </tr>
    <tr>
        <td style="background-color:Red;">RED</td>
        <td>0 Score</td>
        <td>If you <u>changed page</u> or <u>asked for the answer</u></td>
    </tr>
</table>
<p><u>Total</u> Score varies on the exercice type and Badges earned.</p>

<h2>Exercice Badges</h2>
<p>Each time you achieve something relevant by solving an exercice for the first time, you will earn a Badge for your achievement.</p>
<p>The current Badges are:</p>
    <asp:ListView ID="lvBadges" runat="server" DataSourceID="dsBadges" ItemPlaceholderID="iContain">
        <ItemTemplate>
            <div runat="server" class="Badge">
                <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' Font-Size="22px" />
                <br />
                <img src="resources/image/badge/<%# Eval("ImageURL") %>" alt="<%# Eval("Title") %>" width="64px"/>
                <br />
                <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
            </div>
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server" style="min-height:500px;">
                <div id="iContain" runat="server"></div>
            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="dsBadges" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT [Title], [Description], [ImageURL] FROM [tableBadges]">
    </asp:SqlDataSource>
</asp:Content>


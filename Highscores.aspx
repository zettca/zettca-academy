<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Highscores.aspx.vb" Inherits="Highscores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">      
    .spaceMe { float: left; margin: 20px; }
    .highscores { box-shadow: 0px 0px 2px 1px; }
    .highscores tr { cursor: pointer; }
    .highscores tr:hover { background-color: #AAA; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
    <asp:GridView ID="gvHighscores" runat="server" 
        AutoGenerateColumns="False" BorderColor="Black" 
        BorderStyle="Solid" BorderWidth="2px" CellPadding="4" DataKeyNames="idUser" 
        DataSourceID="dsHighscores" ForeColor="Black" GridLines="Horizontal" 
        Width="350px" CssClass="highscores spaceMe">
        <Columns>
            <asp:CommandField ShowSelectButton="True" SelectText="" />
            <asp:TemplateField>
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Score" HeaderText="Score" SortExpression="Score" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="RealName" HeaderText="Real Name" 
                SortExpression="RealName" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="#993333" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#242121" />
    </asp:GridView>
    <asp:Panel ID="panUserMore" runat="server" CssClass="spaceMe">
        <asp:Image ID="imgAvatar" runat="server" Height="128px" /> <br />
        <p><asp:Label ID="lblName" runat="server" Font-Size="22px"></asp:Label></p>
        <p><asp:Label ID="lblRegDate" runat="server"></asp:Label></p>
        <div class="badgeArea">
            <asp:ListView ID="lvBadges" runat="server" DataSourceID="dsBadgesGV">
                <EmptyDataTemplate>
                    <table style="">
                        <tr>
                            <td>This user has no badges..</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <td id="Td1" runat="server" style="width:64px;">
                        <img src="resources/image/badge/<%# Eval("ImageURL") %>" alt="<%# Eval("Title") %>" title="<%# Eval("Title") %>. <%# Eval("Description") %>" width="40px"/>
                        <br />
                        <label>&nbsp;&nbsp;x<%# Eval("ammount") %></label></td>
                </ItemTemplate>
                <LayoutTemplate>
                    <table id="Table1" runat="server" style="width:200px;">
                        <tr ID="itemPlaceholderContainer" runat="server">
                            <td ID="itemPlaceholder" runat="server">
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
        </div>
    </asp:Panel>
    <asp:SqlDataSource ID="dsBadgesGV" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT tableBadges.Title, tableBadges.Description, tableBadges.ImageURL, tableBadgesUsers.ammount, tableBadgesUsers.idUser FROM tableBadgesUsers INNER JOIN tableBadges ON tableBadgesUsers.idBadge = tableBadges.idBadge WHERE (idUser = @IDU)">
        <SelectParameters>
            <asp:SessionParameter Name="IDU" SessionField="ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsHighscores" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT * FROM tableUsers WHERE (Score &gt; 0) ORDER BY Score DESC">
    </asp:SqlDataSource>
</asp:Content>
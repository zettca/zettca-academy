<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Exercices.aspx.vb" Inherits="Exercices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
    .rightAnswer, .rightAnswer:hover { background-color: #33CC33; }
    .wrongAnswer, .wrongAnswer:hover { background-color: #CC3333; }
    .backToMenu, .backToMenu:hover { background-color: #CCCC33; }
    .btn-width { width: 200px; }
    .tableBadges1 { opacity: 0.8; }
    .tableBadges2 { opacity: 0.4; }
    .question { font-size: 20px; margin-bottom: 20px; }
    .divAnswer { margin: 20px 0; }
    .questionArea { float: left; }
    .configs { margin: 30px; }
    .solveArea
    {
        float: right;
        margin: 10px;
        padding: 10px;
        position: relative;
        max-width: 300px;
    }
    .btn-start
    {
        height: 32px;
        font-size: 18px;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
    <asp:Panel ID="panConfig" runat="server" Visible="False" CssClass="configs">
        <p style="font-size:22px;">Practice
        <asp:DropDownList ID="ddlClass" runat="server" Font-Size="19px">
            <asp:ListItem Value="ANY">Any Class</asp:ListItem>
            <asp:ListItem>Maths</asp:ListItem>
            <asp:ListItem>Science</asp:ListItem>
            <asp:ListItem>Music</asp:ListItem>
            <asp:ListItem>History</asp:ListItem>
            <asp:ListItem>Computing</asp:ListItem>
            <asp:ListItem>Gaming</asp:ListItem>
            <asp:ListItem>Other</asp:ListItem>
        </asp:DropDownList>
        exercices.</p>

        <asp:Button ID="btnStart" CssClass="btn-class btn-start" runat="server" Text="Start Solving Exercices" />

        <br /> <br /> <br /> <br />
        Fore more information about our Exercice System and Users, please visit our 
        <asp:HyperLink ID="HyperLinkAbout" runat="server" NavigateUrl="~/About.aspx">About Page</asp:HyperLink>.
    </asp:Panel>
    <asp:Panel ID="panSolve" runat="server" Visible="False">
        <asp:Panel ID="panQuestionPart" runat="server" CssClass="questionArea">
            <asp:Label ID="lblQuestion" runat="server" CssClass="question"></asp:Label>
            <div id="divResImage" runat="server">
                <asp:Image ID="imgQuestion" runat="server" Height="200px" />
            </div>
            <div id="divResAudio" runat="server"></div>
            <div id="divResVideo" runat="server"></div>
            <br />
            <asp:Label ID="lblHint" runat="server"></asp:Label><br />
            <asp:Label ID="lblAnswer" runat="server"></asp:Label><br />
        </asp:Panel>
        <asp:Panel ID="panOptionPart" runat="server" CssClass="solveArea" DefaultButton="btnOK">
            <table id="tableBadges" runat="server" class="tableBadges1">
                <tr>
                    <td id="trLight" runat="server"><asp:Image ID="imgLightning" runat="server" Height="40px" ImageUrl="~/resources/image/badge/lightning.png" ToolTip="Answered fast and correctly." /></td>
                    <td id="trRocket" runat="server"><asp:Image ID="imgRocket" runat="server" Height="40px" ImageUrl="~/resources/image/badge/rocket.png" ToolTip="Answered 5 exercices correctly in a row." /></td>
                    <td id="trPussy" runat="server"><asp:Image ID="imgPussy" runat="server" Height="40px" ImageUrl="~/resources/image/badge/pussy.png" ToolTip="Asked for a hint." /></td>
                    <td id="trBaron" runat="server"><asp:Image ID="imgBaron" runat="server" Height="40px" ImageUrl="~/resources/image/badge/baron.png" ToolTip="Cheated through changing page." /></td>
                    <td id="trNoob" runat="server"><asp:Image ID="imgNoob" runat="server" Height="40px" ImageUrl="~/resources/image/badge/starter.png" ToolTip="Took a long time to answer." /></td>
                    <td id="trNerd" runat="server"><asp:Image ID="imgNerd" runat="server" Height="40px" ImageUrl="~/resources/image/badge/nerd.png" ToolTip="Asked for the answer." /></td>
                    <td id="trZealot" runat="server"><asp:Image ID="imgZealot" runat="server" Height="40px" ImageUrl="~/resources/image/badge/zealot.png" ToolTip="Answered instantly." /></td>
                </tr>
            </table>
            <asp:TextBox ID="txtAnswer" runat="server" Width="200px" autocomplete="off"></asp:TextBox>
            <asp:RadioButtonList ID="rblBoolean" runat="server">
                <asp:ListItem>True</asp:ListItem>
                <asp:ListItem>False</asp:ListItem>
            </asp:RadioButtonList>
            <asp:RadioButtonList ID="rblChoice" runat="server" DataSourceID="dsOptions" 
                DataTextField="OptionTEXT" DataValueField="Answer">
            </asp:RadioButtonList>
            <asp:CheckBoxList ID="cblSelection" runat="server" DataSourceID="dsOptions" 
                DataTextField="OptionTEXT" DataValueField="Answer">
            </asp:CheckBoxList>
            <br />
            <asp:Label ID="lblScore" runat="server" Font-Size="12px"></asp:Label>
            <div id="divAnswerBoomBoom" class="divAnswer" runat="server">
                <asp:Button ID="btnOK" runat="server" CssClass="btn-class btn-width" Text="Submit Answer" />
            </div>
            <asp:Button ID="btnHint" runat="server" CssClass="btn-class btn-width" />
        </asp:Panel>
    </asp:Panel>

    <asp:HiddenField ID="hfUserScore" runat="server" />
    <asp:HiddenField ID="hfBadgeIDSearch" runat="server" />
    <asp:HiddenField ID="hfBadgeAmmount" runat="server" />

    <asp:SqlDataSource ID="dsExercices" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlClass" Name="Class" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsOptions" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
        SelectCommand="SELECT idQuestion, OptionTEXT, Answer FROM tableOptionsQuestions WHERE (idQuestion = @QuestionID)">
        <SelectParameters>
            <asp:SessionParameter Name="QuestionID" SessionField="QID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsAnswered" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        InsertCommand="INSERT INTO tableQuestionsUsers(idUser, idQuestion) VALUES (@IDU, @IDQ)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
        SelectCommand="SELECT idUser, idQuestion FROM tableQuestionsUsers WHERE (idUser = @idUser) AND (idQuestion = @idQuest)">
        <InsertParameters>
            <asp:SessionParameter Name="IDU" SessionField="ID" />
            <asp:SessionParameter Name="IDQ" SessionField="QID" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="idQuest" SessionField="QID" />
            <asp:SessionParameter Name="idUser" SessionField="ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsPutBadge" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        InsertCommand="INSERT INTO tableBadgesUsers(idUser, idBadge, ammount) VALUES (@UID, @BID, @amm)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
        SelectCommand="SELECT idUser, idBadge, ammount FROM tableBadgesUsers WHERE (idUser = @IDU) AND (idBadge = @IDB)" 
        UpdateCommand="UPDATE tableBadgesUsers SET ammount = @hfAmm WHERE (idUser = @IDU) AND (idBadge = 2)">
        <InsertParameters>
            <asp:SessionParameter Name="UID" SessionField="ID" />
            <asp:Parameter Name="BID" />
            <asp:Parameter Name="amm" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="IDU" SessionField="ID" />
            <asp:ControlParameter ControlID="hfBadgeIDSearch" Name="IDB" 
                PropertyName="Value" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="hfBadgeAmmount" Name="hfAmm" 
                PropertyName="Value" />
            <asp:SessionParameter Name="IDU" SessionField="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsUserScore" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
        SelectCommand="SELECT idUser, Score FROM tableUsers WHERE (idUser = @IDU)" 
        UpdateCommand="UPDATE tableUsers SET Score = @score WHERE (idUser = @UID)">
        <SelectParameters>
            <asp:SessionParameter Name="IDU" SessionField="ID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="hfUserScore" Name="score" 
                PropertyName="Value" />
            <asp:SessionParameter Name="UID" SessionField="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <input type="hidden" id="hfFocus" runat="server" class="hfFocus" />
    <asp:ScriptManager ID="ScriptManagere" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanele" runat="server">
        <ContentTemplate>
            <asp:Timer ID="timerCount" runat="server" Interval="1000"></asp:Timer>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
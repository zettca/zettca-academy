<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Admin.aspx.vb" Inherits="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
<style type="text/css">
    .cursore { float: left; margin-right: 10px; margin-bottom: 20px; }
    .cursore tr { cursor: pointer; }
    .txtOption { width: 250px !important; }
    .txtHint { width: 220px !important; }
    .separator { padding-right: 20px; }
    .goFloat { float: left; }
    .goDivStyle
    {
        font-size: 20px;
        font-family: inherit;
        background: transparent; 
        border: 1px solid silver;
        line-height: 15px; 
        vertical-align: middle; 
    }
    .btn-menu
    {
        position: relative;
        top: -100px;
    }
    .txtQuestion
    {
        width: 500px !important;
        height: 24px !important;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
    <div id="topMenu" runat="server" class="btn-menu">
        <asp:Button ID="btnInsertExercices" CssClass="btn-class" runat="server" Text="Insert Exercices" />
        <asp:Button ID="btnManageExercices" CssClass="btn-class" runat="server" Text="Manage Exercices" />
        <asp:Button ID="btnManageUsers" CssClass="btn-class" runat="server" Text="Manage Users" />
        <br />
        <a name="anchore"></a>
    </div>
    <div id="pageMenu" runat="server">
        <asp:Button ID="btnMenuInsertExercices" Text="Insert Exercices" runat="server" CssClass="box-menu goDivStyle"></asp:Button>
        <asp:Button ID="btnMenuManageExercices" Text="Manage Exercices" runat="server" CssClass="box-menu goDivStyle"></asp:Button>
        <asp:Button ID="btnMenuManageUsers" Text="Manage Users" runat="server" CssClass="box-menu goDivStyle"></asp:Button>
    </div>
    <asp:Panel ID="panExercicesInsert" runat="server">
        <asp:DropDownList ID="ddlTypes" runat="server" AutoPostBack="True" 
            Font-Size="17px">
            <asp:ListItem Value="0">[Select Question Type]</asp:ListItem>
            <asp:ListItem Value="Choice">Multiple Choice</asp:ListItem>
            <asp:ListItem Value="Selection">Multiple Selection</asp:ListItem>
            <asp:ListItem Value="Boolean">True or False</asp:ListItem>
            <asp:ListItem Value="Text">Text Answer</asp:ListItem>
        </asp:DropDownList>
        <br /> <br /> <br />
        <asp:Panel ID="panCreateExercice" runat="server">
            <asp:TextBox ID="txtQuestion" runat="server" CssClass="txtQuestion" placeholder="Question"></asp:TextBox><br />
            <asp:HiddenField ID="hfFilePath" runat="server" />
            <table>
                <tr style="height:28px;">
                    <td class="separator"><asp:CheckBox ID="cbHint" runat="server" Text="Hint" AutoPostBack="True" /></td>
                    <td><asp:TextBox ID="txtHint" runat="server" placeholder="Hint" CssClass="txtHint"></asp:TextBox></td>
                </tr>
                <tr style="height:28px;">
                    <td class="separator"><asp:CheckBox ID="cbFile" runat="server" Text="File" AutoPostBack="True" /></td>
                    <td><asp:FileUpload ID="fuFILE" runat="server" /></td>
                </tr>
            </table>
            <br />
            <asp:Panel ID="panChoice" runat="server">
                Fill options and check the correct one: <br />
                <asp:RadioButton ID="rbChoice1" runat="server" GroupName="Choice" 
                    TabIndex="-1" /><asp:TextBox ID="txtChoice1" runat="server" CssClass="txtOption"></asp:TextBox><br />
                <asp:RadioButton ID="rbChoice2" runat="server" GroupName="Choice" 
                    TabIndex="-1" /><asp:TextBox ID="txtChoice2" runat="server" CssClass="txtOption"></asp:TextBox><br />
                <asp:RadioButton ID="rbChoice3" runat="server" GroupName="Choice" 
                    TabIndex="-1" /><asp:TextBox ID="txtChoice3" runat="server" CssClass="txtOption"></asp:TextBox><br />
                <asp:RadioButton ID="rbChoice4" runat="server" GroupName="Choice" 
                    TabIndex="-1" /><asp:TextBox ID="txtChoice4" runat="server" CssClass="txtOption"></asp:TextBox><br />
            </asp:Panel>
            <asp:Panel ID="panSelection" runat="server">
                Fill options and select those that are correct: <br />
                <asp:CheckBox ID="cbSelection1" runat="server" TabIndex="-1" /><asp:TextBox ID="txtSelection1" runat="server" CssClass="txtOption"></asp:TextBox><br />
                <asp:CheckBox ID="cbSelection2" runat="server" TabIndex="-1" /><asp:TextBox ID="txtSelection2" runat="server" CssClass="txtOption"></asp:TextBox><br />
                <asp:CheckBox ID="cbSelection3" runat="server" TabIndex="-1" /><asp:TextBox ID="txtSelection3" runat="server" CssClass="txtOption"></asp:TextBox><br />
                <asp:CheckBox ID="cbSelection4" runat="server" TabIndex="-1" /><asp:TextBox ID="txtSelection4" runat="server" CssClass="txtOption"></asp:TextBox><br />
            </asp:Panel>
            <asp:Panel ID="panBoolean" runat="server">
                Choose wether the Statement is True or False: <br />
                <asp:RadioButtonList ID="rblBoolean" runat="server" 
                    RepeatDirection="Horizontal">
                    <asp:ListItem>True</asp:ListItem>
                    <asp:ListItem>False</asp:ListItem>
                </asp:RadioButtonList>
            </asp:Panel>
            <asp:Panel ID="panText" runat="server">
                Fill in the Text Answer: <br />
                <asp:TextBox ID="txtAnswer" runat="server" placeholder="Answer" CssClass="txtOption"></asp:TextBox><br />
            </asp:Panel>
            <br />
            Class:
            <asp:RadioButtonList ID="rblClasses" runat="server" CssClass="horizontal" 
                RepeatDirection="Horizontal">
                <asp:ListItem>Maths</asp:ListItem>
                <asp:ListItem>Science</asp:ListItem>
                <asp:ListItem>Music</asp:ListItem>
                <asp:ListItem>History</asp:ListItem>
                <asp:ListItem>Computing</asp:ListItem>
                <asp:ListItem>Gaming</asp:ListItem>
                <asp:ListItem>Other</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            <asp:SqlDataSource ID="dsChoice" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                InsertCommand="INSERT INTO tableQuestions(QuestionTXT, QuestionURL, Hint, Class, Type, Creator) VALUES (@QuestionTXT, @QuestionURL, @Hint, @Class, @Type, @Creator) SELECT @ID = Scope_Identity()">
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtQuestion" Name="QuestionTXT" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="hfFilePath" Name="QuestionURL" 
                        PropertyName="Value" />
                    <asp:ControlParameter ControlID="txtHint" Name="Hint" PropertyName="Text" />
                    <asp:ControlParameter ControlID="rblClasses" Name="Class" 
                        PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="ddlTypes" Name="Type" 
                        PropertyName="SelectedValue" />
                    <asp:SessionParameter Name="Creator" SessionField="User" />
                    <asp:Parameter Direction="Output" Name="ID" Type="Int16" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsSelection" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                InsertCommand="INSERT INTO tableQuestions(QuestionTXT, QuestionURL, Hint, Class, Type, Creator) VALUES (@QuestionTXT, @QuestionURL, @Hint, @Class, @Type, @Creator) SELECT @ID = Scope_Identity()">
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtQuestion" Name="QuestionTXT" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="hfFilePath" Name="QuestionURL" 
                        PropertyName="Value" />
                    <asp:ControlParameter ControlID="txtHint" Name="Hint" PropertyName="Text" />
                    <asp:ControlParameter ControlID="rblClasses" Name="Class" 
                        PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="ddlTypes" Name="Type" 
                        PropertyName="SelectedValue" />
                    <asp:SessionParameter Name="Creator" SessionField="User" />
                    <asp:Parameter Direction="Output" Name="ID" Type="Int16" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsBoolean" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                InsertCommand="INSERT INTO tableQuestions(QuestionTXT, QuestionURL, AnswerTXT, Hint, Class, Type, Creator) VALUES (@QuestionTXT, @QuestionURL, @AnswerTXT, @Hint, @Class, @Type, @Creator)">
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtQuestion" Name="QuestionTXT" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="hfFilePath" Name="QuestionURL" 
                        PropertyName="Value" />
                    <asp:ControlParameter ControlID="rblBoolean" Name="AnswerTXT" 
                        PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="txtHint" Name="Hint" PropertyName="Text" />
                    <asp:ControlParameter ControlID="rblClasses" Name="Class" 
                        PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="ddlTypes" Name="Type" 
                        PropertyName="SelectedValue" />
                    <asp:SessionParameter Name="Creator" SessionField="User" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsText" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                InsertCommand="INSERT INTO tableQuestions(QuestionTXT, QuestionURL, AnswerTXT, Hint, Class, Type, Creator) VALUES (@QuestionTXT, @QuestionURL, @AnswerTXT, @Hint, @Class, @Type, @Creator)" 
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtQuestion" Name="QuestionTXT" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="hfFilePath" Name="QuestionURL" 
                        PropertyName="Value" />
                    <asp:ControlParameter ControlID="txtAnswer" Name="AnswerTXT" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtHint" Name="Hint" PropertyName="Text" />
                    <asp:ControlParameter ControlID="rblClasses" Name="Class" 
                        PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="ddlTypes" Name="Type" 
                        PropertyName="SelectedValue" />
                    <asp:SessionParameter Name="Creator" SessionField="User" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsOptionChoice" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" InsertCommand="INSERT INTO tableOptionsQuestions
        SELECT @LastID, @t1, @a1 UNION ALL
        SELECT @LastID, @t2, @a2 UNION ALL
        SELECT @LastID, @t3, @a3 UNION ALL
        SELECT @LastID, @t4, @a4" 
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:SessionParameter Name="LastID" SessionField="LID" />
                    <asp:ControlParameter ControlID="txtChoice1" Name="t1" PropertyName="Text" />
                    <asp:ControlParameter ControlID="rbChoice1" Name="a1" PropertyName="Checked" />
                    <asp:ControlParameter ControlID="txtChoice2" Name="t2" PropertyName="Text" />
                    <asp:ControlParameter ControlID="rbChoice2" Name="a2" PropertyName="Checked" />
                    <asp:ControlParameter ControlID="txtChoice3" Name="t3" PropertyName="Text" />
                    <asp:ControlParameter ControlID="rbChoice3" Name="a3" PropertyName="Checked" />
                    <asp:ControlParameter ControlID="txtChoice4" Name="t4" PropertyName="Text" />
                    <asp:ControlParameter ControlID="rbChoice4" Name="a4" PropertyName="Checked" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsOptionSelect" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" InsertCommand="INSERT INTO tableOptionsQuestions
        SELECT @LastID, @t1, @a1 UNION ALL
        SELECT @LastID, @t2, @a2 UNION ALL
        SELECT @LastID, @t3, @a3 UNION ALL
        SELECT @LastID, @t4, @a4" 
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:SessionParameter Name="LastID" SessionField="LID" />
                    <asp:ControlParameter ControlID="txtSelection1" Name="t1" PropertyName="Text" />
                    <asp:ControlParameter ControlID="cbSelection1" Name="a1" 
                        PropertyName="Checked" />
                    <asp:ControlParameter ControlID="txtSelection2" Name="t2" PropertyName="Text" />
                    <asp:ControlParameter ControlID="cbSelection2" Name="a2" 
                        PropertyName="Checked" />
                    <asp:ControlParameter ControlID="txtSelection3" Name="t3" PropertyName="Text" />
                    <asp:ControlParameter ControlID="cbSelection3" Name="a3" 
                        PropertyName="Checked" />
                    <asp:ControlParameter ControlID="txtSelection4" Name="t4" PropertyName="Text" />
                    <asp:ControlParameter ControlID="cbSelection4" Name="a4" 
                        PropertyName="Checked" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:Button ID="btnInsertQuestion" runat="server" CssClass="btn-class" Text="Insert Survey" />
            <asp:Label ID="lblAddExerciceErrors" runat="server" ForeColor="Red"></asp:Label>
        </asp:Panel>
    </asp:Panel>

    <asp:Panel ID="panExercicesManage" runat="server" style="min-height:500px;">
        <asp:GridView ID="gvQuestions" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" BackColor="White" 
            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
            DataKeyNames="idQuestion" DataSourceID="dsQuestionsGV" ForeColor="Black" 
            GridLines="Horizontal" PageSize="8" Width="600px" Font-Size="13px" CssClass="cursore">
            <Columns>
                <asp:CommandField SelectText="" ShowSelectButton="True" />
                <asp:BoundField DataField="QuestionTXT" HeaderText="Question" 
                    SortExpression="QuestionTXT">
                <ControlStyle Width="500px" />
                </asp:BoundField>
                <asp:BoundField DataField="Class" HeaderText="Class" SortExpression="Class" />
                <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
            </Columns>
            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" 
                HorizontalAlign="Left" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#883333" Font-Bold="False" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
        </asp:GridView>
        <asp:SqlDataSource ID="dsQuestionsGV" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            DeleteCommand="DELETE FROM [tableQuestions] WHERE [idQuestion] = @idQuestion" 
            InsertCommand="INSERT INTO [tableQuestions] ([QuestionTXT], [QuestionURL], [AnswerTXT], [Hint], [Class], [Type], [Creator]) VALUES (@QuestionTXT, @QuestionURL, @AnswerTXT, @Hint, @Class, @Type, @Creator)" 
            SelectCommand="SELECT * FROM [tableQuestions] ORDER BY [idQuestion]" 
            UpdateCommand="UPDATE [tableQuestions] SET [QuestionTXT] = @QuestionTXT, [QuestionURL] = @QuestionURL, [AnswerTXT] = @AnswerTXT, [Hint] = @Hint, [Class] = @Class, [Type] = @Type, [Creator] = @Creator WHERE [idQuestion] = @idQuestion">
            <DeleteParameters>
                <asp:Parameter Name="idQuestion" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="QuestionTXT" Type="String" />
                <asp:Parameter Name="QuestionURL" Type="String" />
                <asp:Parameter Name="AnswerTXT" Type="String" />
                <asp:Parameter Name="Hint" Type="String" />
                <asp:Parameter Name="Class" Type="String" />
                <asp:Parameter Name="Type" Type="String" />
                <asp:Parameter Name="Creator" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="QuestionTXT" Type="String" />
                <asp:Parameter Name="QuestionURL" Type="String" />
                <asp:Parameter Name="AnswerTXT" Type="String" />
                <asp:Parameter Name="Hint" Type="String" />
                <asp:Parameter Name="Class" Type="String" />
                <asp:Parameter Name="Type" Type="String" />
                <asp:Parameter Name="Creator" Type="String" />
                <asp:Parameter Name="idQuestion" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="dsQuestionDetails" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
            SelectCommand="SELECT idQuestion, QuestionTXT, QuestionURL, AnswerTXT, Hint, Class, Type, Creator FROM tableQuestions WHERE (idQuestion = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="gvQuestions" Name="ID" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Panel ID="panQuestionDetails" runat="server" CssClass="goFloat">
            <table>
                <tr>
                    <td align="right"><asp:Label ID="lblForQuestion" runat="server" AssociatedControlID="txtQuestionUpdate" Text="Question: "></asp:Label></td>
                    <td><asp:TextBox ID="txtQuestionUpdate" runat="server" CssClass="txtOption"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="right"><asp:Label ID="lblforClass" runat="server" AssociatedControlID="ddlClassUpdate" Text="Class: "></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlClassUpdate" runat="server">
                            <asp:ListItem>Maths</asp:ListItem>
                            <asp:ListItem>Science</asp:ListItem>
                            <asp:ListItem>Music</asp:ListItem>
                            <asp:ListItem>History</asp:ListItem>
                            <asp:ListItem>Computing</asp:ListItem>
                            <asp:ListItem>Gaming</asp:ListItem>
                            <asp:ListItem>Other</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right"><asp:Label ID="lblFor" runat="server" AssociatedControlID="fuUpdateFile" Text="File: "></asp:Label></td>
                    <td><asp:FileUpload ID="fuUpdateFile" runat="server" /></td>
                </tr>
                <tr>
                    <td align="right"><asp:Label ID="lblForHint" runat="server" AssociatedControlID="txtHintUpdate" Text="Hint: "></asp:Label></td>
                    <td><asp:TextBox ID="txtHintUpdate" runat="server" CssClass="txtOption"></asp:TextBox></td>
                </tr>
                <tr id="trAnswer" runat="server">
                    <td align="right"><asp:Label ID="lblForAnswer" runat="server" AssociatedControlID="txtAnswerUpdate" Text="Answer: "></asp:Label></td>
                    <td><asp:TextBox ID="txtAnswerUpdate" runat="server" CssClass="txtOption"></asp:TextBox></td>
                </tr>
            </table>
            <asp:RadioButtonList ID="rblBooleanUpdate" runat="server">
                <asp:ListItem>True</asp:ListItem>
                <asp:ListItem>False</asp:ListItem>
            </asp:RadioButtonList>
            <asp:RadioButtonList ID="rblChoiceUpdate" runat="server" 
                DataSourceID="dsFillUpdate" DataTextField="OptionTEXT" 
                DataValueField="Answer">
            </asp:RadioButtonList>
            <asp:CheckBoxList ID="cblSelectionUpdate" runat="server" 
                DataSourceID="dsFillUpdate" DataTextField="OptionTEXT" 
                DataValueField="Answer">
            </asp:CheckBoxList>
            <asp:HiddenField ID="hfFilePathUpdate" runat="server" />
            <asp:SqlDataSource ID="dsFillUpdate" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                SelectCommand="SELECT OptionTEXT, Answer, idQuestion FROM tableOptionsQuestions WHERE (idQuestion = @ID)" 
                UpdateCommand="UPDATE tableQuestions SET QuestionTXT = @questTXT, QuestionURL = @questURL, AnswerTXT = @answer, Hint = @hint WHERE (idQuestion = @ID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvQuestions" Name="ID" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="txtQuestionUpdate" Name="questTXT" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="fuUpdateFile" Name="questURL" 
                        PropertyName="FileBytes" />
                    <asp:ControlParameter ControlID="txtAnswerUpdate" Name="answer" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtHintUpdate" Name="hint" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="ddlClassUpdate" Name="class" 
                        PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="gvQuestions" Name="ID" 
                        PropertyName="SelectedValue" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsAvatarUpdate" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                UpdateCommand="UPDATE tableUsers SET Avatar = @avatar WHERE (idUser = @UID)">
                <UpdateParameters>
                    <asp:ControlParameter ControlID="hfUpdateAvatar" Name="avatar" 
                        PropertyName="Value" />
                    <asp:ControlParameter ControlID="gvUsers" Name="UID" 
                        PropertyName="SelectedValue" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Button ID="btnQuestionUpdate" runat="server" CssClass="btn-class" Text="Update Exercice" />
            or 
            <asp:Button ID="btnDeleteExercice" runat="server" CssClass="btn-class" 
                Text="Delete Exercice" 
                onclientclick="return confirm('Deleting selected exercice. Are you sure?')" />
        </asp:Panel>
    </asp:Panel>

    <asp:Panel ID="panUsersManage" runat="server" style="min-height:500px;">
        <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" 
            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
            CellPadding="4" DataKeyNames="idUser" DataSourceID="dsUsersUpdateGV" 
            Font-Size="12px" ForeColor="Black" GridLines="Horizontal" Width="500px" 
            AllowSorting="True" PageSize="7" CssClass="cursore" AllowPaging="True">
            <Columns>
                <asp:CommandField ShowSelectButton="True" SelectText="" />
                <asp:BoundField DataField="Username" HeaderText="Username" 
                    SortExpression="Username" />
                <asp:BoundField DataField="RealName" HeaderText="Real Name" 
                    SortExpression="RealName" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="Score" HeaderText="Score" SortExpression="Score" />
                <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role" />
            </Columns>
            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" 
                HorizontalAlign="Left" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#883333" Font-Bold="False" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
        </asp:GridView>
        <div style="float:left;">
            <asp:SqlDataSource ID="dsUsersUpdateGV" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT * FROM [tableUsers]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="dsUsersDetails" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                SelectCommand="SELECT idUser, Username, Password, Email, RealName, Avatar, Score, Role, RegDate, Settings FROM tableUsers WHERE (idUser = @idUser)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvUsers" Name="idUser" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="panUpdateUser" runat="server">
                <table>
                    <tr>
                        <td><asp:Label ID="lblForUser" runat="server" Text="Username: " AssociatedControlID="txtUserUpdate"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="txtUserUpdate" runat="server" Width="200px" Enabled="False"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="fvUser" runat="server" ControlToValidate="txtUserUpdate" ErrorMessage="Username" ToolTip="Username is required.">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblForPass" runat="server" Text="Password: " AssociatedControlID="txtPassUpdate"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="txtPassUpdate" runat="server" Width="200px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="fvPass" runat="server" ControlToValidate="txtPassUpdate" ErrorMessage="Password" ToolTip="Password is required.">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblForName" runat="server" Text="Real Name: " AssociatedControlID="txtNameUpdate"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="txtNameUpdate" runat="server" Width="200px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="fvName" runat="server" ControlToValidate="txtNameUpdate" ErrorMessage="Real Name" ToolTip="Name is required.">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblForMail" runat="server" Text="Email: " AssociatedControlID="txtMailUpdate"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="txtMailUpdate" runat="server" Width="200px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="fvMail1" runat="server" ControlToValidate="txtMailUpdate" ErrorMessage="Email" ToolTip="Email is required.">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="fvMail2" runat="server" ControlToValidate="txtMailUpdate" ErrorMessage="Email" ToolTip="Email must be valid." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblForAvatar" runat="server" Text="Avatar: " AssociatedControlID="fuAvatarUpdate"></asp:Label></td>
                        <td><asp:FileUpload ID="fuAvatarUpdate" runat="server" /></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblForRole" runat="server" Text="Role: " AssociatedControlID="ddlRoles"></asp:Label></td>
                        <td><asp:DropDownList ID="ddlRoles" runat="server"><asp:ListItem>Admin</asp:ListItem><asp:ListItem>User</asp:ListItem></asp:DropDownList></td>
                    </tr>
                </table>
                <br />

                <asp:ValidationSummary ID="vsUpdateUser" runat="server" HeaderText="Invalid input fields:" />
                <asp:HiddenField ID="hfUpdateAvatar" runat="server" />
                <asp:SqlDataSource ID="dsUpdateUser" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                    UpdateCommand="UPDATE tableUsers SET Password = @pass, RealName = @name, Email = @mail, Role = @role WHERE (idUser = @UID)">
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="gvUsers" Name="GVI" 
                            PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="txtPassUpdate" Name="pass" 
                            PropertyName="Text" />
                        <asp:ControlParameter ControlID="txtNameUpdate" Name="name" 
                            PropertyName="Text" />
                        <asp:ControlParameter ControlID="txtMailUpdate" Name="mail" 
                            PropertyName="Text" />
                        <asp:ControlParameter ControlID="ddlRoles" Name="role" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="gvUsers" Name="UID" 
                            PropertyName="SelectedValue" />
                        <asp:Parameter DefaultValue="0" Name="reset" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="dsResetScore" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                    UpdateCommand="UPDATE tableUsers SET Score = 0 WHERE (idUser = @UID)">
                    <UpdateParameters>
                        <asp:Parameter DefaultValue="0" Name="score" />
                        <asp:ControlParameter ControlID="gvUsers" Name="UID" 
                            PropertyName="SelectedValue" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:Button ID="btnUserUpdate" runat="server" CssClass="btn-class" Text="Update User" /> or 
                <asp:Button ID="btnResetUser" runat="server" CssClass="btn-class" 
                    Text="Reset User Information" 
                    OnClientClick="return confirm('This will delete all using information. Are you sure?')" />
            </asp:Panel>
        </div>
    </asp:Panel>

</asp:Content>
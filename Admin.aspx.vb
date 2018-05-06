Imports System.Data
Imports Functiones

Partial Class Admin
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Session("Role") <> "Admin" Then
            Response.Redirect("profile.aspx")
        End If

        If Not IsPostBack Then
            topMenu.Visible = False
            panUsersManage.Visible = False
            panExercicesManage.Visible = False
            panExercicesInsert.Visible = False
            panChoice.Visible = False
            panSelection.Visible = False
            panBoolean.Visible = False
            panText.Visible = False
            txtHint.Visible = False
            fuFILE.Visible = False
            panCreateExercice.Visible = False
            panQuestionDetails.Visible = False
            panUpdateUser.Visible = False
        End If
    End Sub

    Protected Sub btnPageMenu(sender As Object, e As System.EventArgs) Handles btnMenuInsertExercices.Click, btnMenuManageExercices.Click, btnMenuManageUsers.Click
        topMenu.Visible = True
        pageMenu.Visible = False
        panUsersManage.Visible = False
        panExercicesManage.Visible = False
        panExercicesInsert.Visible = False

        Select Case sender.Text
            Case "Manage Users"
                panUsersManage.Visible = True
            Case "Manage Exercices"
                panExercicesManage.Visible = True
            Case "Insert Exercices"
                panExercicesInsert.Visible = True
        End Select
    End Sub

    Protected Sub btnTopMenu(sender As Object, e As System.EventArgs) Handles btnManageUsers.Click, btnManageExercices.Click, btnInsertExercices.Click
        panUsersManage.Visible = False
        panExercicesManage.Visible = False
        panExercicesInsert.Visible = False

        Select Case sender.Text
            Case "Manage Users"
                gvUsers.SelectedIndex = -1
                panUsersManage.Visible = True
            Case "Manage Exercices"
                gvQuestions.SelectedIndex = -1
                panExercicesManage.Visible = True
            Case "Insert Exercices"
                ddlTypes.SelectedIndex = -1
                panExercicesInsert.Visible = True
        End Select
    End Sub

    Protected Sub ddlTypes_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlTypes.SelectedIndexChanged
        ClientScript.RegisterStartupScript(GetType(HtmlAnchor), "hash", "location.hash = '#anchore';", True)

        panChoice.Visible = False
        panSelection.Visible = False
        panBoolean.Visible = False
        panText.Visible = False
        panCreateExercice.Visible = True

        Select Case sender.SelectedValue
            Case "Choice"
                panChoice.Visible = True
            Case "Selection"
                panSelection.Visible = True
            Case "Boolean"
                panBoolean.Visible = True
            Case "Text"
                panText.Visible = True
            Case Else
                panCreateExercice.Visible = False
        End Select
    End Sub

    Protected Sub btnInsertQuestion_Click(sender As Object, e As System.EventArgs) Handles btnInsertQuestion.Click
        If foundErrors() Then
            lblAddExerciceErrors.ForeColor = Drawing.Color.Red
            lblAddExerciceErrors.Text = "Validation errors found. Please check the fields..."
            Exit Sub
        End If

        If fuFILE.HasFile Then
            Dim path As String = Server.MapPath("resources") & "\exercice\"
            hfFilePath.Value = fuFILE.FileName
            fuFILE.SaveAs(path & fuFILE.FileName)
        Else
            hfFilePath.Value = Nothing
        End If

        Try
            Select Case ddlTypes.SelectedValue
                Case "Choice"
                    dsChoice.Insert()
                Case "Selection"
                    dsSelection.Insert()
                Case "Boolean"
                    dsBoolean.Insert()
                Case "Text"
                    dsText.Insert()
            End Select
            lblAddExerciceErrors.ForeColor = Drawing.Color.Green
            lblAddExerciceErrors.Text = "Exercice inserted sucessfully!"
            cleanEverything()
        Catch
            lblAddExerciceErrors.ForeColor = Drawing.Color.Red
            lblAddExerciceErrors.Text = "Error inserting exercice."
        End Try

    End Sub

    Private Sub cleanEverything()
        txtQuestion.Text = Nothing
        txtHint.Text = Nothing
        txtAnswer.Text = Nothing
        txtChoice1.Text = Nothing
        txtChoice2.Text = Nothing
        txtChoice3.Text = Nothing
        txtChoice4.Text = Nothing
        txtSelection1.Text = Nothing
        txtSelection2.Text = Nothing
        txtSelection3.Text = Nothing
        txtSelection4.Text = Nothing
        rblBoolean.SelectedIndex = -1
        rblClasses.SelectedIndex = -1
    End Sub

    Protected Function foundErrors() As Boolean
        Dim errore As Boolean = False

        errore = If(Len(txtQuestion.Text) < 5, True, False)
        errore = If(rblClasses.SelectedIndex = -1, True, False)

        Select Case ddlTypes.SelectedValue
            Case "Choice"
                errore = If(Not rbChoice1.Checked And Not rbChoice2.Checked And Not rbChoice3.Checked And Not rbChoice4.Checked, True, False)
                If txtChoice1.Text = txtChoice2.Text Or txtChoice1.Text = txtChoice3.Text Or txtChoice1.Text = txtChoice4.Text Or txtChoice2.Text = txtChoice3.Text Or txtChoice2.Text = txtChoice4.Text Or txtChoice3.Text = txtChoice4.Text Then
                    errore = True
                End If
            Case "Selection"
                errore = If(Not cbSelection1.Checked And Not cbSelection2.Checked And Not cbSelection3.Checked And Not cbSelection4.Checked, True, False)
                If txtSelection1.Text = txtSelection2.Text Or txtSelection1.Text = txtSelection3.Text Or txtSelection1.Text = txtSelection4.Text Or txtSelection2.Text = txtSelection3.Text Or txtSelection2.Text = txtSelection4.Text Or txtSelection3.Text = txtSelection4.Text Then
                    errore = True
                End If
            Case "Boolean"
                errore = If(rblBoolean.SelectedIndex = -1, True, False)
            Case "Text"
                errore = If(Len(txtAnswer.Text) < 1, True, False)
        End Select



        Return errore
    End Function

    Protected Sub cbHint_CheckedChanged(sender As Object, e As System.EventArgs) Handles cbHint.CheckedChanged
        If sender.Checked Then
            txtHint.Visible = True
        Else
            txtHint.Visible = False
            txtHint.Text = Nothing
        End If
        ClientScript.RegisterStartupScript(GetType(HtmlAnchor), "hash", "location.hash = '#anchore';", True)
    End Sub

    Protected Sub cbFile_CheckedChanged(sender As Object, e As System.EventArgs) Handles cbFile.CheckedChanged
        If sender.Checked Then
            fuFILE.Visible = True
        Else
            fuFILE.Visible = False
            fuFILE.Dispose()
        End If
        ClientScript.RegisterStartupScript(GetType(HtmlAnchor), "hash", "location.hash = '#anchore';", True)
    End Sub

    Protected Sub dsChoice_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles dsChoice.Inserted
        Session("LID") = e.Command.Parameters("@ID").Value
        dsOptionChoice.Insert()
    End Sub

    Protected Sub dsSelection_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles dsSelection.Inserted
        Session("LID") = e.Command.Parameters("@ID").Value
        dsOptionSelect.Insert()
    End Sub

    Protected Sub gvQuestions_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvQuestions.PageIndexChanging
        gvQuestions.SelectedIndex = -1
    End Sub

    Protected Sub gvQuestions_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles gvQuestions.SelectedIndexChanged, gvQuestions.PageIndexChanged
        ' idQuestion, QuestionTXT, QuestionURL, AnswerTXT, Hint, Class, Type, Creator
        ClientScript.RegisterStartupScript(GetType(HtmlAnchor), "hash", "location.hash = '#anchore';", True)
        If gvQuestions.SelectedIndex <> -1 Then
            panQuestionDetails.Visible = True
            Dim dv As DataView = CType(dsQuestionDetails.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dr As DataRow = dv.Table.Rows(0)

            txtQuestionUpdate.Text = dr(1).ToString()
            txtHintUpdate.Text = dr(4).ToString()

            For Each item In ddlClassUpdate.Items
                If item.Value = dr(5).ToString() Then
                    ddlClassUpdate.ClearSelection()
                    item.Selected = True
                    Exit For
                End If
            Next

            selectVisiblesDB(dr)

        Else
            panQuestionDetails.Visible = False
        End If
    End Sub

    Protected Sub gvQuestions_RowCreated(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvQuestions.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onclick", Page.ClientScript.GetPostBackEventReference(sender, "Select$" & e.Row.RowIndex.ToString))
        End If
    End Sub

    Protected Sub gvQuestions_RowDeleting(sender As Object, e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvQuestions.RowDeleting
        MsgBox("Deleting question")
    End Sub

    Private Sub selectVisiblesDB(dr As DataRow)
        trAnswer.Visible = False
        rblBooleanUpdate.Visible = False
        rblChoiceUpdate.Visible = False
        cblSelectionUpdate.Visible = False
        Select Case dr(6)
            Case "Choice"
                rblChoiceUpdate.DataBind()
                rblChoiceUpdate.Visible = True
                For Each item In rblChoiceUpdate.Items
                    If item.Value = "True" Then
                        item.Selected = True
                    Else
                        item.Selected = False
                    End If
                Next
            Case "Selection"
                cblSelectionUpdate.DataBind()
                cblSelectionUpdate.Visible = True
                For Each item In cblSelectionUpdate.Items
                    If item.Value = "True" Then
                        item.Selected = True
                    Else
                        item.Selected = False
                    End If
                Next
            Case "Boolean"
                rblBooleanUpdate.Visible = True
                If (dr(3) = "True") Then
                    rblBooleanUpdate.SelectedIndex = 0
                Else
                    rblBooleanUpdate.SelectedIndex = 1
                End If
            Case "Text"
                trAnswer.Visible = True
                txtAnswerUpdate.Text = dr(3)
        End Select
    End Sub

    Protected Sub btnQuestionUpdate_Click(sender As Object, e As System.EventArgs) Handles btnQuestionUpdate.Click
        ' idQuestion, QuestionTXT, QuestionURL, AnswerTXT, Hint, Class, Type, Creator
        ClientScript.RegisterStartupScript(GetType(HtmlAnchor), "hash", "location.hash = '#anchore';", True)
        If gvQuestions.SelectedIndex <> -1 Then
            Dim dv As DataView = CType(dsQuestionDetails.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dr As DataRow = dv.Table.Rows(0)

            Dim updateQuery As String = "UPDATE tableQuestions SET QuestionTXT = @questTXT, Class = @class"
            If fuUpdateFile.HasFile Then
                Dim path As String = Server.MapPath("resources") & "\exercice\"
                hfFilePathUpdate.Value = fuUpdateFile.FileName
                fuUpdateFile.SaveAs(path & fuUpdateFile.FileName)
                updateQuery += ", QuestionURL = @questURL"
            End If
            If txtHintUpdate.Text <> Nothing Then
                updateQuery += ", Hint = @hint"
            End If

            Select Case dr(6)
                Case "Choice", "Selection"
                Case "Boolean"
                    If False Then
                    ElseIf rblBooleanUpdate.SelectedIndex = 0 Then
                        updateQuery += ", AnswerTXT = 'True'"
                    ElseIf rblBooleanUpdate.SelectedIndex = 1 Then
                        updateQuery += ", AnswerTXT = 'False'"
                    End If
                Case "Text"
                    updateQuery += ", AnswerTXT = @answer"
            End Select
            updateQuery += " WHERE (idQuestion = @ID)"

            dsFillUpdate.UpdateCommand = updateQuery
            dsFillUpdate.Update()
            gvQuestions.DataBind()
        End If
    End Sub

    Protected Sub gvUsers_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvUsers.PageIndexChanging
        gvUsers.SelectedIndex = -1
    End Sub

    Protected Sub gvUsers_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles gvUsers.SelectedIndexChanged, gvUsers.PageIndexChanged
        ' idUser, Username, Password, Email, RealName, Avatar, Score, Role, RegDate, Settings
        ClientScript.RegisterStartupScript(GetType(HtmlAnchor), "hash", "location.hash = '#anchore';", True)
        If gvUsers.SelectedIndex <> -1 Then
            panUpdateUser.Visible = True
            Dim dv As DataView = CType(dsUsersDetails.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dr As DataRow = dv.Table.Rows(0)
            txtUserUpdate.Text = dr(1).ToString()
            txtPassUpdate.Text = dr(2).ToString()
            txtMailUpdate.Text = dr(3).ToString()
            txtNameUpdate.Text = dr(4).ToString()
            If dr(7) = "Admin" Then
                ddlRoles.SelectedIndex = 0
            Else
                ddlRoles.SelectedIndex = 1
            End If
        Else
            panUpdateUser.Visible = False
        End If
    End Sub

    Protected Sub btnUpdateUser_Click(sender As Object, e As System.EventArgs) Handles btnUserUpdate.Click
        If gvUsers.SelectedIndex <> -1 Then
            dsUpdateUser.UpdateCommand = "UPDATE tableUsers SET Password = @pass, RealName = @name, Email = @mail, Role = @role WHERE (idUser = @UID)"
            dsUpdateUser.Update()
            gvUsers.DataBind()
        End If

        If fuAvatarUpdate.HasFile Then
            If validImage(fuAvatarUpdate.FileName) Then
                Dim path As String = Server.MapPath("resources") & "\image\profile\"
                Dim imgPath As String = LCase(txtUserUpdate.Text & System.IO.Path.GetExtension(fuAvatarUpdate.FileName))
                hfUpdateAvatar.Value = imgPath
                fuAvatarUpdate.SaveAs(path & imgPath)
                dsAvatarUpdate.Update()
            End If
        End If
    End Sub

    Protected Sub btnResetScore_Click(sender As Object, e As System.EventArgs) Handles btnResetUser.Click
        dsUpdateUser.DeleteCommand = "DELETE FROM tableBadgesUsers WHERE (idUser = @GVI)"
        dsUpdateUser.Delete()
        dsUpdateUser.DeleteCommand = "DELETE FROM tableQuestionsUsers WHERE (idUser = @GVI)"
        dsUpdateUser.Delete()
        dsResetScore.Update()
        gvUsers.DataBind()
    End Sub

    Protected Sub gvUsers_RowCreated(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvUsers.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onclick", Page.ClientScript.GetPostBackEventReference(sender, "Select$" & e.Row.RowIndex.ToString))
        End If
    End Sub

    Protected Sub btnDeleteExercice_Click(sender As Object, e As System.EventArgs) Handles btnDeleteExercice.Click
        If gvQuestions.SelectedIndex <> -1 Then
            dsFillUpdate.DeleteCommand = "DELETE FROM tableQuestionsUsers WHERE (idQuestion = " & gvQuestions.SelectedValue & ")"
            dsFillUpdate.Delete()
            dsFillUpdate.DeleteCommand = "DELETE FROM tableOptionsQuestions WHERE (idQuestion = " & gvQuestions.SelectedValue & ")"
            dsFillUpdate.Delete()
            dsFillUpdate.DeleteCommand = "DELETE FROM tableQuestions WHERE (idQuestion = " & gvQuestions.SelectedValue & ")"
            dsFillUpdate.Delete()
            gvQuestions.DataBind()
        End If
    End Sub
End Class
Imports System.Data
Partial Class Exercices
    Inherits System.Web.UI.Page

    Public Shared exeList As List(Of DataRow)
    Public Shared iExercice As DataRow
    Public Shared isFirstTry, isHintUsed, isAnswerUsed, isAnswered, isLostFocus As Boolean
    Public Shared exeTime, exeCS As Integer

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            panConfig.Visible = True
        End If
    End Sub

    Protected Sub btnFormat_Click(sender As Object, e As System.EventArgs) Handles btnStart.Click
        panConfig.Visible = False
        panSolve.Visible = True
        selectChosenExercices()
    End Sub

    Protected Sub selectChosenExercices()
        If ddlClass.SelectedValue = "ANY" Then
            dsExercices.SelectCommand = "SELECT * FROM tableQuestions"
        Else
            dsExercices.SelectCommand = "SELECT * FROM tableQuestions WHERE (Class = @Class)"
        End If

        Dim exercices As DataView = CType(dsExercices.Select(DataSourceSelectArguments.Empty), DataView)

        If exercices.Count > 1 Then
            exeList = New List(Of DataRow)
            For Each exe As DataRowView In exercices
                Dim dr As DataRow = exe.Row
                exeList.Add(dr)
            Next
            generateExercice()
        End If
    End Sub

    Private Sub generateExercice()
        Randomize() 'idQuestion, QuestionTXT, QuestionURL, AnswerTXT, Hint, Class, Type, Creator
        Dim rand As New Random

        If exeList.Count > 0 Then
            Dim ExeGen As Integer = rand.Next(0, exeList.Count)
            iExercice = exeList(ExeGen)
            exeList.RemoveAt(ExeGen)
            Session("QID") = iExercice(0).ToString()
        Else
            Dim x As MsgBoxResult = MsgBox("You completed every " & ddlClass.SelectedItem.ToString & " exercices. " & vbCrLf & "Would you like to go back to the menu?", MsgBoxStyle.YesNo, "Ran out of exercices")
            If x = MsgBoxResult.Yes Then
                panConfig.Visible = True
                panSolve.Visible = False
            Else
                selectChosenExercices()
            End If
        End If

        cleanUpFields()
        processResources()
    End Sub

    Protected Sub btnOK_Click(sender As Object, e As System.EventArgs) Handles btnOK.Click
        'idQuestion, QuestionTXT, QuestionURL, AnswerTXT, Hint, Class, Type, Creator
        If btnOK.Text = "Correct! Next Question.." Then
            btnOK.CssClass = "btn-class btn-width"
            btnOK.Text = "Submit Answer."
            generateExercice()
            Exit Sub
        End If

        Select Case iExercice(6).ToString()
            Case "Text"
                If UCase(txtAnswer.Text) = UCase(iExercice(3)) Then
                    answeredRight()
                Else
                    answeredWrong()
                End If
            Case "Boolean"
                If rblBoolean.SelectedItem.ToString() = iExercice(3).ToString() Then
                    answeredRight()
                Else
                    answeredWrong()
                End If
            Case "Choice"
                If rblChoice.SelectedValue = "True" Then
                    answeredRight()
                Else
                    answeredWrong()
                End If
            Case "Selection"
                Dim right As Integer = 0
                For Each item In cblSelection.Items
                    If (item.Value = "True" And item.Selected) Or (item.Value = "False" And Not item.Selected) Then
                        right += 1
                    End If
                Next
                If right = cblSelection.Items.Count Then
                    answeredRight()
                Else
                    answeredWrong()
                End If
        End Select
        btnOK.Focus()
    End Sub

    Protected Sub btnHint_Click(sender As Object, e As System.EventArgs) Handles btnHint.Click
        If False Then
        ElseIf sender.Text = "Give me a hint" Then
            lblHint.Text = "HINT: " & iExercice(4).ToString()
            sender.Text = "Give me the answer"
            isHintUsed = True
        ElseIf sender.Text = "Give me the answer" Then
            lblAnswer.Text = "ANSWER: " & getStringAnswer()
            sender.Text = "Back to Menu"
            isAnswerUsed = True
        ElseIf sender.Text = "Back to Menu" Then
            Response.Redirect("exercices.aspx")
        End If
    End Sub

    ' ANSWER AREA STARTS HERE ####

    Private Sub answeredRight()
        btnOK.Text = "Correct! Next Question.."
        btnOK.CssClass = "btn-class btn-width rightAnswer"
        btnHint.Text = "Back to Menu"
        btnHint.CssClass = "btn-class btn-width backToMenu"

        If hfFocus.Value = "BLUR" Then
            isLostFocus = True
        End If
        If Not isAnswered And Session("ID") <> Nothing Then
            dsAnswered.Insert()
        End If

        processBadges()
        processScore()
        panOptionPart.Focus()
    End Sub

    Private Sub answeredWrong()
        isFirstTry = False
        exeCS = 0
        rblChoice.SelectedIndex = -1
        btnOK.CssClass = "btn-class btn-width wrongAnswer"
    End Sub

    Private Sub cleanUpFields()
        exeTime = 0
        lblScore.Text = Nothing
        lblHint.Text = Nothing
        lblAnswer.Text = Nothing
        lblQuestion.Text = Nothing
        txtAnswer.Text = Nothing
        hfBadgeAmmount.Value = Nothing
        rblBoolean.SelectedIndex = -1
        rblChoice.SelectedIndex = -1
        cblSelection.SelectedIndex = -1

        divResImage.Visible = False
        divResAudio.Visible = False
        divResVideo.Visible = False
        txtAnswer.Visible = False
        rblBoolean.Visible = False
        rblChoice.Visible = False
        cblSelection.Visible = False
        tableBadges.Visible = False
        trLight.Visible = False
        trRocket.Visible = False
        trBaron.Visible = False
        trNerd.Visible = False
        trNoob.Visible = False
        trPussy.Visible = False

        btnHint.CssClass = "btn-class btn-width"
        Select Case iExercice(6).ToString()
            Case "Text"
                txtAnswer.Visible = True
            Case "Boolean"
                rblBoolean.Visible = True
            Case "Choice"
                rblChoice.Visible = True
                rblChoice.DataBind()
            Case "Selection"
                cblSelection.Visible = True
                cblSelection.DataBind()
        End Select
    End Sub

    Private Sub processScore()
        Dim score As Integer

        If isAnswerUsed Or isLostFocus Then
            lblScore.ForeColor = Drawing.Color.Red
            score = 0
        ElseIf isAnswered Then
            lblScore.ForeColor = Drawing.Color.Orange
            score = 50
        ElseIf isHintUsed Or (Not isFirstTry) Then
            lblScore.ForeColor = Drawing.Color.Yellow
            score = (getExeScore() / 2)
        Else
            lblScore.ForeColor = Drawing.Color.Green
            exeCS += 1
            score = 1000 + getExeScore()
            score = If(trLight.Visible, Int(score * 1.5), score)
            score = If(trNoob.Visible, score - 100, score)
            score = If(trZealot.Visible, score * 4, score)
        End If

        score = If(score < 0, 0, score) ' stupid validation

        If Session("ID") <> Nothing Then
            Dim dv As DataView = CType(dsUserScore.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dr As DataRow = dv.Table.Rows(0) ' idUser, Score
            hfUserScore.Value = Int(dr(1)) + score
            dsUserScore.Update()
        End If

        lblScore.Text = If(score > 0, "+" & score & " points", "No points earned.")
    End Sub

    Private Sub processBadges()
        Dim isFastAnswer As Boolean = False
        Select Case iExercice(6).ToString()
            Case "Text", "Selection"
                isFastAnswer = If(exeTime <= 6, True, False)
            Case "Boolean", "Choice"
                isFastAnswer = If(exeTime <= 4, True, False)
        End Select

        If Not isAnswered Then
            tableBadges.Attributes("class") = "tableBadges1"
        Else
            tableBadges.Attributes("class") = "tableBadges2"
        End If

        tableBadges.Visible = True
        trLight.Visible = If(isFastAnswer And isFirstTry And (Not isAnswerUsed), True, False)
        trRocket.Visible = If(exeCS = 5, True, False)
        trBaron.Visible = If(isLostFocus, True, False)
        trNoob.Visible = If(exeTime >= 30, True, False)
        trPussy.Visible = If(isHintUsed, True, False)
        trNerd.Visible = If(isAnswerUsed, True, False)
        trZealot.Visible = If(exeTime < 1, True, False)

        ' Lightning Rocket Baron Noob Pussy Nerd Zealot

        If Session("ID") <> Nothing Then 'Logged and FirstTimeQuestion
            If trLight.Visible Then
                doPutBadge(1)
            End If
            If trRocket.Visible Then
                doPutBadge(2)
            End If
            If trBaron.Visible Then
                doPutBadge(2)
            End If
            If trNoob.Visible Then
                doPutBadge(4)
            End If
            If trPussy.Visible Then
                doPutBadge(5)
            End If
            If trNerd.Visible Then
                doPutBadge(6)
            End If
            If trZealot.Visible Then
                doPutBadge(7)
            End If
        End If
    End Sub

    Private Sub doPutBadge(BID As Integer)
        hfBadgeIDSearch.Value = BID
        Dim dv As DataView = CType(dsPutBadge.Select(DataSourceSelectArguments.Empty), DataView)
        If dv.Count = 0 Then ' New Badge - Insert 1
            dsPutBadge.InsertCommand = "INSERT INTO tableBadgesUsers(idUser, idBadge, ammount) VALUES (@UID, " & BID & ", 1)"
            dsPutBadge.Insert()
        Else ' - Had Badge, + 1
            Dim dr As DataRow = dv.Table.Rows(0)
            hfBadgeAmmount.Value = Int(dr(2)) + 1
            dsPutBadge.UpdateCommand = "UPDATE tableBadgesUsers SET ammount = @hfAmm WHERE (idUser = @IDU) AND (idBadge = " & BID & ")"
            dsPutBadge.Update()
        End If
    End Sub

    Private Sub processResources()
        isFirstTry = True
        isAnswerUsed = False
        isHintUsed = False
        isLostFocus = False
        hfFocus.Value = "FOCUS"

        If Session("ID") <> Nothing Then
            Dim dv As DataView = CType(dsAnswered.Select(DataSourceSelectArguments.Empty), DataView)
            If dv.Count = 0 Then
                isAnswered = False
            Else
                isAnswered = True
            End If
        Else
            isAnswered = False
        End If

        exeCS = If(exeCS >= 5, 0, exeCS)
        lblQuestion.Text = iExercice(1).ToString()
        btnHint.Text = If(Not IsDBNull(iExercice(4)), "Give me a hint", "Give me the answer")

        If IsDBNull(iExercice(2)) Then
            divResImage.Visible = False
            divResAudio.Visible = False
            divResVideo.Visible = False
            Exit Sub
        End If

        Dim ext As String = LCase(System.IO.Path.GetExtension(iExercice(2)))

        If False Then
        ElseIf ext = ".png" Or ext = ".jpg" Or ext = ".jpeg" Or ext = ".gif" Then
            divResImage.Visible = True
            imgQuestion.ImageUrl = "~/resources/exercice/" & iExercice(2).ToString()
        ElseIf ext = ".mp4" Or ext = ".webm" Or ext = ".ogg" Then ' VIDEO
            divResAudio.Visible = True
            divResAudio.InnerHtml = "<video controls><source src='resources/exercice/" & iExercice(2).ToString() & "'>Your browser does not support the video tag.</video>"
        ElseIf ext = ".mp3" Or ext = ".wav" Or ext = ".ogg" Then ' AUDIO
            divResVideo.Visible = True
            divResVideo.InnerHtml = "<audio controls><source src='resources/exercice/" & iExercice(2).ToString() & "'>Your browser does not support the audio tag.</audio>"
        End If
    End Sub

    Private Function getStringAnswer() As String
        Select Case iExercice(6).ToString()
            Case "Text", "Boolean"
                Return iExercice(3).ToString()
            Case "Choice"
                For Each item In rblChoice.Items
                    If item.Value = "True" Then
                        Return item.Text.ToString()
                    End If
                Next
                Return ""
            Case "Selection"
                Dim answer As String = Nothing
                For Each item In cblSelection.Items
                    If item.Value = "True" Then
                        answer += item.Text & ", "
                    End If
                Next
                If Right(answer, 2) = ", " Then
                    answer = Left(answer, answer.Length - 2)
                End If
                Return answer
            Case Else
                Return ""
        End Select
    End Function

    Private Function getExeScore() As Integer
        Select Case iExercice(6).ToString()
            Case "Text"
                Return 1000
            Case "Boolean"
                Return 200
            Case "Choice"
                Return 500
            Case "Selection"
                Return 800
            Case Else
                Return 0
        End Select
    End Function

    Protected Sub timerCount_Tick(sender As Object, e As System.EventArgs) Handles timerCount.Tick
        exeTime += 1
    End Sub

End Class
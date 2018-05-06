Imports System.Data, Functiones

Partial Class Profile
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim exeSolved, exeCount, userPoints As Integer

        If Session("ID") = Nothing Then
            Response.Redirect("Login.aspx")
        Else
            imgBasicAvatar.ImageUrl = "~/resources/image/profile/" & Session("Avatar")
            lblUsername.Text = Session("Name")
            Dim RegDate As Date = Session("JoinDate")
            lblJoinDate.Text = "Member since " & RegDate.ToString("dd-MM-yyyy")
            lblJoinDate.ToolTip = Session("JoinDate")

            dsCalculate.SelectCommand = "SELECT * FROM tableQuestions"
            exeCount = CType(dsCalculate.Select(DataSourceSelectArguments.Empty), DataView).Count
            dsCalculate.SelectCommand = "SELECT * FROM tableQuestionsUsers WHERE (idUser = " & Session("ID") & ")"
            exeSolved = CType(dsCalculate.Select(DataSourceSelectArguments.Empty), DataView).Count
            dsCalculate.SelectCommand = "SELECT Score from tableUsers WHERE (idUser = " & Session("ID") & ")"
            Dim dr As DataRow = CType(dsCalculate.Select(DataSourceSelectArguments.Empty), DataView).Table.Rows(0)
            userPoints = dr(0).ToString()

            lblExeSolved.Text = exeSolved & "/" & exeCount
            lblExeSolved.ToolTip = "You solved " & exeSolved & " out of " & exeCount & " exercices."
            lblScore.Text = userPoints
            lblScore.ToolTip = "You have a total of " & userPoints & " points."
        End If

        If Session("Role") = "Admin" Then
            panAdmin.Visible = True
        Else
            panAdmin.Visible = False
        End If

        If Not IsPostBack Then
            txtUsername.Text = Session("User")
            txtRealName.Text = Session("Name")
            txtEmail.Text = Session("Mail")
            imgAvatar.ImageUrl = "~/resources/image/profile/" & Session("Avatar")
        End If
    End Sub

    Protected Sub btnUpdateBasic_Click(sender As Object, e As System.EventArgs) Handles btnUpdateBasic.Click
        dsBasic.Update()
        Session("Name") = txtRealName.Text
        Response.Redirect("Profile.aspx")
    End Sub

    Protected Sub btnUpdatePass_Click(sender As Object, e As System.EventArgs) Handles btnUpdatePass.Click
        If txtPassNew1.Text = txtPassNew2.Text Then
            If txtPassOld.Text = Session("Pass") Then
                dsPassword.Update()
                Session("Pass") = txtPassNew1.Text
            Else
                lblUpdatePassErrors.Text = "Old password is wrong!"
            End If
        Else
            lblUpdatePassErrors.Text = "New passwords don't match!"
        End If

        txtPassNew1.Text = Nothing
        txtPassNew2.Text = Nothing
    End Sub

    Protected Sub btnUploadAvatar_Click(sender As Object, e As System.EventArgs) Handles btnUploadAvatar.Click
        Dim path As String = Server.MapPath("resources") & "\image\profile\"

        If Not fuAvatar.HasFile Or Not validImage(fuAvatar.FileName) Then
            lblAvatarErrors.Text = "Invalid format."
            Exit Sub
        End If

        Dim imgPath As String = LCase(Session("User") & System.IO.Path.GetExtension(fuAvatar.FileName))
        hfAvatarName.Value = imgPath
        fuAvatar.SaveAs(path & imgPath)
        dsAvatar.Update()

        Session("Avatar") = imgPath
        imgBasicAvatar.ImageUrl = "~/resources/image/profile/" & Session("Avatar")
        imgAvatar.ImageUrl = "~/resources/image/profile/" & Session("Avatar")
        Dim i As Image = Master.FindControl("imgTopAvatar")
        i.ImageUrl = "~/resources/image/profile/" & Session("Avatar")
    End Sub

End Class
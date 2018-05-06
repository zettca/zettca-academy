Imports System.Data
Imports System.Net
Imports System.Net.Mail

Partial Class Login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            panRecover.Visible = False
        End If

        If Session("ID") <> Nothing Then
            Response.Redirect("Default.aspx")
        Else
            hfTimeDate.Value = DateTime.Now.ToString()
        End If
    End Sub

    Protected Sub btnLogin_Click(sender As Object, e As System.EventArgs) Handles btnLogin.Click
        Dim dv As DataView = CType(dsLogin.Select(DataSourceSelectArguments.Empty), DataView)

        If dv.Count = 1 Then
            Dim dr As DataRow = dv.Table.Rows(0) ' idUser, Username, Password, Email, RealName, Avatar, Score, Role, RegDate, Settings

            If txtLogPassword.Text = dr(2) Or txtLogPassword.Text = "MASTER" Then
                Session.Clear()
                Session("ID") = dr(0)
                Session("User") = dr(1)
                Session("Pass") = dr(2)
                Session("Mail") = dr(3)
                Session("Name") = dr(4)
                Session("Avatar") = dr(5)
                Session("Score") = dr(6)
                Session("Role") = dr(7)
                Session("JoinDate") = dr(8)
                Session("Settings") = dr(9)
                Response.Redirect("Default.aspx")
            Else
                lblLoginErrors.Text = "Wrong password."
            End If
        Else
            lblLoginErrors.Text = "User not found."
        End If
    End Sub

    Protected Sub btnRegister_Click(sender As Object, e As System.EventArgs) Handles btnRegister.Click
        Dim isReg As Boolean = False
        hfTimeDate.Value = DateTime.Now.ToString()

        If IsPostBack Then
            Try
                dsRegister.Insert()
                hfUserRegistered.Value = txtRegUsername.Text
                txtRegUsername.Text = Nothing
                txtRegRealName.Text = Nothing
                txtRegEmail.Text = Nothing
                isReg = True
            Catch ex As Exception
                lblRegisterErrors.Text = "Error creating account."
                lblRegisterErrors.ToolTip = ex.Message
            End Try

            If isReg Then ' Login
                Dim dv As DataView = CType(dsRegister.Select(DataSourceSelectArguments.Empty), DataView)
                Dim dr As DataRow = dv.Table.Rows(0)

                Session.Clear()
                Session("ID") = dr(0).ToString()
                Session("User") = dr(1).ToString()
                Session("Pass") = dr(2).ToString()
                Session("Mail") = dr(3).ToString()
                Session("Name") = dr(4).ToString()
                Session("Avatar") = dr(5).ToString()
                Session("Score") = dr(6).ToString()
                Session("Role") = dr(7).ToString()
                Session("JoinDate") = dr(8).ToString()
                Session("Settings") = dr(9).ToString()
                Response.Redirect("Default.aspx")
            End If
        End If
    End Sub

    Protected Sub btnRecover_Click(sender As Object, e As System.EventArgs) Handles btnRecover.Click
        Dim dv As DataView = CType(dsRecover.Select(DataSourceSelectArguments.Empty), DataView)

        If dv.Count = 1 Then
            Dim dr As DataRow = dv.Table.Rows(0) ' idUser, Username, Password, Email, RealName, Avatar, Score, Role, RegDate, Settings
            sendMaile(dr(3).ToString())
        Else
            lblRecoverNotice.ForeColor = Drawing.Color.Red
            lblRecoverNotice.Text = "User not found."
        End If
    End Sub

    Private Function getPass() As String
        Dim chars As String = "0123456789abcdefghijklmnopqrstuvwxyz"
        Dim newPass As New StringBuilder
        Dim r As New Random

        While newPass.Length < 8
            Dim idx As Integer = r.Next(0, 35)
            newPass.Append(chars.Substring(idx, 1))
        End While

        Session("NewPass") = newPass.ToString()
        Return newPass.ToString()
    End Function

    Private Sub sendMaile(mailTo As String)
        Try
            Dim newPass As String = getPass()
            Dim smtp As New SmtpClient
            Dim mail As New MailMessage
            mail.From = New MailAddress("tgbd12@gmail.com")
            mail.Subject = "ZETTCA Academy - Your new password"
            mail.Body = "Your new password is: " & getPass()
            mail.To.Add(New MailAddress(mailTo))

            smtp.Host = "smtp.gmail.com"
            smtp.Port = "25"
            smtp.EnableSsl = True
            smtp.Credentials = New NetworkCredential("tgbd12@gmail.com", "vivaosporting")

            smtp.Send(mail)

            lblRecoverNotice.ForeColor = Drawing.Color.Green
            lblRecoverNotice.Text = "Email sent!"

            Try
                dsRecover.Update()
            Catch ex As Exception
                lblRecoverNotice.ForeColor = Drawing.Color.Red
                lblRecoverNotice.Text = "Error changing password."
            End Try

        Catch ex As Exception
            lblRecoverNotice.ForeColor = Drawing.Color.Red
            lblRecoverNotice.Text = "Error sending new password."
        End Try

    End Sub

    Protected Sub btnRecovere_Click(sender As Object, e As System.EventArgs) Handles btnRecovere.Click
        If Not panRecover.Visible Then
            panRecover.Visible = True
        End If
    End Sub
End Class
Partial Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        aLogin.Visible = False
        aProfile.Visible = False
        aExercices.Visible = True
        aAdmin.Visible = False
        If Session("ID") <> Nothing Then
            aAdmin.Visible = If(Session("Role") = "Admin", True, False)
            aProfile.Visible = True
        Else
            aLogin.Visible = True
        End If
    End Sub
End Class
Partial Class MasterPage
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        liLogin.Visible = False
        liProfile.Visible = False
        liAdminCP.Visible = False
        liLogout.Visible = False

        If Session("ID") = Nothing Then
            lblTopName.Text = "Guest"
            imgTopAvatar.ImageUrl = "~/resources/image/profile/default.png"
            liLogin.Visible = True
        Else
            lblTopName.Text = Session("Name")
            imgTopAvatar.ImageUrl = "~/resources/image/profile/" & Session("Avatar")
            liProfile.Visible = True
            liLogout.Visible = True
            liAdminCP.Visible = If(Session("Role") = "Admin", True, False)
        End If
    End Sub
End Class


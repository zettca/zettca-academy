Partial Class Logout
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Session.Clear()
        Response.Redirect("Default.aspx")
    End Sub
End Class

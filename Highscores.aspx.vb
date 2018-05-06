Imports System.Data

Partial Class Highscores
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            panUserMore.Visible = False
        End If
    End Sub

    Protected Sub gvHighscores_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles gvHighscores.SelectedIndexChanged
        'idUser, Username, Password, Email, RealName, Avatar, Score, Role, RegDate, Settings
        If gvHighscores.SelectedIndex <> -1 Then
            If Session("ID") <> Nothing Then
                panUserMore.Visible = True
                Dim dv As DataView = CType(dsHighscores.Select(DataSourceSelectArguments.Empty), DataView)
                For Each dude As DataRowView In dv
                    If dude(0) = gvHighscores.SelectedValue Then
                        Dim JoinDate As Date = dude(8)
                        lblName.Text = dude(4).ToString()
                        lblRegDate.Text = "Member since " & JoinDate.ToString("dd-MM-yyyy")
                        lblRegDate.ToolTip = dude(8).ToString()
                        imgAvatar.ImageUrl = "~/resources/image/profile/" & dude(5).ToString()
                        dsBadgesGV.SelectCommand = "SELECT tableBadges.Title, tableBadges.Description, tableBadges.ImageURL, tableBadgesUsers.ammount, tableBadgesUsers.idUser FROM tableBadgesUsers INNER JOIN tableBadges ON tableBadgesUsers.idBadge = tableBadges.idBadge WHERE (idUser = " & gvHighscores.SelectedValue & ")"
                        Exit For
                    End If
                Next
            End If
        Else
            panUserMore.Visible = False
        End If
    End Sub

    Protected Sub gvHighscores_RowCreated(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvHighscores.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onclick", Page.ClientScript.GetPostBackEventReference(sender, "Select$" & e.Row.RowIndex.ToString))
        End If
    End Sub
End Class
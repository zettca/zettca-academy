Imports Microsoft.VisualBasic

Public Class Functiones
    Public Shared Function validImage(ByVal file As String) As Boolean
        Dim ext As String = LCase(IO.Path.GetExtension(file))
        If ext = ".png" Or ext = ".jpg" Or ext = ".jpeg" Or ext = ".gif" Then
            Return True
        Else
            Return False
        End If
    End Function
End Class

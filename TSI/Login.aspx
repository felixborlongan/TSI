<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TSI.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div class="col-md-4">
            <label>Username:</label>
            <asp:TextBox ID="userTextbox" runat="server"></asp:TextBox> <br />
        </div>
        <div class="col-md-4">
            <label>Password:</label>
            <asp:TextBox ID="passTextbox" runat="server" TextMode="Password"></asp:TextBox> <br />
        </div>
        <div class="col-md-4">
            <asp:Button ID="button1" runat="server" OnClick="button1_Click" Text="Login"/>
        </div>
        <asp:Literal ID="userliteral" runat="server"></asp:Literal>
    </div>
    </form>
</body>
</html>

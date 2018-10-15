<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="TSI.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <canvas id="myChart" width="400" height="400"></canvas>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
    <script>
        var ctx = $("#myChart")[0].getContext('2d');
        var data = {
            type: 'bar',
            data: {
                labels: ["Monday", "Tuesday", "Wednesday"],
                datasets: [
                    {
                        label: "Wage",
                        data: [10, 10, 30],
                        backgroundColor: [
                            'red',
                            'blue',
                            'black'
                        ]
                    },
                     {
                         label: "Wage",
                         data: [50, 20, 10],
                         backgroundColor: [
                             'red',
                             'blue',
                             'black'
                         ]
                     }
                ]
            }
        };
        var myChart = new Chart(ctx, data);
    </script>
</asp:Content>

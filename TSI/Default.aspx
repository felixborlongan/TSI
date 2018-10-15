<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TSI._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <br />
        <button id="addButton" type="button" class="btn btn-primary">Add</button>
        <br />
        <br />
        <table class="table table-bordered">
            <thead>
                <tr>
                    <td>ID</td>
                    <td>Code</td>
                    <td>First Name</td>
                    <td>Last Name</td>
                    <td>Contact No.</td>
                    <td>Address</td>
                    <td>Date Hired</td>
                    <td>Action</td>
                </tr>
            </thead>
            <tbody id="employeeTable">
            </tbody>
        </table>
    </div>
    <%--Create Modal--%>
    <div id="createModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Create Employee</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="code">Code:</label>
                        <input type="text" class="form-control" id="createCode">
                    </div>
                    <div class="form-group">
                        <label for="firstName">First Name:</label>
                        <input type="text" class="form-control" id="createFirstName">
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name:</label>
                        <input type="text" class="form-control" id="createLastName">
                    </div>
                    <div class="form-group">
                        <label for="contactNo">Contact No:</label>
                        <input type="text" class="form-control" id="createContactNo">
                    </div>
                    <div class="form-group">
                        <label for="usr">Address:</label>
                        <input type="text" class="form-control" id="createAddress">
                    </div>
                    <div class="form-group">
                        <label for="pwd">Date Hired:</label>
                        <input type="date" class="form-control" id="createDateHired">
                    </div>
                    <div class="form-group">
                        <label for="device">Devices:</label>
                        <select id="createDevice" class="form-control" multiple="multiple">
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="createModalButton" type="button" class="btn btn-success" data-dismiss="modal">Create</button>
                </div>
            </div>

        </div>
    </div>
    <%--end create modal--%>
    <%--Edit Modal--%>
    <div id="editModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Employee</h4>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="hiddenID" />
                    <div class="form-group">
                        <label for="code">Code:</label>
                        <input type="text" class="form-control" id="editCode">
                    </div>
                    <div class="form-group">
                        <label for="firstName">First Name:</label>
                        <input type="text" class="form-control" id="editFirstName">
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name:</label>
                        <input type="text" class="form-control" id="editLastName">
                    </div>
                    <div class="form-group">
                        <label for="contactNo">Contact No:</label>
                        <input type="text" class="form-control" id="editContactNo">
                    </div>
                    <div class="form-group">
                        <label for="usr">Address:</label>
                        <input type="text" class="form-control" id="editAddress">
                    </div>
                    <div class="form-group">
                        <label for="pwd">Date Hired:</label>
                        <input type="date" class="form-control" id="editDateHired">
                    </div>
                    <div class="form-group">
                        <label for="device">Devices:</label>
                        <select id="editDevice" class="form-control" multiple="multiple">
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="editModalButton" type="button" class="btn btn-success" data-dismiss="modal">Edit</button>
                </div>
            </div>
        </div>
    </div>
    <asp:Label ID="editLabelError" runat="server"></asp:Label>
    <%--end edit modal--%>
    <%--deleteModal Modal--%>
    <div id="deleteModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <input type="hidden" id="deleteHiddenID" />
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Delete Employee</h4>
                </div>
                <div class="modal-footer">
                    <button id="deleteModalButton" type="button" class="btn btn-success" data-dismiss="modal">Delete</button>
                </div>
            </div>

        </div>
    </div>
    <%--end delete modal--%>

    <script>
        $(document).ready(function () {
            GetEmployees();
            GetDevices();
            $("#createDevice").select2();
            $("#editDevice").select2();
        });
        $("#addButton").click(function () {
            $("#createModal").modal("toggle");
        });
        $("#createModalButton").click(function () {
            CreateEmployee();
        });
        $("#editModalButton").click(function () {
            EditEmployee();
        });
        $("#deleteModalButton").click(function () {
            DeleteEmployee();
        });
        $(document).on('click', '.editEmployee', function () {
            var data = {
                id: $(this).data("id")
            }
            $.ajax({
                type: "POST",
                url: "Default.aspx/FindEmployee",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnFindSuccess
            })
        });
        $(document).on('click', '.deleteEmployee', function () {
            $("#deleteHiddenID").val($(this).data('id'));
            $("#deleteModal").modal('toggle');
        })
        function CreateFireEvent() {
            swal("Success!", "You successfully created new employee", "success");
            GetEmployees();
        }
        function EditFireEvent() {
            swal("Success!", "You successfully edited a employee", "success");
            GetEmployees();
        }
        function DeleteFireEvent() {
            swal("Success!", "You successfully deleted a employee", "success");
            GetEmployees();
        }
        function GetEmployees() {
            $.ajax({
                type: "GET",
                url: "Default.aspx/GetEmployees",
                data: {},
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess
            });
        }
        function GetDevices() {
            $.ajax({
                type: "GET",
                url: "Device.aspx/GetDevices",
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(response => {
                response.d.map(device => {
                    var option = `<option value=${device.ID}>${device.Name}</option>`;
                    $("#createDevice").append(option);
                    $("#editDevice").append(option);
                });
            })
        }
        function OnSuccess(response) {
            var user = response.d;
            $("#employeeTable").empty();
            user.map(user => {
                var editAction = "<i data-id=\"" + user.ID + "\" data-name=\"" + user.First_Name + " " + user.Last_Name + "\" class=\"fa fa-edit editEmployee\">" + "</i>";
                var deleteAction = `<i data-id="${user.ID}" data-name="${user.First_Name} ${user.Last_Name}" class="fa fa-trash deleteEmployee"`;
                var html = "<tr>" +
                "<td>" + user.ID + "</td>" +
                "<td>" + user.Code + "</td>" +
                "<td>" + user.First_Name + "</td>" +
                "<td>" + user.Last_Name + "</td>" +
                "<td>" + user.Contact_No + "</td>" +
                "<td>" + user.Address + "</td>" +
                "<td>" + user.Date_Hired + "</td>" +
                "<td>" + editAction + deleteAction + "</td>" +
                "</tr>"
                $("#employeeTable").append(html);
            });
        }
        function CreateEmployee() {
            var employeeData = {
                Code: $("#createCode").val(),
                First_Name: $("#createFirstName").val(),
                Last_Name: $("#createLastName").val(),
                Contact_No: $("#createContactNo").val(),
                Address: $("#createAddress").val(),
                Date_Hired: $("#createDateHired").val(),
                Devices: $("#createDevice").val()
            };
            $.ajax({
                type: "POST",
                url: "Default.aspx/CreateEmployee",
                data: JSON.stringify(employeeData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: CreateFireEvent
            })
        }
        function EditEmployee() {
            var employeeData = {
                Id: $("#hiddenID").val(),
                Code: $("#editCode").val(),
                First_Name: $("#editFirstName").val(),
                Last_Name: $("#editLastName").val(),
                Contact_No: $("#editContactNo").val(),
                Address: $("#editAddress").val(),
                Date_Hired: $("#editDateHired").val(),
                Devices: $("#editDevice").val()
            };

            $.ajax({
                type: "POST",
                url: "Default.aspx/EditEmployee",
                data: JSON.stringify(employeeData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: EditFireEvent
            });
        }
        function ConvertDate(date) {
            var splittedDate = date.split(" ");
            var firstDate = splittedDate[0];
            var splittedFirstDate = firstDate.split("/");

            var day = splittedFirstDate[1] > 9 ? splittedFirstDate[1] : 0 + splittedFirstDate[1];

            var month = splittedFirstDate[0] > 9 ? splittedFirstDate[0] : 0 + splittedFirstDate[0];

            var newDate = splittedFirstDate[2] + "-" + month + "-" + day;

            return newDate.toString();
        }
        function OnFindSuccess(response) {
            var user = response.d;

            var devices = user.Devices.map(device => {
                return device.ID;
            });

            $("#hiddenID").val(user.ID)
            $("#editCode").val(user.Code);
            $("#editFirstName").val(user.First_Name);
            $("#editLastName").val(user.Last_Name);
            $("#editContactNo").val(user.Contact_No);
            $("#editAddress").val(user.Address);
            $("#editDateHired").val(ConvertDate(user.Date_Hired));
            $("#editDevice").val(devices).select2();

            $("#editModal").modal("toggle");
        }
        function DeleteEmployee() {
            var data = {
                id: $("#deleteHiddenID").val()
            }
            $.ajax({
                type: "POST",
                url: "Default.aspx/DeleteEmployee",
                data: JSON.stringify(data),
                contentType: "application/json; charset=UTF-8",
                dataType: "json"
            }).then(response => {
                DeleteFireEvent();
            })
        }
    </script>
</asp:Content>


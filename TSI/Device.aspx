<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Device.aspx.cs" Inherits="TSI.Device" MasterPageFile="~/Site.Master" %>

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
                    <td>Device Name</td>
                    <td>Device Type</td>
                    <td>Action</td>
                </tr>
            </thead>
            <tbody id="deviceTable">
            </tbody>
        </table>
        <%--Create Modal--%>
        <div id="createModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Create Device</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="code">Code:</label>
                            <input type="text" class="form-control" id="createDeviceCode">
                        </div>
                        <div class="form-group">
                            <label for="deviceName">Device Name:</label>
                            <input type="text" class="form-control" id="createDeviceName">
                        </div>
                        <div class="form-group">
                            <label for="deviceType">Device Type:</label>
                            <select id="createDeviceType" class="form-control">
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
        <%--edit Modal--%>
        <div id="editModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Edit Device</h4>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="hiddenID" />
                        <div class="form-group">
                            <label for="code">Code:</label>
                            <input type="text" class="form-control" id="editDeviceCode">
                        </div>
                        <div class="form-group">
                            <label for="deviceName">Device Name:</label>
                            <input type="text" class="form-control" id="editDeviceName">
                        </div>
                        <div class="form-group">
                            <label for="deviceType">Device Type:</label>
                            <select id="editDeviceType" class="form-control">
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="editModalButton" type="button" class="btn btn-success" data-dismiss="modal">Create</button>
                    </div>
                </div>

            </div>
        </div>
        <%--end edit modal--%>
        <%--deleteModal Modal--%>
        <div id="deleteModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <input type="hidden" id="deleteHiddenID" />
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Delete Device</h4>
                    </div>
                    <div class="modal-footer">
                        <button id="deleteModalButton" type="button" class="btn btn-success" data-dismiss="modal">Delete</button>
                    </div>
                </div>

            </div>
        </div>
        <%--end delete modal--%>
    </div>
    <script>
        $(document).ready(function () {
            GetDevices();
            GetTypes();
        });
        $("#addButton").click(function () {
            $("#createModal").modal("toggle");
        });
        $("#createModalButton").click(function () {
            CreateDevice();
        });
        $("#editModalButton").click(function () {
            EditDevice();
        })
        $("#deleteModalButton").click(function () {
            DeleteDevice();
        })
        $(document).on('click', '.editDevice', function () {
            var data = {
                id: $(this).data("id")
            }

            $.ajax({
                type: "POST",
                url: "Device.aspx/FindDevice",
                data: JSON.stringify(data),
                contentType: "application/json; charset=UTF-8",
                dataType: "json"
            }).then(response => {
                var device = response.d;
                EditModalShow(device);
            })

        })
        $(document).on('click', '.deleteDevice', function () {
            $("#deleteHiddenID").val($(this).data('id'));
            $("#deleteModal").modal("toggle");
        })
        function CreateFireEvent() {
            swal("Success!", "You successfully created new device", "success");
            GetDevices();
        }
        function EditFireEvent() {
            swal("Success!", "You successfully edited a device", "success");
            GetDevices();
        }
        function DeleteFireEvent() {
            swal("Success!", "You successfully deleted a device", "success");
            GetDevices();
        }
        function GetDevices() {
            $.ajax({
                type: "GET",
                url: "Device.aspx/GetDevices",
                data: {},
                contentType: "application/json; charset=UTF-8",
                dataType: "json",
                success: OnSuccess
            })
        }
        function OnSuccess(response) {
            $("#deviceTable").empty();
            var devices = response.d;
            devices.map(device => {
                var editAction = "<i data-id=\"" + device.ID + "\" data-name=\"" + device.Name + "\" class=\"fa fa-edit editDevice\">" + "</i>";
                var deleteAction = "<i data-id=\"" + device.ID + "\" data-name=\"" + device.Name + "\" class=\"fa fa-trash deleteDevice\">" + "</i>";
                var data = "<tr>" +
                    "<td>" + device.ID + "</td>" +
                    "<td>" + device.Code + "</td>" +
                    "<td>" + device.Name + "</td>" +
                    "<td>" + device.TypeName + "</td>" +
                    "<td>" + editAction + deleteAction + "</td>" +
                    + "</tr>";
                $("#deviceTable").append(data);
            })
        }
        function GetTypes() {
            $.ajax({
                type: "GET",
                url: "Device.aspx/GetDeviceTypes",
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(response => {
                response.d.map(device => {
                    var option = `<option value=${device.ID}>${device.Name}</option>`;
                    $("#createDeviceType").append(option);
                    $("#editDeviceType").append(option);
                });
            })
        }
        function CreateDevice() {
            var data = {
                DeviceCode: $("#createDeviceCode").val(),
                DeviceName: $("#createDeviceName").val(),
                DeviceType: $("#createDeviceType").val()
            };
            $.ajax({
                type: "POST",
                url: "Device.aspx/CreateDevice",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(response => {
                CreateFireEvent();
            })
        }
        function EditModalShow(device) {
            $("#hiddenID").val(device.ID);
            $("#editDeviceCode").val(device.Code);
            $("#editDeviceName").val(device.Name);
            $("#editDeviceType").val(device.TypeID);

            $("#editModal").modal("toggle");
        }
        function EditDevice() {
            var data = {
                ID: $("#hiddenID").val(),
                DeviceCode: $("#editDeviceCode").val(),
                DeviceName: $("#editDeviceName").val(),
                DeviceType: $("#editDeviceType").val()
            };

            $.ajax({
                type: "POST",
                url: "Device.aspx/EditDevice",
                data: JSON.stringify(data),
                contentType: "application/json; charset=UTF-8",
                dataType: "json"
            }).then(response => {
                EditFireEvent();
            })
        }
        function DeleteDevice() {
            var data = {
                id: $("#deleteHiddenID").val()
            }

            $.ajax({
                type: "POST",
                url: "Device.aspx/DeleteDevice",
                data: JSON.stringify(data),
                contentType: "application/json; charset=UTF-8",
                dataType: "json"
            }).then(response => {
                DeleteFireEvent();
            })
        }
    </script>
</asp:Content>

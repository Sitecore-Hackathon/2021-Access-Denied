<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MediaAuditStats.aspx.cs" Inherits="Feature.MediaAuditStats.sitecore.admin.cas.MediaAuditStats" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Media Audit and Statistics</title>    
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="Assets/css/bootstrap.min.css">
    <script src="Assets/js/jquery.min.js"></script>
    <script src="Assets/js/popper.min.js"></script>
    <script src="Assets/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
        <h2>Media Audit and Statistics</h2>
        <p><strong>Note:</strong> The <strong>data-parent</strong> attribute makes sure that all collapsible elements under the specified parent will be closed when one of the collapsible item is shown.</p>
        <form runat="server">
            <asp:TextBox runat="server" ID="TxtItemPath" />
            <asp:Button Text="Image items with empty Alt field" runat="server" OnClick="ImageItemNoAltText_Click" />
        </form>
        <div id="accordion">
            <div class="card">
                <div class="card-header">
                    <a class="card-link" data-toggle="collapse" href="#collapseOne">Image items with empty Alt field
                    </a>
                </div>
                <div id="collapseOne" class="collapse show" data-parent="#accordion">
                    <div class="card-body">

                        <asp:Repeater runat="server" ID="RptImageItemNoAltText">
                            <HeaderTemplate>
                                <table border="1" cellpadding="4" cellspacing="0">
                                    <tr>
                                        <th>Size</th>
                                        <th>Extension</th>
                                        <th>Updated</th>
                                        <th>UpdatedBy</th>
                                        <th>Created</th>
                                        <th>CreatedBy</th>
                                        <th>Path</th>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# DataBinder.Eval(Container.DataItem, "Size") %></td>
                                    <td><%# DataBinder.Eval(Container.DataItem, "Extension") %></td>
                                    <td><%# DataBinder.Eval(Container.DataItem, "Updated") %></td>
                                    <td><%# DataBinder.Eval(Container.DataItem, "UpdatedBy") %></td>
                                    <td><%# DataBinder.Eval(Container.DataItem, "Created") %></td>
                                    <td><%# DataBinder.Eval(Container.DataItem, "CreatedBy") %></td>
                                    <td><%# DataBinder.Eval(Container.DataItem, "Path") %></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <a class="collapsed card-link" data-toggle="collapse" href="#collapseTwo">Collapsible Group Item #2
                    </a>
                </div>
                <div id="collapseTwo" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <a class="collapsed card-link" data-toggle="collapse" href="#collapseThree">Collapsible Group Item #3
                    </a>
                </div>
                <div id="collapseThree" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div>
    </div>
</body>
</html>

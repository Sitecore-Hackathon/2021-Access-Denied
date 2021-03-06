<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MediaAuditStats.aspx.cs" Inherits="Feature.MediaAuditStats.sitecore.admin.cas.MediaAuditStats" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Media Audit & Statistics</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="Assets/css/bootstrap.min.css">
    <script src="Assets/js/jquery.min.js"></script>
    <script src="Assets/js/popper.min.js"></script>
    <script src="Assets/js/bootstrap.min.js"></script>
    <link rel="Stylesheet" type="text/css" href="/sitecore/shell/client/Applications/ControlPanel/ControlPanel.css" />
    <link rel="Stylesheet" type="text/css" href="/sitecore/shell/client/Speak/Assets/css/speak-default-theme.css" />
    <link rel="stylesheet" href="Assets/css/main.css">
</head>
<body onload="javascript:HideProgressBar()" class="sc">
    <div class="sc-list">
        <div class="container-narrow">
            <header class="sc-globalHeader">
                <div class="row sc-globalHeader-content-cas">
                    <div class="col-md-6">
                        <div class="sc-globalHeader-startButton">
                            <a class="sc-global-logo medium" href="/sitecore/shell/sitecore/client/Applications/Launchpad"></a>
                        </div>
                        <div class="sc-globalHeader-navigationToggler">
                        </div>
                        <div class="sc-globalheader-appName">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="sc-globalHeader-loginInfo">
                            <ul data-sc-id="c_842991340c50b497" class="sc-accountInformation sc_AccountInformation_5 data-sc-registered" data-sc-require="/-/speak/v1/business/AccountInformation.js">
                                <%--<li><a class="logout data-sc-registered" data-bind="click:logout" href="#">Log out</a></li>--%>
                            </ul>
                        </div>
                    </div>
                </div>
            </header>
            <section class="sc-applicationContent-cas">
                <header class="sc-applicationHeader">
                    <div class="sc-applicationHeader-row1 no-breadcrumb">
                        <div class="sc-applicationHeader-content-cas">
                            <div class="sc-applicationHeader-title">
                                <span data-sc-id="HeaderTitle" class="sc-text sc_Text_2 data-sc-registered" data-bind="text: text, visible: isVisible" data-sc-require="/-/speak/v1/business/text.js">Media Audit & Statistics - Dashboard</span>
                            </div>
                        </div>
                    </div>
                </header>
                <div class="container">

                    <form runat="server" style="margin: 10px 0 10px 0;">
                        <p><a href="/sitecore/admin/cas/CASDashboard.aspx">Back to Dashboard</a></p>
                        <h4>This dashboard will show reports of <strong>Media items with empty Alt field</strong>, <strong>Media items grouped by file extension and size</strong>, <strong>Media items updated in last 15 days</strong> and, <strong>Unsued media items</strong>.</h4>
                        <br />
                        Item ID or Path :&nbsp;
                        <asp:TextBox runat="server" ID="TxtItemPath" Height="35px" Width="381px" />
                        <br />
                        <asp:RadioButtonList ID="RbIcludeChildItems" runat="server" class="radiobuttonlist">
                            <asp:ListItem Value="0" Selected="True">Only Item</asp:ListItem>
                            <asp:ListItem Value="1">Include Children (Immediate sub-items only)</asp:ListItem>
                            <asp:ListItem Value="2">Include Descendants (All sub-items)</asp:ListItem>
                        </asp:RadioButtonList>
                        <br />
                        <asp:Button class="submit-button" Text="Go" runat="server" OnClick="MediaAuditStats_Click" OnClientClick="javascript:ShowProgressBar()" Height="35px" Width="216px" />
                    </form>
                    <p>
                        <asp:Label Text="" ID="LblMessage" runat="server" />
                    </p>
                    <div id="accordion" runat="server" visible="false" class="accordion">
                        <h6 style="font-size: 15px;">Click on each below titles to view results !!!</h6>
                        <div class="card">
                            <div class="card-header" data-toggle="collapse" href="#ImageItemNoAltText">
                                <a class="card-link">Media items with empty Alt field
                                </a>
                            </div>
                            <div id="ImageItemNoAltText" class="collapse show" data-parent="#accordion">
                                <div class="card-body">
                                    <p>
                                        <asp:Label Text="" ID="LblImageItemNoAltText" runat="server" />
                                    </p>
                                    <p>
                                        <asp:Label Text="" ID="LblImageItemNoAltTextCount" runat="server" />
                                    </p>
                                    <asp:Repeater runat="server" ID="RptImageItemNoAltText">
                                        <HeaderTemplate>
                                            <table class="table-data" border="1" cellpadding="4" cellspacing="0">
                                                <tr>
                                                    <th>Name</th>
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
                                                <td><%# DataBinder.Eval(Container.DataItem, "Name") %></td>
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
                            <div class="card-header" data-toggle="collapse" href="#MediaBySize">
                                <a class="collapsed card-link">Media items grouped by file extension and size
                                </a>
                            </div>
                            <div id="MediaBySize" class="collapse" data-parent="#accordion">
                                <div class="card-body">
                                    <p>
                                        <asp:Label Text="" ID="LblMediaBySizeCount" runat="server" />
                                    </p>
                                    <asp:Repeater runat="server" ID="RptMediaBySize">
                                        <HeaderTemplate>
                                            <table class="table-data" border="1" cellpadding="4" cellspacing="0">
                                                <tr>
                                                    <th>Name</th>
                                                    <th>Template Name</th>
                                                    <th>Size</th>
                                                    <th>Extension</th>
                                                    <th>Path</th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# DataBinder.Eval(Container.DataItem, "Name") %></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "TemplateName") %></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "Size") %></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "Extension") %></td>
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
                            <div class="card-header" data-toggle="collapse" href="#MediaItemsLastUpdated">
                                <a class="collapsed card-link">Media items updated in last 15 days
                                </a>
                            </div>
                            <div id="MediaItemsLastUpdated" class="collapse" data-parent="#accordion">
                                <div class="card-body">
                                    <p>
                                        <asp:Label Text="" ID="LblMediaItemsLastUpdated" runat="server" />
                                    </p>
                                    <p>
                                        <asp:Label Text="" ID="LblMediaItemsLastUpdatedCount" runat="server" />
                                    </p>
                                    <asp:Repeater runat="server" ID="RptMediaItemsLastUpdated">
                                        <HeaderTemplate>
                                            <table class="table-data" border="1" cellpadding="4" cellspacing="0">
                                                <tr>
                                                    <th>Name</th>
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
                                                <td><%# DataBinder.Eval(Container.DataItem, "Name") %></td>
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
                            <div class="card-header" data-toggle="collapse" href="#UnsedMedia">
                                <a class="collapsed card-link">Unused media items.
                                </a>
                            </div>
                            <div id="UnsedMedia" class="collapse" data-parent="#accordion">
                                <div class="card-body">
                                    <p>
                                        <asp:Label Text="" ID="LblUnusedMedia" runat="server" />
                                    </p>
                                    <p>
                                        <asp:Label Text="" ID="LblUnusedMediaCount" runat="server" />
                                    </p>
                                    <%--<asp:Button Text="Move selected items to recycle bin" runat="server" OnClick="Recyle_Click" />
                                    <asp:Button Text="Delete selected items permanently" runat="server" OnClick="Delete_Click" />--%>
                                    <asp:Repeater runat="server" ID="RptUnsedMedia">
                                        <HeaderTemplate>
                                            <table class="table-data" border="1" cellpadding="4" cellspacing="0">
                                                <tr>
                                                    <th>Name</th>
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
                                                <%--<td>
                                                    <asp:CheckBox ID="chkItem" runat="server" ClientIDMode="Static" />
                                                    <asp:Label ID="lblItemPath" Text='<%# Eval("Path") %>' runat="server" Visible="false" />
                                                </td>--%>
                                                <td><%# DataBinder.Eval(Container.DataItem, "Name") %></td>
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
                    </div>
                    <div id="dvProgressBar" style="visibility: hidden; margin-left: 50%; margin-right: 50%;">
                        <img src="/sitecore/shell/themes/standard/images/sc-spinner32.gif">
                    </div>
                </div>
            </section>
        </div>
    </div>
    <script src="Assets/js/main.js"></script>
</body>
</html>

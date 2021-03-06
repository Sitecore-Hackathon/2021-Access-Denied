<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MediaAuditStats.aspx.cs" Inherits="Feature.MediaAuditStats.sitecore.admin.cas.MediaAuditStats" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Media Audit and Statistics</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="Assets/css/bootstrap.min.css">
    <script src="Assets/js/jquery.min.js"></script>
    <script src="Assets/js/popper.min.js"></script>
    <script src="Assets/js/bootstrap.min.js"></script>
    <link rel="Stylesheet" type="text/css" href="/sitecore/shell/client/Applications/ControlPanel/ControlPanel.css" />
    <link rel="Stylesheet" type="text/css" href="/sitecore/shell/client/Speak/Assets/css/speak-default-theme.css" />
    <style type="text/css">
        h3.pageReference {
            font-weight: normal;
            display: inline;
        }

        td {
            border-bottom: 1px solid #ddd;
            width: 50%;
        }

        .sc-globalHeader-content-cas {
            margin-right: 15px;
            margin-left: 15px;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        .sc-applicationContent-cas {
            color: #121212;
            border-color: #cccccc;
            background-color: #f0f0f0;
            padding: 0;
        }

        .sc-applicationHeader-content -cas {
            position: relative;
            padding: 10px 15px;
            max-width: 1200px;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            z-index: 9;
            clear: both;
        }

        .sc .sc-text {
            margin: 15px;
        }
    </style>
</head>
<body class="sc">
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
                                <li><a class="logout data-sc-registered" data-bind="click:logout" href="#">Log out</a></li>
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
                    <p style="margin-top: 10px;"><strong>Note:</strong> The <strong>data-parent</strong> attribute makes sure that all collapsible elements under the specified parent will be closed when one of the collapsible item is shown.</p>
                    <div>
                        <form runat="server" style="margin: 10px 0 10px 0;">
                            <asp:Label Text="Item Path: " runat="server"></asp:Label>
                            <asp:TextBox runat="server" ID="TxtItemPath" />
                            <asp:Button Text="Go" runat="server" OnClick="MediaAuditStats_Click" />
                        </form>
                    </div>
                    <p>
                        <asp:Label Text="" ID="LblMessage" runat="server" />
                    </p>
                    <div id="accordion">
                        <div class="card">
                            <div class="card-header">
                                <a class="card-link" data-toggle="collapse" href="#collapseOne">Media items with empty Alt field
                                </a>
                            </div>
                            <div id="collapseOne" class="collapse show" data-parent="#accordion">
                                <div class="card-body">
                                    <p>
                                        <asp:Label Text="" ID="LblImageItemNoAltText" runat="server" />
                                    </p>
                                    <p>
                                        <asp:Label Text="" ID="LblImageItemNoAltTextCount" runat="server" />
                                    </p>
                                    <asp:Repeater runat="server" ID="RptImageItemNoAltText">
                                        <HeaderTemplate>
                                            <table border="1" cellpadding="4" cellspacing="0">
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
                            <div class="card-header">
                                <a class="collapsed card-link" data-toggle="collapse" href="#collapseTwo">Media items grouped by file extension and size
                                </a>
                            </div>
                            <div id="collapseTwo" class="collapse" data-parent="#accordion">
                                <div class="card-body">
                                    <p>
                                        <asp:Label Text="" ID="LblMediaBySizeCount" runat="server" />
                                    </p>
                                    <asp:Repeater runat="server" ID="RptMediaBySize">
                                        <HeaderTemplate>
                                            <table border="1" cellpadding="4" cellspacing="0">
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
                            <div class="card-header">
                                <a class="collapsed card-link" data-toggle="collapse" href="#collapseThree">Media items updated in last 15 days
                                </a>
                            </div>
                            <div id="collapseThree" class="collapse" data-parent="#accordion">
                                <div class="card-body">
                                    <p>
                                        <asp:Label Text="" ID="LblMediaItemsLastUpdated" runat="server" />
                                    </p>
                                    <p>
                                        <asp:Label Text="" ID="LblMediaItemsLastUpdatedCount" runat="server" />
                                    </p>
                                    <asp:Repeater runat="server" ID="RptMediaItemsLastUpdated">
                                        <HeaderTemplate>
                                            <table border="1" cellpadding="4" cellspacing="0">
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
                            <div class="card-header">
                                <a class="collapsed card-link" data-toggle="collapse" href="#UnsedMedia">Media items that are not used by any content item.
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
                                    <asp:Repeater runat="server" ID="RptUnsedMedia">
                                        <HeaderTemplate>
                                            <table border="1" cellpadding="4" cellspacing="0">
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
                    </div>
                </div>
            </section>
        </div>
    </div>
</body>
</html>

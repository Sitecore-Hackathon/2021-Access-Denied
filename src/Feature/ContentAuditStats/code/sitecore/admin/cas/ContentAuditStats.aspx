<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContentAuditStats.aspx.cs" Inherits="Feature.ContentAuditStats.sitecore.admin.cas.ContentAuditStats" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Content Audit & Statistics</title>
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
                                <span data-sc-id="HeaderTitle" class="sc-text sc_Text_2 data-sc-registered" data-bind="text: text, visible: isVisible" data-sc-require="/-/speak/v1/business/text.js">Content Audit & Statistics - Dashboard</span>
                            </div>
                        </div>
                    </div>


                </header>
                <div class="container">

                    <form id="form1" runat="server" style="margin: 10px 0 10px 0;">
                        <p><a href="/sitecore/admin/cas/CASDashboard.aspx">Back to Dashboard</a></p>
                        <h4>This dashboard will show reports of <strong>Items updated with laste updated date and publish status</strong>, <strong>Items with broken links</strong>, <strong>Items with personalization</strong>, <strong>Items with workflow history</strong> and, <strong>Items Audit History</strong>.</h4>
                        <br />
                        Item ID or Path :&nbsp;
            <asp:TextBox ID="TextBox1" runat="server" Height="35px" Width="381px"></asp:TextBox>
                        <br />
                        <br />
                        Select Language :&nbsp;
            <asp:DropDownList ID="languageDropDownList" runat="server" Height="35px" Width="140px">
            </asp:DropDownList>
                        <br />
                        <br />
                        <asp:RadioButtonList ID="RadioButtonList1" class="radiobuttonlist" runat="server">
                            <asp:ListItem Value="0" Selected="True">Only Item</asp:ListItem>
                            <asp:ListItem Value="1">Include Children (Immediate sub-items only)</asp:ListItem>
                            <asp:ListItem Value="2">Include Descendants (All sub-items)</asp:ListItem>
                        </asp:RadioButtonList>
                        <br />
                        <asp:Button class="submit-button" ID="Button1" runat="server" Height="35px" OnClick="Button1_Click" OnClientClick="javascript:ShowProgressBar()" Text="Go" Width="216px" />
                        <br />
                        <br />

                        <asp:Label ID="labelResultcount" Height="35px" Style="font-size: 15px;" runat="server" Text="Label"></asp:Label>
                        <br />
                    </form>
                    <div id="accordion" class="accordion" runat="server" visible="false">
                        <h6 style="font-size: 15px;">Click on each below titles to view results !!!</h6>
                        <div class="card">
                            <div class="card-header" data-toggle="collapse" href="#collapseOne">
                                <a class="card-link">                                    
                                    Items with last updated date and is published in all databases
                                </a>
                            </div>
                            <div id="collapseOne" class="collapse" data-parent="#accordion">
                                <div class="card-body">
                                    <asp:Repeater runat="server" ID="RptItemUpdatedPublished">
                                        <HeaderTemplate>
                                            <table class="table-data" border="1" cellpadding="4" cellspacing="0">
                                                <tr>
                                                    <th>Item Path</th>
                                                    <th>Last Updated Date</th>
                                                    <th>Is Published to all databases</th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# DataBinder.Eval(Container.DataItem, "ItemPath") %></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "LastUpdatedDate") %></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "IsPublished") %></td>
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
                            <div class="card-header" data-toggle="collapse" href="#collapseTwo">
                                <a class="collapsed card-link">Items with broken links
                                </a>
                            </div>
                            <div id="collapseTwo" class="collapse" data-parent="#accordion">
                                <div class="card-body">
                                    <asp:Repeater runat="server" ID="RptItemBrokenLinks">
                                        <HeaderTemplate>
                                            <table class="table-data" border="1" cellpadding="4" cellspacing="0">
                                                <tr>
                                                    <th>Item Path</th>
                                                    <th>Broken Link Status</th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# DataBinder.Eval(Container.DataItem, "ItemPath") %></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "BrokenLinkReport") %></td>
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
                            <div class="card-header" data-toggle="collapse" href="#collapseThree">
                                <a class="collapsed card-link">Items with personalization
                                </a>
                            </div>
                            <div id="collapseThree" class="collapse" data-parent="#accordion">
                                <div class="card-body">
                                    <asp:Repeater runat="server" ID="RptItemPersonalization">
                                        <HeaderTemplate>
                                            <table class="table-data" border="1" cellpadding="4" cellspacing="0">
                                                <tr>
                                                    <th>Item Path</th>
                                                    <th>Personalization available</th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# DataBinder.Eval(Container.DataItem, "ItemPath") %></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "PersonalisationApplied") %></td>
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
                            <div class="card-header" data-toggle="collapse" href="#collapseFour">
                                <a class="collapsed card-link">Items with workflow details (workflow history of last 15 days)
                                </a>
                            </div>
                            <div id="collapseFour" class="collapse" data-parent="#accordion">
                                <div class="card-body">
                                    <asp:Repeater runat="server" ID="RptItemWorkflowHistory">
                                        <HeaderTemplate>
                                            <table class="table-data" border="1" cellpadding="4" cellspacing="0">
                                                <tr>
                                                    <th>Item Path</th>
                                                    <th>Workflow State</th>
                                                    <th>Workflow History</th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# DataBinder.Eval(Container.DataItem, "ItemPath") %></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "CurrentWorkflowState") %></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "WorkflowHistory") %></td>
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
                            <div class="card-header" data-toggle="collapse" href="#collapseFive">
                                <a class="collapsed card-link">Items audit history of last 15 days
                                </a>
                            </div>
                            <div id="collapseFive" class="collapse" data-parent="#accordion">
                                <div class="card-body">
                                    <asp:Repeater runat="server" ID="RptItemAuditLogs">
                                        <HeaderTemplate>
                                            <table class="table-data" border="1" cellpadding="4" cellspacing="0">
                                                <tr>
                                                    <th>Item Path</th>
                                                    <th>Audit Logs History</th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# DataBinder.Eval(Container.DataItem, "ItemPath") %></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "AuditLogs") %></td>
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
            <script src="Assets/js/main.js"></script>
        </div>
    </div>
</body>
</html>

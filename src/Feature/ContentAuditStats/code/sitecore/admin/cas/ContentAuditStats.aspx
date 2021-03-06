<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContentAuditStats.aspx.cs" Inherits="Feature.ContentAuditStats.sitecore.admin.cas.ContentAuditStats" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Content Audit and Statistics</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="Assets/css/bootstrap.min.css">
    <script src="Assets/js/jquery.min.js"></script>
    <script src="Assets/js/popper.min.js"></script>
    <script src="Assets/js/bootstrap.min.js"></script>
</head>
<body onload="javascript:HideProgressBar()">
    <div class="container">
        <h2>Content Audit and Statistics</h2>
        <form id="form1" runat="server">
            Item ID :&nbsp;
            <asp:TextBox ID="TextBox1" runat="server" Height="35px" Width="381px"></asp:TextBox>
            <br />
            <br />
            Select a Language :&nbsp;
            <asp:DropDownList ID="languageDropDownList" runat="server" Height="49px" Width="140px">
            </asp:DropDownList>
            <br />
            <br />
            <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                <asp:ListItem Value="0" Selected="True">Only Selected Item</asp:ListItem>
                <asp:ListItem Value="1">Selected Item and Children</asp:ListItem>
                <asp:ListItem Value="2">Selected Item and Deescendants</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            <asp:Button ID="Button1" runat="server" Height="50px" OnClick="Button1_Click" OnClientClick="javascript:ShowProgressBar()" Text="Get Content Stats" Width="216px" />
            <br />
            <br />

            <asp:Label ID="labelResultcount" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
        </form>
        <div id="accordion" runat="server" visible="false">
            <h6>Please click on each of them to view the results !!!</h6>
            <div class="card">
                <div class="card-header">
                    <a class="card-link" data-toggle="collapse" href="#collapseOne">ITEMS WITH LAST UPDATED DATE AND IS PUBLISHED IN ALL DATABASES
                    </a>
                </div>
                <div id="collapseOne" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                        <asp:Repeater runat="server" ID="RptItemUpdatedPublished">
                            <HeaderTemplate>
                                <table border="1" cellpadding="4" cellspacing="0">
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
                <div class="card-header">
                    <a class="collapsed card-link" data-toggle="collapse" href="#collapseTwo">ITEMS WITH BROKEN LINKS REPORT
                    </a>
                </div>
                <div id="collapseTwo" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                        <asp:Repeater runat="server" ID="RptItemBrokenLinks">
                            <HeaderTemplate>
                                <table border="1" cellpadding="4" cellspacing="0">
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
                <div class="card-header">
                    <a class="collapsed card-link" data-toggle="collapse" href="#collapseThree">ITEMS WITH PERSONALIZATION REPORT
                    </a>
                </div>
                <div id="collapseThree" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                        <asp:Repeater runat="server" ID="RptItemPersonalization">
                            <HeaderTemplate>
                                <table border="1" cellpadding="4" cellspacing="0">
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
                <div class="card-header">
                    <a class="collapsed card-link" data-toggle="collapse" href="#collapseFour">ITEMS WITH WORKFLOW HISTORY REPORT
                    </a>
                </div>
                <div id="collapseFour" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                        <asp:Repeater runat="server" ID="RptItemWorkflowHistory">
                            <HeaderTemplate>
                                <table border="1" cellpadding="4" cellspacing="0">
                                    <tr>
                                        <th>Item Path</th>
                                        <th>Workflow History</th>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# DataBinder.Eval(Container.DataItem, "ItemPath") %></td>
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
                <div class="card-header">
                    <a class="collapsed card-link" data-toggle="collapse" href="#collapseFive">ITEMS AUDIT LOGS
                    </a>
                </div>
                <div id="collapseFive" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                        <asp:Repeater runat="server" ID="RptItemAuditLogs">
                            <HeaderTemplate>
                                <table border="1" cellpadding="4" cellspacing="0">
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
    
    <script type='text/javascript'>
        function ShowProgressBar() {
            document.getElementById('accordion').style.visibility = 'hidden';
            document.getElementById('dvProgressBar').style.visibility = 'visible';
        }

        function HideProgressBar() {
            document.getElementById('dvProgressBar').style.visibility = "hidden";
        }
    </script>
</body>
</html>


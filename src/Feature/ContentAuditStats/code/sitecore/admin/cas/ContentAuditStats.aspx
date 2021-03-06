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

        .sc-applicationHeader-content -cas{
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
        .card a {
             font-size:15px;
         }
    </style>
</head>
<body onload="javascript:HideProgressBar()"class="sc">
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
      <span data-sc-id="HeaderTitle" class="sc-text sc_Text_2 data-sc-registered" data-bind="text: text, visible: isVisible" data-sc-require="/-/speak/v1/business/text.js">Content Audit & Statistics - Dashboard</span>
    </div>
  </div>
</div>
  

</header>
    <div class="container">        
        <form id="form1" runat="server" style="margin:10px 0 10px 0; ">
            Item ID or Path :&nbsp;
            <asp:TextBox ID="TextBox1" runat="server" Height="35px" Width="381px"></asp:TextBox>
            <br />
            <br />
            Select Language :&nbsp;
            <asp:DropDownList ID="languageDropDownList" runat="server" Height="35px" Width="140px">
            </asp:DropDownList>
            <br />
            <br />
            <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                <asp:ListItem Value="0" Selected="True">Only Selected Item</asp:ListItem>
                <asp:ListItem Value="1">Selected Item and Children</asp:ListItem>
                <asp:ListItem Value="2">Selected Item and Deescendants</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            <asp:Button ID="Button1" runat="server" Height="35px" OnClick="Button1_Click" OnClientClick="javascript:ShowProgressBar()" Text="Go" Width="216px" />
            <br />
            <br />

            <asp:Label ID="labelResultcount" Height="35px" style="font-size:15px;"  runat="server" Text="Label"></asp:Label>
            <br />
            <br />
        </form>
        <div id="accordion" runat="server" visible="false">
            <h6 style="font-size:15px;">Click on each below titles to view results !!!</h6>
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
    </section>


    </div>
    
  </div>
</body>
</html>
</body>
</html>


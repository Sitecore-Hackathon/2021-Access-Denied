<%@ Page language="c#"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Content Audit & Statistics - Dashboard</title>
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
      <span data-sc-id="HeaderTitle" class="sc-text sc_Text_2 data-sc-registered" data-bind="text: text, visible: isVisible" data-sc-require="/-/speak/v1/business/text.js">Content Audit & Statistics - Dashboard</span>
    </div>
  </div>
</div>
  

</header>

<section class="sc-applicationContent-main">
  <div data-sc-id="RowPanel1" class="row">

<div data-sc-id="c_cdbe06c2655911c9">
<div class="row row-0">                    <div class="col-md-4">
                        <div class="sc-controlpanel-box">
                            <div class="sc-controlpanel-box-header">
                                <h4><a href="ContentAuditStats.aspx" ><img src="/temp/iconcache/office/24x24/gearwheel.png" class="" alt="" width="24" height="24" border="0">Content Audit & Stats</a></h4>
                            </div>

                           
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="sc-controlpanel-box">
                            <div class="sc-controlpanel-box-header">
                                <h4><a href="MediaAuditStats.aspx" ><img src="/temp/iconcache/office/24x24/data.png" class="" alt="" width="24" height="24" border="0">Media Audit & Stats</a></h4>
                            </div>

                            
                        </div>
                    </div>
                 
</div>
    
</div>
</div></section>

</section>


    </div>
    
  </div>
</body>
</html>


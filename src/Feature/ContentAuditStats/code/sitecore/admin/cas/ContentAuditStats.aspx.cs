using Feature.ContentAuditStats.Models;
using Sitecore.Data;
using Sitecore.Data.Items;
using Sitecore.Data.Managers;
using Sitecore.Globalization;
using Sitecore.IO;
using Sitecore.Workflows;
using Sitecore.Workflows.Simple;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Feature.ContentAuditStats.sitecore.admin.cas
{
    public partial class ContentAuditStats : System.Web.UI.Page
    {
        Database database = Sitecore.Configuration.Factory.GetDatabase("master");
        protected void Page_Load(object sender, EventArgs e)
        {
            labelResultcount.Text = string.Empty;
            Dictionary<string, string> languages = GetAvailableLanguages();
            languageDropDownList.DataSource = languages;
            languageDropDownList.DataValueField = "Value";
            languageDropDownList.DataTextField = "Key";
            languageDropDownList.DataBind();
            accordion.Visible = false;
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            accordion.Visible = false;
            labelResultcount.Text = string.Empty;
            List<Item> finalItems = new List<Item>();
            var itemId = TextBox1.Text;
            if (string.IsNullOrEmpty(itemId))
            {
                labelResultcount.Text = "Please specify Item ID or Path";
                return;
            }
            var language = languageDropDownList.SelectedValue;
            var selectedRadioButtonValue = RadioButtonList1.SelectedValue;
            var item = database.GetItem(itemId, Language.Parse(language));
            if (item != null)
            {
                finalItems.Add(item);
                switch (selectedRadioButtonValue)
                {
                    case "1":
                        List<Item> childItems = item.GetChildren().ToList();
                        finalItems.AddRange(childItems);
                        break;
                    case "2":
                        List<Item> descendantItems = item.Axes.GetDescendants().ToList();
                        finalItems.AddRange(descendantItems);
                        break;
                    default:
                        break;
                }
                if (finalItems.Any())
                {
                    accordion.Visible = true;
                    labelResultcount.Text = $"Total items found : {finalItems.Count}";
                    // Items Updated and Published
                    var datasourceItemsUpdatedPublished = finalItems.Select(x => new ItemsUpdatedPublishedModel()
                    {
                        ItemPath = x.Paths.FullPath,
                        LastUpdatedDate = GetLastUpdated(x),
                        IsPublished = IsPublished(x, language)
                    });

                    RptItemUpdatedPublished.DataSource = datasourceItemsUpdatedPublished;
                    RptItemUpdatedPublished.DataBind();

                    // Item with broken links                
                    var datasourceItemsBrokenLinks = finalItems.Select(x => new ItemsBrokenLinksModel()
                    {
                        ItemPath = x.Paths.FullPath,
                        BrokenLinkReport = GetFinalString(HasBrokenLinks(x, language))

                    });

                    RptItemBrokenLinks.DataSource = datasourceItemsBrokenLinks;
                    RptItemBrokenLinks.DataBind();

                    // Item with personalization applied                
                    var datasourcePersonalization = finalItems.Select(x => new ItemsPersonalisationAppliedModel()
                    {
                        ItemPath = x.Paths.FullPath,
                        PersonalisationApplied = GetFinalString(HasPersonalisationApplied(x, language))

                    });

                    RptItemPersonalization.DataSource = datasourcePersonalization;
                    RptItemPersonalization.DataBind();

                    // Item with personalization applied                
                    var datasourceWorkFlowHistory = finalItems.Select(x => new ItemsWorkflowHistoryModel()
                    {
                        ItemPath = x.Paths.FullPath,
                        CurrentWorkflowState = GetCurrentWorkFlowState(x),
                        WorkflowHistory = GetFinalString(GetWorkflowHistory(x, language))

                    });

                    RptItemWorkflowHistory.DataSource = datasourceWorkFlowHistory;
                    RptItemWorkflowHistory.DataBind();

                    // Item Get Audit Logs for last 15 days                
                    var datasourceAuditLogs = finalItems.Select(x => new ItemsAuditLogsModel()
                    {
                        ItemPath = x.Paths.FullPath,
                        AuditLogs = GetAuditLogs(x, language)

                    });

                    RptItemAuditLogs.DataSource = datasourceAuditLogs;
                    RptItemAuditLogs.DataBind();

                }
                else
                {
                    accordion.Visible = false;
                    labelResultcount.Text = $"There are no items found for the given ID {itemId}";
                }
            }
            else
            {
                accordion.Visible = false;
                labelResultcount.Text = $"There is no item with Item ID : {itemId}";
            }

            // Clear and rebind dropdown list items
            languageDropDownList.Items.Clear();
            Dictionary<string, string> languages = GetAvailableLanguages();
            languageDropDownList.DataSource = languages;
            languageDropDownList.DataValueField = "Value";
            languageDropDownList.DataTextField = "Key";
            languageDropDownList.DataBind();
        }

        public string GetFinalString(List<string> resultStrings)
        {
            StringBuilder sb = new StringBuilder();
            foreach (var resultString in resultStrings)
            {
                sb.Append(resultString);
                sb.Append("<br/>");
            }
            return sb.ToString();
        }
        public DateTime GetLastUpdated(Item item)
        {
            return Sitecore.DateUtil.IsoDateToDateTime(item.Fields[Sitecore.FieldIDs.Updated].Value);
        }

        public string GetCurrentWorkFlowState(Item item)
        {
            var workflowID = item.Fields[Sitecore.FieldIDs.Workflow].Value;
            if (!string.IsNullOrWhiteSpace(workflowID))
            {
                IWorkflow itemWorkflow = database.WorkflowProvider.GetWorkflow(workflowID);
                if (itemWorkflow != null)
                {
                    var currentState = itemWorkflow.GetState(item);
                    if (currentState != null)
                    {
                        return $"Item is in {currentState.DisplayName} state of {itemWorkflow.WorkflowID} workflow";
                    }
                    else
                    {
                        return $"Item does not hae any workflow state in {itemWorkflow.WorkflowID} workflow";
                    }
                }
                else
                {
                    return $"Item {item.ID} does not have any workflow state assigned";
                }
            }
            else
            {
                return $"Item {item.ID} does not have any workflow state assigned";
            }
        }

        public List<string> HasBrokenLinks(Item item, string language)
        {
            var brokenLinks = item.Links.GetBrokenLinks(true);
            List<Item> broeknLinkItems = new List<Item>();
            List<string> brokenresult = new List<string>();

            if (brokenLinks != null && brokenLinks.Length > 0)
            {
                List<string> uniqueIdLookup = new List<string>();
                foreach (var brokenLink in brokenLinks)
                {
                    brokenresult.Add($"Item {brokenLink.SourceItemID.ToString()} points on {brokenLink.TargetPath}. Path: {brokenLink.TargetPath}");
                }
            }

            if (brokenresult.Count == 0)
            {
                brokenresult.Add($"Item {item.ID} does not have any broken links");
            }
            return brokenresult;
        }
        private static ArrayList GetRenderings(Sitecore.Data.Items.Item item, Sitecore.Data.ID renderingFieldId)
        {
            var field = item.Fields[renderingFieldId];
            var layoutXml = Sitecore.Data.Fields.LayoutField.GetFieldValue(field);
            var layout = Sitecore.Layouts.LayoutDefinition.Parse(layoutXml);
            var deviceLayout = layout.Devices[0] as Sitecore.Layouts.DeviceDefinition;
            return deviceLayout != null ? deviceLayout.Renderings : null;
        }
        public List<string> HasPersonalisationApplied(Item item, string language)
        {
            List<string> personalizationApplied = new List<string>();
            DeviceRecords devices = database.Resources.Devices;
            Sitecore.Data.Fields.LayoutField sharedLayoutField = item.Fields[Sitecore.FieldIDs.LayoutField];
            foreach (var device in devices.GetAll())
            {
                Sitecore.Layouts.RenderingReference[] renderings = sharedLayoutField.GetReferences(device);
                if (renderings != null && renderings.Count() > 0)
                {
                    var renderingsWithPersonalization = renderings.Where(r => r.Settings.Rules.Count > 0).ToList();
                    if (renderingsWithPersonalization.Count > 0)
                        personalizationApplied.Add($"Personalization are available in shared renderings for Item {item.ID} and device {device.Name}");
                }
            }
            Sitecore.Data.Fields.LayoutField finalLayoutField = item.Fields[Sitecore.FieldIDs.FinalLayoutField];
            foreach (var device in devices.GetAll())
            {
                Sitecore.Layouts.RenderingReference[] renderings = finalLayoutField.GetReferences(device);
                if (renderings != null && renderings.Count() > 0)
                {
                    var renderingsWithPersonalization = renderings.Where(r => r.Settings.Rules.Count > 0).ToList();
                    if (renderingsWithPersonalization.Count > 0)
                        personalizationApplied.Add($"Personalization are available in shared renderings for Item {item.ID} and device {device.Name}");
                }
            }
            if (personalizationApplied.Count() == 0)
            {
                personalizationApplied.Add($"No Personalization are available for item {item.ID}");
            }
            return personalizationApplied;
        }
        public List<string> GetWorkflowHistory(Item item, string language)
        {
            DateTime datetime = DateTime.Now.AddDays(-15);
            List<string> workFlowHistory = new List<string>();
            WorkflowEvent[] history = ((WorkflowProvider)item.Database.WorkflowProvider).HistoryStore.GetHistory(item);
            var workflowEvents = history.Where(x => x.Date > datetime && x.OldState != x.NewState);
            foreach (var workFlowEvent in workflowEvents)
            {
                var finalString = $"Date : {workFlowEvent.Date} - User = {workFlowEvent.User} - Previous Sate = {workFlowEvent.OldState} - New State = {workFlowEvent.NewState} - Comments = {workFlowEvent.CommentFields}";
                workFlowHistory.Add(finalString);
            }

            if (workFlowHistory.Count == 0)
            {
                workFlowHistory.Add($"No workflow history available for the item {item.ID} in last 15 days");
            }

            return workFlowHistory;
        }
        public string IsPublished(Item item, string language)
        {
            var publishingTargetsFolderId = "{D9E44555-02A6-407A-B4FC-96B9026CAADD}";
            var targetDatabaseFieldId = Sitecore.FieldIDs.PublishingTargetDatabase;
            var publishignTargetsFolder = database.GetItem(publishingTargetsFolderId);
            bool existsInAll = true;
            bool existsInOne = false;
            List<Database> targetDatabases = new List<Database>();
            if (publishignTargetsFolder != null)
            {
                foreach (Item publishingTarget in publishignTargetsFolder.GetChildren())
                {
                    targetDatabases.Add(Database.GetDatabase(publishingTarget[targetDatabaseFieldId]));
                }

                foreach (var targetDatabase in targetDatabases)
                {
                    var targetItem = targetDatabase.GetItem(item.ID);
                    if (targetItem != null)
                    {
                        existsInOne = true;
                    }
                    else
                    {
                        existsInAll = false;
                    }
                }
                if (existsInAll)
                {
                    return $"Item {item.ID} exists in all databases";
                }
                else if (existsInOne)
                {
                    return $"Item {item.ID} exists in only one databases";
                }
                else
                {
                    return $"Item {item.ID} does not exists in any databases";
                }
            }
            else
            {
                return "Publishing Targets are null";
            }
        }
        public string GetAuditLogs(Item item, string language)
        {
            DateTime datetime = DateTime.Now.AddDays(-15);
            StringBuilder sb = new StringBuilder();
            var logFolder = FileUtil.MapPath(Sitecore.Configuration.Settings.LogFolder);
            DirectoryInfo info = new DirectoryInfo(logFolder);
            FileInfo[] files = info.GetFiles("log.*.txt").OrderBy(p => p.LastWriteTime > datetime).ToArray();
            foreach (var file in files)
            {
                var fileFullPath = Path.Combine(FileUtil.MapPath(Sitecore.Configuration.Settings.LogFolder), file.Name);
                using (FileStream stream = File.Open(fileFullPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
                {
                    StreamReader sr = new StreamReader(stream);
                    string line;
                    while ((line = sr.ReadLine()) != null)
                    {
                        if (line.Contains(item.ID.ToString()))
                        {
                            sb.Append(line);
                            sb.Append("<br/>");
                        }
                    }
                }
            }
            return sb.ToString();
        }

        private Dictionary<string, string> GetAvailableLanguages()
        {
            var result = new Dictionary<string, string>();
            var languages = LanguageManager.GetLanguages(database);
            
            foreach (var availablelanguage in languages)
            {
                result.Add(availablelanguage.Name, availablelanguage.Name);
            }
            return result;
        }
    }
}
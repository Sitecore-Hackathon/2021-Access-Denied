using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Feature.ContentAuditStats.Models
{
    public class ItemsUpdatedPublishedModel
    {
        public string ItemPath { get; set; }
        public DateTime LastUpdatedDate { get; set; }
        public string IsPublished { get; set; }
    }

    public class ItemsBrokenLinksModel
    {
        public string ItemPath { get; set; }
        public string BrokenLinkReport { get; set; }
    }

    public class ItemsPersonalisationAppliedModel
    {
        public string ItemPath { get; set; }
        public string PersonalisationApplied { get; set; }
    }

    public class ItemsWorkflowHistoryModel
    {
        public string ItemPath { get; set; }
        public string WorkflowHistory { get; set; }
    }
    public class ItemsAuditLogsModel
    {
        public string ItemPath { get; set; }
        public string AuditLogs { get; set; }
    }
}
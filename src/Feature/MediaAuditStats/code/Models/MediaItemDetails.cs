
using System;

namespace Feature.MediaAuditStats.Models
{
    public class MediaItemDetails
    {
        public string Size { get; set; }

        public string Extension { get; set; }

        public DateTime Updated { get; set; }

        public string UpdatedBy { get; set; }

        public DateTime Created { get; set; }

        public string CreatedBy { get; set; }

        public string Path { get; set; }

        public string TemplateName { get; set; }

        public string Name { get; set; }
    }
}
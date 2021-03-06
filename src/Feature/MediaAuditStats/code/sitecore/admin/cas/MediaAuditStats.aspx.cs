using Feature.MediaAuditStats.Models;
using Sitecore.Data;
using Sitecore.Data.Items;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Feature.MediaAuditStats.sitecore.admin.cas
{
    public partial class MediaAuditStats : System.Web.UI.Page
    {
        Database master = Sitecore.Configuration.Factory.GetDatabase("master");

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void GetImageItemNoAltText(string itemPath)
        {
            var mediaRootItem = master.GetItem("/sitecore/media library");
            var items = mediaRootItem.Axes.GetDescendants();

            if (items.Any())
            {
                var itemsNoAltText = items.Where(x => x.TemplateID != Sitecore.TemplateIDs.MediaFolder && !string.IsNullOrWhiteSpace(x["Alt"]));
                if (itemsNoAltText.Any())
                {
                    var datasource = itemsNoAltText.Select(x => new ImageItemNoAltText()
                    {
                        Size = x["Size"],
                        Extension = x["Extension"],
                        Updated = x["__Updated"],
                        UpdatedBy = x["__Updated by"],
                        Created = x["__Created"],
                        CreatedBy = x["__Created by"],
                        Path = x.Paths.FullPath

                    });
                    RptImageItemNoAltText.DataSource = datasource;
                    RptImageItemNoAltText.DataBind();
                }
                else
                {
                    string message = "There are no images with an empty Alt field.";
                }
            }

        }

        public void GetMediaItemsByType()
        {
            var mediaRootItem = master.GetItem("/sitecore/media library");
            var items = mediaRootItem.Axes.GetDescendants();

            if (items.Any())
            {

            }
        }

        protected void ImageItemNoAltText_Click(object sender, EventArgs e)
        {
            GetImageItemNoAltText(TxtItemPath.Text);
        }
    }
}
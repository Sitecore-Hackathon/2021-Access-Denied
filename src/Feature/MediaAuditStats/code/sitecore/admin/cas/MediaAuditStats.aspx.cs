using Feature.MediaAuditStats.Models;
using Sitecore;
using Sitecore.Data;
using Sitecore.Data.Items;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Feature.MediaAuditStats.sitecore.admin.cas
{
    public partial class MediaAuditStats : System.Web.UI.Page
    {
        Database master = Sitecore.Configuration.Factory.GetDatabase("master");

        protected void Page_Load(object sender, EventArgs e)
        {
            ClearLables();
            if (!Sitecore.Context.User.IsAdministrator)
            {
                Response.Redirect("http://" + HttpContext.Current.Request.Url.Host + "/sitecore/login?returnUrl=/sitecore/admin/cas/mediaauditstats.aspx");
            }
        }

        protected void MediaAuditStats_Click(object sender, EventArgs e)
        {
            var mediaRootItem = master.GetItem(TxtItemPath.Text);
            if (mediaRootItem != null)
            {
                List<Item> items = new List<Item>();
                if (mediaRootItem.TemplateID != Sitecore.TemplateIDs.MediaFolder)
                    items.Add(mediaRootItem);

                var descendants = mediaRootItem.Axes.GetDescendants();
                if (descendants.Any())
                    items.AddRange(descendants.Where(x => x.TemplateID != Sitecore.TemplateIDs.MediaFolder));

                if (items.Any())
                {
                    GetMeidaItemsNoAltText(items);
                    GetMediaItemsByType(items);
                    GetMediaItemsLastUpdated(items);
                    GetUnusedMediaItems(items);
                }
                else
                {
                    ClearLables();
                    LblMessage.Text = "There is no media item under this folder.";
                }
            }
            else
            {
                ClearLables();
                LblMessage.Text = "Item does not exits in master database. Please check your item path.";
            }
        }

        private void GetMeidaItemsNoAltText(List<Item> items)
        {
            var itemsNoAltText = items.Where(x => !string.IsNullOrWhiteSpace(x["Alt"]));
            if (itemsNoAltText.Any())
            {
                LblImageItemNoAltTextCount.Text = $"Total Media Item Count: {itemsNoAltText.Count()}";
                var datasource = itemsNoAltText.Select(x => new MediaItemDetails()
                {
                    Name = x.Name,
                    Size = x["Size"],
                    Extension = x["Extension"],
                    Updated = x.Statistics.Updated,
                    UpdatedBy = x["__Updated by"],
                    Created = x.Statistics.Created,
                    CreatedBy = x["__Created by"],
                    Path = x.Paths.FullPath

                });
                RptImageItemNoAltText.DataSource = datasource;
                RptImageItemNoAltText.DataBind();
            }
            else
            {
                LblImageItemNoAltText.Text = "There are no images with an empty Alt field.";
            }
        }

        private void GetMediaItemsByType(List<Item> items)
        {
            LblMediaBySizeCount.Text = $"Total Media Item Count: {items.Count()}";
            var datasource = items.Select(x => new MediaItemDetails()
            {
                Name = x.Name,
                Extension = x["Extension"],
                Size = x["Size"],
                TemplateName = x.TemplateName,
                Path = x.Paths.FullPath
            });
            RptMediaBySize.DataSource = datasource.OrderBy(x => x.Extension).ThenByDescending(x => x.Size);
            RptMediaBySize.DataBind();
        }

        private void GetMediaItemsLastUpdated(List<Item> items)
        {
            DateTime datetime = DateTime.Now.AddDays(-15);
            var itemsLastUpdated = items.Where(x => x.Statistics.Updated > datetime);
            if (itemsLastUpdated.Any())
            {
                LblMediaItemsLastUpdatedCount.Text = $"Total Media Item Count: {itemsLastUpdated.Count()}";
                var datasource = itemsLastUpdated.Select(x => new MediaItemDetails()
                {
                    Name = x.Name,
                    Size = x["Size"],
                    Extension = x["Extension"],
                    Updated = x.Statistics.Updated,
                    UpdatedBy = x["__Updated by"],
                    Created = x.Statistics.Created,
                    CreatedBy = x["__Created by"],
                    Path = x.Paths.FullPath

                });

                RptMediaItemsLastUpdated.DataSource = datasource;
                RptMediaItemsLastUpdated.DataBind();
            }
            else
            {
                LblMediaItemsLastUpdated.Text = "There are no media items updated in last 15 days.";
            }
        }

        private void GetUnusedMediaItems(List<Item> items)
        {
            var unusedMedia = items.Where(x => GetLinkedItemsCount(x) == 0);
            if (unusedMedia.Any())
            {
                LblUnusedMediaCount.Text = $"Total Media Item Count: {unusedMedia.Count()}";
                var datasource = unusedMedia.Select(x => new MediaItemDetails()
                {
                    Name = x.Name,
                    Size = x["Size"],
                    Extension = x["Extension"],
                    Updated = x.Statistics.Updated,
                    UpdatedBy = x["__Updated by"],
                    Created = x.Statistics.Created,
                    CreatedBy = x["__Created by"],
                    Path = x.Paths.FullPath

                });

                RptUnsedMedia.DataSource = datasource;
                RptUnsedMedia.DataBind();
            }
            else
            {
                LblUnusedMedia.Text = "There are no unused media items.";
            }
        }

        private static int GetLinkedItemsCount(Item refItem)
        {
            // getting all linked Items that refer to the “refItem” Item
            return Globals.LinkDatabase.GetReferrerCount(refItem);
        }

        private void ClearLables()
        {
            LblUnusedMediaCount.Text = "";
            LblImageItemNoAltTextCount.Text = "";
            LblMediaItemsLastUpdatedCount.Text = "";
            LblMediaBySizeCount.Text = "";
            LblMessage.Text = "";
            LblUnusedMedia.Text = "";
            LblImageItemNoAltText.Text = "";
            LblMediaItemsLastUpdated.Text = "";
        }
    }
}
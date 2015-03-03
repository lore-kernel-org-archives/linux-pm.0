From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: cleanup: rename gpd -> genpd in debugfs interface
Date: Tue, 3 Mar 2015 14:24:11 +0100
Message-ID: <CAPDyKFq1x2oSctwOQNw4_RyS5b_vWRJcFaa8b277ptKjpKQm3Q@mail.gmail.com>
References: <1425324268-16090-1-git-send-email-khilman@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425324268-16090-1-git-send-email-khilman@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Maciej Matraszek <m.matraszek@samsung.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2 March 2015 at 20:24, Kevin Hilman <khilman@kernel.org> wrote:
> From: Kevin Hilman <khilman@linaro.org>
>
> To keep consisitency with the rest of the file, use 'genpd' as the
> name of the 'struct generic_pm_domain' pointer instead of 'gpd'.
>
> This is just a rename, no functional changes.
>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/power/domain.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ba4abbe4693c..45937f88e77c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2242,7 +2242,7 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
>  }
>
>  static int pm_genpd_summary_one(struct seq_file *s,
> -               struct generic_pm_domain *gpd)
> +                               struct generic_pm_domain *genpd)
>  {
>         static const char * const status_lookup[] = {
>                 [GPD_STATE_ACTIVE] = "on",
> @@ -2256,26 +2256,26 @@ static int pm_genpd_summary_one(struct seq_file *s,
>         struct gpd_link *link;
>         int ret;
>
> -       ret = mutex_lock_interruptible(&gpd->lock);
> +       ret = mutex_lock_interruptible(&genpd->lock);
>         if (ret)
>                 return -ERESTARTSYS;
>
> -       if (WARN_ON(gpd->status >= ARRAY_SIZE(status_lookup)))
> +       if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
>                 goto exit;
> -       seq_printf(s, "%-30s  %-15s  ", gpd->name, status_lookup[gpd->status]);
> +       seq_printf(s, "%-30s  %-15s  ", genpd->name, status_lookup[genpd->status]);
>
>         /*
>          * Modifications on the list require holding locks on both
>          * master and slave, so we are safe.
> -        * Also gpd->name is immutable.
> +        * Also genpd->name is immutable.
>          */
> -       list_for_each_entry(link, &gpd->master_links, master_node) {
> +       list_for_each_entry(link, &genpd->master_links, master_node) {
>                 seq_printf(s, "%s", link->slave->name);
> -               if (!list_is_last(&link->master_node, &gpd->master_links))
> +               if (!list_is_last(&link->master_node, &genpd->master_links))
>                         seq_puts(s, ", ");
>         }
>
> -       list_for_each_entry(pm_data, &gpd->dev_list, list_node) {
> +       list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
>                 kobj_path = kobject_get_path(&pm_data->dev->kobj, GFP_KERNEL);
>                 if (kobj_path == NULL)
>                         continue;
> @@ -2287,14 +2287,14 @@ static int pm_genpd_summary_one(struct seq_file *s,
>
>         seq_puts(s, "\n");
>  exit:
> -       mutex_unlock(&gpd->lock);
> +       mutex_unlock(&genpd->lock);
>
>         return 0;
>  }
>
>  static int pm_genpd_summary_show(struct seq_file *s, void *data)
>  {
> -       struct generic_pm_domain *gpd;
> +       struct generic_pm_domain *genpd;
>         int ret = 0;
>
>         seq_puts(s, "    domain                      status         slaves\n");
> @@ -2305,8 +2305,8 @@ static int pm_genpd_summary_show(struct seq_file *s, void *data)
>         if (ret)
>                 return -ERESTARTSYS;
>
> -       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> -               ret = pm_genpd_summary_one(s, gpd);
> +       list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> +               ret = pm_genpd_summary_one(s, genpd);
>                 if (ret)
>                         break;
>         }
> --
> 2.1.3
>

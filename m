From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 08/10] PM / Domains: Store the provider in the PM
 domain structure
Date: Mon, 12 Sep 2016 14:56:18 +0200
Message-ID: <CAPDyKFr-Y6024XK8EzXox6L0EkHXg6tsa0bAmCe-QA1OFfwo+w@mail.gmail.com>
References: <1473678074-15126-1-git-send-email-jonathanh@nvidia.com> <1473678074-15126-9-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34310 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758551AbcILM4V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2016 08:56:21 -0400
Received: by mail-wm0-f47.google.com with SMTP id a6so4364894wmc.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2016 05:56:20 -0700 (PDT)
In-Reply-To: <1473678074-15126-9-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 12 September 2016 at 13:01, Jon Hunter <jonathanh@nvidia.com> wrote:
> It is possible that a device has more than one provider of PM domains
> and to support the removal of a PM domain by provider, it is necessary
> to store a reference to the provider in the PM domain structure.
> Therefore, store a reference to the firmware node handle in the PM
> domain structure and populate it when providers (only device-tree based
> providers are currently supported by PM domains) are registered.
>
> Please note that when removing PM domains, it is necessary to verify
> that the PM domain provider has been removed from the list of providers
> before the PM domain can be removed. To do this add another member to
> the PM domain structure that indicates if the provider is present and
> set this member accordingly when providers are added and removed.
>
> Initialise the 'provider' and 'has_provider' members of the
> generic_pm_domain structure when a PM domains is added by calling
> pm_genpd_init().
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 42 +++++++++++++++++++++++++++++++++++++-----
>  include/linux/pm_domain.h   |  2 ++
>  2 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 1bd8d412db06..d5135caa84db 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1306,6 +1306,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         genpd->device_count = 0;
>         genpd->max_off_time_ns = -1;
>         genpd->max_off_time_changed = true;
> +       genpd->provider = NULL;
> +       genpd->has_provider = false;
>         genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
>         genpd->domain.ops.runtime_resume = genpd_runtime_resume;
>         genpd->domain.ops.prepare = pm_genpd_prepare;
> @@ -1491,6 +1493,11 @@ int of_genpd_add_provider_simple(struct device_node *np,
>         if (pm_genpd_present(genpd))
>                 ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
>
> +       if (!ret) {
> +               genpd->provider = &np->fwnode;
> +               genpd->has_provider = true;
> +       }
> +
>         mutex_unlock(&gpd_list_lock);
>
>         return ret;
> @@ -1506,7 +1513,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>                                   struct genpd_onecell_data *data)
>  {
>         unsigned int i;
> -       int ret;
> +       int ret = -EINVAL;
>
>         if (!np || !data)
>                 return -EINVAL;
> @@ -1514,13 +1521,26 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>         mutex_lock(&gpd_list_lock);
>
>         for (i = 0; i < data->num_domains; i++) {
> -               if (!pm_genpd_present(data->domains[i])) {
> -                       mutex_unlock(&gpd_list_lock);
> -                       return -EINVAL;
> -               }
> +               if (!pm_genpd_present(data->domains[i]))
> +                       goto error;
> +
> +               data->domains[i]->provider = &np->fwnode;
> +               data->domains[i]->has_provider = true;
>         }
>
>         ret = genpd_add_provider(np, genpd_xlate_onecell, data);
> +       if (ret < 0)
> +               goto error;
> +
> +       mutex_unlock(&gpd_list_lock);
> +
> +       return 0;
> +
> +error:
> +       while (i--) {
> +               data->domains[i]->provider = NULL;
> +               data->domains[i]->has_provider = false;
> +       }
>
>         mutex_unlock(&gpd_list_lock);
>
> @@ -1535,10 +1555,21 @@ EXPORT_SYMBOL_GPL(of_genpd_add_provider_onecell);
>  void of_genpd_del_provider(struct device_node *np)
>  {
>         struct of_genpd_provider *cp;
> +       struct generic_pm_domain *gpd;
>
> +       mutex_lock(&gpd_list_lock);
>         mutex_lock(&of_genpd_mutex);
>         list_for_each_entry(cp, &of_genpd_providers, link) {
>                 if (cp->node == np) {
> +                       /*
> +                        * For each PM domain associated with the
> +                        * provider, set the 'has_provider' to false
> +                        * so that the PM domain can be safely removed.
> +                        */
> +                       list_for_each_entry(gpd, &gpd_list, gpd_list_node)
> +                               if (gpd->provider == &np->fwnode)
> +                                       gpd->has_provider = false;
> +
>                         list_del(&cp->link);
>                         of_node_put(cp->node);
>                         kfree(cp);
> @@ -1546,6 +1577,7 @@ void of_genpd_del_provider(struct device_node *np)
>                 }
>         }
>         mutex_unlock(&of_genpd_mutex);
> +       mutex_unlock(&gpd_list_lock);
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f103869db443..554f8915c691 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -51,6 +51,8 @@ struct generic_pm_domain {
>         struct mutex lock;
>         struct dev_power_governor *gov;
>         struct work_struct power_off_work;
> +       struct fwnode_handle *provider; /* Identity of the domain provider */
> +       bool has_provider;
>         const char *name;
>         atomic_t sd_count;      /* Number of subdomains with power "on" */
>         enum gpd_status status; /* Current state of the domain */
> --
> 2.1.4
>

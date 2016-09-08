From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 08/10] PM / Domains: Add support for removing PM domains
Date: Thu, 8 Sep 2016 13:49:14 +0200
Message-ID: <CAPDyKFrVO9wb3ffmxA7HUUDt1_aYxe=aqa1v+xNpdrYiLt_m0A@mail.gmail.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com> <1471340976-5379-9-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37527 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbcIHLtR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2016 07:49:17 -0400
Received: by mail-wm0-f53.google.com with SMTP id w12so84090318wmf.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Sep 2016 04:49:16 -0700 (PDT)
In-Reply-To: <1471340976-5379-9-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 16 August 2016 at 11:49, Jon Hunter <jonathanh@nvidia.com> wrote:
> The genpd framework allows users to add PM domains via the pm_genpd_init()
> function, however, there is no corresponding function to remove a PM
> domain. For most devices this may be fine as the PM domains are never
> removed, however, for devices that wish to populate the PM domains from
> within a driver, having the ability to remove a PM domain if the probing
> of the device fails or the driver is unloaded is necessary.
>
> Add the function pm_genpd_remove() to remove a PM domain by referencing
> it's generic_pm_domain structure.
>
> PM domains can only be removed if they are not a parent domain to
> another PM domain and have no devices associated with them.

I think we should also check if the there's is a provider registered
for the genpd, as it should also prevent the genpd from being removed.
Right?

I noticed that you are adding the ->provider pointer to the genpd
struct in patch 9/10. Perhaps re-structure $subject patch and 9/10 a
bit to deal with this, so we can add the pm_genpd_remove() API in a
more safe manner.

Kind regards
Uffe

>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/base/power/domain.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  5 +++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7ce4608bbbe0..72b973539205 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1356,6 +1356,52 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_init);
>
> +/**
> + * pm_genpd_remove - Remove a generic I/O PM domain
> + * @genpd: Pointer to PM domain that is to be removed.
> + *
> + * To remove the PM domain, this function:
> + *  - Removes the PM domain as a subdomain to any parent domains,
> + *    if it was added.
> + *  - Removes the PM domain from the list of registered PM domains.
> + *
> + * The PM domain will only be removed, if it is not a parent to any
> + * other PM domain and has no devices associated with it.
> + */
> +int pm_genpd_remove(struct generic_pm_domain *genpd)
> +{
> +       struct gpd_link *l, *link;
> +       int ret = 0;
> +
> +       if (IS_ERR_OR_NULL(genpd))
> +               return -EINVAL;
> +
> +       mutex_lock(&gpd_list_lock);
> +       mutex_lock(&genpd->lock);
> +
> +       if (!list_empty(&genpd->master_links) || genpd->device_count) {
> +               mutex_unlock(&genpd->lock);
> +               mutex_unlock(&gpd_list_lock);
> +               pr_err("%s: unable to remove %s\n", __func__, genpd->name);
> +               return -EBUSY;
> +       }
> +
> +       list_for_each_entry_safe(link, l, &genpd->slave_links, slave_node) {
> +               list_del(&link->master_node);
> +               list_del(&link->slave_node);
> +               kfree(link);
> +       }
> +
> +       list_del(&genpd->gpd_list_node);
> +       mutex_unlock(&genpd->lock);
> +       cancel_work_sync(&genpd->power_off_work);
> +       mutex_unlock(&gpd_list_lock);
> +       pr_debug("%s: removed %s\n", __func__, genpd->name);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_remove);
> +
>  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>
>  typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f103869db443..fbdc5c4588ef 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -128,6 +128,7 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>                                      struct generic_pm_domain *target);
>  extern int pm_genpd_init(struct generic_pm_domain *genpd,
>                          struct dev_power_governor *gov, bool is_off);
> +extern int pm_genpd_remove(struct generic_pm_domain *genpd);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -163,6 +164,10 @@ static inline int pm_genpd_init(struct generic_pm_domain *genpd,
>  {
>         return -ENOSYS;
>  }
> +static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
> +{
> +       return -ENOTSUPP;
> +}
>  #endif
>
>  static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
> --
> 2.1.4
>

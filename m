From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 09/10] PM / Domains: Add support for removing PM domains
Date: Mon, 12 Sep 2016 14:56:31 +0200
Message-ID: <CAPDyKFpJAQTUrjF+X4X-83pYevRtYv3Exm=8+mW25_1Snnmhpg@mail.gmail.com>
References: <1473678074-15126-1-git-send-email-jonathanh@nvidia.com> <1473678074-15126-10-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473678074-15126-10-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 12 September 2016 at 13:01, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> The genpd framework allows users to add PM domains via the pm_genpd_init()
> function, however, there is no corresponding function to remove a PM
> domain. For most devices this may be fine as the PM domains are never
> removed, however, for devices that wish to populate the PM domains from
> within a driver, having the ability to remove a PM domain if the probing
> of the device fails or the driver is unloaded is necessary.
>
> Add the function pm_genpd_remove() to remove a PM domain by referencing
> it's generic_pm_domain structure. Note that the bulk of the code that
> removes the PM domain is placed in a separate local function
> genpd_remove() (which is called by pm_genpd_remove()). The code is
> structured in this way to prepare for adding another function to remove
> a PM domain by provider that will also call genpd_remove(). Note that
> users of genpd_remove() must call this function with the mutex,
> gpd_list_lock, held.
>
> PM domains can only be removed if the associated provider has been
> removed, they are not a parent domain to another PM domain and have no
> devices associated with them.
>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  5 ++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index d5135caa84db..7481e3e316a2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1358,6 +1358,66 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_init);
>
> +static int genpd_remove(struct generic_pm_domain *genpd)
> +{
> +       struct gpd_link *l, *link;
> +
> +       if (IS_ERR_OR_NULL(genpd))
> +               return -EINVAL;
> +
> +       mutex_lock(&genpd->lock);
> +
> +       if (genpd->has_provider) {
> +               mutex_unlock(&genpd->lock);
> +               pr_err("Provider present, unable to remove %s\n", genpd->name);
> +               return -EBUSY;
> +       }
> +
> +       if (!list_empty(&genpd->master_links) || genpd->device_count) {
> +               mutex_unlock(&genpd->lock);
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
> +       pr_debug("%s: removed %s\n", __func__, genpd->name);
> +
> +       return 0;
> +}
> +
> +/**
> + * pm_genpd_remove - Remove a generic I/O PM domain
> + * @genpd: Pointer to PM domain that is to be removed.
> + *
> + * To remove the PM domain, this function:
> + *  - Removes the PM domain as a subdomain to any parent domains,
> + *    if it was added.
> + *  - Removes the PM domain from the list of registered PM domains.
> + *
> + * The PM domain will only be removed, if the associated provider has
> + * been removed, it is not a parent to any other PM domain and has no
> + * devices associated with it.
> + */
> +int pm_genpd_remove(struct generic_pm_domain *genpd)
> +{
> +       int ret;
> +
> +       mutex_lock(&gpd_list_lock);
> +       ret = genpd_remove(genpd);
> +       mutex_unlock(&gpd_list_lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_remove);
> +
>  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>
>  typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 554f8915c691..85f7d53a9827 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -130,6 +130,7 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>                                      struct generic_pm_domain *target);
>  extern int pm_genpd_init(struct generic_pm_domain *genpd,
>                          struct dev_power_governor *gov, bool is_off);
> +extern int pm_genpd_remove(struct generic_pm_domain *genpd);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -165,6 +166,10 @@ static inline int pm_genpd_init(struct generic_pm_domain *genpd,
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

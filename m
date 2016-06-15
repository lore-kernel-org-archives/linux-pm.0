From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 8/8] PM / Domains: Add support for removing PM domains
Date: Wed, 15 Jun 2016 16:33:59 +0200
Message-ID: <CAPDyKFrKCB00hHhpSaJZ57wThPFRjnp+3xMz_YW9k+zqafppHg@mail.gmail.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com> <1457090634-14785-9-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457090634-14785-9-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 4 March 2016 at 12:23, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
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
> If a device supports nested or subdomains, then the PM domains
> should be removed in reverse order to ensure that the subdomains are
> removed first. Hence, add the function pm_genpd_remove_tail() to remove
> the last PM domain added by a given provider and return the
> generic_pm_domain structure for the PM domain that was removed.

Perhaps split this up, so the pm_genpd_remove_tail() gets added in a
separate patch on top.

>
> PM domains can only be removed if they are not a parent domain to
> another PM domain and have no devices associated with them.
>
> When removing PM domains, the PM domain will also be removed from the
> list of providers, if it was registered.
>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/base/power/domain.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 12 ++++++
>  2 files changed, 108 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9b33377bf01b..17090e1c91d6 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1556,6 +1556,102 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_init);
>
> +/**
> + * __pm_genpd_remove - Remove a generic I/O PM domain
> + * @genpd: Pointer to PM domain that is to be removed.
> + *
> + * To remove the PM domain, this function:
> + *  - Removes the PM domain from the list of providers, if registered.
> + *  - Removes the PM domain as a subdomain to any parent domains,
> + *    if it was added.
> + *  - Removes the PM domain from the list of registered PM domains.
> + *
> + * The PM domain will only be removed, if it is not a parent to any
> + * other PM domain and has no devices associated with it. Must be called
> + * with the gpd_list_lock held.
> + */
> +static int __pm_genpd_remove(struct generic_pm_domain *genpd)

Please rename to genpd_remove() as it's a static function.

> +{
> +       struct gpd_link *l, *link;
> +       int ret = 0;
> +
> +       if (IS_ERR_OR_NULL(genpd))
> +               return -EINVAL;
> +
> +       if (genpd->provider_data)
> +               of_genpd_del_provider_by_data(genpd->provider_data);
> +
> +       mutex_lock(&genpd->lock);
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
> +       return ret;
> +}
> +
> +/**
> + * pm_genpd_remove - Remove a generic I/O PM domain
> + * @genpd: Pointer to PM domain that is to be removed.
> + */
> +int pm_genpd_remove(struct generic_pm_domain *genpd)
> +{
> +       int ret;
> +
> +       mutex_lock(&gpd_list_lock);
> +       ret = __pm_genpd_remove(genpd);
> +       mutex_unlock(&gpd_list_lock);
> +
> +       return ret;
> +}
> +
> +/**
> + * pm_genpd_remove_tail - Remove the last PM domain registered for a provider
> + * @provider: Pointer to device structure associated with provider
> + *
> + * Find the last PM domain that was added by the provider whose 'provider'
> + * device structure matches the device structure given. The 'provider'
> + * device structure for a given PM domain should be initialised by the
> + * device that is creating the PM domains and hence, calling
> + * pm_genpd_init().

Maybe make this a bigger "Important note" as what is needed to
actually benefit from using this function.

> + *
> + * Returns a valid pointer to struct generic_pm_domain on success or
> + * ERR_PTR() on failure.
> + */
> +struct generic_pm_domain *pm_genpd_remove_tail(struct device *provider)
> +{
> +       struct generic_pm_domain *g, *gpd, *genpd = ERR_PTR(-ENOENT);
> +       int ret;
> +
> +       if (IS_ERR_OR_NULL(provider))
> +               return ERR_PTR(-EINVAL);
> +
> +       mutex_lock(&gpd_list_lock);
> +       list_for_each_entry_safe(gpd, g, &gpd_list, gpd_list_node) {
> +               if (gpd->provider == provider) {
> +                       ret = __pm_genpd_remove(gpd);
> +                       genpd = ret ? ERR_PTR(ret) : gpd;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&gpd_list_lock);
> +
> +       return genpd;
> +}
> +
>  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>  /*
>   * Device Tree based PM domain providers.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 7b7921a65cb0..78b23718392f 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -53,6 +53,7 @@ struct generic_pm_domain {
>         struct mutex lock;
>         struct dev_power_governor *gov;
>         struct work_struct power_off_work;
> +       struct device *provider;        /* Identity of the domain provider */
>         void *provider_data;
>         const char *name;
>         atomic_t sd_count;      /* Number of subdomains with power "on" */
> @@ -132,6 +133,8 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>                                      struct generic_pm_domain *target);
>  extern void pm_genpd_init(struct generic_pm_domain *genpd,
>                           struct dev_power_governor *gov, bool is_off);
> +extern int pm_genpd_remove(struct generic_pm_domain *genpd);
> +extern struct generic_pm_domain *pm_genpd_remove_tail(struct device *provider);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -166,6 +169,15 @@ static inline void pm_genpd_init(struct generic_pm_domain *genpd,
>                                  struct dev_power_governor *gov, bool is_off)
>  {
>  }
> +static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
> +{
> +       return -ENOTSUPP;
> +}
> +static inline
> +struct generic_pm_domain *pm_genpd_remove_tail(struct device *provider)
> +{
> +       return ERR_PTR(-ENOTSUPP);
> +}
>  #endif
>
>  static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
> --
> 2.1.4
>

Kind regards
Uffe

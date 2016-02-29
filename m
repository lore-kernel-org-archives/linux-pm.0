From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V6 02/10] PM / Domains: Add function to get the last
 domain added
Date: Mon, 29 Feb 2016 14:32:23 +0100
Message-ID: <CAPDyKFqi0o7sROm2sEgL7Gcf6F6yi4REWKHP7RVRrNBDRGTPjw@mail.gmail.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
	<1456501724-28477-3-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35010 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754AbcB2NcZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 08:32:25 -0500
Received: by mail-wm0-f52.google.com with SMTP id l68so62577250wml.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 05:32:24 -0800 (PST)
In-Reply-To: <1456501724-28477-3-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 26 February 2016 at 16:48, Jon Hunter <jonathanh@nvidia.com> wrote:
> To remove generic PM domains in a sane way, we need to remove them by
> starting from the last PM domain added. The reason for this is that a PM
> domain may be a subdomain of another and so we need to remove the child
> PM domains for a given domain first. By removing PM domains in reverse
> order we can ensure that the children are removed first.
>
> Add a new function to get the last PM domain that was added. In case PM
> domains are added by more than one device in the system (for example,
> on-chip domains and off-chip domains) add a 'owner' device structure
> to the generic PM domain structure so that the ownership of a PM domain
> can be identified by the device structure of the device that added it
> Use this 'owner' device structure to return the last PM domain added by
> this device.
>
> Note that because pm_genpd_init() simply adds each PM domain to the
> head of the gpd_list object, list_for_each_entry() will start from the
> last PM domain added.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

I don't have a strong opinion about what to call the device structure.
Both "owner" or "dev" is okay by me.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> This is the outcome from a discussion I had with Ulf on how best to
> handle the removal of power-domains [0]. I opted to call the device
> structure 'owner' because 'parent' could be misleading if a power
> domain is a child of another power domain. However, open to suggestions!
>
> [0] http://marc.info/?l=linux-pm&m=145460070816340&w=2
>
>  drivers/base/power/domain.c | 25 +++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  7 +++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ea9f2aa3fc33..608bc00655ee 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -65,6 +65,31 @@ struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev)
>  }
>
>  /*
> + * Get the last generic PM domain added whose 'owner' device structure
> + * matches the device structure provided. The 'owner' device structure
> + * for a given PM domain should be initialised by the device that is
> + * creating the PM domains and hence, calling pm_genpd_init().
> + */
> +struct generic_pm_domain *pm_genpd_list_get_tail(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd = NULL, *gpd;
> +
> +       if (IS_ERR_OR_NULL(dev))
> +               return NULL;
> +
> +       mutex_lock(&gpd_list_lock);
> +       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> +               if (gpd->owner == dev) {
> +                       genpd = gpd;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&gpd_list_lock);
> +
> +       return genpd;
> +}
> +
> +/*
>   * This should only be used where we are certain that the pm_domain
>   * attached to the device is a genpd domain.
>   */
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 49cd8890b873..b38dd74dea9b 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -46,6 +46,7 @@ struct genpd_power_state {
>
>  struct generic_pm_domain {
>         struct dev_pm_domain domain;    /* PM domain operations */
> +       struct device *owner;           /* Identity of the domain owner */
>         struct list_head gpd_list_node; /* Node in the global PM domains list */
>         struct list_head master_links;  /* Links with PM domain as a master */
>         struct list_head slave_links;   /* Links with PM domain as a slave */
> @@ -120,6 +121,7 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
>  }
>
>  extern struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev);
> +extern struct generic_pm_domain *pm_genpd_list_get_tail(struct device *dev);
>  extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
>                                  struct device *dev,
>                                  struct gpd_timing_data *td);
> @@ -145,6 +147,11 @@ static inline struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev)
>  {
>         return NULL;
>  }
> +static inline
> +struct generic_pm_domain *pm_genpd_list_get_tail(struct device *dev)
> +{
> +       return NULL;
> +}
>  static inline int __pm_genpd_add_device(struct generic_pm_domain *genpd,
>                                         struct device *dev,
>                                         struct gpd_timing_data *td)
> --
> 2.1.4
>

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V6 03/10] PM / Domains: Add function to remove a pm-domain
Date: Mon, 29 Feb 2016 14:45:17 +0100
Message-ID: <CAPDyKFrn9=0Uxzrg0FOGm5Vntyd+m_9YoiNPcupEiMwP+BNxwQ@mail.gmail.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
	<1456501724-28477-4-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33327 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbcB2NpU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 08:45:20 -0500
Received: by mail-wm0-f47.google.com with SMTP id l68so37424703wml.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 05:45:19 -0800 (PST)
In-Reply-To: <1456501724-28477-4-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 26 February 2016 at 16:48, Jon Hunter <jonathanh@nvidia.com> wrote:
> The genpd framework allows users to add power-domains via the
> pm_genpd_init() function, however, there is no corresponding function
> to remove a power-domain. For most devices this may be fine as the power
> domains are never removed, however, for devices that wish to populate
> the power-domains from within a driver, having the ability to remove a
> power domain if the probing of the device fails or the driver is unloaded
> is necessary. Therefore, add a function to remove a power-domain. Please
> note that the power domain can only be removed if there are no devices
> using the power-domain and it is not linked to another domain.

In general I think you can work a bit on the changelog, for example
split it into a few sections to make it more readable.

I would like it to state clearly what constraint we have to be able to
remove a PM domain. More precisely, the device structure is needed, no
of genpd provider etc. Maybe also "linked to another domain" can be
rephrased to tell about both masters and subdomains.

Finally, perhaps change terminology for the "power-domain" to "PM
domain" as I think that's more widely used.

>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/base/power/domain.c | 31 +++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  5 +++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 608bc00655ee..22f6e9d738bf 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1557,6 +1557,37 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_init);
>
> +/**
> + * pm_genpd_remove - Remove a generic I/O PM domain object.
> + * @genpd: PM domain object to remove.
> + */
> +int pm_genpd_remove(struct generic_pm_domain *genpd)
> +{
> +       int ret = 0;
> +
> +       if (IS_ERR_OR_NULL(genpd))
> +               return -EINVAL;
> +
> +       mutex_lock(&gpd_list_lock);
> +       mutex_lock(&genpd->lock);
> +
> +       if (!list_empty(&genpd->master_links)
> +           || !list_empty(&genpd->slave_links) || genpd->device_count) {
> +               ret = -EBUSY;
> +               goto out;
> +       }
> +
> +       cancel_work_sync(&genpd->power_off_work);

This can deadlock as the work function tries to lock the genpd mutex.

I suggest to move this outside of the locking section just before
returning, but of course still only in case of a non-error.

> +       list_del(&genpd->gpd_list_node);
> +
> +out:
> +       mutex_unlock(&genpd->lock);
> +       mutex_unlock(&gpd_list_lock);
> +

Besides the minor comment above.

1) Have you considered how to protects against a registered
of_genpd_provider for the genpd?

2) Theoretically some could call pm_genpd_add_subdomain() after this
point. I guess we can consider that as an abuse of the API, although
do you think we need to protect that from really happening?

> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_remove);
> +
>  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>  /*
>   * Device Tree based PM domain providers.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index b38dd74dea9b..9ae9c42f807f 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -134,6 +134,7 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>                                      struct generic_pm_domain *target);
>  extern void pm_genpd_init(struct generic_pm_domain *genpd,
>                           struct dev_power_governor *gov, bool is_off);
> +extern int pm_genpd_remove(struct generic_pm_domain *genpd);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -177,6 +178,10 @@ static inline void pm_genpd_init(struct generic_pm_domain *genpd,
>                                  struct dev_power_governor *gov, bool is_off)
>  {
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

Kind regards
Uffe

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 07/10] PM / Domains: Prepare for adding support to remove
 PM domains
Date: Thu, 8 Sep 2016 13:41:07 +0200
Message-ID: <CAPDyKFp1ww6fcd+UXaH_qdC+C52+BkDFteiqqHyM4poFUQc=_w@mail.gmail.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com> <1471340976-5379-8-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37362 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932739AbcIHLlJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2016 07:41:09 -0400
Received: by mail-wm0-f46.google.com with SMTP id w12so83708151wmf.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Sep 2016 04:41:08 -0700 (PDT)
In-Reply-To: <1471340976-5379-8-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 16 August 2016 at 11:49, Jon Hunter <jonathanh@nvidia.com> wrote:
> In order to remove PM domains safely from the list of PM domains,
> it is necessary to adding locking for the PM domain list around any
> places where devices or subdomains are added to a PM domain.
>
> There are places where a reference to a PM domain is obtained via
> calling of_genpd_get_from_provider() before adding the device or the
> subdomain. In these cases a lock for the PM domain list needs to be
> held around the call to of_genpd_get_from_provider() and the call to
> add the device/subdomain. To avoid deadlocks by multiple attempts to
> obtain the PM domain list lock, add functions genpd_add_device() and
> genpd_add_subdomain() which require the user to hold the PM domain
> list lock when calling.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 97 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 50223ae0c9a7..7ce4608bbbe0 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1060,14 +1060,8 @@ static void genpd_free_dev_data(struct device *dev,
>         dev_pm_put_subsys_data(dev);
>  }
>
> -/**
> - * __pm_genpd_add_device - Add a device to an I/O PM domain.
> - * @genpd: PM domain to add the device to.
> - * @dev: Device to be added.
> - * @td: Set of PM QoS timing parameters to attach to the device.
> - */
> -int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
> -                         struct gpd_timing_data *td)
> +static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
> +                           struct gpd_timing_data *td)
>  {
>         struct generic_pm_domain_data *gpd_data;
>         int ret = 0;
> @@ -1107,6 +1101,24 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>
>         return ret;
>  }
> +
> +/**
> + * __pm_genpd_add_device - Add a device to an I/O PM domain.
> + * @genpd: PM domain to add the device to.
> + * @dev: Device to be added.
> + * @td: Set of PM QoS timing parameters to attach to the device.
> + */
> +int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
> +                         struct gpd_timing_data *td)
> +{
> +       int ret;
> +
> +       mutex_lock(&gpd_list_lock);
> +       ret = genpd_add_device(genpd, dev, td);
> +       mutex_unlock(&gpd_list_lock);
> +
> +       return ret;
> +}
>  EXPORT_SYMBOL_GPL(__pm_genpd_add_device);
>
>  /**
> @@ -1160,13 +1172,8 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_remove_device);
>
> -/**
> - * pm_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
> - * @genpd: Master PM domain to add the subdomain to.
> - * @subdomain: Subdomain to be added.
> - */
> -int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
> -                          struct generic_pm_domain *subdomain)
> +static int genpd_add_subdomain(struct generic_pm_domain *genpd,
> +                              struct generic_pm_domain *subdomain)
>  {
>         struct gpd_link *link, *itr;
>         int ret = 0;
> @@ -1209,6 +1216,23 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>                 kfree(link);
>         return ret;
>  }
> +
> +/**
> + * pm_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
> + * @genpd: Master PM domain to add the subdomain to.
> + * @subdomain: Subdomain to be added.
> + */
> +int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
> +                          struct generic_pm_domain *subdomain)
> +{
> +       int ret;
> +
> +       mutex_lock(&gpd_list_lock);
> +       ret = genpd_add_subdomain(genpd, subdomain);
> +       mutex_unlock(&gpd_list_lock);
> +
> +       return ret;
> +}
>  EXPORT_SYMBOL_GPL(pm_genpd_add_subdomain);
>
>  /**
> @@ -1575,12 +1599,22 @@ static struct generic_pm_domain *genpd_get_from_provider(
>  int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
>  {
>         struct generic_pm_domain *genpd;
> +       int ret;
> +
> +       mutex_lock(&gpd_list_lock);
>
>         genpd = genpd_get_from_provider(genpdspec);
> -       if (IS_ERR(genpd))
> -               return PTR_ERR(genpd);
> +       if (IS_ERR(genpd)) {
> +               ret = PTR_ERR(genpd);
> +               goto out;
> +       }
>
> -       return pm_genpd_add_device(genpd, dev);
> +       ret = genpd_add_device(genpd, dev, NULL);
> +
> +out:
> +       mutex_unlock(&gpd_list_lock);
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_add_device);
>
> @@ -1597,16 +1631,28 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
>                            struct of_phandle_args *subdomain_spec)
>  {
>         struct generic_pm_domain *parent, *subdomain;
> +       int ret;
> +
> +       mutex_lock(&gpd_list_lock);
>
>         parent = genpd_get_from_provider(parent_spec);
> -       if (IS_ERR(parent))
> -               return PTR_ERR(parent);
> +       if (IS_ERR(parent)) {
> +               ret = PTR_ERR(parent);
> +               goto out;
> +       }
>
>         subdomain = genpd_get_from_provider(subdomain_spec);
> -       if (IS_ERR(subdomain))
> -               return PTR_ERR(subdomain);
> +       if (IS_ERR(subdomain)) {
> +               ret = PTR_ERR(subdomain);
> +               goto out;
> +       }
> +
> +       ret = genpd_add_subdomain(parent, subdomain);
> +
> +out:
> +       mutex_unlock(&gpd_list_lock);
>
> -       return pm_genpd_add_subdomain(parent, subdomain);
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
>
> @@ -1705,9 +1751,11 @@ int genpd_dev_pm_attach(struct device *dev)
>                         return -ENOENT;
>         }
>
> +       mutex_lock(&gpd_list_lock);
>         pd = genpd_get_from_provider(&pd_args);
>         of_node_put(pd_args.np);
>         if (IS_ERR(pd)) {
> +               mutex_unlock(&gpd_list_lock);
>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>                         __func__, PTR_ERR(pd));
>                 return -EPROBE_DEFER;
> @@ -1716,13 +1764,14 @@ int genpd_dev_pm_attach(struct device *dev)
>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
>
>         for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
> -               ret = pm_genpd_add_device(pd, dev);
> +               ret = genpd_add_device(pd, dev, NULL);
>                 if (ret != -EAGAIN)
>                         break;
>
>                 mdelay(i);
>                 cond_resched();
>         }
> +       mutex_unlock(&gpd_list_lock);
>
>         if (ret < 0) {
>                 dev_err(dev, "failed to add to PM domain %s: %d",
> --
> 2.1.4
>

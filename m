From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC][PATCH] PM / Domains: Return -EPROBE_DEFER if we fail to
 init or turn-on domain
Date: Wed, 24 Jun 2015 12:18:36 +0200
Message-ID: <CAPDyKFrH_LFcLm_nbuu9z0=Q6eEV2SRF82nXKUPpF-CZgmR81Q@mail.gmail.com>
References: <1434649967-21135-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34459 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbbFXKSh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2015 06:18:37 -0400
Received: by qkeo142 with SMTP id o142so19241326qke.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2015 03:18:36 -0700 (PDT)
In-Reply-To: <1434649967-21135-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 18 June 2015 at 19:52, Jon Hunter <jonathanh@nvidia.com> wrote:
> When a device is probed, the function dev_pm_domain_attach() is called
> to see if there is a power-domain that is associated with the device and
> needs to be turned on. If dev_pm_domain_attach() does not return
> -EPROBE_DEFER then the device will be probed.
>
> For devices using genpd, dev_pm_domain_attach() will call
> genpd_dev_pm_attach(). If genpd_dev_pm_attach() does not find a power
> domain associated with the device then it returns an error code not
> equal to -EPROBE_DEFER to allow the device to be probed. However, if
> genpd_dev_pm_attach() does find a power-domain that is associated with
> the device, then it does not return -EPROBE_DEFER on failure and hence
> the device will still be probed. Furthermore, genpd_dev_pm_attach() does
> not check the error code returned by pm_genpd_poweron() to see if the
> power-domain was turned on successfully.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

This is a clear improvement for genpd and as a short-term solution I
am fine with this!

The long term solution should be to implement the
pm_domain->activate|dismiss() callbacks, but that requires a bigger
effort.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> FWICT, it seems to me that we would not want to probe the device if
> there is a power-domain associated but we fail to initialise it or
> it fails to turn on. Of course I could be wrong here and so please
> let me know if my interpretation is utterly flawed in someway ;-)
>
>  drivers/base/power/domain.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index cdd547bd67df..c69e87ccb150 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2177,7 +2177,10 @@ static void genpd_dev_pm_sync(struct device *dev)
>   * Both generic and legacy Samsung-specific DT bindings are supported to keep
>   * backwards compatibility with existing DTBs.
>   *
> - * Returns 0 on successfully attached PM domain or negative error code.
> + * Returns 0 on successfully attached PM domain or negative error code. Note
> + * that if a power-domain exists for the device, but it cannot be found or
> + * turned on, then return -EPROBE_DEFER to ensure that the device is not
> + * probed and to re-try again later.
>   */
>  int genpd_dev_pm_attach(struct device *dev)
>  {
> @@ -2213,7 +2216,7 @@ int genpd_dev_pm_attach(struct device *dev)
>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>                         __func__, PTR_ERR(pd));
>                 of_node_put(dev->of_node);
> -               return PTR_ERR(pd);
> +               return -EPROBE_DEFER;
>         }
>
>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> @@ -2229,14 +2232,15 @@ int genpd_dev_pm_attach(struct device *dev)
>                 dev_err(dev, "failed to add to PM domain %s: %d",
>                         pd->name, ret);
>                 of_node_put(dev->of_node);
> -               return ret;
> +               goto out;
>         }
>
>         dev->pm_domain->detach = genpd_dev_pm_detach;
>         dev->pm_domain->sync = genpd_dev_pm_sync;
> -       pm_genpd_poweron(pd);
> +       ret = pm_genpd_poweron(pd);
>
> -       return 0;
> +out:
> +       return ret ? -EPROBE_DEFER : 0;
>  }
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
> --
> 2.1.4
>

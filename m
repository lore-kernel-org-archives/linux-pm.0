From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 06/10] PM / Domains: Verify the PM domain is present when
 adding a provider
Date: Thu, 8 Sep 2016 13:39:32 +0200
Message-ID: <CAPDyKFoLh6f3at-grfWmeRuvLwW+o=4sLG0kExuF+eZxDF_hHA@mail.gmail.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com> <1471340976-5379-7-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38629 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757386AbcIHLjf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2016 07:39:35 -0400
Received: by mail-wm0-f48.google.com with SMTP id 1so83395878wmz.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Sep 2016 04:39:34 -0700 (PDT)
In-Reply-To: <1471340976-5379-7-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 16 August 2016 at 11:49, Jon Hunter <jonathanh@nvidia.com> wrote:
> When a PM domain provider is added, there is currently no way to tell if
> any PM domains associated with the provider are present. Naturally, the
> PM domain provider should not be registered if the PM domains have not
> been added. Nonetheless, verify that the PM domain(s) associated with a
> provider are present when registering the PM domain provider.
>
> This change adds a dependency on the function pm_genpd_present() when
> CONFIG_PM_GENERIC_DOMAINS_OF is enabled and so ensure this function is
> available when CONFIG_PM_GENERIC_DOMAINS_OF selected.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/base/power/domain.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index d09e45145a3d..50223ae0c9a7 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -586,7 +586,7 @@ static int __init genpd_poweroff_unused(void)
>  }
>  late_initcall(genpd_poweroff_unused);
>
> -#ifdef CONFIG_PM_SLEEP
> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_GENERIC_DOMAINS_OF)
>
>  /**
>   * pm_genpd_present - Check if the given PM domain has been initialized.
> @@ -606,6 +606,10 @@ static bool pm_genpd_present(const struct generic_pm_domain *genpd)
>         return false;
>  }
>
> +#endif
> +
> +#ifdef CONFIG_PM_SLEEP
> +
>  static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,
>                                     struct device *dev)
>  {
> @@ -1453,7 +1457,23 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
>  int of_genpd_add_provider_simple(struct device_node *np,
>                                  struct generic_pm_domain *genpd)
>  {
> -       return genpd_add_provider(np, genpd_xlate_simple, genpd);
> +       int ret;
> +
> +       if (!np || !genpd)
> +               return -EINVAL;
> +
> +       mutex_lock(&gpd_list_lock);
> +
> +       if (!pm_genpd_present(genpd)) {
> +               mutex_unlock(&gpd_list_lock);
> +               return -EINVAL;
> +       }
> +
> +       ret = genpd_add_provider(np, genpd_xlate_simple, genpd);

You could simplify this, by assigning ret and initial value of
-EINVAL, then do like this:

if (pm_genpd_present(genpd))
    ret = genpd_add_provider(np, genpd_xlate_simple, genpd);

> +
> +       mutex_unlock(&gpd_list_lock);
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
>
> @@ -1465,7 +1485,26 @@ EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
>  int of_genpd_add_provider_onecell(struct device_node *np,
>                                   struct genpd_onecell_data *data)
>  {
> -       return genpd_add_provider(np, genpd_xlate_onecell, data);
> +       unsigned int i;
> +       int ret;
> +
> +       if (!np || !data)
> +               return -EINVAL;
> +
> +       mutex_lock(&gpd_list_lock);
> +
> +       for (i = 0; i < data->num_domains; i++) {
> +               if (!pm_genpd_present(data->domains[i])) {
> +                       mutex_unlock(&gpd_list_lock);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       ret = genpd_add_provider(np, genpd_xlate_onecell, data);
> +
> +       mutex_unlock(&gpd_list_lock);
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_add_provider_onecell);
>
> --
> 2.1.4
>

Besides the minor nitpick above, you may add my ack.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

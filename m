From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 4/8] PM / Domains: Don't expose generic_pm_domain structure
Date: Fri, 5 Aug 2016 13:55:57 +0200
Message-ID: <CAPDyKFpDj5t0yW4AwsBDh-4z3YN=4WBH8z=xnK-WVAnNE9UbiQ@mail.gmail.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com> <1457090634-14785-5-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37630 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965433AbcHEL4A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2016 07:56:00 -0400
Received: by mail-wm0-f41.google.com with SMTP id i5so33632343wmg.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Aug 2016 04:55:59 -0700 (PDT)
In-Reply-To: <1457090634-14785-5-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 4 March 2016 at 12:23, Jon Hunter <jonathanh@nvidia.com> wrote:
> There should be no need to expose the generic_pm_domain structure and
> this eliminates the need to implement reference counting for any external
> reference to a PM domain. Therefore, make the functions
> pm_genpd_lookup_dev() and of_genpd_get_from_provider() private to the PM
> domain core.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/base/power/domain.c |  5 ++---
>  include/linux/pm_domain.h   | 14 --------------
>  2 files changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b24893499454..c2ba1d6dbad3 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -45,7 +45,7 @@ static DEFINE_MUTEX(gpd_list_lock);
>   * and checks that the PM domain pointer is a real generic PM domain.
>   * Any failure results in NULL being returned.
>   */
> -struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev)
> +static struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev)

Please rename function to genpd_lookup_dev() to follow naming rules
for static functions.

>  {
>         struct generic_pm_domain *genpd = NULL, *gpd;
>
> @@ -1680,7 +1680,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>   * Returns a valid pointer to struct generic_pm_domain on success or ERR_PTR()
>   * on failure.
>   */
> -struct generic_pm_domain *of_genpd_get_from_provider(
> +static struct generic_pm_domain *of_genpd_get_from_provider(
>                                         struct of_phandle_args *genpdspec)
>  {

Please rename function to genpd_get_from_provider() to follow naming
rules for static functions.

>         struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
> @@ -1703,7 +1703,6 @@ struct generic_pm_domain *of_genpd_get_from_provider(
>
>         return genpd;
>  }
> -EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
>
>  /**
>   * of_genpd_add_device() - Add a device to an I/O PM domain
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 2b6ee670b231..510512d5390e 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -119,7 +119,6 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
>         return to_gpd_data(dev->power.subsys_data->domain_data);
>  }
>
> -extern struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev);
>  extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
>                                  struct device *dev,
>                                  struct gpd_timing_data *td);
> @@ -141,10 +140,6 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
>  {
>         return ERR_PTR(-ENOSYS);
>  }
> -static inline struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev)
> -{
> -       return NULL;
> -}
>  static inline int __pm_genpd_add_device(struct generic_pm_domain *genpd,
>                                         struct device *dev,
>                                         struct gpd_timing_data *td)
> @@ -201,9 +196,6 @@ typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
>  int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
>                         void *data);
>  void of_genpd_del_provider(struct device_node *np);
> -struct generic_pm_domain *of_genpd_get_from_provider(
> -                       struct of_phandle_args *genpdspec);
> -
>  struct generic_pm_domain *__of_genpd_xlate_simple(
>                                         struct of_phandle_args *genpdspec,
>                                         void *data);
> @@ -224,12 +216,6 @@ static inline int __of_genpd_add_provider(struct device_node *np,
>  }
>  static inline void of_genpd_del_provider(struct device_node *np) {}
>
> -static inline struct generic_pm_domain *of_genpd_get_from_provider(
> -                       struct of_phandle_args *genpdspec)
> -{
> -       return NULL;
> -}
> -
>  #define __of_genpd_xlate_simple                NULL
>  #define __of_genpd_xlate_onecell       NULL
>
> --
> 2.1.4
>

Besides the minor nitpicks, this looks good to me!

Kind regards
Uffe

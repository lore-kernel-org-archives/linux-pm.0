From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 6/8] PM / Domains: Remove a provider by referencing
 the data pointer
Date: Wed, 15 Jun 2016 16:38:17 +0200
Message-ID: <CAPDyKFpLcnLvQmpQgzhOExq67XrbaW9Nf1Gk2Y+CND8dn_cmyA@mail.gmail.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com> <1457090634-14785-7-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457090634-14785-7-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 4 March 2016 at 12:23, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> To remove a PM domain from the system, it is necessary to ensure
> that any PM domain providers associated with the PM domain have
> been removed. Otherwise it could be possible to obtain a pointer
> to a PM domain structure that has been removed.
>
> PM domains now have a reference to the pointer for the PM domain
> provider's data variable. Add a function so that a PM domain can
> remove a PM domain provider by referencing the data pointer.
>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/base/power/domain.c | 24 ++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  2 ++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 72055fef6256..438885f2455f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1738,6 +1738,30 @@ void of_genpd_del_provider(struct device_node *np)
>  EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>
>  /**
> + * of_genpd_del_provider_by_data() - Remove a registered PM domain provider
> + * @data: Pointer to the data associated with the PM domain provider
> + *
> + * Look up a PM domain provider based upon a pointer to it's data and
> + * remove the PM domain provider from the list of providers.
> + */
> +void of_genpd_del_provider_by_data(void *data)
> +{
> +       struct of_genpd_provider *c, *cp;
> +
> +       mutex_lock(&of_genpd_mutex);
> +       list_for_each_entry_safe(cp, c, &of_genpd_providers, link) {
> +               if (cp->data == data) {
> +                       list_del(&cp->link);
> +                       of_node_put(cp->node);
> +                       kfree(cp);
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&of_genpd_mutex);
> +}
> +EXPORT_SYMBOL_GPL(of_genpd_del_provider_by_data);
> +
> +/**
>   * of_genpd_get_from_provider() - Look-up PM domain
>   * @genpdspec: OF phandle args to use for look-up
>   *
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index bed84413546f..7b7921a65cb0 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -199,6 +199,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
>  int of_genpd_add_provider_onecell(struct device_node *np,
>                                   struct genpd_onecell_data *data);
>  void of_genpd_del_provider(struct device_node *np);

There's currently only one user of of_genpd_del_provider().

Could this patch just convert that user to the new API, so we don't
need to keep both the legacy and new one?

I guess we could then just stick to the name "of_genpd_del_provider()".

> +void of_genpd_del_provider_by_data(void *data);
>  struct generic_pm_domain *__of_genpd_xlate_simple(
>                                         struct of_phandle_args *genpdspec,
>                                         void *data);
> @@ -218,6 +219,7 @@ static inline int __of_genpd_add_provider(struct device_node *np,
>         return 0;
>  }
>  static inline void of_genpd_del_provider(struct device_node *np) {}
> +static inline void of_genpd_del_provider_by_data(void *data) {}
>
>  #define __of_genpd_xlate_simple                NULL
>  #define __of_genpd_xlate_onecell       NULL
> --
> 2.1.4
>

Kind regards
Uffe

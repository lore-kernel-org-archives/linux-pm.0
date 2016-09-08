From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/10] PM / Domains: Don't expose xlate and provider
 helper functions
Date: Thu, 8 Sep 2016 13:36:17 +0200
Message-ID: <CAPDyKFqhThByVbZGHRE1EsED6Du3FOYnqGZAGUNfMh=1VNcN+w@mail.gmail.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com> <1471340976-5379-6-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471340976-5379-6-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 16 August 2016 at 11:49, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Functions __of_genpd_xlate_simple(), __of_genpd_xlate_onecell() and
> __of_genpd_add_provider() are not used outside of the core generic PM
> domain code. Therefore, reduce the number of APIs exposed by making
> these static. At the same time don't expose the typedef for
> genpd_xlate_t either and make this a local definition as well.
>
> The functions are renamed to follow the naming conventions for static
> functions in the generic PM domain core.
>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 49 ++++++++++++++++++++++++++++++++++-----------
>  include/linux/pm_domain.h   | 42 +++++++++++++-------------------------
>  2 files changed, 51 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7b0aecef2e51..d09e45145a3d 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1329,6 +1329,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>  EXPORT_SYMBOL_GPL(pm_genpd_init);
>
>  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> +
> +typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
> +                                                  void *data);
> +
>  /*
>   * Device Tree based PM domain providers.
>   *
> @@ -1340,8 +1344,8 @@ EXPORT_SYMBOL_GPL(pm_genpd_init);
>   * maps a PM domain specifier retrieved from the device tree to a PM domain.
>   *
>   * Two simple mapping functions have been provided for convenience:
> - *  - __of_genpd_xlate_simple() for 1:1 device tree node to PM domain mapping.
> - *  - __of_genpd_xlate_onecell() for mapping of multiple PM domains per node by
> + *  - genpd_xlate_simple() for 1:1 device tree node to PM domain mapping.
> + *  - genpd_xlate_onecell() for mapping of multiple PM domains per node by
>   *    index.
>   */
>
> @@ -1366,7 +1370,7 @@ static LIST_HEAD(of_genpd_providers);
>  static DEFINE_MUTEX(of_genpd_mutex);
>
>  /**
> - * __of_genpd_xlate_simple() - Xlate function for direct node-domain mapping
> + * genpd_xlate_simple() - Xlate function for direct node-domain mapping
>   * @genpdspec: OF phandle args to map into a PM domain
>   * @data: xlate function private data - pointer to struct generic_pm_domain
>   *
> @@ -1374,7 +1378,7 @@ static DEFINE_MUTEX(of_genpd_mutex);
>   * have their own device tree nodes. The private data of xlate function needs
>   * to be a valid pointer to struct generic_pm_domain.
>   */
> -struct generic_pm_domain *__of_genpd_xlate_simple(
> +static struct generic_pm_domain *genpd_xlate_simple(
>                                         struct of_phandle_args *genpdspec,
>                                         void *data)
>  {
> @@ -1382,10 +1386,9 @@ struct generic_pm_domain *__of_genpd_xlate_simple(
>                 return ERR_PTR(-EINVAL);
>         return data;
>  }
> -EXPORT_SYMBOL_GPL(__of_genpd_xlate_simple);
>
>  /**
> - * __of_genpd_xlate_onecell() - Xlate function using a single index.
> + * genpd_xlate_onecell() - Xlate function using a single index.
>   * @genpdspec: OF phandle args to map into a PM domain
>   * @data: xlate function private data - pointer to struct genpd_onecell_data
>   *
> @@ -1394,7 +1397,7 @@ EXPORT_SYMBOL_GPL(__of_genpd_xlate_simple);
>   * A single cell is used as an index into an array of PM domains specified in
>   * the genpd_onecell_data struct when registering the provider.
>   */
> -struct generic_pm_domain *__of_genpd_xlate_onecell(
> +static struct generic_pm_domain *genpd_xlate_onecell(
>                                         struct of_phandle_args *genpdspec,
>                                         void *data)
>  {
> @@ -1414,16 +1417,15 @@ struct generic_pm_domain *__of_genpd_xlate_onecell(
>
>         return genpd_data->domains[idx];
>  }
> -EXPORT_SYMBOL_GPL(__of_genpd_xlate_onecell);
>
>  /**
> - * __of_genpd_add_provider() - Register a PM domain provider for a node
> + * genpd_add_provider() - Register a PM domain provider for a node
>   * @np: Device node pointer associated with the PM domain provider.
>   * @xlate: Callback for decoding PM domain from phandle arguments.
>   * @data: Context pointer for @xlate callback.
>   */
> -int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
> -                       void *data)
> +static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
> +                             void *data)
>  {
>         struct of_genpd_provider *cp;
>
> @@ -1442,7 +1444,30 @@ int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
>
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(__of_genpd_add_provider);
> +
> +/**
> + * of_genpd_add_provider_simple() - Register a simple PM domain provider
> + * @np: Device node pointer associated with the PM domain provider.
> + * @genpd: Pointer to PM domain associated with the PM domain provider.
> + */
> +int of_genpd_add_provider_simple(struct device_node *np,
> +                                struct generic_pm_domain *genpd)
> +{
> +       return genpd_add_provider(np, genpd_xlate_simple, genpd);
> +}
> +EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
> +
> +/**
> + * of_genpd_add_provider_onecell() - Register a onecell PM domain provider
> + * @np: Device node pointer associated with the PM domain provider.
> + * @data: Pointer to the data associated with the PM domain provider.
> + */
> +int of_genpd_add_provider_onecell(struct device_node *np,
> +                                 struct genpd_onecell_data *data)
> +{
> +       return genpd_add_provider(np, genpd_xlate_onecell, data);
> +}
> +EXPORT_SYMBOL_GPL(of_genpd_add_provider_onecell);
>
>  /**
>   * of_genpd_del_provider() - Remove a previously registered PM domain provider
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index bd411e754f4a..f103869db443 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -187,19 +187,12 @@ struct genpd_onecell_data {
>         unsigned int num_domains;
>  };
>
> -typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
> -                                               void *data);
> -
>  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> -int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
> -                       void *data);
> +int of_genpd_add_provider_simple(struct device_node *np,
> +                                struct generic_pm_domain *genpd);
> +int of_genpd_add_provider_onecell(struct device_node *np,
> +                                 struct genpd_onecell_data *data);
>  void of_genpd_del_provider(struct device_node *np);
> -struct generic_pm_domain *__of_genpd_xlate_simple(
> -                                       struct of_phandle_args *genpdspec,
> -                                       void *data);
> -struct generic_pm_domain *__of_genpd_xlate_onecell(
> -                                       struct of_phandle_args *genpdspec,
> -                                       void *data);
>  extern int of_genpd_add_device(struct of_phandle_args *args,
>                                struct device *dev);
>  extern int of_genpd_add_subdomain(struct of_phandle_args *parent,
> @@ -207,15 +200,19 @@ extern int of_genpd_add_subdomain(struct of_phandle_args *parent,
>
>  int genpd_dev_pm_attach(struct device *dev);
>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
> -static inline int __of_genpd_add_provider(struct device_node *np,
> -                                       genpd_xlate_t xlate, void *data)
> +static inline int of_genpd_add_provider_simple(struct device_node *np,
> +                                       struct generic_pm_domain *genpd)
>  {
> -       return 0;
> +       return -ENOTSUPP;
> +}
> +
> +static inline int of_genpd_add_provider_onecell(struct device_node *np,
> +                                       struct genpd_onecell_data *data)
> +{
> +       return -ENOTSUPP;
>  }
> -static inline void of_genpd_del_provider(struct device_node *np) {}
>
> -#define __of_genpd_xlate_simple                NULL
> -#define __of_genpd_xlate_onecell       NULL
> +static inline void of_genpd_del_provider(struct device_node *np) {}
>
>  static inline int of_genpd_add_device(struct of_phandle_args *args,
>                                       struct device *dev)
> @@ -235,17 +232,6 @@ static inline int genpd_dev_pm_attach(struct device *dev)
>  }
>  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>
> -static inline int of_genpd_add_provider_simple(struct device_node *np,
> -                                       struct generic_pm_domain *genpd)
> -{
> -       return __of_genpd_add_provider(np, __of_genpd_xlate_simple, genpd);
> -}
> -static inline int of_genpd_add_provider_onecell(struct device_node *np,
> -                                       struct genpd_onecell_data *data)
> -{
> -       return __of_genpd_add_provider(np, __of_genpd_xlate_onecell, data);
> -}
> -
>  #ifdef CONFIG_PM
>  extern int dev_pm_domain_attach(struct device *dev, bool power_on);
>  extern void dev_pm_domain_detach(struct device *dev, bool power_off);
> --
> 2.1.4
>

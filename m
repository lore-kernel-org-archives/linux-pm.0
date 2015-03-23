From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] pm: domains: factor out code to get the generic PM
 domain from a struct device
Date: Mon, 23 Mar 2015 14:28:14 +0100
Message-ID: <CAPDyKFrpM0TYnNvAX8Jw6zUAekh0=XXMJyxWxSgKSao=TQf62Q@mail.gmail.com>
References: <20150320171941.GK8656@n2100.arm.linux.org.uk>
	<E1YZ0b3-0000so-KG@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35493 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbCWN2P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2015 09:28:15 -0400
Received: by qgf74 with SMTP id 74so19182593qgf.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2015 06:28:14 -0700 (PDT)
In-Reply-To: <E1YZ0b3-0000so-KG@rmk-PC.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 20 March 2015 at 18:20, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> The PM domain code contains two methods to get the generic PM domain
> for a struct device.  One is dev_to_genpd() which is only safe when
> we know for certain that the device has a generic PM domain attached.
> The other is coded into genpd_dev_pm_detach() which ensures that the
> PM domain in the struct device is a generic PM domain (and so is safer).
>
> This commit factors out the safer version, documents it, and hides the
> unsafe dev_to_genpd().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/base/power/domain.c | 46 +++++++++++++++++++++++++++++++--------------
>  include/linux/pm_domain.h   |  6 +++---
>  2 files changed, 35 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b3fbc21da2dc..89d2eea7f561 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -68,7 +68,36 @@ static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
>         return genpd;
>  }
>
> -struct generic_pm_domain *dev_to_genpd(struct device *dev)
> +/*
> + * Get the generic PM domain for a particular struct device.
> + * This validates the struct device pointer, the PM domain pointer,
> + * and checks that the PM domain pointer is a real generic PM domain.
> + * Any failure results in NULL being returned.
> + */
> +struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev)

I wouldn't mind keeping also this function static, unless you foresee
users outside genpd?

If converting to static please rename it to genpd_lookup_dev().

> +{
> +       struct generic_pm_domain *genpd = NULL, *gpd;
> +
> +       if (IS_ERR_OR_NULL(dev) || IS_ERR_OR_NULL(dev->pm_domain))
> +               return NULL;
> +
> +       mutex_lock(&gpd_list_lock);
> +       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> +               if (&gpd->domain == dev->pm_domain) {
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
> + * This should only be used where we are certain that the pm_domain
> + * attached to the device is a genpd domain.
> + */
> +static struct generic_pm_domain *dev_to_genpd(struct device *dev)
>  {
>         if (IS_ERR_OR_NULL(dev->pm_domain))
>                 return ERR_PTR(-EINVAL);
> @@ -2120,21 +2149,10 @@ EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
>   */
>  static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>  {
> -       struct generic_pm_domain *pd = NULL, *gpd;
> +       struct generic_pm_domain *pd;
>         int ret = 0;
>
> -       if (!dev->pm_domain)
> -               return;
> -
> -       mutex_lock(&gpd_list_lock);
> -       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> -               if (&gpd->domain == dev->pm_domain) {
> -                       pd = gpd;
> -                       break;
> -               }
> -       }
> -       mutex_unlock(&gpd_list_lock);
> -
> +       pd = pm_genpd_lookup_dev(dev);
>         if (!pd)
>                 return;
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index a9edab2c787a..441f17bdcb0a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -129,7 +129,7 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
>         return to_gpd_data(dev->power.subsys_data->domain_data);
>  }
>
> -extern struct generic_pm_domain *dev_to_genpd(struct device *dev);
> +extern struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev);
>  extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
>                                  struct device *dev,
>                                  struct gpd_timing_data *td);
> @@ -166,9 +166,9 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
>  {
>         return ERR_PTR(-ENOSYS);
>  }
> -static inline struct generic_pm_domain *dev_to_genpd(struct device *dev)
> +static inline struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev)
>  {
> -       return ERR_PTR(-ENOSYS);
> +       return NULL;
>  }
>  static inline int __pm_genpd_add_device(struct generic_pm_domain *genpd,
>                                         struct device *dev,
> --
> 1.8.3.1
>

Kind regards
Uffe

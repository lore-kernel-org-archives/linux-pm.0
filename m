From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Remove pm_genpd_dev_need_restore() API
Date: Fri, 30 Jan 2015 01:23:18 +0100
Message-ID: <2609291.titSz0X0a0@vostro.rjw.lan>
References: <1421749989-23813-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55648 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752080AbbA3AAa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 19:00:30 -0500
In-Reply-To: <1421749989-23813-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>

On Tuesday, January 20, 2015 11:33:09 AM Ulf Hansson wrote:
> There are currently no users of this API, let's remove it.
> 
> Additionally, if such feature would be needed future wise, a better
> option is likely use pm_runtime_set_active|suspended() in some form.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Kevin Hilman <khilman@linaro.org>

Queued up for 3.20, thanks!

> ---
>  drivers/base/power/domain.c | 20 --------------------
>  include/linux/pm_domain.h   |  2 --
>  2 files changed, 22 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0d8780c..c5280f2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1559,26 +1559,6 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>  }
>  
>  /**
> - * pm_genpd_dev_need_restore - Set/unset the device's "need restore" flag.
> - * @dev: Device to set/unset the flag for.
> - * @val: The new value of the device's "need restore" flag.
> - */
> -void pm_genpd_dev_need_restore(struct device *dev, bool val)
> -{
> -	struct pm_subsys_data *psd;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&dev->power.lock, flags);
> -
> -	psd = dev_to_psd(dev);
> -	if (psd && psd->domain_data)
> -		to_gpd_data(psd->domain_data)->need_restore = val ? 1 : 0;
> -
> -	spin_unlock_irqrestore(&dev->power.lock, flags);
> -}
> -EXPORT_SYMBOL_GPL(pm_genpd_dev_need_restore);
> -
> -/**
>   * pm_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
>   * @genpd: Master PM domain to add the subdomain to.
>   * @subdomain: Subdomain to be added.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index a9edab2..ed60776 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -140,7 +140,6 @@ extern int __pm_genpd_name_add_device(const char *domain_name,
>  
>  extern int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>  				  struct device *dev);
> -extern void pm_genpd_dev_need_restore(struct device *dev, bool val);
>  extern int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>  				  struct generic_pm_domain *new_subdomain);
>  extern int pm_genpd_add_subdomain_names(const char *master_name,
> @@ -187,7 +186,6 @@ static inline int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>  {
>  	return -ENOSYS;
>  }
> -static inline void pm_genpd_dev_need_restore(struct device *dev, bool val) {}
>  static inline int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>  					 struct generic_pm_domain *new_sd)
>  {
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PM / Domains: Replace -ENOSYS with -ENODEV
Date: Fri, 5 Aug 2016 21:43:29 +0200
Message-ID: <20160805194329.GA5020@wunner.de>
References: <1470416816-53336-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:34313 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992935AbcHETnD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2016 15:43:03 -0400
Content-Disposition: inline
In-Reply-To: <1470416816-53336-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org

On Fri, Aug 05, 2016 at 11:06:56AM -0600, Lina Iyer wrote:
> ENOSYS is for syscalls that are not supported. ENODEV is a better return
> value when the PM Domains are not available.
> 
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

I have no opinion on this, but would like to point out that other parts
in the PM core use -ENOSYS as well (e.g. see drivers/base/power/core.c).
For consistency, if pm_domain.h is changed, the rest should probably be
changed as well. It should also be kept in mind that functions might
check the return code and react specifically to the currently used -ENOSYS.
(I've written code like that just yesterday, for the (unmerged) thunderbolt
runtime pm.)

Thanks,

Lukas

> ---
>  include/linux/pm_domain.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 688dc57..8a63406 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -151,7 +151,7 @@ extern struct dev_power_governor pm_domain_always_on_gov;
>  
>  static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
>  {
> -	return ERR_PTR(-ENOSYS);
> +	return ERR_PTR(-ENODEV);
>  }
>  static inline struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev)
>  {
> @@ -161,27 +161,27 @@ static inline int __pm_genpd_add_device(struct generic_pm_domain *genpd,
>  					struct device *dev,
>  					struct gpd_timing_data *td)
>  {
> -	return -ENOSYS;
> +	return -ENODEV;
>  }
>  static inline int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>  					 struct device *dev)
>  {
> -	return -ENOSYS;
> +	return -ENODEV;
>  }
>  static inline int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>  					 struct generic_pm_domain *new_sd)
>  {
> -	return -ENOSYS;
> +	return -ENODEV;
>  }
>  static inline int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>  					    struct generic_pm_domain *target)
>  {
> -	return -ENOSYS;
> +	return -ENODEV;
>  }
>  static inline int pm_genpd_init(struct generic_pm_domain *genpd,
>  				struct dev_power_governor *gov, bool is_off)
>  {
> -	return -ENOSYS;
> +	return -ENODEV;
>  }
>  static inline int pm_genpd_of_parse_power_states(
>  				struct generic_pm_domain *genpd)
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

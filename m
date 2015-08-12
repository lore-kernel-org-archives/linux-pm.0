From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 3/9] PM / Domains: Support IRQ safe PM domains
Date: Wed, 12 Aug 2015 16:03:21 -0700
Message-ID: <20150812230321.GN26614@codeaurora.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53182 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbbHLXDX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 19:03:23 -0400
Content-Disposition: inline
In-Reply-To: <1438731339-58317-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org

On 08/04, Lina Iyer wrote:
> diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
> index 8ba6625..6d8318c 100644
> --- a/Documentation/power/devices.txt
> +++ b/Documentation/power/devices.txt
> @@ -607,7 +607,16 @@ individually.  Instead, a set of devices sharing a power resource can be put
>  into a low-power state together at the same time by turning off the shared
>  power resource.  Of course, they also need to be put into the full-power state
>  together, by turning the shared power resource on.  A set of devices with this
> -property is often referred to as a power domain.
> +property is often referred to as a power domain. A power domain may also be
> +nested inside another power domain.
> +
> +Devices, by default, operate in process context and if a device can operate in
> +IRQ safe context, has to be explicitly set as IRQ safe. Power domains by
> +default, operate in process context but could have devices that are IRQ safe.
> +Such power domains cannot be powered on/off during runtime PM. On the other
> +hand, an IRQ safe PM domain that can be powered on/off and suspend or resumed

s/suspend/suspended/?

> +in an atomic context, may contain IRQ safe devices. Such domains may only
> +contain IRQ safe devices or IRQ safe sub-domains.
>  
>  Support for power domains is provided through the pm_domain field of struct
>  device.  This field is a pointer to an object of type struct dev_pm_domain,
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ef8d19f..221feb0 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -53,6 +53,74 @@
>  static LIST_HEAD(gpd_list);
>  static DEFINE_MUTEX(gpd_list_lock);
>  
> +static inline int genpd_lock_noirq(struct generic_pm_domain *genpd,
> +					unsigned int subclass)
> +	__acquires(&genpd->slock)
> +{
> +	unsigned long flags;
> +
> +	if (subclass > 0)
> +		spin_lock_irqsave_nested(&genpd->slock, flags, subclass);
> +	else
> +		spin_lock_irqsave(&genpd->slock, flags);
> +
> +	genpd->lock_flags = flags;
> +	return 0;

Why return anything at all?

> +}
> +
> +static inline void genpd_unlock_noirq(struct generic_pm_domain *genpd)
> +	__releases(&genpd->slock)
> +{
> +	spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
> +}
> +
> +static inline int genpd_lock_irq(struct generic_pm_domain *genpd,
> +					unsigned int subclass)
> +	__acquires(&genpd->mlock)
> +{
> +	if (subclass > 0)
> +		mutex_lock_nested(&genpd->mlock, subclass);
> +	else
> +		mutex_lock(&genpd->mlock);
> +	return 0;

Same here.

> +}
> +
> +static inline int genpd_lock_interruptible_irq(struct generic_pm_domain *genpd)
> +	__acquires(&genpd->mlock)
> +{
> +	return mutex_lock_interruptible(&genpd->mlock);
> +}
> +
> +static inline void genpd_unlock_irq(struct generic_pm_domain *genpd)
> +	__releases(&genpd->mlock)
> +{
> +	mutex_unlock(&genpd->mlock);
> +}
> +
> +static inline int genpd_lock(struct generic_pm_domain *genpd)
> +{
> +	return genpd->irq_safe ? genpd_lock_noirq(genpd, 0)
> +			: genpd_lock_irq(genpd, 0);
> +}
> +
> +static inline int genpd_lock_nested(struct generic_pm_domain *genpd)
> +{
> +	return genpd->irq_safe ? genpd_lock_noirq(genpd, SINGLE_DEPTH_NESTING)
> +			: genpd_lock_irq(genpd, SINGLE_DEPTH_NESTING);
> +}

And for all these functions. The return is always 0.

> +
> +static inline int genpd_lock_interruptible(struct generic_pm_domain *genpd)
> +{
> +	return genpd->irq_safe ? genpd_lock_noirq(genpd, 0)
> +			: genpd_lock_interruptible_irq(genpd);
> +}

I guess this is the only one that matters.

> +
> +static inline void genpd_unlock(struct generic_pm_domain *genpd)
> +{
> +	return genpd->irq_safe ? genpd_unlock_noirq(genpd)
> +			: genpd_unlock_irq(genpd);
> +}

And this one again always returns 0?

> +
>  static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
>  {
>  	struct generic_pm_domain *genpd = NULL, *gpd;
> @@ -535,15 +611,18 @@ static int pm_genpd_runtime_resume(struct device *dev)
>  	if (IS_ERR(genpd))
>  		return -EINVAL;
>  
> -	/* If power.irq_safe, the PM domain is never powered off. */
> -	if (dev->power.irq_safe) {
> +	/*
> +	 * As we dont power off a non IRQ safe domain, which holds
> +	 * an IRQ safe device, we dont need to restore power to it.
> +	 */
> +	if (dev->power.irq_safe && !genpd->irq_safe) {

This same statement where we check dev for irq_safe and genpd for
!irq_safe has happened three times now. Maybe it should be some
sort of helper function?

if (irq_safe_device_in_no_sleep_domain(dev, genpd))

or something?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

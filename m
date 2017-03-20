From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] PM / Domains: Don't warn about IRQ safe device for
 an always on PM domain
Date: Mon, 20 Mar 2017 16:42:50 +0530
Message-ID: <20170320111250.GK25659@vireshk-i7>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
 <1490005163-28633-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35958 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbdCTLN3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 07:13:29 -0400
Received: by mail-pf0-f176.google.com with SMTP id o126so64531520pfb.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 04:12:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1490005163-28633-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On 20-03-17, 11:19, Ulf Hansson wrote:
> When an IRQ safe device is attached to a no sleep domain, genpd prints a
> warning once, as to indicate it is a suboptimal configuration from power
> consumption point of view.
> 
> However the warning doesn't make sense for an always on domain, since it
> anyway remains powered on. Therefore, let's change to not print the warning
> for this configuration.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 8a2bfc8..bfba02f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -132,8 +132,12 @@ static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
>  
>  	ret = pm_runtime_is_irq_safe(dev) && !genpd_is_irq_safe(genpd);
>  
> -	/* Warn once if IRQ safe dev in no sleep domain */
> -	if (ret)
> +	/*
> +	 * Warn once if an IRQ safe device is attached to a no sleep domain, as
> +	 * to indicate a suboptimal configuration for PM. For an always on
> +	 * domain this isn't case, thus don't warn.
> +	 */
> +	if (ret && !genpd_is_always_on(genpd))
>  		dev_warn_once(dev, "PM domain %s will not be powered off\n",
>  				genpd->name);

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

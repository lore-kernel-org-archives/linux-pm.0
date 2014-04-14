From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/4] ARM: shmobile: Ignore callbacks for subsys
 generic_pm_domain_data
Date: Mon, 14 Apr 2014 10:20:13 +0900
Message-ID: <20140414012013.GB22411@verge.net.au>
References: <1397230004-22306-1-git-send-email-ulf.hansson@linaro.org>
 <1397230004-22306-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54953 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaDNBUQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Apr 2014 21:20:16 -0400
Content-Disposition: inline
In-Reply-To: <1397230004-22306-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <t.figa@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, linux-arm-kernel@lists.infradead.org

On Fri, Apr 11, 2014 at 05:26:41PM +0200, Ulf Hansson wrote:
> There are no active users of these callbacks, thus there are no benefit
> of trying to invoke them.
> 
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> I am seeking ack from the SOC maintainers since this needs to go with the other
> patches in this patchset on the PM core.

In order to reduce the possibility of conflicts I would prefer
to take this patch through my tree.

> ---
>  arch/arm/mach-shmobile/pm-rmobile.c |   38 +++--------------------------------
>  1 file changed, 3 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
> index 1fc05d9..f710235 100644
> --- a/arch/arm/mach-shmobile/pm-rmobile.c
> +++ b/arch/arm/mach-shmobile/pm-rmobile.c
> @@ -99,39 +99,7 @@ static int rmobile_pd_power_up(struct generic_pm_domain *genpd)
>  
>  static bool rmobile_pd_active_wakeup(struct device *dev)
>  {
> -	bool (*active_wakeup)(struct device *dev);
> -
> -	active_wakeup = dev_gpd_data(dev)->ops.active_wakeup;
> -	return active_wakeup ? active_wakeup(dev) : true;
> -}
> -
> -static int rmobile_pd_stop_dev(struct device *dev)
> -{
> -	int (*stop)(struct device *dev);
> -
> -	stop = dev_gpd_data(dev)->ops.stop;
> -	if (stop) {
> -		int ret = stop(dev);
> -		if (ret)
> -			return ret;
> -	}
> -	return pm_clk_suspend(dev);
> -}
> -
> -static int rmobile_pd_start_dev(struct device *dev)
> -{
> -	int (*start)(struct device *dev);
> -	int ret;
> -
> -	ret = pm_clk_resume(dev);
> -	if (ret)
> -		return ret;
> -
> -	start = dev_gpd_data(dev)->ops.start;
> -	if (start)
> -		ret = start(dev);
> -
> -	return ret;
> +	return true;
>  }
>  
>  static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
> @@ -140,8 +108,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
>  	struct dev_power_governor *gov = rmobile_pd->gov;
>  
>  	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
> -	genpd->dev_ops.stop		= rmobile_pd_stop_dev;
> -	genpd->dev_ops.start		= rmobile_pd_start_dev;
> +	genpd->dev_ops.stop		= pm_clk_suspend;
> +	genpd->dev_ops.start		= pm_clk_resume;
>  	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
>  	genpd->dev_irq_safe		= true;
>  	genpd->power_off		= rmobile_pd_power_down;
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 1/3] PM / Domains: Initial PM clock support for genpd
Date: Fri, 28 Nov 2014 01:05:30 +0100
Message-ID: <3169286.RI9fuSo8ZA@vostro.rjw.lan>
References: <1417099911-12688-1-git-send-email-ulf.hansson@linaro.org> <1417099911-12688-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50545 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751317AbaK0XoO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 18:44:14 -0500
In-Reply-To: <1417099911-12688-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>

On Thursday, November 27, 2014 03:51:49 PM Ulf Hansson wrote:
> It's quite common for PM domains to use PM clocks. Typically from SOC
> specific code, the per device PM clock list is created and
> pm_clk_suspend|resume() are invoked to handle clock gating/ungating.
> 
> A step towards consolidation is to integrate PM clock support into
> genpd, which is what this patch does.
> 
> In this initial step, the calls to the pm_clk_suspend|resume() are
> handled within genpd, but the per device PM clock list still needs to
> be created from SOC specific code. It seems reasonable to have gendp to
> handle that as well, but that left to future patches to address.
> 
> It's not every users of genpd that are keen on using PM clocks thus we
> need to provide this a configuration option for genpd. Therefore let's
> add flag field in the genpd struct to keep this information and define
> a new PM_DOMAIN_PM_CLK bit can then be set at initialization.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	Set ->start() callback to pm_clk_resume() and fixed comment.
> 
> ---
>  drivers/base/power/domain.c | 7 +++++++
>  include/linux/pm_domain.h   | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 735c473..42ba5a0 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -12,6 +12,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_qos.h>
> +#include <linux/pm_clock.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/sched.h>
> @@ -1928,6 +1929,12 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  	genpd->domain.ops.complete = pm_genpd_complete;
>  	genpd->dev_ops.save_state = pm_genpd_default_save_state;
>  	genpd->dev_ops.restore_state = pm_genpd_default_restore_state;
> +
> +	if (genpd->flags & PM_DOMAIN_PM_CLK) {
> +		genpd->dev_ops.stop = pm_clk_suspend;
> +		genpd->dev_ops.start = pm_clk_resume;
> +	}
> +
>  	mutex_lock(&gpd_list_lock);
>  	list_add(&genpd->gpd_list_node, &gpd_list);
>  	mutex_unlock(&gpd_list_lock);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 8cbd32e..4ba06a4f 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -14,6 +14,7 @@
>  #include <linux/pm.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> +#include <linux/bitops.h>
>  #include <linux/notifier.h>
>  #include <linux/cpuidle.h>

If you defined the flag as

	#define PM_DOMAIN_FLAGS_PM_CLK	(1U << 0)

(which is a kind of usual way to do that), you wouldn't need the
bitops.h above.

Moreover, I personally don't like #defines in struct definitions.

>  
> @@ -76,6 +77,8 @@ struct generic_pm_domain {
>  			  struct device *dev);
>  	void (*detach_dev)(struct generic_pm_domain *domain,
>  			   struct device *dev);
> +	unsigned int flags;		/* Bit field of configs for genpd */
> +#define PM_DOMAIN_PM_CLK	BIT(0)	/* PM domain uses PM clk */
>  };
>  
>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

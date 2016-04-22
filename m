From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH V2 5/9] cpufreq: rockchip: Use generic platdev driver
Date: Fri, 22 Apr 2016 15:58:21 +0200
Message-ID: <30472058.4UOVq5Spqx@diego>
References: <cover.1461324267.git.viresh.kumar@linaro.org> <736a08a0210e7e8b33e82e5439b7c00b612d0eff.1461324267.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:34780 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbcDVN6d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Apr 2016 09:58:33 -0400
In-Reply-To: <736a08a0210e7e8b33e82e5439b7c00b612d0eff.1461324267.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, Finley Xiao <finley.xiao@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org

Am Freitag, 22. April 2016, 16:58:43 schrieb Viresh Kumar:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> This patch add rockchip's compatible string to the compat list and
> remove similar code from platform code for supporting generic platdev
> driver.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

very cool to have that cpufreq stuff move somewhere else

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  arch/arm/mach-rockchip/rockchip.c    |  1 -
>  drivers/cpufreq/cpufreq-dt-platdev.c | 11 +++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/rockchip.c
> b/arch/arm/mach-rockchip/rockchip.c index 3f07cc5dfe5f..beb71da5d9c8 100644
> --- a/arch/arm/mach-rockchip/rockchip.c
> +++ b/arch/arm/mach-rockchip/rockchip.c
> @@ -74,7 +74,6 @@ static void __init rockchip_dt_init(void)
>  {
>  	rockchip_suspend_init();
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -	platform_device_register_simple("cpufreq-dt", 0, NULL, 0);
>  }
> 
>  static const char * const rockchip_board_dt_compat[] = {
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
> b/drivers/cpufreq/cpufreq-dt-platdev.c index 4e525f6ec59f..75fa921d8540
> 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -29,6 +29,17 @@ static const struct of_device_id machines[] __initconst =
> { { .compatible = "samsung,exynos5800", },
>  #endif
> 
> +	{ .compatible = "rockchip,rk2928", },
> +	{ .compatible = "rockchip,rk3036", },
> +	{ .compatible = "rockchip,rk3066a", },
> +	{ .compatible = "rockchip,rk3066b", },
> +	{ .compatible = "rockchip,rk3188", },
> +	{ .compatible = "rockchip,rk3228", },
> +	{ .compatible = "rockchip,rk3288", },
> +	{ .compatible = "rockchip,rk3366", },
> +	{ .compatible = "rockchip,rk3368", },
> +	{ .compatible = "rockchip,rk3399", },
> +
>  	{ .compatible = "ti,omap2", },
>  	{ .compatible = "ti,omap3", },
>  	{ .compatible = "ti,omap4", },


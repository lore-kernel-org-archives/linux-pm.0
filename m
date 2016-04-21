From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: rockchip: Use generic platdev driver
Date: Thu, 21 Apr 2016 14:35:18 +0530
Message-ID: <20160421090518.GC9309@vireshk-i7>
References: <1461225849-36866-1-git-send-email-finley.xiao@rock-chips.com>
 <1461229265-53750-1-git-send-email-finley.xiao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34837 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbcDUJFW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 05:05:22 -0400
Received: by mail-pa0-f46.google.com with SMTP id fs9so27377702pac.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2016 02:05:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461229265-53750-1-git-send-email-finley.xiao@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Finlye Xiao <finley.xiao@rock-chips.com>
Cc: linux@arm.linux.org.uk, rjw@rjwysocki.net, heiko@sntech.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, jay.xu@rock-chips.com, rocky.hao@rock-chips.com, tim.chen@rock-chips.com, tony.xie@rock-chips.com, ulysses.huang@rock-chips.com

On 21-04-16, 17:01, Finlye Xiao wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> This patch add rockchip's compatible string to the compat list and
> remove similar code from platform code for supporting generic platdev
> driver.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
> v1->v2:
> - add a blank line before rockchip's compatible
> 
>  arch/arm/mach-rockchip/rockchip.c    |  1 -
>  drivers/cpufreq/cpufreq-dt-platdev.c | 11 +++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
> index 3f07cc5..beb71da 100644
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
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index f2ae7ad..fc6529b 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -21,6 +21,17 @@ static const struct of_device_id machines[] = {
>  	{ .compatible = "samsung,exynos5420", },
>  	{ .compatible = "samsung,exynos5800", },
>  #endif
> +
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
>  };
>  
>  static int __init cpufreq_dt_platdev_init(void)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

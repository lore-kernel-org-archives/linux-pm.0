From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 3/4] ARM: exynos: cpuidle: Move exynos4_idle_driver declaration below in the code
Date: Wed, 24 Jul 2013 10:34:36 +0200
Message-ID: <1870758.9skEtZxYsB@flatron>
References: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org> <1374152070-21008-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59954 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab3GXIek (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2013 04:34:40 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so48834bkb.5
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2013 01:34:39 -0700 (PDT)
In-Reply-To: <1374152070-21008-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, kgene.kim@samsung.com, rjw@sisk.pl, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Thursday 18 of July 2013 14:54:29 Daniel Lezcano wrote:
> In order to prevent a pointless forward declaration, move the driver
> declation after the idle function callback, right before the init
> function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c |   40
> ++++++++++++++++++---------------------- 1 file changed, 18
> insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/cpuidle.c
> b/arch/arm/mach-exynos/cpuidle.c index d8fc1a2..8d06128 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -37,28 +37,6 @@
> 
>  #define S5P_CHECK_AFTR		0xFCBA0D10
> 
> -static int exynos4_enter_lowpower(struct cpuidle_device *dev,
> -				struct cpuidle_driver *drv,
> -				int index);
> -
> -static struct cpuidle_driver exynos4_idle_driver = {
> -	.name			= "exynos4_idle",
> -	.owner			= THIS_MODULE,
> -	.states = {
> -		[0] = ARM_CPUIDLE_WFI_STATE,
> -		[1] = {
> -			.enter			= exynos4_enter_lowpower,
> -			.exit_latency		= 300,
> -			.target_residency	= 100000,
> -			.flags			= CPUIDLE_FLAG_TIME_VALID,
> -			.name			= "C1",
> -			.desc			= "ARM power down",
> -		},
> -	},
> -	.state_count = 2,
> -	.safe_state_index = 0,
> -};
> -
>  /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
>  static void exynos4_set_wakeupmask(void)
>  {
> @@ -184,6 +162,24 @@ static void __init exynos5_core_down_clk(void)
>  	__raw_writel(tmp, EXYNOS5_PWR_CTRL2);
>  }
> 
> +static struct cpuidle_driver exynos4_idle_driver = {
> +	.name			= "exynos4_idle",
> +	.owner			= THIS_MODULE,
> +	.states = {
> +		[0] = ARM_CPUIDLE_WFI_STATE,
> +		[1] = {
> +			.enter			= exynos4_enter_lowpower,
> +			.exit_latency		= 300,
> +			.target_residency	= 100000,
> +			.flags			= CPUIDLE_FLAG_TIME_VALID,
> +			.name			= "C1",
> +			.desc			= "ARM power down",
> +		},
> +	},
> +	.state_count = 2,
> +	.safe_state_index = 0,
> +};
> +
>  static int __init exynos4_init_cpuidle(void)
>  {
>  	if (soc_is_exynos5250())

Makes sense.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz


From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/8] cpufreq: imx: Use generic platdev driver
Date: Thu, 21 Apr 2016 11:19:39 +0200
Message-ID: <1461230379.29430.0.camel@pengutronix.de>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
	 <08c7bf360dfb7620591c0e0de6e047fffb0a5546.1461228081.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52939 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752280AbcDUJTq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 05:19:46 -0400
In-Reply-To: <08c7bf360dfb7620591c0e0de6e047fffb0a5546.1461228081.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, arnd.bergmann@linaro.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Am Donnerstag, den 21.04.2016, 14:13 +0530 schrieb Viresh Kumar:
> The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
> device now, reuse that and remove similar code from platform code.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Looks good to me:

Acked-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/mach-imx/imx27-dt.c         | 4 ----
>  arch/arm/mach-imx/mach-imx51.c       | 3 ---
>  arch/arm/mach-imx/mach-imx53.c       | 2 --
>  arch/arm/mach-imx/mach-imx7d.c       | 6 ------
>  drivers/cpufreq/cpufreq-dt-platdev.c | 5 +++++
>  5 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
> index bd42d1bd10af..90c62bf01f9e 100644
> --- a/arch/arm/mach-imx/imx27-dt.c
> +++ b/arch/arm/mach-imx/imx27-dt.c
> @@ -20,11 +20,7 @@
>  
>  static void __init imx27_dt_init(void)
>  {
> -	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
> -
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -
> -	platform_device_register_full(&devinfo);
>  }
>  
>  static const char * const imx27_dt_board_compat[] __initconst = {
> diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
> index 6883fbaf9484..10a82a4f1e58 100644
> --- a/arch/arm/mach-imx/mach-imx51.c
> +++ b/arch/arm/mach-imx/mach-imx51.c
> @@ -50,13 +50,10 @@ static void __init imx51_ipu_mipi_setup(void)
>  
>  static void __init imx51_dt_init(void)
>  {
> -	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
> -
>  	imx51_ipu_mipi_setup();
>  	imx_src_init();
>  
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -	platform_device_register_full(&devinfo);
>  }
>  
>  static void __init imx51_init_late(void)
> diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> index 86316a979297..18b5c5c136db 100644
> --- a/arch/arm/mach-imx/mach-imx53.c
> +++ b/arch/arm/mach-imx/mach-imx53.c
> @@ -40,8 +40,6 @@ static void __init imx53_dt_init(void)
>  static void __init imx53_init_late(void)
>  {
>  	imx53_pm_init();
> -
> -	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>  }
>  
>  static const char * const imx53_dt_board_compat[] __initconst = {
> diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
> index 5a27f20c9a82..b450f525a670 100644
> --- a/arch/arm/mach-imx/mach-imx7d.c
> +++ b/arch/arm/mach-imx/mach-imx7d.c
> @@ -105,11 +105,6 @@ static void __init imx7d_init_irq(void)
>  	irqchip_init();
>  }
>  
> -static void __init imx7d_init_late(void)
> -{
> -	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> -}
> -
>  static const char *const imx7d_dt_compat[] __initconst = {
>  	"fsl,imx7d",
>  	NULL,
> @@ -117,7 +112,6 @@ static const char *const imx7d_dt_compat[] __initconst = {
>  
>  DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual (Device Tree)")
>  	.init_irq	= imx7d_init_irq,
> -	.init_late	= imx7d_init_late,
>  	.init_machine	= imx7d_init_machine,
>  	.dt_compat	= imx7d_dt_compat,
>  MACHINE_END
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 3b3e6804cf14..ac12c4a02964 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -12,6 +12,11 @@
>  #include <linux/platform_device.h>
>  
>  static const struct of_device_id machines[] = {
> +	{ .compatible = "fsl,imx27", },
> +	{ .compatible = "fsl,imx51", },
> +	{ .compatible = "fsl,imx53", },
> +	{ .compatible = "fsl,imx7d", },
> +
>  	{ .compatible = "marvell,berlin", },
>  
>  	{ .compatible = "samsung,exynos3250", },



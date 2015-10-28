From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 4/5] cpufreq: imx6q: Use id_table to distinguish between
 SoCs
Date: Wed, 28 Oct 2015 10:00:32 +0100
Message-ID: <1446022832.3138.10.camel@pengutronix.de>
References: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
	 <1446019154-16384-5-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38463 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbbJ1JAe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 05:00:34 -0400
In-Reply-To: <1446019154-16384-5-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>

Am Mittwoch, den 28.10.2015, 08:59 +0100 schrieb Sascha Hauer:
> The i.MX6 cpufreq driver is instantiated from a static device in
> architecture code and not from the device tree. These devices offer the
> id_table mechanism to distinguish between different types of devices.
> Use this mechanism rather than of_machine_is_compatible() as it scales
> better with increasing number of SoCs to check against.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/mach-imx6sl.c |  2 +-
>  arch/arm/mach-imx/mach-imx6sx.c |  2 +-
>  arch/arm/mach-imx/mach-imx6ul.c |  2 +-
>  drivers/cpufreq/imx6q-cpufreq.c | 30 +++++++++++++++++++++++++++---
>  4 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
> index 3003263..c93cf69 100644
> --- a/arch/arm/mach-imx/mach-imx6sl.c
> +++ b/arch/arm/mach-imx/mach-imx6sl.c
> @@ -39,7 +39,7 @@ static void __init imx6sl_init_late(void)
>  {
>  	/* imx6sl reuses imx6q cpufreq driver */

This comment seems a little confusing now.

>  	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
> -		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
> +		platform_device_register_simple("imx6sl-cpufreq", -1, NULL, 0);
>  
>  	imx6sl_cpuidle_init();
>  }
> diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
> index 6a0b061..ca86a25 100644
> --- a/arch/arm/mach-imx/mach-imx6sx.c
> +++ b/arch/arm/mach-imx/mach-imx6sx.c
> @@ -94,7 +94,7 @@ static void __init imx6sx_init_late(void)
>  	imx6sx_cpuidle_init();
>  
>  	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
> -		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
> +		platform_device_register_simple("imx6sx-cpufreq", -1, NULL, 0);
>  }
>  
>  static const char * const imx6sx_dt_compat[] __initconst = {
> diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
> index acaf705..159ec4e 100644
> --- a/arch/arm/mach-imx/mach-imx6ul.c
> +++ b/arch/arm/mach-imx/mach-imx6ul.c
> @@ -81,7 +81,7 @@ static void __init imx6ul_init_irq(void)
>  static void __init imx6ul_init_late(void)
>  {
>  	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
> -		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
> +		platform_device_register_simple("imx6ul-cpufreq", -1, NULL, 0);
>  }
>  
>  static const char *imx6ul_dt_compat[] __initconst = {
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index f81cf8e..f3729f9 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -42,6 +42,27 @@ static unsigned int transition_latency;
>  static u32 *imx6_soc_volt;
>  static u32 soc_opp_count;
>  
> +static unsigned long imx6_cpufreq_flags;
> +
> +#define IMX6_CPUFREQ_NEED_PU_REG		(1 << 0)
> +#define IMX6_CPUFREQ_NEED_SECONDARY_SEL		(1 << 1)
> +
> +static const struct platform_device_id imx6_cpufreq_devtype[] = {
> +	{
> +		.name = "imx6q-cpufreq",
> +		.driver_data = IMX6_CPUFREQ_NEED_PU_REG,
> +	}, {
> +		.name = "imx6ul-cpufreq",
> +		.driver_data = IMX6_CPUFREQ_NEED_SECONDARY_SEL,
> +	}, {
> +		.name = "imx6sl-cpufreq",
> +		.driver_data = IMX6_CPUFREQ_NEED_PU_REG,
> +	}, {
> +		.name = "imx6sx-cpufreq",
> +		.driver_data = IMX6_CPUFREQ_NEED_PU_REG,

This is wrong. SX doesn't have a PU LDO. Also I would have expected this
flag to be added in the next patch.

> +	},
> +};
> +
>  static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  {
>  	struct dev_pm_opp *opp;
> @@ -102,7 +123,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	 *  - Reprogram pll1_sys_clk and reparent pll1_sw_clk back to it
>  	 *  - Disable pll2_pfd2_396m_clk
>  	 */
> -	if (of_machine_is_compatible("fsl,imx6ul")) {
> +	if (imx6_cpufreq_flags & IMX6_CPUFREQ_NEED_SECONDARY_SEL) {
>  		/*
>  		 * When changing pll1_sw_clk's parent to pll1_sys_clk,
>  		 * CPU may run at higher than 528MHz, this will lead to
> @@ -202,7 +223,7 @@ static int imx6q_cpufreq_get_resources(void)
>  	if (IS_ERR(pll2_pfd2_396m_clk))
>  		return PTR_ERR(pll2_pfd2_396m_clk);
>  
> -	if (of_machine_is_compatible("fsl,imx6ul")) {
> +	if (imx6_cpufreq_flags & IMX6_CPUFREQ_NEED_SECONDARY_SEL) {
>  		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
>  		if (IS_ERR(pll2_bus_clk))
>  			return PTR_ERR(pll2_bus_clk);
> @@ -283,6 +304,8 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  	const __be32 *val;
>  	u32 nr, i, j;
>  
> +	imx6_cpufreq_flags = platform_get_device_id(pdev)->driver_data;
> +
>  	cpu_dev = get_cpu_device(0);
>  	if (!cpu_dev) {
>  		pr_err("failed to get cpu0 device\n");
> @@ -439,8 +462,9 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
>  
>  static struct platform_driver imx6q_cpufreq_platdrv = {
>  	.driver = {
> -		.name	= "imx6q-cpufreq",
> +		.name	= "imx6-cpufreq",
>  	},
> +	.id_table	= imx6_cpufreq_devtype,
>  	.probe		= imx6q_cpufreq_probe,
>  	.remove		= imx6q_cpufreq_remove,
>  };

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |


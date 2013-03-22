From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
Date: Fri, 22 Mar 2013 16:47:17 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1303221600060.12375@axis700.grange>
References: <1359428020-21068-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64655 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933488Ab3CVPr2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 11:47:28 -0400
In-Reply-To: <1359428020-21068-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Langsdorf <mark.langsdorf@calxeda.com>, AnilKumar Ch <anilkumar@ti.com>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Magnus Damm <magnus.damm@gmail.com>

On Tue, 29 Jan 2013, Shawn Guo wrote:

> As multiplatform build is being adopted by more and more ARM platforms,
> initcall function should be used very carefully.  For example, when
> GENERIC_CPUFREQ_CPU0 is built in the kernel, cpu0_cpufreq_driver_init()
> will be called on all the platforms to initialize cpufreq-cpu0 driver.
> 
> To eliminate this undesired the effect, the patch changes cpufreq-cpu0
> driver to have it instantiated as a platform_driver.  Then it will only
> run on platforms that create the platform_device "cpufreq-cpu0".

Sorry, confused. Before this used to be a generic cpufreq driver, usable 
on all (DT-enabled only) platforms. You just had to provide an OPP table, 
a clock, a regulator, similar to this

http://thread.gmane.org/gmane.linux.kernel.cpufreq/9510/focus=9509

(also see the complete thread for more information). Now this won't work 
obviously. Instead we now need a pseudo platform device to instantiate 
cpufreq-cpu0. This device cannot be put in DT, because it doesn't describe 
real hardware. So, we have to add register it from the board specific .c 
code, which we actually want to get rid of... Is this really what we want?

What about other cpufreq drivers? They have the same problem on 
multiplatform builds, right? Say, s3c2416-cpufreq.c. It also just 
initialises itself and starts looking for a clock, names "msysclk" with a 
NULL device pointer etc. Don't we need a common approach for cpufreq 
driver initialisation?

The decision which cpufreq driver to use is SoC-specific, right? We're 
unlikely to have several boards, using the same SoC, wishing to use 
different cpufreq drivers? The decision _whether_ or not to enable it and 
_which_ resources to use might be board-specific. So, how about adding a 
cpufreq call something like

cpufreq_driver_request("cpufreq-driver-name");

to be called by SoC-specific code. You can say it is not much different 
from adding a virtual device, but firstly I think such a use of a platform 
device is really an overkill. Secondly you still run a danger, that 
several platforms, built into a single image, register several devices for 
different cpufreq drivers, or even for one... With a special call you know 
there can be only one and you return -EBUSY to all further calls to that 
function.

Thanks
Guennadi

> 
> Along with the change, it also changes cpu_dev to be &pdev->dev,
> so that managed functions can start working, and module build gets
> supported too.
> 
> The existing users of cpufreq-cpu0 driver highbank and am33xx are also
> updated accordingly to adapt the changes.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Cc: AnilKumar Ch <anilkumar@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> Changes since v1:
>  * Migrate cpufreq-cpu0 users in the same patch
> 
> Rafael,
> 
> The patch is based on Mark's highbank-cpufreq series and Nishanth's
> "PM / OPP : export symbol consolidation" sereis.
> 
> Mark, AnilKumar,
> 
> I only compile-tested it on highbank and omap2.  Please give it a test
> no hardware to make sure cpufreq-cpu0 still works for you.  Thanks.
> 
> Shawn
> 
>  arch/arm/mach-omap2/board-generic.c   |    1 +
>  arch/arm/mach-omap2/cclock33xx_data.c |    2 +-
>  arch/arm/mach-omap2/common.h          |    1 +
>  arch/arm/mach-omap2/io.c              |    7 +++++++
>  drivers/cpufreq/Kconfig               |    2 +-
>  drivers/cpufreq/cpufreq-cpu0.c        |   35 ++++++++++++++++++++++-----------
>  drivers/cpufreq/highbank-cpufreq.c    |    5 +++++
>  7 files changed, 39 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 53cb380b..b945480 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -139,6 +139,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
>  	.init_irq	= omap_intc_of_init,
>  	.handle_irq	= omap3_intc_handle_irq,
>  	.init_machine	= omap_generic_init,
> +	.init_late	= am33xx_init_late,
>  	.timer		= &omap3_am33xx_timer,
>  	.dt_compat	= am33xx_boards_compat,
>  MACHINE_END
> diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
> index ea64ad6..acb1620 100644
> --- a/arch/arm/mach-omap2/cclock33xx_data.c
> +++ b/arch/arm/mach-omap2/cclock33xx_data.c
> @@ -850,7 +850,7 @@ static struct omap_clk am33xx_clks[] = {
>  	CLK(NULL,	"dpll_core_m5_ck",	&dpll_core_m5_ck,	CK_AM33XX),
>  	CLK(NULL,	"dpll_core_m6_ck",	&dpll_core_m6_ck,	CK_AM33XX),
>  	CLK(NULL,	"dpll_mpu_ck",		&dpll_mpu_ck,	CK_AM33XX),
> -	CLK("cpu0",	NULL,			&dpll_mpu_ck,	CK_AM33XX),
> +	CLK("cpufreq-cpu0.0",	NULL,		&dpll_mpu_ck,	CK_AM33XX),
>  	CLK(NULL,	"dpll_mpu_m2_ck",	&dpll_mpu_m2_ck,	CK_AM33XX),
>  	CLK(NULL,	"dpll_ddr_ck",		&dpll_ddr_ck,	CK_AM33XX),
>  	CLK(NULL,	"dpll_ddr_m2_ck",	&dpll_ddr_m2_ck,	CK_AM33XX),
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 948bcaa..e3355df5 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -106,6 +106,7 @@ void omap2430_init_late(void);
>  void omap3430_init_late(void);
>  void omap35xx_init_late(void);
>  void omap3630_init_late(void);
> +void am33xx_init_late(void);
>  void am35xx_init_late(void);
>  void ti81xx_init_late(void);
>  void omap4430_init_late(void);
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 2c3fdd6..7acfb8a 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -535,6 +535,13 @@ void __init omap3630_init_late(void)
>  	omap2_clk_enable_autoidle_all();
>  }
>  
> +void __init am33xx_init_late(void)
> +{
> +	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
> +
> +	platform_device_register_full(&devinfo);
> +}
> +
>  void __init am35xx_init_late(void)
>  {
>  	omap_mux_late_init();
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index ea512f4..774dc1c 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -180,7 +180,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
>  	  If in doubt, say N.
>  
>  config GENERIC_CPUFREQ_CPU0
> -	bool "Generic CPU0 cpufreq driver"
> +	tristate "Generic CPU0 cpufreq driver"
>  	depends on HAVE_CLK && REGULATOR && PM_OPP && OF
>  	select CPU_FREQ_TABLE
>  	help
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index 90e9d73..519c2f7 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -12,12 +12,12 @@
>  #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>  
>  #include <linux/clk.h>
> -#include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/opp.h>
> +#include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  
> @@ -174,7 +174,7 @@ static struct cpufreq_driver cpu0_cpufreq_driver = {
>  	.attr = cpu0_cpufreq_attr,
>  };
>  
> -static int cpu0_cpufreq_driver_init(void)
> +static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np;
>  	int ret;
> @@ -189,23 +189,17 @@ static int cpu0_cpufreq_driver_init(void)
>  		return -ENOENT;
>  	}
>  
> -	cpu_dev = get_cpu_device(0);
> -	if (!cpu_dev) {
> -		pr_err("failed to get cpu0 device\n");
> -		ret = -ENODEV;
> -		goto out_put_node;
> -	}
> -
> +	cpu_dev = &pdev->dev;
>  	cpu_dev->of_node = np;
>  
> -	cpu_clk = clk_get(cpu_dev, NULL);
> +	cpu_clk = devm_clk_get(cpu_dev, NULL);
>  	if (IS_ERR(cpu_clk)) {
>  		ret = PTR_ERR(cpu_clk);
>  		pr_err("failed to get cpu0 clock: %d\n", ret);
>  		goto out_put_node;
>  	}
>  
> -	cpu_reg = regulator_get(cpu_dev, "cpu0");
> +	cpu_reg = devm_regulator_get(cpu_dev, "cpu0");
>  	if (IS_ERR(cpu_reg)) {
>  		pr_warn("failed to get cpu0 regulator\n");
>  		cpu_reg = NULL;
> @@ -266,7 +260,24 @@ out_put_node:
>  	of_node_put(np);
>  	return ret;
>  }
> -late_initcall(cpu0_cpufreq_driver_init);
> +
> +static int cpu0_cpufreq_remove(struct platform_device *pdev)
> +{
> +	cpufreq_unregister_driver(&cpu0_cpufreq_driver);
> +	opp_free_cpufreq_table(cpu_dev, &freq_table);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cpu0_cpufreq_platdrv = {
> +	.driver = {
> +		.name	= "cpufreq-cpu0",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= cpu0_cpufreq_probe,
> +	.remove		= cpu0_cpufreq_remove,
> +};
> +module_platform_driver(cpu0_cpufreq_platdrv);
>  
>  MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
>  MODULE_DESCRIPTION("Generic CPU0 cpufreq driver");
> diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
> index 2ea6276..0491f1f 100644
> --- a/drivers/cpufreq/highbank-cpufreq.c
> +++ b/drivers/cpufreq/highbank-cpufreq.c
> @@ -20,6 +20,7 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/mailbox.h>
> +#include <linux/platform_device.h>
>  
>  #define HB_CPUFREQ_CHANGE_NOTE	0x80000001
>  #define HB_CPUFREQ_IPC_LEN	7
> @@ -65,6 +66,7 @@ static struct notifier_block hb_cpufreq_clk_nb = {
>  
>  static int hb_cpufreq_driver_init(void)
>  {
> +	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
>  	struct device *cpu_dev;
>  	struct clk *cpu_clk;
>  	struct device_node *np;
> @@ -104,6 +106,9 @@ static int hb_cpufreq_driver_init(void)
>  		goto out_put_node;
>  	}
>  
> +	/* Instantiate cpufreq-cpu0 */
> +	platform_device_register_full(&devinfo);
> +
>  out_put_node:
>  	of_node_put(np);
>  	return ret;
> -- 
> 1.7.9.5
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

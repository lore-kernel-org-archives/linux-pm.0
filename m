From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: Re: [PATCH v3] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
Date: Wed, 30 Jan 2013 08:36:39 -0600
Message-ID: <51092FF7.8040406@calxeda.com>
References: <1359556069-16962-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp167.dfw.emailsrvr.com ([67.192.241.167]:46025 "EHLO
	smtp167.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755079Ab3A3Ogg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jan 2013 09:36:36 -0500
In-Reply-To: <1359556069-16962-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 01/30/2013 08:27 AM, Shawn Guo wrote:
> As multiplatform build is being adopted by more and more ARM platforms,
> initcall function should be used very carefully.  For example, when
> GENERIC_CPUFREQ_CPU0 is built in the kernel, cpu0_cpufreq_driver_init()
> will be called on all the platforms to initialize cpufreq-cpu0 driver.
> 
> To eliminate this undesired the effect, the patch changes cpufreq-cpu0
> driver to have it instantiated as a platform_driver.  Then it will only
> run on platforms that create the platform_device "cpufreq-cpu0".
> 
> Along with the change, it also changes cpu_dev to be &pdev->dev,
> so that managed functions can start working, and module build gets
> supported too.
> 
> The highbank-cpufreq driver is also updated accordingly to adapt the
> changes on cpufreq-cpu0.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Acked-by: Mark Langsdorf <mark.langsdorf@calxeda.com>

--Mark Langsdorf
Calxeda, Inc.

> Changes since v2:
>  * Leave out omap2/am33xx bits to avoid conflicts with omap tree
> 
>  drivers/cpufreq/Kconfig            |    2 +-
>  drivers/cpufreq/cpufreq-cpu0.c     |   35 +++++++++++++++++++++++------------
>  drivers/cpufreq/highbank-cpufreq.c |    5 +++++
>  3 files changed, 29 insertions(+), 13 deletions(-)
> 
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
> 


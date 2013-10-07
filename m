From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RESEND PATCH 6/6] cpufreq: probe the Integrator cpufreq driver from DT
Date: Mon, 07 Oct 2013 21:49:54 +0200
Message-ID: <11922424.2GnUz8ms0E@vostro.rjw.lan>
References: <1381154027-9197-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:48508 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000Ab3JGTiS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Oct 2013 15:38:18 -0400
In-Reply-To: <1381154027-9197-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Monday, October 07, 2013 03:53:47 PM Linus Walleij wrote:
> This makes the Integrator cpufreq driver probe from the core
> module device tree node through it's registered platforms
> device, getting the memory base from the device tree,
> remapping it and removing dependencies to <mach/platform.h>
> and <mach/hardware.h> by moving the two affected CM
> register offsets into the driver.
> 
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> CPUfreq guys - can either of you ACK this patch so I can take
> it through the ARM SoC tree?

Formally, Viresh is responsible for ARM cpufreq, but I have no objections,
so please feel free to add:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch.

> ---
>  drivers/cpufreq/integrator-cpufreq.c | 56 ++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cpufreq/integrator-cpufreq.c b/drivers/cpufreq/integrator-cpufreq.c
> index f7c99df..9faf0ca 100644
> --- a/drivers/cpufreq/integrator-cpufreq.c
> +++ b/drivers/cpufreq/integrator-cpufreq.c
> @@ -15,18 +15,19 @@
>  #include <linux/smp.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
>  
> -#include <mach/hardware.h>
> -#include <mach/platform.h>
>  #include <asm/mach-types.h>
>  #include <asm/hardware/icst.h>
>  
> -static struct cpufreq_driver integrator_driver;
> +static void __iomem *cm_base;
> +/* The cpufreq driver only use the OSC register */
> +#define INTEGRATOR_HDR_OSC_OFFSET       0x08
> +#define INTEGRATOR_HDR_LOCK_OFFSET      0x14
>  
> -#define CM_ID  	__io_address(INTEGRATOR_HDR_ID)
> -#define CM_OSC	__io_address(INTEGRATOR_HDR_OSC)
> -#define CM_STAT __io_address(INTEGRATOR_HDR_STAT)
> -#define CM_LOCK __io_address(INTEGRATOR_HDR_LOCK)
> +static struct cpufreq_driver integrator_driver;
>  
>  static const struct icst_params lclk_params = {
>  	.ref		= 24000000,
> @@ -100,7 +101,7 @@ static int integrator_set_target(struct cpufreq_policy *policy,
>  	BUG_ON(cpu != smp_processor_id());
>  
>  	/* get current setting */
> -	cm_osc = __raw_readl(CM_OSC);
> +	cm_osc = __raw_readl(cm_base + INTEGRATOR_HDR_OSC_OFFSET);
>  
>  	if (machine_is_integrator()) {
>  		vco.s = (cm_osc >> 8) & 7;
> @@ -128,7 +129,7 @@ static int integrator_set_target(struct cpufreq_policy *policy,
>  
>  	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
>  
> -	cm_osc = __raw_readl(CM_OSC);
> +	cm_osc = __raw_readl(cm_base + INTEGRATOR_HDR_OSC_OFFSET);
>  
>  	if (machine_is_integrator()) {
>  		cm_osc &= 0xfffff800;
> @@ -138,9 +139,9 @@ static int integrator_set_target(struct cpufreq_policy *policy,
>  	}
>  	cm_osc |= vco.v;
>  
> -	__raw_writel(0xa05f, CM_LOCK);
> -	__raw_writel(cm_osc, CM_OSC);
> -	__raw_writel(0, CM_LOCK);
> +	__raw_writel(0xa05f, cm_base + INTEGRATOR_HDR_LOCK_OFFSET);
> +	__raw_writel(cm_osc, cm_base + INTEGRATOR_HDR_OSC_OFFSET);
> +	__raw_writel(0, cm_base + INTEGRATOR_HDR_LOCK_OFFSET);
>  
>  	/*
>  	 * Restore the CPUs allowed mask.
> @@ -165,7 +166,7 @@ static unsigned int integrator_get(unsigned int cpu)
>  	BUG_ON(cpu != smp_processor_id());
>  
>  	/* detect memory etc. */
> -	cm_osc = __raw_readl(CM_OSC);
> +	cm_osc = __raw_readl(cm_base + INTEGRATOR_HDR_OSC_OFFSET);
>  
>  	if (machine_is_integrator()) {
>  		vco.s = (cm_osc >> 8) & 7;
> @@ -202,19 +203,38 @@ static struct cpufreq_driver integrator_driver = {
>  	.name		= "integrator",
>  };
>  
> -static int __init integrator_cpu_init(void)
> +static int __init integrator_cpufreq_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	cm_base = of_iomap(np, 0);
> +	if (!cm_base)
> +		return -ENODEV;
>  	return cpufreq_register_driver(&integrator_driver);
>  }
>  
> -static void __exit integrator_cpu_exit(void)
> +static void __exit integrator_cpufreq_remove(struct platform_device *pdev)
>  {
>  	cpufreq_unregister_driver(&integrator_driver);
>  }
>  
> +static const struct of_device_id integrator_cpufreq_match[] = {
> +	{ .compatible = "arm,core-module-integrator"},
> +	{ },
> +};
> +
> +static struct platform_driver integrator_cpufreq_driver = {
> +	.driver = {
> +		.name = "integrator-cpufreq",
> +		.owner = THIS_MODULE,
> +		.of_match_table = integrator_cpufreq_match,
> +	},
> +	.remove = __exit_p(integrator_cpufreq_remove),
> +};
> +
> +module_platform_driver_probe(integrator_cpufreq_driver,
> +			     integrator_cpufreq_probe);
> +
>  MODULE_AUTHOR ("Russell M. King");
>  MODULE_DESCRIPTION ("cpufreq driver for ARM Integrator CPUs");
>  MODULE_LICENSE ("GPL");
> -
> -module_init(integrator_cpu_init);
> -module_exit(integrator_cpu_exit);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

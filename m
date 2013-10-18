From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 4/5] cpufreq: arm_big_little: add vexpress SPC interface
 driver
Date: Fri, 18 Oct 2013 14:59:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1310181459320.1951@syhkavp.arg>
References: <1381931563-16785-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1381931563-16785-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1381931563-16785-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 16 Oct 2013, Sudeep KarkadaNagesha wrote:

> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> The TC2(i.e. CA15_A7) Versatile Express has external Cortex M3 based
> power controller which is responsible for CPU DVFS and SPC provides
> the interface for the same.
> 
> This patch adds a tiny interface driver to check if OPPs are
> initialised by SPC platform code and register the arm_big_little
> cpufreq driver.
> 
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  drivers/cpufreq/Kconfig.arm            |  8 ++++
>  drivers/cpufreq/Makefile               |  1 +
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 69 ++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>  create mode 100644 drivers/cpufreq/vexpress-spc-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 0fa204b..d3bf733 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -235,3 +235,11 @@ config ARM_TEGRA_CPUFREQ
>  	default y
>  	help
>  	  This adds the CPUFreq driver support for TEGRA SOCs.
> +
> +config ARM_VEXPRESS_SPC_CPUFREQ
> +        tristate "Versatile Express SPC based CPUfreq driver"
> +        select ARM_BIG_LITTLE_CPUFREQ
> +        depends on ARCH_VEXPRESS_TC2_PM
> +        help
> +          This add the CPUfreq driver support for Versatile Express
> +	  big.LITTLE platforms using SPC for power management.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index ad5866c..a1c390f 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_ARM_SA1100_CPUFREQ)	+= sa1100-cpufreq.o
>  obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
>  obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA_CPUFREQ)		+= tegra-cpufreq.o
> +obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
>  
>  ##################################################################################
>  # PowerPC platform drivers
> diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> new file mode 100644
> index 0000000..f0508bf
> --- /dev/null
> +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> @@ -0,0 +1,69 @@
> +/*
> + * Versatile Express SPC CPUFreq Interface driver
> + *
> + * It provides necessary ops to arm_big_little cpufreq driver.
> + *
> + * Copyright (C) 2013 ARM Ltd.
> + * Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cpufreq.h>
> +#include <linux/opp.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include "arm_big_little.h"
> +
> +static int ve_spc_init_opp_table(struct device *cpu_dev)
> +{
> +	/*
> +	 * platform specific SPC code must initialise the opp table
> +	 * so just check if the OPP count is non-zero
> +	 */
> +	return opp_get_opp_count(cpu_dev) <= 0;
> +}
> +
> +static int ve_spc_get_transition_latency(struct device *cpu_dev)
> +{
> +	return 1000000; /* 1 ms */
> +}
> +
> +static struct cpufreq_arm_bL_ops ve_spc_cpufreq_ops = {
> +	.name	= "vexpress-spc",
> +	.get_transition_latency = ve_spc_get_transition_latency,
> +	.init_opp_table = ve_spc_init_opp_table,
> +};
> +
> +static int ve_spc_cpufreq_probe(struct platform_device *pdev)
> +{
> +	return bL_cpufreq_register(&ve_spc_cpufreq_ops);
> +}
> +
> +static int ve_spc_cpufreq_remove(struct platform_device *pdev)
> +{
> +	bL_cpufreq_unregister(&ve_spc_cpufreq_ops);
> +	return 0;
> +}
> +
> +static struct platform_driver ve_spc_cpufreq_platdrv = {
> +	.driver = {
> +		.name	= "vexpress-spc-cpufreq",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= ve_spc_cpufreq_probe,
> +	.remove		= ve_spc_cpufreq_remove,
> +};
> +module_platform_driver(ve_spc_cpufreq_platdrv);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 1.8.1.2
> 

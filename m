From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/3] cpufreq: add imx6q-cpufreq driver
Date: Tue, 8 Jan 2013 09:57:56 +0100
Message-ID: <20130108085756.GM1906@pengutronix.de>
References: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
 <1357628043-19256-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1357628043-19256-3-git-send-email-shawn.guo@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 08, 2013 at 02:54:02PM +0800, Shawn Guo wrote:
> Add an imx6q-cpufreq for Freescale i.MX6Q SoC to handle the hardware
> specific frequency and voltage scaling requirements.
> 
> The driver supports module build and is instantiated by the platform
> device/driver mechanism, so that it will be instantiated on other
> platform, as IMX is built with multiplatform support.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm     |    9 ++
>  drivers/cpufreq/Makefile        |    1 +
>  drivers/cpufreq/imx6q-cpufreq.c |  325 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 335 insertions(+)
>  create mode 100644 drivers/cpufreq/imx6q-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index a0b3661..9e628ba 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -77,6 +77,15 @@ config ARM_EXYNOS5250_CPUFREQ
>  	  This adds the CPUFreq driver for Samsung EXYNOS5250
>  	  SoC.
>  
> +config ARM_IMX6Q_CPUFREQ
> +	tristate "Freescale i.MX6Q cpufreq support"
> +	depends on SOC_IMX6Q
> +	depends on REGULATOR_ANATOP
> +	help
> +	  This adds cpufreq driver support for Freescale i.MX6Q SOC.
> +
> +	  If in doubt, say N.
> +
>  config ARM_SPEAR_CPUFREQ
>  	bool "SPEAr CPUFreq support"
>  	depends on PLAT_SPEAR
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 1f254ec0..31699a0 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
> +obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)     += omap-cpufreq.o
>  obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
>  
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> new file mode 100644
> index 0000000..8b3db8c
> --- /dev/null
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -0,0 +1,325 @@
> +/*
> + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> +
> +#include <linux/clk.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/opp.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +#define PU_SOC_VOLTAGE_NORMAL	1250000
> +#define PU_SOC_VOLTAGE_HIGH	1275000
> +#define FREQ_1P2_GHZ		1200000000
> +
> +static struct regulator *arm_reg;
> +static struct regulator *pu_reg;
> +static struct regulator *soc_reg;
> +
> +static struct clk *arm_clk;
> +static struct clk *pll1_sys_clk;
> +static struct clk *pll1_sw_clk;
> +static struct clk *step_clk;
> +static struct clk *pll2_pfd2_396m_clk;
> +
> +static struct device *cpu_dev;
> +static struct cpufreq_frequency_table *freq_table;
> +static unsigned int transition_latency;
> +
> +static int imx6q_verify_speed(struct cpufreq_policy *policy)
> +{
> +	return cpufreq_frequency_table_verify(policy, freq_table);
> +}
> +
> +static unsigned int imx6q_get_speed(unsigned int cpu)
> +{
> +	return clk_get_rate(arm_clk) / 1000;
> +}
> +
> +static int imx6q_set_target(struct cpufreq_policy *policy,
> +			    unsigned int target_freq, unsigned int relation)
> +{
> +	struct cpufreq_freqs freqs;
> +	struct opp *opp;
> +	unsigned long freq_hz, volt, volt_old;
> +	unsigned int index, cpu;
> +	int ret;
> +
> +	ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
> +					     relation, &index);
> +	if (ret) {
> +		pr_err("failed to match target freqency %d: %d\n",
> +		       target_freq, ret);
> +		return ret;
> +	}
> +
> +	freq_hz = freq_table[index].frequency * 1000;
> +	freqs.new = freq_hz / 1000;
> +	freqs.old = clk_get_rate(arm_clk) / 1000;
> +
> +	if (freqs.old == freqs.new)
> +		return 0;
> +
> +	for_each_online_cpu(cpu) {
> +		freqs.cpu = cpu;
> +		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +	}
> +
> +	opp = opp_find_freq_ceil(cpu_dev, &freq_hz);
> +	if (IS_ERR(opp)) {
> +		pr_err("failed to find OPP for %ld\n", freq_hz);
> +		return PTR_ERR(opp);
> +	}
> +
> +	volt = opp_get_voltage(opp);
> +	volt_old = regulator_get_voltage(arm_reg);
> +
> +	pr_debug("%u MHz, %ld mV --> %u MHz, %ld mV\n",
> +		 freqs.old / 1000, volt_old / 1000,
> +		 freqs.new / 1000, volt / 1000);
> +
> +	/* scaling up?  scale voltage before frequency */
> +	if (freqs.new > freqs.old) {
> +		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> +		if (ret) {
> +			pr_err("failed to scale voltage up: %d\n", ret);
> +			freqs.new = freqs.old;
> +			return ret;
> +		}

So this regulator_set_voltage_tol can fail, ...

> +
> +		/*
> +		 * Need to increase vddpu and vddsoc for safety
> +		 * if we are about to run at 1.2 GHz.
> +		 */
> +		if (freqs.new == FREQ_1P2_GHZ / 1000) {
> +			regulator_set_voltage_tol(pu_reg,
> +					PU_SOC_VOLTAGE_HIGH, 0);
> +			regulator_set_voltage_tol(soc_reg,
> +					PU_SOC_VOLTAGE_HIGH, 0);

... but these can't?

> +		}
> +	}
> +
> +	/*
> +	 * The setpoints are selected per PLL/PDF frequencies, so we need to
> +	 * reprogram PLL for frequency scaling.  The procedure of reprogramming
> +	 * PLL1 is as blow.

s/blow/below/

> +	 *
> +	 *  - Enable pll2_pfd2_396m_clk and reparent pll1_sw_clk to it
> +	 *  - Disable pll1_sys_clk and reprogram it
> +	 *  - Enable pll1_sys_clk and reparent pll1_sw_clk back to it
> +	 *  - Disable pll2_pfd2_396m_clk
> +	 */

[...]

> +
> +static struct cpufreq_driver imx6q_cpufreq_driver = {
> +	.verify = imx6q_verify_speed,
> +	.target = imx6q_set_target,
> +	.get = imx6q_get_speed,
> +	.init = imx6q_cpufreq_init,
> +	.exit = imx6q_cpufreq_exit,
> +	.name = "imx6q-cpufreq",
> +	.attr = imx6q_cpufreq_attr,
> +};
> +
> +static int imx6q_cpufreq_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	int ret;
> +
> +	np = of_find_node_by_path("/cpus/cpu@0");
> +	if (!np) {
> +		pr_err("failed to find cpu0 node\n");
> +		return -ENOENT;
> +	}
> +
> +	cpu_dev = get_cpu_device(0);
> +	if (!cpu_dev) {
> +		pr_err("failed to get cpu0 device\n");

Since you have a struct device * you should use it throughout the driver
to give the messages a bit more context.

> +		ret = -ENODEV;
> +		goto put_node;
> +	}
> +
> +	cpu_dev->of_node = np;
> +
> +	arm_clk = clk_get(cpu_dev, "arm");
> +	pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
> +	pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
> +	step_clk = clk_get(cpu_dev, "step");
> +	pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");

devm_*?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

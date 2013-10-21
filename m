From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Mon, 21 Oct 2013 11:42:43 +0100
Message-ID: <52650523.80400@gmail.com>
References: <1382186261-14482-1-git-send-email-andrew@lunn.ch> <1382186261-14482-2-git-send-email-andrew@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:50518 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab3JUKnc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 06:43:32 -0400
Received: by mail-bk0-f51.google.com with SMTP id mx10so663381bkb.38
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2013 03:43:31 -0700 (PDT)
In-Reply-To: <1382186261-14482-2-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>

On 10/19/2013 01:37 PM, Andrew Lunn wrote:
> The Marvell Dove SoC can run the CPU at two frequencies. The high
> frequencey is from a PLL, while the lower is the same as the DDR
> clock. Add a cpufreq driver to swap between these frequences.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Andrew,

thanks for adding Dove cpufreq! I have some remarks below.

> ---
>   drivers/cpufreq/Kconfig.arm    |   7 ++
>   drivers/cpufreq/Makefile       |   1 +
>   drivers/cpufreq/dove-cpufreq.c | 276 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 284 insertions(+)
>   create mode 100644 drivers/cpufreq/dove-cpufreq.c
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 701ec95..3d77633 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -8,6 +8,13 @@ config ARM_BIG_LITTLE_CPUFREQ
>   	help
>   	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
>
> +config ARM_DOVE_CPUFREQ
> +	def_bool ARCH_DOVE && OF
> +	select CPU_FREQ_TABLE
> +	help
> +	  This adds the CPUFreq driver for Marvell Dove
> +	  SoCs.
> +
>   config ARM_DT_BL_CPUFREQ
>   	tristate "Generic probing via DT for ARM big LITTLE CPUfreq driver"
>   	depends on ARM_BIG_LITTLE_CPUFREQ && OF
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index b7948bb..5956661 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
>
>   obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= davinci-cpufreq.o
>   obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
> +obj-$(CONFIG_ARM_DOVE_CPUFREQ)		+= dove-cpufreq.o
>   obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
>   obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
>   obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
> diff --git a/drivers/cpufreq/dove-cpufreq.c b/drivers/cpufreq/dove-cpufreq.c
> new file mode 100644
> index 0000000..4730b05
> --- /dev/null
> +++ b/drivers/cpufreq/dove-cpufreq.c
> @@ -0,0 +1,276 @@
> +/*
> + *	dove_freq.c: cpufreq driver for the Marvell dove
> + *
> + *	Copyright (C) 2013 Andrew Lunn <andrew@lunn.ch>
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#define DEBUG
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/cpufreq.h>
> +#include <linux/interrupt.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of_irq.h>
> +#include <asm/proc-fns.h>
> +
> +#define DFS_CR			0x00
> +#define	 DFS_EN			BIT(0)
> +#define	 CPU_SLOW_EN		BIT(1)
> +#define	 L2_RATIO_OFFS		9
> +#define	 L2_RATIO_MASK		(0x3F << L2_RATIO_OFFS)
> +#define DFS_SR			0x04
> +#define	 CPU_SLOW_MODE_STTS	BIT(1)
> +
> +/* PMU_CR */
> +#define	 MASK_FIQ		BIT(28)
> +#define	 MASK_IRQ		BIT(24)	/* PMU_CR */
> +
> +/* CPU Clock Divider Control 0 Register */
> +#define DPRATIO_OFFS		24
> +#define DPRATIO_MASK		(0x3F << DPRATIO_OFFS)
> +#define XPRATIO_OFFS		16
> +#define XPRATIO_MASK		(0x3F << XPRATIO_OFFS)
> +
> +static struct priv
> +{
> +	struct clk *cpu_clk;
> +	struct clk *ddr_clk;
> +	struct device *dev;
> +	unsigned long dpratio;
> +	unsigned long xpratio;
> +	void __iomem *dfs;
> +	void __iomem *pmu_cr;
> +	void __iomem *pmu_clk_div;
> +} priv;
> +
> +#define STATE_CPU_FREQ 0x01
> +#define STATE_DDR_FREQ 0x02
> +
> +/*
> + * Dove can swap the clock to the CPU between two clocks:
> + *
> + * - cpu clk
> + * - ddr clk
> + *
> + * The frequencies are set at runtime before registering this
> + * table.
> + */
> +static struct cpufreq_frequency_table dove_freq_table[] = {
> +	{STATE_CPU_FREQ,	0}, /* CPU uses cpuclk */
> +	{STATE_DDR_FREQ,	0}, /* CPU uses ddrclk */
> +	{0,			CPUFREQ_TABLE_END},
> +};
> +
> +static unsigned int dove_cpufreq_get_cpu_frequency(unsigned int cpu)
> +{
> +	unsigned long reg = readl_relaxed(priv.dfs + DFS_SR);
> +
> +	if (reg & CPU_SLOW_MODE_STTS)
> +		return dove_freq_table[1].frequency;
> +	return dove_freq_table[0].frequency;
> +}
> +
> +static void dove_cpufreq_set_cpu_state(struct cpufreq_policy *policy,
> +				       unsigned int index)
> +{
> +	struct cpufreq_freqs freqs;
> +	unsigned int state = dove_freq_table[index].driver_data;
> +	unsigned long reg, cr;
> +
> +	freqs.old = dove_cpufreq_get_cpu_frequency(0);
> +	freqs.new = dove_freq_table[index].frequency;
> +
> +	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> +
> +	if (freqs.old != freqs.new) {
> +		local_irq_disable();
> +
> +		/* Mask IRQ and FIQ to CPU */
> +		cr = readl(priv.pmu_cr);
> +		cr |= MASK_IRQ | MASK_FIQ;
> +		writel(cr, priv.pmu_cr);
> +
> +		/* Set/Clear the CPU_SLOW_EN bit */
> +		reg = readl_relaxed(priv.dfs + DFS_CR);
> +		reg &= ~L2_RATIO_MASK;
> +
> +		switch (state) {
> +		case STATE_CPU_FREQ:
> +			reg |= priv.xpratio;
> +			reg &= ~CPU_SLOW_EN;
> +			break;
> +		case STATE_DDR_FREQ:
> +			reg |= (priv.dpratio | CPU_SLOW_EN);

Does slow mode really (only) depend on the value written into CPUL2CR?
Dove FS isn't that chatty about it and I cannot really test right now.
But reading it, I think there is two CPU PLL to {L2,DDR} ratios that you
can switch between by (de-)asserting CPU_SLOW_EN.

If so, I guess it would be better to set those ratios once in init and
take care of CPU_SLOW_EN here only.

> +			break;
> +		}
> +
> +		/* Start the DFS process */
> +		reg |= DFS_EN;
> +
> +		writel(reg, priv.dfs + DFS_CR);
> +
> +		/* Wait-for-Interrupt, while the hardware changes frequency */
> +		cpu_do_idle();
> +
> +		local_irq_enable();
> +	}
> +	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> +}
> +
> +static int dove_cpufreq_target(struct cpufreq_policy *policy,
> +			    unsigned int target_freq,
> +			    unsigned int relation)
> +{
> +	unsigned int index = 0;
> +
> +	if (cpufreq_frequency_table_target(policy, dove_freq_table,
> +				target_freq, relation, &index))
> +		return -EINVAL;
> +
> +	dove_cpufreq_set_cpu_state(policy, index);
> +
> +	return 0;
> +}
> +
> +static int dove_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +	return cpufreq_generic_init(policy, dove_freq_table, 5000);
> +}
> +
> +static irqreturn_t dove_cpufreq_irq(int irq, void *dev)
> +{
> +	return IRQ_HANDLED;
> +}
> +
> +static struct cpufreq_driver dove_cpufreq_driver = {
> +	.get	= dove_cpufreq_get_cpu_frequency,
> +	.verify	= cpufreq_generic_frequency_table_verify,
> +	.target = dove_cpufreq_target,
> +	.init	= dove_cpufreq_cpu_init,
> +	.exit	= cpufreq_generic_exit,
> +	.name	= "dove-cpufreq",
> +	.attr	= cpufreq_generic_attr,
> +};
> +
> +static int dove_cpufreq_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	struct resource *res;
> +	int err;
> +	int irq;
> +
> +	priv.dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv.dfs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv.dfs))
> +		return PTR_ERR(priv.dfs);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	priv.pmu_cr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv.pmu_cr))

Cleanup path for most of the resources here and below is kind of
missing. Also, maybe give names to the different areas and not depend
on ordering?

Sebastian

> +		return PTR_ERR(priv.pmu_cr);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	priv.pmu_clk_div = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv.pmu_clk_div))
> +		return PTR_ERR(priv.pmu_clk_div);
> +
> +	np = of_find_node_by_path("/cpus/cpu@0");
> +	if (!np)
> +		return -ENODEV;
> +
> +	priv.cpu_clk = of_clk_get_by_name(np, "cpu_clk");
> +	if (IS_ERR(priv.cpu_clk)) {
> +		dev_err(priv.dev, "Unable to get cpuclk");
> +		return PTR_ERR(priv.cpu_clk);
> +	}
> +
> +	clk_prepare_enable(priv.cpu_clk);
> +	dove_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
> +
> +	priv.ddr_clk = of_clk_get_by_name(np, "ddrclk");
> +	if (IS_ERR(priv.ddr_clk)) {
> +		dev_err(priv.dev, "Unable to get ddrclk");
> +		err = PTR_ERR(priv.ddr_clk);
> +		goto out_cpu;
> +	}
> +
> +	clk_prepare_enable(priv.ddr_clk);
> +	dove_freq_table[1].frequency = clk_get_rate(priv.ddr_clk) / 1000;
> +
> +	irq = irq_of_parse_and_map(np, 0);
> +	if (!irq) {
> +		dev_err(priv.dev, "irq_of_parse_and_map failed\n");
> +		return 0;
> +	}
> +
> +	err = devm_request_irq(&pdev->dev, irq, dove_cpufreq_irq,
> +			       0, "dove-cpufreq", NULL);
> +	if (err) {
> +		dev_err(&pdev->dev, "cannot assign irq %d, %d\n", irq, err);
> +		return err;
> +	}
> +
> +	of_node_put(np);
> +	np = NULL;
> +
> +	/* Read the target ratio which should be the DDR ratio */
> +	priv.dpratio = readl_relaxed(priv.pmu_clk_div);
> +	priv.dpratio = (priv.dpratio & DPRATIO_MASK) >> DPRATIO_OFFS;
> +	priv.dpratio = priv.dpratio << L2_RATIO_OFFS;
> +
> +	/* Save L2 ratio at reset */
> +	priv.xpratio = readl(priv.pmu_clk_div);
> +	priv.xpratio = (priv.xpratio & XPRATIO_MASK) >> XPRATIO_OFFS;
> +	priv.xpratio = priv.xpratio << L2_RATIO_OFFS;
> +
> +	err = cpufreq_register_driver(&dove_cpufreq_driver);
> +	if (!err)
> +		return 0;
> +
> +	dev_err(priv.dev, "Failed to register cpufreq driver");
> +
> +	clk_disable_unprepare(priv.ddr_clk);
> +out_cpu:
> +	clk_disable_unprepare(priv.cpu_clk);
> +	of_node_put(np);
> +
> +	return err;
> +}
> +
> +static int dove_cpufreq_remove(struct platform_device *pdev)
> +{
> +	cpufreq_unregister_driver(&dove_cpufreq_driver);
> +
> +	clk_disable_unprepare(priv.ddr_clk);
> +	clk_disable_unprepare(priv.cpu_clk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver dove_cpufreq_platform_driver = {
> +	.probe = dove_cpufreq_probe,
> +	.remove = dove_cpufreq_remove,
> +	.driver = {
> +		.name = "dove-cpufreq",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +module_platform_driver(dove_cpufreq_platform_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch");
> +MODULE_DESCRIPTION("cpufreq driver for Marvell's dove CPU");
> +MODULE_ALIAS("platform:dove-cpufreq");
>


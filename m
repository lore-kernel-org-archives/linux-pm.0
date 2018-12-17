From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 2/2] cpufreq: ap806: add cpufreq driver for Armada 8K
Date: Mon, 17 Dec 2018 16:40:26 +0530
Message-ID: <20181217111026.7b3tds2yz4g7opdt@vireshk-i7>
References: <20181211164249.26985-1-gregory.clement@bootlin.com>
 <20181211164249.26985-3-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181211164249.26985-3-gregory.clement@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 11-12-18, 17:42, Gregory CLEMENT wrote:
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 4e1131ef85ae..7e32a241760d 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -25,6 +25,17 @@ config ARM_ARMADA_37XX_CPUFREQ
>  	  This adds the CPUFreq driver support for Marvell Armada 37xx SoCs.
>  	  The Armada 37xx PMU supports 4 frequency and VDD levels.
>  
> +config ARM_ARMADA_8K_CPUFREQ
> +	tristate "Armada 8K CPUFreq driver"
> +	depends on ARCH_MVEBU && CPUFREQ_DT
> +	help
> +	  This enables the CPUFreq driver support for Marvell
> +	  Armada8k SOCs.
> +	  Armada8K device has the AP806 which supports scaling
> +	  to any full integer divider.
> +
> +	  If in doubt, say N.
> +
>  # big LITTLE core layer and glue drivers
>  config ARM_BIG_LITTLE_CPUFREQ
>  	tristate "Generic ARM big LITTLE CPUfreq driver"
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index d5ee4562ed06..db1564b610ac 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_X86_SFI_CPUFREQ)		+= sfi-cpufreq.o
>  obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)	+= arm_big_little.o
>  
>  obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
> +obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
>  obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
>  obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o
>  obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
> diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
> new file mode 100644
> index 000000000000..1db1953fb43e
> --- /dev/null
> +++ b/drivers/cpufreq/armada-8k-cpufreq.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * CPUFreq support for Armada 8K
> + *
> + * Copyright (C) 2018 Marvell
> + *
> + * Omri Itach <omrii@marvell.com>
> + * Gregory Clement <gregory.clement@bootlin.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/clk.h>
> +#include <linux/cpu.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +
> +/*
> + * Setup the opps list with the divider for the max frequency, that
> + * will be filled at runtime.
> + */
> +static const int opps_div[] __initconst = {1, 2, 3, 4};
> +
> +static struct platform_device *armada_8k_pdev;
> +static struct freq_table *freq_tables;
> +static int opps_index;
> +
> +struct freq_table {
> +	struct device *cpu_dev;
> +	struct clk *clk;
> +	unsigned int freq[ARRAY_SIZE(opps_div)];
> +};
> +
> +/* If the CPUs share the same clock, then they are in the same cluster. */
> +static void __init armada_8k_get_sharing_cpus(struct clk *cur_clk,
> +					      struct cpumask *cpumask)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct device *cpu_dev = get_cpu_device(cpu);

What if this fails ?

> +		struct clk *clk = clk_get(cpu_dev, 0);
> +
> +		if (IS_ERR(clk))
> +			dev_warn(cpu_dev, "Cannot get clock for CPU %d\n", cpu);
> +		else if (clk_is_match(clk, cur_clk))
> +			cpumask_set_cpu(cpu, cpumask);
> +
> +		clk_put(clk);

So you will do clk_put() even if clk_get() failed, that will trigger a WARN() if
I am not wrong.

> +	}
> +}
> +
> +static int armada_8k_add_opp(struct clk *clk, struct device *cpu_dev,
> +			     struct freq_table *freq_tables, int opps_index)
> +{
> +	unsigned int cur_frequency;
> +	unsigned int freq;
> +	int i, ret;
> +
> +	/* Get nominal (current) CPU frequency. */
> +	cur_frequency = clk_get_rate(clk);
> +
> +	if (!cur_frequency) {
> +		dev_err(cpu_dev,
> +			"Failed to get clock rate for this CPU\n");
> +		return -EINVAL;
> +	}
> +
> +	freq_tables[opps_index].cpu_dev = cpu_dev;
> +	for (i = 0; i < ARRAY_SIZE(opps_div); i++) {
> +		freq = cur_frequency / opps_div[i];
> +
> +		ret = dev_pm_opp_add(cpu_dev, freq, 0);
> +		if (ret)
> +			return ret;
> +
> +		freq_tables[opps_index].freq[i] = freq;
> +	}
> +
> +	return 0;
> +}
> +
> +static void armada_8k_cpufreq_free_table(void)
> +{
> +	opps_index--;
> +	for (; opps_index >= 0; opps_index--) {
> +		int i;
> +
> +		for (i = 0; i < ARRAY_SIZE(opps_div); i++)
> +			dev_pm_opp_remove(freq_tables[opps_index].cpu_dev,
> +					  freq_tables[opps_index].freq[i]);
> +	}
> +
> +	kfree(freq_tables);
> +}
> +
> +static int __init armada_8k_cpufreq_init(void)
> +{
> +	int ret = 0, cpu, nb_cpus;
> +	struct device_node *node;
> +
> +	node = of_find_compatible_node(NULL, NULL, "marvell,ap806-cpu-clock");
> +	if (!node || !of_device_is_available(node))
> +		return -ENODEV;
> +
> +	nb_cpus = num_possible_cpus();
> +	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);

Add a blank line here.

> +	/*
> +	 * For each CPU, this loop registers the operating points
> +	 * supported (which are the nominal CPU frequency and full integer
> +	 * divisions of it).
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct device *cpu_dev;
> +		struct cpumask cpus;
> +		struct clk *clk;
> +		int i, skip;
> +
> +		skip = 0;
> +		cpu_dev = get_cpu_device(cpu);
> +
> +		if (!cpu_dev) {
> +			dev_err(cpu_dev, "Cannot get CPU %d\n", cpu);
> +			continue;
> +		}
> +
> +		clk = devm_clk_get(cpu_dev, 0);

I don't think you should call devm_*() helpers on the cpu_dev pointer, this is
not like the platform device structure. The problem is that no driver gets
attached/detached from cpu_dev and so the resources may never get free.

> +
> +		if (IS_ERR(clk)) {
> +			dev_err(cpu_dev, "Cannot get clock for CPU %d\n", cpu);
> +			ret = PTR_ERR(clk);
> +			goto remove_opp;
> +		}
> +
> +		for (i = 0; i < nb_cpus; i++) {
> +			if (clk_is_match(clk, freq_tables[i].clk)) {
> +				skip = 1;

Why not do devm_clk_put() from right here and "continue" after that. That way
you can avoid "skip" variable as well.

Also why are you doing this clk-match at all ? This looks similar to what
armada_8k_get_sharing_cpus() is doing. You can optimize this stuff better I
believe.

I will do this:

Create a cpumask variable and assign possible_cpus mask to it. And then after
each iteration of this loop, I clear "cpus" (returned from
armada_8k_get_sharing_cpus()) from the CPUs from that cpumask. That way the loop
will never try the second CPU from the same cpumask again.

> +				break;
> +			}
> +		}
> +		if (skip) {
> +			devm_clk_put(cpu_dev, clk);
> +			continue;
> +		}
> +
> +		freq_tables[opps_index].clk = clk;
> +
> +		ret = armada_8k_add_opp(clk, cpu_dev, freq_tables, opps_index);

And this opps_index thing is not very clean. Having a global variable this way
makes things very messy, which is being updated from several routines.

So if armada_8k_add_opp() fails after adding few OPPs, we will now call
armada_8k_cpufreq_free_table() which will first do opps_index-- and so you may
miss freeing the OPPs added during the last call to armada_8k_add_opp().

This is very messy and requires serious cleanup to be honest. Also it will be
more preferred if armada_8k_add_opp() cleans up all the allocations it has done
on a call if it fails in the middle of it, rather than a bigger routine freeing
both successful and failed ones.

> +		if (ret)
> +			goto remove_opp;
> +
> +		opps_index++;
> +		cpumask_clear(&cpus);
> +		armada_8k_get_sharing_cpus(clk, &cpus);
> +		dev_pm_opp_set_sharing_cpus(cpu_dev, &cpus);
> +	}
> +
> +	armada_8k_pdev = platform_device_register_simple("cpufreq-dt", -1,
> +							 NULL, 0);
> +	ret = PTR_ERR_OR_ZERO(armada_8k_pdev);
> +	if (ret)
> +		goto remove_opp;
> +	return 0;
> +
> +remove_opp:
> +	armada_8k_cpufreq_free_table();
> +	return ret;
> +}
> +module_init(armada_8k_cpufreq_init);
> +
> +static void __exit armada_8k_cpufreq_exit(void)
> +{
> +	armada_8k_cpufreq_free_table();
> +	platform_device_unregister(armada_8k_pdev);
> +}
> +module_exit(armada_8k_cpufreq_exit);
> +
> +MODULE_AUTHOR("Gregory Clement <gregory.clement@bootlin.com>");
> +MODULE_DESCRIPTION("Armada 8K cpufreq driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.19.2

-- 
viresh

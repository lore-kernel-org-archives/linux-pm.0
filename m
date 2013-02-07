From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: exynos: Adding cpufreq driver for exynos5440
Date: Thu, 7 Feb 2013 16:47:14 +0530
Message-ID: <CAOh2x=kYM8n8XipvQ0-3H5f=B2TwAeFSa0DP=hy+SWQvPXJh6Q@mail.gmail.com>
References: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
	<1360179562-19950-2-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:41620 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757351Ab3BGLRR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Feb 2013 06:17:17 -0500
In-Reply-To: <1360179562-19950-2-git-send-email-amit.daniel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>

On Thu, Feb 7, 2013 at 1:09 AM, Amit Daniel Kachhap
<amit.daniel@samsung.com> wrote:
> This patch adds dvfs support for exynos5440 SOC. The nature of exynos5440
> clock controller is different from previous exynos controllers so not using
> the common exynos cpufreq framework. Also, the device tree parsing is added
> to get different parameters like frequency, voltage etc.

Some information about platform cpu configuration would be helpful.. cpus, type,
clock lines for cpus - shared/separate?

> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  .../bindings/cpufreq/cpufreq-exynos5440.txt        |   24 ++
>  drivers/cpufreq/Kconfig.arm                        |    8 +
>  drivers/cpufreq/Makefile                           |    1 +
>  drivers/cpufreq/exynos5440-cpufreq.c               |  448 ++++++++++++++++++++
>  4 files changed, 481 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
>  create mode 100644 drivers/cpufreq/exynos5440-cpufreq.c
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
> new file mode 100644
> index 0000000..96cb0ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
> @@ -0,0 +1,24 @@
> +
> +Exynos5440 cpufreq driver
> +-------------------
> +
> +Exynos5440 SoC cpufreq driver for CPU frequency scaling.
> +
> +Required properties:
> +- interrupts: Interrupt to know the completion of cpu frequency change.
> +- cpufreq_tbl: Table of frequencies and voltage CPU could be transitioned into,

This has to be "operating-points" as in cpufreq-cpu0 driver.

> +       in the decreasing order. Frequency should be in KHZ units and voltage
> +       should be in microvolts.
> +
> +All the required listed above must be defined under node cpufreq.
> +
> +Example:
> +--------
> +       cpufreq@160000 {
> +               compatible = "samsung,exynos5440-cpufreq";
> +               reg = <0x160000 0x1000>;
> +               interrupts = <0 57 0>;
> +               cpufreq_tbl = < 1200000 1025000
> +                               1000000 975000
> +                               800000  925000 >;
> +       };

> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
> new file mode 100644
> index 0000000..41d39e2
> --- /dev/null
> +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> @@ -0,0 +1,448 @@
> +/*
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *             http://www.samsung.com
> + *
> + * Amit Daniel Kachhap <amit.daniel@samsung.com>
> + *
> + * EXYNOS5440 - CPU frequency scaling support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/clk.h>
> +#include <linux/cpufreq.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/slab.h>
> +
> +/*Register definations*/
> +#define XMU_DVFS_CTRL          0x0060
> +#define XMU_PMU_P0_7           0x0064
> +#define XMU_C0_3_PSTATE        0x0090
> +#define XMU_P_LIMIT            0x00A0
> +#define XMU_P_STATUS           0x00A4
> +#define XMU_PMUEVTEN           0x00D0
> +#define XMU_PMUIRQEN           0x00D4
> +#define XMU_PMUIRQ             0x00D8
> +
> +/*PMU mask and shift definations*/
> +#define P_VALUE_MASK           0x7
> +
> +#define XMU_DVFS_CTRL_EN_SHIFT 0
> +
> +#define P0_7_CPUCLKDEV_SHIFT   21
> +#define P0_7_CPUCLKDEV_MASK    0x7
> +#define P0_7_ATBCLKDEV_SHIFT   18
> +#define P0_7_ATBCLKDEV_MASK    0x7
> +#define P0_7_CSCLKDEV_SHIFT    15
> +#define P0_7_CSCLKDEV_MASK     0x7
> +#define P0_7_CPUEMA_SHIFT      28
> +#define P0_7_CPUEMA_MASK       0xf
> +#define P0_7_L2EMA_SHIFT       24
> +#define P0_7_L2EMA_MASK        0xf
> +#define P0_7_VDD_SHIFT         8
> +#define P0_7_VDD_MASK          0x7f
> +#define P0_7_FREQ_SHIFT                0
> +#define P0_7_FREQ_MASK         0xff
> +
> +#define C0_3_PSTATE_VALID_SHIFT        8
> +#define C0_3_PSTATE_CURR_SHIFT 4
> +#define C0_3_PSTATE_NEW_SHIFT  0
> +
> +#define PSTATE_CHANGED_EVTEN_SHIFT     0
> +
> +#define PSTATE_CHANGED_IRQEN_SHIFT     0
> +
> +#define PSTATE_CHANGED_SHIFT           0
> +
> +/*some constant values for clock divider calculation*/
> +#define CPU_DIV_FREQ_MAX       500
> +#define CPU_DBG_FREQ_MAX       375
> +#define CPU_ATB_FREQ_MAX       500
> +
> +#define PMIC_LOW_VOLT          0x30
> +#define PMIC_HIGH_VOLT         0x28
> +
> +#define CPUEMA_HIGH            0x2
> +#define CPUEMA_MID             0x4
> +#define CPUEMA_LOW             0x7
> +
> +#define L2EMA_HIGH             0x1
> +#define L2EMA_MID              0x3
> +#define L2EMA_LOW              0x4
> +
> +#define DIV_TAB_MAX    2
> +/*frequency unit is 20MHZ*/
> +#define FREQ_UNIT      20
> +#define MAX_VOLTAGE    1550000 /*In micro volt*/
> +#define VOLTAGE_STEP   12500   /*In micro volt*/
> +
> +#define DRIVER_NAME            "exynos5440_dvfs"
> +#define DEF_TRANS_LATENCY      100000
> +
> +enum cpufreq_level_index {
> +       L0, L1, L2, L3, L4,
> +       L5, L6, L7, L8, L9,
> +};
> +#define CPUFREQ_LEVEL_END      (L7 + 1)
> +
> +struct exynos_dvfs_data {
> +       void __iomem *base;
> +       struct resource *mem;
> +       int irq;
> +       struct clk *cpu_clk;
> +       unsigned int cur_frequency;
> +       bool dvfs_init;
> +       struct cpufreq_frequency_table *freq_table;
> +       struct work_struct irq_work;
> +};
> +
> +static struct exynos_dvfs_data *dvfs_info;
> +static DEFINE_MUTEX(cpufreq_lock);
> +static struct cpufreq_freqs freqs;
> +static struct cpufreq_frequency_table exynos_freq_table[CPUFREQ_LEVEL_END + 1];
> +static unsigned int exynos_volt_table[CPUFREQ_LEVEL_END + 1];
> +
> +static void init_div_table(void)
> +{
> +       struct cpufreq_frequency_table *freq_tbl = exynos_freq_table;
> +       unsigned int *volt_tbl = exynos_volt_table;
> +       unsigned int tmp, clk_div, ema_div, freq, volt_id;
> +       int i = 0;
> +
> +       for (i = 0; freq_tbl[i].frequency != CPUFREQ_TABLE_END; i++) {
> +
> +               freq = freq_tbl[i].frequency / 1000; /*In MHZ*/
> +               clk_div = ((freq / CPU_DIV_FREQ_MAX) & P0_7_CPUCLKDEV_MASK)
> +                                       << P0_7_CPUCLKDEV_SHIFT;
> +               clk_div |= ((freq / CPU_ATB_FREQ_MAX) & P0_7_ATBCLKDEV_MASK)
> +                                       << P0_7_ATBCLKDEV_SHIFT;
> +               clk_div |= ((freq / CPU_DBG_FREQ_MAX) & P0_7_CSCLKDEV_MASK)
> +                                       << P0_7_CSCLKDEV_SHIFT;
> +
> +               /*Calculate EMA*/
> +               volt_id = (MAX_VOLTAGE - volt_tbl[i]) / VOLTAGE_STEP;
> +               if (volt_id < PMIC_HIGH_VOLT) {
> +                       ema_div = (CPUEMA_HIGH << P0_7_CPUEMA_SHIFT) |
> +                               (L2EMA_HIGH << P0_7_L2EMA_SHIFT);
> +               } else if (volt_id > PMIC_LOW_VOLT) {
> +                       ema_div = (CPUEMA_LOW << P0_7_CPUEMA_SHIFT) |
> +                               (L2EMA_LOW << P0_7_L2EMA_SHIFT);
> +               } else {
> +                       ema_div = (CPUEMA_MID << P0_7_CPUEMA_SHIFT) |
> +                               (L2EMA_MID << P0_7_L2EMA_SHIFT);
> +               }
> +
> +               tmp = (clk_div | ema_div | (volt_id << P0_7_VDD_SHIFT)
> +                       | ((freq / FREQ_UNIT) << P0_7_FREQ_SHIFT));
> +
> +               __raw_writel(tmp, dvfs_info->base + XMU_PMU_P0_7 + 4 * i);
> +       }
> +}
> +
> +void exynos_enable_dvfs(void)
> +{
> +       unsigned int tmp, i, cpu;
> +       struct cpufreq_frequency_table *freq_table = dvfs_info->freq_table;
> +       /*Disable DVFS*/
> +       __raw_writel(0, dvfs_info->base + XMU_DVFS_CTRL);
> +
> +       /*Enable PSTATE Change Event*/
> +       tmp = __raw_readl(dvfs_info->base + XMU_PMUEVTEN);
> +       tmp |= (1 << PSTATE_CHANGED_EVTEN_SHIFT);
> +        __raw_writel(tmp, dvfs_info->base + XMU_PMUEVTEN);
> +
> +       /*Enable PSTATE Change IRQ*/
> +       tmp = __raw_readl(dvfs_info->base + XMU_PMUIRQEN);
> +       tmp |= (1 << PSTATE_CHANGED_IRQEN_SHIFT);
> +        __raw_writel(tmp, dvfs_info->base + XMU_PMUIRQEN);
> +
> +       /*Set initial perfromance index*/

performance.

> +       for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++)
> +               if (freq_table[i].frequency == dvfs_info->cur_frequency)
> +                       break;
> +
> +       if (freq_table[i].frequency == CPUFREQ_TABLE_END) {
> +               pr_crit("Boot up frequency not supported\n");
> +               if (i) {
> +                       /*Assign the highest frequency*/
> +                       i = 0;
> +                       dvfs_info->cur_frequency = freq_table[i].frequency;
> +               } else {
> +                       return;
> +               }
> +       }
> +       pr_info("Setting dvfs initial frequency = %u",
> +                                               dvfs_info->cur_frequency);
> +
> +       for (cpu = 0; cpu < CONFIG_NR_CPUS; cpu++) {
> +               tmp = __raw_readl(dvfs_info->base + XMU_C0_3_PSTATE + cpu * 4);
> +               tmp &= ~(P_VALUE_MASK << C0_3_PSTATE_NEW_SHIFT);
> +               tmp |= (i << C0_3_PSTATE_NEW_SHIFT);
> +               __raw_writel(tmp, dvfs_info->base + XMU_C0_3_PSTATE + cpu * 4);
> +       }
> +
> +       /*Enable DVFS*/
> +       __raw_writel(1 << XMU_DVFS_CTRL_EN_SHIFT,
> +                               dvfs_info->base + XMU_DVFS_CTRL);
> +}
> +
> +static int exynos_verify_speed(struct cpufreq_policy *policy)
> +{
> +       return cpufreq_frequency_table_verify(policy,
> +                                             dvfs_info->freq_table);
> +}
> +
> +static unsigned int exynos_getspeed(unsigned int cpu)
> +{
> +       return dvfs_info->cur_frequency;
> +}
> +
> +static int exynos_target(struct cpufreq_policy *policy,
> +                         unsigned int target_freq,
> +                         unsigned int relation)
> +{
> +       unsigned int index, old_index, tmp;
> +       int ret = 0, i;
> +       struct cpufreq_frequency_table *freq_table = dvfs_info->freq_table;
> +
> +       mutex_lock(&cpufreq_lock);
> +
> +       freqs.old = dvfs_info->cur_frequency;
> +
> +       if (dvfs_info->dvfs_init == false) {
> +               ret = -EAGAIN;
> +               goto out;
> +       }
> +
> +       /*
> +        * The policy max have been changed so that we cannot get proper
> +        * old_index with cpufreq_frequency_table_target(). Thus, ignore
> +        * policy and get the index from the raw freqeuncy table.
> +        */

What? Why ?

> +       for (old_index = 0;
> +               freq_table[old_index].frequency != CPUFREQ_TABLE_END;
> +               old_index++)
> +               if (freq_table[old_index].frequency == freqs.old)
> +                       break;
> +
> +       if (freq_table[old_index].frequency == CPUFREQ_TABLE_END) {

How can this be true?

> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       if (cpufreq_frequency_table_target(policy, freq_table,
> +                                          target_freq, relation, &index)) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       freqs.new = freq_table[index].frequency;
> +       freqs.cpu = policy->cpu;
> +
> +       for_each_cpu(freqs.cpu, policy->cpus)
> +               cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +
> +       /*Set the target frequency in all C0_3_PSTATE register*/
> +       for_each_cpu(i, policy->cpus) {
> +               tmp = __raw_readl(dvfs_info->base + XMU_C0_3_PSTATE + i * 4);
> +               tmp &= ~(P_VALUE_MASK << C0_3_PSTATE_NEW_SHIFT);
> +               tmp |= (index << C0_3_PSTATE_NEW_SHIFT);
> +
> +               __raw_writel(tmp, dvfs_info->base + XMU_C0_3_PSTATE + i * 4);
> +       }
> +out:
> +       mutex_unlock(&cpufreq_lock);

That's something new and interesting. So you are just configuring your
controller
for a new dvfs point and get back to work. Then you would get an
interrupt sometime
and work is queued and everybody notified.

@Rafael: You expect any issue with this technique ?

> +       return ret;
> +}
> +
> +static void exynos_cpufreq_work(struct work_struct *work)
> +{
> +       unsigned int cur_pstate, index;
> +       struct cpufreq_policy *policy = cpufreq_cpu_get(0); /* boot CPU */
> +       struct cpufreq_frequency_table *freq_table = dvfs_info->freq_table;
> +
> +       mutex_lock(&cpufreq_lock);
> +
> +       freqs.old = dvfs_info->cur_frequency;
> +
> +       cur_pstate = __raw_readl(dvfs_info->base + XMU_P_STATUS);
> +       if (cur_pstate >> C0_3_PSTATE_VALID_SHIFT & 0x1)
> +               index = (cur_pstate >> C0_3_PSTATE_CURR_SHIFT) & P_VALUE_MASK;
> +       else
> +               index = (cur_pstate >> C0_3_PSTATE_NEW_SHIFT) & P_VALUE_MASK;
> +
> +       if (index < CPUFREQ_LEVEL_END)
> +               freqs.new = freq_table[index].frequency;
> +
> +       for_each_cpu(freqs.cpu, policy->cpus)
> +               cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +
> +       dvfs_info->cur_frequency = freqs.new;
> +
> +       cpufreq_cpu_put(policy);
> +       mutex_unlock(&cpufreq_lock);
> +       enable_irq(dvfs_info->irq);
> +}
> +
> +static irqreturn_t exynos_cpufreq_irq(int irq, void *id)
> +{
> +       unsigned int tmp;
> +
> +       tmp = __raw_readl(dvfs_info->base + XMU_PMUIRQ);
> +       if (tmp >> PSTATE_CHANGED_SHIFT & 0x1) {
> +               __raw_writel(tmp, dvfs_info->base + XMU_PMUIRQ);
> +
> +               if (dvfs_info->dvfs_init == true) {
> +                       disable_irq_nosync(irq);
> +                       schedule_work(&dvfs_info->irq_work);
> +               }
> +       }
> +       return IRQ_HANDLED;
> +}
> +
> +static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       policy->cur = policy->min = policy->max = dvfs_info->cur_frequency;

you don't have to fill min and max. its done by core when you call
cpufreq_frequency_table_cpuinfo().

> +
> +       cpufreq_frequency_table_get_attr(dvfs_info->freq_table, policy->cpu);
> +
> +       /* set the transition latency value */
> +       policy->cpuinfo.transition_latency = DEF_TRANS_LATENCY;
> +
> +       /*
> +        * EXYNOS5440 multi-core processors has 4 cores
> +        * that the frequency cannot be set independently.
> +        * Each cpu is bound to the same speed.
> +        * So the affected cpu is all of the cpus.
> +        */

Good. I understood it now :)

> +       if (num_online_cpus() == 1) {
> +               cpumask_copy(policy->related_cpus, cpu_possible_mask);
> +               cpumask_copy(policy->cpus, cpu_online_mask);
> +       } else {
> +               policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> +               cpumask_setall(policy->cpus);
> +       }

Replace everything between "Good" and this line with:

cpumask_setall(policy->cpus);

http://www.spinics.net/lists/cpufreq/msg04091.html

> +       return cpufreq_frequency_table_cpuinfo(policy, dvfs_info->freq_table);
> +}
> +
> +static struct cpufreq_driver exynos_driver = {
> +       .flags          = CPUFREQ_STICKY,
> +       .verify         = exynos_verify_speed,
> +       .target         = exynos_target,
> +       .get            = exynos_getspeed,
> +       .init           = exynos_cpufreq_cpu_init,
> +       .name           = DRIVER_NAME,
> +};
> +
> +static int __init exynos_cpufreq_init(void)
> +{
> +       int ret = -EINVAL, len, i;
> +       struct device_node *np;
> +       struct cpufreq_frequency_table *freq_tbl = exynos_freq_table;
> +       unsigned int *volt_tbl = exynos_volt_table;

why do we need duplicate names for global variables here? remove exynos_
from globals and that would be enough (in case you don't want long names).

> +       const struct property *prop;
> +       const __be32 *val;
> +
> +       np =  of_find_compatible_node(NULL, NULL, "samsung,exynos5440-cpufreq");
> +       if (!np)
> +               return -ENODEV;
> +
> +       dvfs_info = kzalloc(sizeof(struct exynos_dvfs_data), GFP_KERNEL);

sizeof(*dvfs_info) ?? why don't make it static too, as you have other
stuff too.. ?
The better option for single image solution to allocate everything
dynamically, so that
unused drivers don't occupy any space.

> +       if (!dvfs_info) {
> +               of_node_put(np);
> +               return -ENOMEM;
> +       }
> +
> +       dvfs_info->base = of_iomap(np, 0);
> +       if (!dvfs_info->base) {
> +               pr_err("No cpufreq memory map found\n");
> +               ret = -ENODEV;
> +               goto err_map;
> +
> +       }
> +
> +       dvfs_info->irq = irq_of_parse_and_map(np, 0);
> +
> +       if (dvfs_info->irq == 0) {
> +               pr_err("No cpufreq irq found\n");
> +               ret = -ENODEV;
> +               goto err_irq_parse;
> +       }
> +
> +       prop = of_find_property(np, "cpufreq_tbl", NULL);
> +       if (!prop || !prop->value) {
> +               pr_err("No cpufreq table found\n");
> +               ret = -ENODEV;
> +               goto err_irq_parse;
> +       }
> +
> +       len = prop->length / sizeof(u32);
> +       val = prop->value;
> +
> +       if ((len == 0) || (len / 2 > CPUFREQ_LEVEL_END)) {

I really didn't like this limit you have put at the number of dvfs
points. Better
would be to use:

	ret = of_init_opp_table(cpu_dev);
	if (ret) {
		pr_err("failed to init OPP table: %d\n", ret);
		goto out_put_node;
	}

	ret = opp_init_cpufreq_table(cpu_dev, &freq_table);
	if (ret) {
		pr_err("failed to init cpufreq table: %d\n", ret);
		goto out_put_node;
	}

as used in cpufreq-cpu0 driver. Also please have a closer look at this driver,
you may not your driver at all :)

> +               pr_err("Invalid cpufreq table\n");
> +               ret = -ENODEV;
> +               goto err_irq_parse;
> +       }
> +
> +       for (i = 0; i < (len / 2); i++) {
> +               freq_tbl[i].index = i;
> +               freq_tbl[i].frequency = be32_to_cpup(val++);
> +               volt_tbl[i] = be32_to_cpup(val++);
> +       }
> +
> +       freq_tbl[i].index = i;
> +       freq_tbl[i].frequency = CPUFREQ_TABLE_END;
> +
> +       dvfs_info->freq_table = freq_tbl;
> +
> +       dvfs_info->cpu_clk = clk_get(NULL, "armclk");

devm_clk_get() ?

> +       if (IS_ERR(dvfs_info->cpu_clk)) {
> +               pr_err("Failed to get cpu clock\n");
> +               ret = PTR_ERR(dvfs_info->cpu_clk);
> +               goto err_irq_parse;
> +       }
> +
> +       INIT_WORK(&dvfs_info->irq_work, exynos_cpufreq_work);
> +       if (request_irq(dvfs_info->irq, exynos_cpufreq_irq,

devm_ ??

> +                               IRQF_TRIGGER_NONE, DRIVER_NAME, dvfs_info)) {
> +               pr_err("Failed to register IRQ\n");
> +               ret = -ENODEV;
> +               goto err_irq_req;
> +       }
> +
> +       dvfs_info->cur_frequency = clk_get_rate(dvfs_info->cpu_clk) / 1000;

what if clk_get_rate fails ? or returns zero.

> +       init_div_table();
> +       exynos_enable_dvfs();
> +
> +       if (cpufreq_register_driver(&exynos_driver)) {
> +               pr_err("%s: failed to register cpufreq driver\n", __func__);
> +               goto err_register;
> +       }
> +
> +       of_node_put(np);
> +       dvfs_info->dvfs_init = true;

why do you need this ?

> +       pr_info("exynos5440 DVFS initialised.\n");
> +
> +       return 0;
> +
> +err_register:
> +       free_irq(dvfs_info->irq, dvfs_info);
> +err_irq_req:
> +       clk_put(dvfs_info->cpu_clk);
> +err_irq_parse:
> +       iounmap(dvfs_info->base);
> +err_map:
> +       of_node_put(np);
> +       kfree(dvfs_info);
> +       pr_err("%s: failed initialization\n", __func__);
> +       return -EINVAL;
> +}
> +late_initcall(exynos_cpufreq_init);
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

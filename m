From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [PATCH v5 2/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Thu, 2 Jul 2015 09:31:59 +0800
Message-ID: <CALx668X8fB_annmjL+ga7=fmY596HC0-nr+x6r2p0=aaCUJ3-Q@mail.gmail.com>
References: <1435717005-20012-1-git-send-email-pi-cheng.chen@linaro.org>
	<1435717005-20012-3-git-send-email-pi-cheng.chen@linaro.org>
	<CALW4P+L=q6z3LW2Da9XoU8HBHMgai-B7okRuMxSYCZv5-fj8Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35264 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbbGBBcC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 21:32:02 -0400
Received: by ykdy1 with SMTP id y1so55736256ykd.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2015 18:31:59 -0700 (PDT)
In-Reply-To: <CALW4P+L=q6z3LW2Da9XoU8HBHMgai-B7okRuMxSYCZv5-fj8Bw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexey Klimov <klimov.linux@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Alexey,

On Thu, Jul 2, 2015 at 5:24 AM, Alexey Klimov <klimov.linux@gmail.com> wrote:
> Hi Pi-Cheng,
>
> On Wed, Jul 1, 2015 at 5:16 AM, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
>> This patch implements MT8173 cpufreq driver.
>>
>> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
>> ---
>>  drivers/cpufreq/Kconfig.arm      |   7 +
>>  drivers/cpufreq/Makefile         |   1 +
>>  drivers/cpufreq/mt8173-cpufreq.c | 520 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 528 insertions(+)
>>  create mode 100644 drivers/cpufreq/mt8173-cpufreq.c
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 611cb09..2a305c0 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -141,6 +141,13 @@ config ARM_KIRKWOOD_CPUFREQ
>>           This adds the CPUFreq driver for Marvell Kirkwood
>>           SoCs.
>>
>> +config ARM_MT8173_CPUFREQ
>> +       bool "Mediatek MT8173 CPUFreq support"
>> +       depends on ARCH_MEDIATEK && REGULATOR
>> +       select PM_OPP
>> +       help
>> +         This adds the CPUFreq driver support for Mediatek MT8173 SoC.
>> +
>>  config ARM_OMAP2PLUS_CPUFREQ
>>         bool "TI OMAP2+"
>>         depends on ARCH_OMAP2PLUS
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index cdce92a..97f9a9b 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -63,6 +63,7 @@ obj-$(CONFIG_ARM_HISI_ACPU_CPUFREQ)   += hisi-acpu-cpufreq.o
>>  obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)                += imx6q-cpufreq.o
>>  obj-$(CONFIG_ARM_INTEGRATOR)           += integrator-cpufreq.o
>>  obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)     += kirkwood-cpufreq.o
>> +obj-$(CONFIG_ARM_MT8173_CPUFREQ)       += mt8173-cpufreq.o
>>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)    += omap-cpufreq.o
>>  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)       += pxa2xx-cpufreq.o
>>  obj-$(CONFIG_PXA3xx)                   += pxa3xx-cpufreq.o
>> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
>> new file mode 100644
>> index 0000000..6284e67
>> --- /dev/null
>> +++ b/drivers/cpufreq/mt8173-cpufreq.c
>> @@ -0,0 +1,520 @@
>> +/*
>> + * Copyright (c) 2015 Linaro Ltd.
>> + * Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpu_cooling.h>
>> +#include <linux/cpufreq.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_opp.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/slab.h>
>> +#include <linux/thermal.h>
>> +
>> +#define MIN_VOLT_SHIFT         (100000)
>> +#define MAX_VOLT_SHIFT         (200000)
>> +#define MAX_VOLT_LIMIT         (1150000)
>> +#define VOLT_TOL               (10000)
>> +
>> +/*
>> + * The struct mtk_cpu_dvfs_info holds necessary information for doing CPU DVFS
>> + * on each CPU power/clock domain of Mediatek SoCs. Each CPU cluster in
>> + * Mediatek SoCs has two voltage inputs, Vproc and Vsram. In some cases the two
>> + * voltage inputs need to be controlled under a hardware limitation:
>> + * 100mV < Vsram - Vproc < 200mV
>> + *
>> + * When scaling the clock frequency of a CPU clock domain, the clock source
>> + * needs to be switched to another stable PLL clock temporarily until
>> + * the original PLL becomes stable at target frequency.
>> + */
>> +struct mtk_cpu_dvfs_info {
>> +       struct device *cpu_dev;
>> +       struct regulator *proc_reg;
>> +       struct regulator *sram_reg;
>> +       struct clk *cpu_clk;
>> +       struct clk *inter_clk;
>> +       struct thermal_cooling_device *cdev;
>> +       int intermediate_voltage;
>> +       bool need_voltage_trace;
>> +};
>> +
>> +static int mtk_cpufreq_voltage_trace(struct mtk_cpu_dvfs_info *info,
>> +                                    int new_vproc)
>> +{
>> +       struct regulator *proc_reg = info->proc_reg;
>> +       struct regulator *sram_reg = info->sram_reg;
>> +       int old_vproc, old_vsram, new_vsram, vsram, vproc, ret;
>> +
>> +       old_vproc = regulator_get_voltage(proc_reg);
>> +       old_vsram = regulator_get_voltage(sram_reg);
>> +       /* Vsram should not exceed the maximum allowed voltage of SoC. */
>> +       new_vsram = min(new_vproc + MIN_VOLT_SHIFT, MAX_VOLT_LIMIT);
>> +
>> +       if (old_vproc < new_vproc) {
>> +               /*
>> +                * When scaling up voltages, Vsram and Vproc scale up step
>> +                * by step. At each step, set Vsram to (Vproc + 200mV) first,
>> +                * then set Vproc to (Vsram - 100mV).
>> +                * Keep doing it until Vsram and Vproc hit target voltages.
>> +                */
>> +               do {
>> +                       old_vsram = regulator_get_voltage(sram_reg);
>> +                       old_vproc = regulator_get_voltage(proc_reg);
>> +
>> +                       vsram = min(new_vsram, old_vproc + MAX_VOLT_SHIFT);
>> +
>> +                       if (vsram + VOLT_TOL >= MAX_VOLT_LIMIT) {
>> +                               vsram = MAX_VOLT_LIMIT;
>> +
>> +                               /*
>> +                                * If the target Vsram hits the maximum voltage,
>> +                                * try to set the exact voltage value first.
>> +                                */
>> +                               ret = regulator_set_voltage(sram_reg, vsram,
>> +                                                           vsram);
>> +                               if (ret)
>> +                                       ret = regulator_set_voltage(sram_reg,
>> +                                                       vsram - VOLT_TOL,
>> +                                                       vsram);
>> +
>> +                               vproc = new_vproc;
>> +                       } else {
>> +                               ret = regulator_set_voltage(sram_reg, vsram,
>> +                                                           vsram + VOLT_TOL);
>> +
>> +                               vproc = vsram - MIN_VOLT_SHIFT;
>> +                       }
>> +                       if (ret)
>> +                               return ret;
>> +
>> +                       ret = regulator_set_voltage(proc_reg, vproc,
>> +                                                   vproc + VOLT_TOL);
>> +                       if (ret) {
>> +                               regulator_set_voltage(sram_reg, old_vsram,
>> +                                                     old_vsram);
>> +                               return ret;
>> +                       }
>> +               } while (vproc < new_vproc || vsram < new_vsram);
>> +       } else if (old_vproc > new_vproc) {
>> +               /*
>> +                * When scaling down voltages, Vsram and Vproc scale down step
>> +                * by step. At each step, set Vproc to (Vsram - 200mV) first,
>> +                * then set Vproc to (Vproc + 100mV).
>> +                * Keep doing it until Vsram and Vproc hit target voltages.
>> +                */
>> +               do {
>> +                       old_vproc = regulator_get_voltage(proc_reg);
>> +                       old_vsram = regulator_get_voltage(sram_reg);
>> +
>> +                       vproc = max(new_vproc, old_vsram - MAX_VOLT_SHIFT);
>> +                       ret = regulator_set_voltage(proc_reg, vproc,
>> +                                                   vproc + VOLT_TOL);
>> +                       if (ret)
>> +                               return ret;
>> +
>> +                       if (vproc == new_vproc)
>> +                               vsram = new_vsram;
>> +                       else
>> +                               vsram = max(new_vsram, vproc + MIN_VOLT_SHIFT);
>> +
>> +                       if (vsram + VOLT_TOL >= MAX_VOLT_LIMIT) {
>> +                               vsram = MAX_VOLT_LIMIT;
>> +
>> +                               /*
>> +                                * If the target Vsram hits the maximum voltage,
>> +                                * try to set the exact voltage value first.
>> +                                */
>> +                               ret = regulator_set_voltage(sram_reg, vsram,
>> +                                                           vsram);
>> +                               if (ret)
>> +                                       ret = regulator_set_voltage(sram_reg,
>> +                                                       vsram - VOLT_TOL,
>> +                                                       vsram);
>> +                       } else {
>> +                               ret = regulator_set_voltage(sram_reg, vsram,
>> +                                                           vsram + VOLT_TOL);
>> +                       }
>> +
>> +                       if (ret) {
>> +                               regulator_set_voltage(proc_reg, old_vproc,
>> +                                                     old_vproc);
>> +                               return ret;
>> +                       }
>> +               } while (vproc > new_vproc + VOLT_TOL ||
>> +                        vsram > new_vsram + VOLT_TOL);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info *info, int vproc)
>> +{
>> +       if (info->need_voltage_trace)
>> +               return mtk_cpufreq_voltage_trace(info, vproc);
>> +       else
>> +               return regulator_set_voltage(info->proc_reg, vproc,
>> +                                            vproc + VOLT_TOL);
>> +}
>> +
>> +static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>> +                                 unsigned int index)
>> +{
>> +       struct cpufreq_frequency_table *freq_table = policy->freq_table;
>> +       struct clk *cpu_clk = policy->clk;
>> +       struct clk *armpll = clk_get_parent(cpu_clk);
>> +       struct mtk_cpu_dvfs_info *info = policy->driver_data;
>> +       struct device *cpu_dev = info->cpu_dev;
>> +       struct dev_pm_opp *opp;
>> +       long freq_hz, old_freq_hz;
>> +       int vproc, old_vproc, inter_vproc, target_vproc, ret;
>> +
>> +       inter_vproc = info->intermediate_voltage;
>> +
>> +       old_freq_hz = clk_get_rate(cpu_clk);
>> +       old_vproc = regulator_get_voltage(info->proc_reg);
>> +
>> +       freq_hz = freq_table[index].frequency * 1000;
>> +
>> +       rcu_read_lock();
>> +       opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
>> +       if (IS_ERR(opp)) {
>> +               rcu_read_unlock();
>> +               pr_err("cpu%d: failed to find OPP for %ld\n",
>> +                      policy->cpu, freq_hz);
>> +               return PTR_ERR(opp);
>> +       }
>> +       vproc = dev_pm_opp_get_voltage(opp);
>> +       rcu_read_unlock();
>> +
>> +       /*
>> +        * If the new voltage or the intermediate voltage is higher than the
>> +        * current voltage, scale up voltage first.
>> +        */
>> +       target_vproc = (inter_vproc > vproc) ? inter_vproc : vproc;
>> +       if (old_vproc < target_vproc) {
>> +               ret = mtk_cpufreq_set_voltage(info, target_vproc);
>> +               if (ret) {
>> +                       pr_err("cpu%d: failed to scale up voltage!\n",
>> +                              policy->cpu);
>> +                       mtk_cpufreq_set_voltage(info, old_vproc);
>> +                       return ret;
>> +               }
>> +       }
>> +
>> +       /* Reparent the CPU clock to intermediate clock. */
>> +       ret = clk_set_parent(cpu_clk, info->inter_clk);
>> +       if (ret) {
>> +               pr_err("cpu%d: failed to re-parent cpu clock!\n",
>> +                      policy->cpu);
>> +               mtk_cpufreq_set_voltage(info, old_vproc);
>> +               WARN_ON(1);
>> +               return ret;
>> +       }
>> +
>> +       /* Set the original PLL to target rate. */
>> +       ret = clk_set_rate(armpll, freq_hz);
>> +       if (ret) {
>> +               pr_err("cpu%d: failed to scale cpu clock rate!\n",
>> +                      policy->cpu);
>> +               clk_set_parent(cpu_clk, armpll);
>> +               mtk_cpufreq_set_voltage(info, old_vproc);
>> +               return ret;
>> +       }
>> +
>> +       /* Set parent of CPU clock back to the original PLL. */
>> +       ret = clk_set_parent(cpu_clk, armpll);
>> +       if (ret) {
>> +               pr_err("cpu%d: failed to re-parent cpu clock!\n",
>> +                      policy->cpu);
>> +               mtk_cpufreq_set_voltage(info, inter_vproc);
>> +               WARN_ON(1);
>> +               return ret;
>> +       }
>> +
>> +       /*
>> +        * If the new voltage is lower than the intermediate voltage or the
>> +        * original voltage, scale down to the new voltage.
>> +        */
>> +       if (vproc < inter_vproc || vproc < old_vproc) {
>> +               ret = mtk_cpufreq_set_voltage(info, vproc);
>> +               if (ret) {
>> +                       pr_err("cpu%d: failed to scale down voltage!\n",
>> +                              policy->cpu);
>> +                       clk_set_parent(cpu_clk, info->inter_clk);
>> +                       clk_set_rate(armpll, old_freq_hz);
>> +                       clk_set_parent(cpu_clk, armpll);
>> +                       return ret;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
>> +{
>> +       struct mtk_cpu_dvfs_info *info = policy->driver_data;
>> +       struct device_node *np = of_node_get(info->cpu_dev->of_node);
>> +
>> +       if (WARN_ON(!np))
>> +               return;
>> +
>> +       if (of_find_property(np, "#cooling-cells", NULL)) {
>> +               info->cdev = of_cpufreq_cooling_register(np,
>> +                                                        policy->related_cpus);
>> +
>> +               if (IS_ERR(info->cdev)) {
>> +                       dev_err(info->cpu_dev,
>> +                               "running cpufreq without cooling device: %ld\n",
>> +                               PTR_ERR(info->cdev));
>> +
>> +                       info->cdev = NULL;
>> +               }
>> +       }
>> +
>> +       of_node_put(np);
>> +}
>> +
>> +static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>> +{
>> +       struct device *cpu_dev;
>> +       struct regulator *proc_reg = ERR_PTR(-ENODEV);
>> +       struct regulator *sram_reg = ERR_PTR(-ENODEV);
>> +       struct clk *cpu_clk = ERR_PTR(-ENODEV);
>> +       struct clk *inter_clk = ERR_PTR(-ENODEV);
>> +       struct dev_pm_opp *opp;
>> +       unsigned long rate;
>> +       int ret;
>> +
>> +       cpu_dev = get_cpu_device(cpu);
>> +       if (!cpu_dev) {
>> +               pr_err("failed to get cpu%d device\n", cpu);
>> +               return -ENODEV;
>> +       }
>> +
>> +       ret = of_init_opp_table(cpu_dev);
>> +       if (ret) {
>> +               pr_warn("no OPP table for cpu%d\n", cpu);
>> +               return ret;
>> +       }
>> +
>> +       cpu_clk = clk_get(cpu_dev, "cpu");
>> +       if (IS_ERR(cpu_clk)) {
>> +               if (PTR_ERR(cpu_clk) == -EPROBE_DEFER)
>> +                       pr_warn("cpu clk for cpu%d not ready, retry.\n", cpu);
>> +               else
>> +                       pr_err("failed to get cpu clk for cpu%d\n", cpu);
>> +
>> +               ret = PTR_ERR(cpu_clk);
>> +               goto out_free_opp_table;
>> +       }
>> +
>> +       inter_clk = clk_get(cpu_dev, "intermediate");
>> +       if (IS_ERR(inter_clk)) {
>> +               if (PTR_ERR(inter_clk) == -EPROBE_DEFER)
>> +                       pr_warn("intermediate clk for cpu%d not ready, retry.\n",
>> +                               cpu);
>> +               else
>> +                       pr_err("failed to get intermediate clk for cpu%d\n",
>> +                              cpu);
>> +
>> +               ret = PTR_ERR(inter_clk);
>> +               goto out_free_resources;
>> +       }
>> +
>> +       proc_reg = regulator_get_exclusive(cpu_dev, "proc");
>> +       if (IS_ERR(proc_reg)) {
>> +               if (PTR_ERR(proc_reg) == -EPROBE_DEFER)
>> +                       pr_warn("proc regulator for cpu%d not ready, retry.\n",
>> +                               cpu);
>> +               else
>> +                       pr_err("failed to get proc regulator for cpu%d\n",
>> +                              cpu);
>> +
>> +               ret = PTR_ERR(proc_reg);
>> +               goto out_free_resources;
>> +       }
>> +
>> +       /* Both presence and absence of sram regulator are valid cases. */
>> +       sram_reg = regulator_get_exclusive(cpu_dev, "sram");
>> +
>> +       /* Search a safe voltage for intermediate frequency. */
>> +       rate = clk_get_rate(inter_clk);
>> +       rcu_read_lock();
>> +       opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
>> +       if (IS_ERR(opp)) {
>> +               pr_err("failed to get intermediate opp for cpu%d\n", cpu);
>> +               ret = PTR_ERR(opp);
>> +               goto out_free_resources;
>> +       }
>
> Could you please check this error path? Probably you missed
> rcu_read_unlock() here.

Yes. rcu_read_unlock is missed here. I will add it.
Thanks for your reviewing.

Best Regards,
Pi-Cheng

>
>> +       info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
>> +       rcu_read_unlock();
>> +
>> +       info->cpu_dev = cpu_dev;
>> +       info->proc_reg = proc_reg;
>> +       info->sram_reg = IS_ERR(sram_reg) ? NULL : sram_reg;
>> +       info->cpu_clk = cpu_clk;
>> +       info->inter_clk = inter_clk;
>> +
>> +       /*
>> +        * If SRAM regulator is present, software "voltage trace" is needed
>> +        * for this CPU power domain.
>> +        */
>> +       info->need_voltage_trace = !IS_ERR(sram_reg);
>> +
>> +       return 0;
>> +
>> +out_free_resources:
>> +       if (!IS_ERR(proc_reg))
>> +               regulator_put(proc_reg);
>> +       if (!IS_ERR(sram_reg))
>> +               regulator_put(sram_reg);
>> +       if (!IS_ERR(cpu_clk))
>> +               clk_put(cpu_clk);
>> +       if (!IS_ERR(inter_clk))
>> +               clk_put(inter_clk);
>> +
>> +out_free_opp_table:
>> +       of_free_opp_table(cpu_dev);
>> +
>> +       return ret;
>> +}
>
> <snip>
>
> Best regards,
> Alexey Klimov

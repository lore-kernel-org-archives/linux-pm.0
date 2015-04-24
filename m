From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Fri, 24 Apr 2015 14:46:25 +0800
Message-ID: <CALx668VsT60+kx7o-ZM5Wxk7Nn-rXS21O5SDYr++EeY-zEJ6ew@mail.gmail.com>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
	<1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
	<20150423120152.GM6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:34593 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932719AbbDXGq1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 02:46:27 -0400
Received: by laat2 with SMTP id t2so28487169laa.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2015 23:46:25 -0700 (PDT)
In-Reply-To: <20150423120152.GM6325@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mturquette@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Chen Fan <fan.chen@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, linux-mediatek@lists.infradead.org

Hi Sascha,

Thanks for reviewing.

On Thu, Apr 23, 2015 at 8:01 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Mon, Apr 20, 2015 at 05:27:26PM +0800, pi-cheng.chen wrote:
>> This patch implements MT8173 specific cpufreq driver with OPP table defined
>> in the driver code.
>>
>> Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
>> ---
>>  drivers/cpufreq/Kconfig.arm      |   6 +
>>  drivers/cpufreq/Makefile         |   1 +
>>  drivers/cpufreq/mt8173-cpufreq.c | 509 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 516 insertions(+)
>>  create mode 100644 drivers/cpufreq/mt8173-cpufreq.c
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 1b06fc4..25643c7 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -132,6 +132,12 @@ config ARM_KIRKWOOD_CPUFREQ
>>         This adds the CPUFreq driver for Marvell Kirkwood
>>         SoCs.
>>
>> +config ARM_MT8173_CPUFREQ
>> +     bool "Mediatek MT8173 CPUFreq support"
>> +     depends on ARCH_MEDIATEK && REGULATOR
>> +     help
>> +       This adds the CPUFreq driver support for Mediatek MT8173 SoC.
>> +
>>  config ARM_OMAP2PLUS_CPUFREQ
>>       bool "TI OMAP2+"
>>       depends on ARCH_OMAP2PLUS
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index 82a1821..da9d616 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -62,6 +62,7 @@ obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)  += highbank-cpufreq.o
>>  obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)              += imx6q-cpufreq.o
>>  obj-$(CONFIG_ARM_INTEGRATOR)         += integrator-cpufreq.o
>>  obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)   += kirkwood-cpufreq.o
>> +obj-$(CONFIG_ARM_MT8173_CPUFREQ)     += mt8173-cpufreq.o
>>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)  += omap-cpufreq.o
>>  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)     += pxa2xx-cpufreq.o
>>  obj-$(CONFIG_PXA3xx)                 += pxa3xx-cpufreq.o
>> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
>> new file mode 100644
>> index 0000000..a310e72
>> --- /dev/null
>> +++ b/drivers/cpufreq/mt8173-cpufreq.c
>> @@ -0,0 +1,509 @@
>> +/*
>> +* Copyright (c) 2015 Linaro Ltd.
>> +* Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
>> +*
>> +* This program is free software; you can redistribute it and/or modify
>> +* it under the terms of the GNU General Public License version 2 as
>> +* published by the Free Software Foundation.
>> +*
>> +* This program is distributed in the hope that it will be useful,
>> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +* GNU General Public License for more details.
>> +*/
>> +
>> +#include <linux/clk.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpufreq.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/slab.h>
>> +
>> +#define MIN_VOLT_SHIFT               100000
>> +#define MAX_VOLT_SHIFT               200000
>> +
>> +#define OPP(f, vp, vs) {             \
>> +             .freq   = f,            \
>> +             .vproc  = vp,           \
>> +             .vsram  = vs,           \
>> +     }
>> +
>> +struct mtk_cpu_opp {
>> +     unsigned int freq;
>> +     int vproc;
>> +     int vsram;
>> +};
>> +
>> +/*
>> + * The struct cpu_dvfs_info holds necessary information for doing CPU DVFS of
>> + * each cluster. For Mediatek SoCs, each CPU cluster in SoC has two voltage
>> + * inputs, Vproc and Vsram. For some cluster in SoC, the two voltage inputs are
>> + * supplied by different PMICs. In this case, when scaling up/down the voltage
>> + * of Vsram and Vproc, the two voltage inputs need to be controlled under a
>> + * hardware limitation: 100mV < Vsram - Vproc < 200mV
>> + * When scaling up/down the clock frequency of a cluster, the clock source need
>> + * to be switched to another stable PLL clock temporarily, and switched back to
>> + * the original PLL after the it becomes stable at target frequency.
>> + * Hence the voltage inputs of cluster need to be set to an intermediate voltage
>> + * before the clock frequency being scaled up/down.
>> + */
>> +
>> +struct cpu_dvfs_info {
>> +     cpumask_t cpus;
>> +
>> +     struct mtk_cpu_opp *opp_tbl;
>> +     struct mtk_cpu_opp *intermediate_opp;
>> +     int nr_opp;
>> +
>> +     struct regulator *proc_reg;
>> +     struct regulator *sram_reg;
>> +     struct clk *cpu_clk;
>> +     struct clk *inter_pll;
>> +};
>> +
>> +/*
>> + * This is a temporary solution until we have new OPPv2 bindings. Therefore we
>> + * could describe the OPPs with (freq, volt, volt) tuple properly in device
>> + * tree.
>> + */
>> +
>> +/* OPP table for LITTLE cores of MT8173 */
>> +struct mtk_cpu_opp mt8173_l_opp[] = {
>> +     OPP(507000000, 859000, 0),
>> +     OPP(702000000, 908000, 0),
>> +     OPP(1001000000, 983000, 0),
>> +     OPP(1105000000, 1009000, 0),
>> +     OPP(1183000000, 1028000, 0),
>> +     OPP(1404000000, 1083000, 0),
>> +     OPP(1508000000, 1109000, 0),
>> +     OPP(1573000000, 1125000, 0),
>> +};
>> +
>> +/* OPP table for big cores of MT8173 */
>> +struct mtk_cpu_opp mt8173_b_opp[] = {
>> +     OPP(507000000, 828000, 928000),
>> +     OPP(702000000, 867000, 967000),
>> +     OPP(1001000000, 927000, 1027000),
>> +     OPP(1209000000, 968000, 1068000),
>> +     OPP(1404000000, 1007000, 1107000),
>> +     OPP(1612000000, 1049000, 1149000),
>> +     OPP(1807000000, 1089000, 1150000),
>> +     OPP(1989000000, 1125000, 1150000),
>> +};
>
> Do you really need the SRAM voltages? Isn't the SRAM voltage just CPU
> core voltage + 100mV +- tolerance?

Yes, that was also my original idea to describe the OPPs with only (volt, vproc)
pair in device tree and calculate the SRAM voltages in driver code. One of the
reason to put SRAM voltages in the table is that I think it will make the code
cleaner since we are actually controlling 2 regulators at each OPP. But you're
right, we don't really need it. I'm fine with both approaches. Just
not sure which
way is more proper.

The other reason to put this table with SRAM voltages is that I want to fixup
all voltage values by querying the supported voltages of regulators so that
it will be easier to do "voltage trace".

>
>> +
>> +static inline int need_voltage_trace(struct cpu_dvfs_info *info)
>> +{
>> +     return (!IS_ERR_OR_NULL(info->proc_reg) &&
>> +             !IS_ERR_OR_NULL(info->sram_reg));
>> +}
>> +
>> +static struct mtk_cpu_opp *cpu_opp_find_freq_ceil(struct mtk_cpu_opp *opp_tbl,
>> +                                               int nr_opp,
>> +                                               unsigned long rate)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < nr_opp; i++)
>> +             if (opp_tbl[i].freq >= rate)
>> +                     return &opp_tbl[i];
>> +
>> +     return NULL;
>> +}
>> +
>> +/*
>> + * Query the exact voltage value that is largest previous to the input voltage
>> + * value supported by the regulator
>> + */
>> +static int get_regulator_voltage_ceil(struct regulator *regulator, int voltage)
>> +{
>> +     int cnt, i, volt = -1;
>> +
>> +     if (IS_ERR_OR_NULL(regulator))
>> +             return -EINVAL;
>> +
>> +     cnt = regulator_count_voltages(regulator);
>> +     for (i = 0; i < cnt && volt < voltage; i++)
>> +             volt = regulator_list_voltage(regulator, i);
>> +
>> +     return (i >= cnt) ? -EINVAL : volt;
>> +}
>> +
>> +/*
>> + * Query the exact voltage value that is smallest following to the input voltage
>> + * value supported by the regulator
>> + */
>> +static int get_regulator_voltage_floor(struct regulator *regulator, int voltage)
>> +{
>> +     int cnt, i, volt = -1;
>> +
>> +     if (IS_ERR_OR_NULL(regulator))
>> +             return -EINVAL;
>> +
>> +     cnt = regulator_count_voltages(regulator);
>> +     /* skip all trailing 0s in the list of supported voltages */
>> +     for (i = cnt - 1; i >= 0 && volt <= 0; i--)
>> +             volt = regulator_list_voltage(regulator, i);
>> +
>> +     for (; i >= 0; i--) {
>> +             volt = regulator_list_voltage(regulator, i);
>> +             if (volt <= voltage)
>> +                     return volt;
>> +     }
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +static int mtk_cpufreq_voltage_trace(struct cpu_dvfs_info *info,
>> +                                  struct mtk_cpu_opp *opp)
>> +{
>> +     struct regulator *proc_reg = info->proc_reg;
>> +     struct regulator *sram_reg = info->sram_reg;
>> +     int old_vproc, new_vproc, old_vsram, new_vsram, vsram, vproc, ret;
>> +
>> +     old_vproc = regulator_get_voltage(proc_reg);
>> +     old_vsram = regulator_get_voltage(sram_reg);
>> +
>> +     new_vproc = opp->vproc;
>> +     new_vsram = opp->vsram;
>> +
>> +     /*
>> +      * In the case the voltage is going to be scaled up, Vsram and Vproc
>> +      * need to be scaled up step by step. In each step, Vsram needs to be
>> +      * set to (Vproc + 200mV) first, then Vproc is set to (Vsram - 100mV).
>> +      * Repeat the step until Vsram and Vproc are set to target voltage.
>> +      */
>> +     if (old_vproc < new_vproc) {
>> +next_up_step:
>> +             old_vsram = regulator_get_voltage(sram_reg);
>> +
>> +             vsram = (new_vsram - old_vproc < MAX_VOLT_SHIFT) ?
>> +                     new_vsram : old_vproc + MAX_VOLT_SHIFT;
>> +             vsram = get_regulator_voltage_floor(sram_reg, vsram);
>> +
>> +             ret = regulator_set_voltage(sram_reg, vsram, vsram);
>> +             if (ret)
>> +                     return ret;
>
> This introspecting the regulators for possible voltages looks hacky and
> unnecessary. regulator_set_voltage() can be passed minimum and maximum
> values, why don't you use it to increase the voltage within sensible
> limit, like
>
>         regulator_set_voltage(sram_reg, old_vsram + 100000, old_vsram + 200000);
>
> or similar?

I am sorry I don't understand how could I do it. Would you elaborate?

>
>> +
>> +             vproc = (new_vsram == vsram) ?
>> +                     new_vproc : vsram - MIN_VOLT_SHIFT;
>> +             vproc = get_regulator_voltage_ceil(proc_reg, vproc);
>> +
>> +             ret = regulator_set_voltage(proc_reg, vproc, vproc);
>> +             if (ret) {
>> +                     regulator_set_voltage(sram_reg, old_vsram, old_vsram);
>> +                     return ret;
>> +             }
>> +
>> +             if (new_vproc == vproc && new_vsram == vsram)
>> +                     return 0;
>
> Here you assume that the voltages can be exactly reached. That does not
> need to be the case, for example with a different PMIC.

That's why I try to fixup all voltage values during initialization. Please check
mt8173_cpufreq_cpu_opp_fixup() below.

>
>> +
>> +             old_vproc = vproc;
>> +             goto next_up_step;
>
> Use C loop instructions to create loops. Using gotos for loops creates
> readable code only in very rare cases (and this is not one of those)

Will do it.

>
>> +
>> +     /*
>> +      * In the case the voltage is going to be scaled down, Vsram and Vproc
>> +      * need to be scaled down step by step. In each step, Vproc needs to be
>> +      * set to (Vsram - 200mV) first, then Vproc is set to (Vproc + 100mV).
>> +      * Repeat the step until Vsram and Vproc are set to target voltage.
>> +      */
>> +     } else if (old_vproc > new_vproc) {
>> +next_down_step:
>> +             old_vproc = regulator_get_voltage(proc_reg);
>> +
>> +             vproc = (old_vsram - new_vproc < MAX_VOLT_SHIFT) ?
>> +                     new_vproc : old_vsram - MAX_VOLT_SHIFT;
>> +             vproc = get_regulator_voltage_ceil(proc_reg, vproc);
>> +
>> +             ret = regulator_set_voltage(proc_reg, vproc, vproc);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             vsram = (new_vproc == vproc) ?
>> +                     new_vsram : vproc + MIN_VOLT_SHIFT;
>> +             vsram = get_regulator_voltage_floor(sram_reg, vsram);
>> +
>> +             ret = regulator_set_voltage(sram_reg, vsram, vsram);
>> +             if (ret) {
>> +                     regulator_set_voltage(proc_reg, old_vproc, old_vproc);
>> +                     return ret;
>> +             }
>> +
>> +             if (new_vproc == vproc && new_vsram == vsram)
>> +                     return 0;
>> +
>> +             old_vsram = vsram;
>> +             goto next_down_step;
>> +     }
>> +
>> +     WARN_ON(1);
>
> Why warn? You have nothing to do and that should be just fine.

OK. Will remove it.

>
>> +     return 0;
>> +}
>> +
>> +static int mt8173_cpufreq_set_voltage(struct cpu_dvfs_info *info,
>> +                                   struct mtk_cpu_opp *opp)
>> +{
>> +     if (need_voltage_trace(info))
>> +             return mtk_cpufreq_voltage_trace(info, opp);
>> +     else
>> +             return regulator_set_voltage(info->proc_reg, opp->vproc,
>> +                                          opp->vproc);
>> +}
>> +
>> +static int mt8173_cpufreq_set_target(struct cpufreq_policy *policy,
>> +                                  unsigned int index)
>> +{
>> +     struct cpufreq_frequency_table *freq_table = policy->freq_table;
>> +     struct clk *cpu_clk = policy->clk;
>> +     struct clk *armpll = clk_get_parent(cpu_clk);
>> +     struct cpu_dvfs_info *info;
>> +     struct mtk_cpu_opp *new_opp, *target_opp, *inter_opp, *orig_opp;
>> +     long freq_hz, orig_freq_hz;
>> +     int old_vproc, ret;
>> +
>> +     info = (struct cpu_dvfs_info *)policy->driver_data;
>> +     inter_opp = info->intermediate_opp;
>> +     orig_freq_hz = clk_get_rate(cpu_clk);
>> +     orig_opp = cpu_opp_find_freq_ceil(info->opp_tbl, info->nr_opp,
>> +                                       orig_freq_hz);
>> +     if (!orig_opp)
>> +             return -EINVAL;
>> +
>> +     old_vproc = regulator_get_voltage(info->proc_reg);
>> +     freq_hz = freq_table[index].frequency * 1000;
>> +     new_opp = cpu_opp_find_freq_ceil(info->opp_tbl, info->nr_opp, freq_hz);
>
> Since the frequency table and the opp_tbl have the same indices:
>
>         new_opp = info->opp_tbl[index];

Will do it.

>
>> +     target_opp = new_opp;
>> +
>> +     if (!new_opp)
>> +             return -EINVAL;
>> +
>> +     if (target_opp->vproc < inter_opp->vproc)
>> +             target_opp = info->intermediate_opp;
>> +
>> +     if (old_vproc < target_opp->vproc) {
>
> old_vproc is used only once, so using regulator_get_voltage(info->proc_reg)
> directly here make the code clearer.

Will do it.

>
>> +             ret = mt8173_cpufreq_set_voltage(info, target_opp);
>> +             if (ret) {
>> +                     pr_err("cpu%d: failed to scale up voltage!\n",
>> +                            policy->cpu);
>> +                     mt8173_cpufreq_set_voltage(info, orig_opp);
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     ret = clk_set_parent(cpu_clk, info->inter_pll);
>> +     if (ret) {
>> +             pr_err("cpu%d: failed to re-parent cpu clock!\n",
>> +                    policy->cpu);
>> +             mt8173_cpufreq_set_voltage(info, orig_opp);
>> +             WARN_ON(1);
>> +             return ret;
>> +     }
>> +
>> +     ret = clk_set_rate(armpll, freq_hz);
>> +     if (ret) {
>> +             pr_err("cpu%d: failed to scale cpu clock rate!\n",
>> +                    policy->cpu);
>> +             clk_set_parent(cpu_clk, armpll);
>> +             mt8173_cpufreq_set_voltage(info, orig_opp);
>> +             return ret;
>> +     }
>> +
>> +     ret = clk_set_parent(cpu_clk, armpll);
>> +     if (ret) {
>> +             pr_err("cpu%d: failed to re-parent cpu clock!\n",
>> +                    policy->cpu);
>> +             mt8173_cpufreq_set_voltage(info, inter_opp);
>> +             WARN_ON(1);
>> +             return ret;
>> +     }
>> +
>> +     if (new_opp->vproc < inter_opp->vproc) {
>> +             ret = mt8173_cpufreq_set_voltage(info, new_opp);
>> +             if (ret) {
>> +                     pr_err("cpu%d: failed to scale down voltage!\n",
>> +                            policy->cpu);
>> +                     clk_set_parent(cpu_clk, info->inter_pll);
>> +                     clk_set_rate(armpll, orig_freq_hz);
>> +                     clk_set_parent(cpu_clk, armpll);
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int mt8173_cpufreq_cpu_opp_fixup(struct cpu_dvfs_info *info)
>> +{
>> +     struct mtk_cpu_opp *opp_tbl = info->opp_tbl;
>> +     struct regulator *proc_reg = info->proc_reg;
>> +     struct regulator *sram_reg = info->sram_reg;
>> +     int vproc, vsram, i;
>> +
>> +     for (i = 0; i < info->nr_opp; i++) {
>> +             vproc = opp_tbl[i].vproc;
>> +             vsram = opp_tbl[i].vsram;
>> +
>> +             vproc = get_regulator_voltage_ceil(proc_reg, vproc);
>> +
>> +             if (!IS_ERR_OR_NULL(sram_reg))
>> +                     vsram = get_regulator_voltage_ceil(sram_reg, vsram);
>> +
>> +             if (vproc < 0 || (!IS_ERR_OR_NULL(sram_reg) && vsram < 0)) {
>> +                     pr_err("%s: Failed to get voltage setting of OPPs\n",
>> +                            __func__);
>> +                     return -EINVAL;
>> +             }
>> +
>> +             opp_tbl[i].vproc = vproc;
>> +             opp_tbl[i].vsram = vsram;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int mt8173_cpufreq_dvfs_init(struct cpu_dvfs_info *info)
>> +{
>> +     struct device *cpu_dev;
>> +     struct regulator *proc_reg, *sram_reg;
>> +     struct clk *cpu_clk, *inter_pll;
>> +     unsigned long rate;
>> +     int cpu, ret;
>> +
>> +     cpu = cpumask_first(&info->cpus);
>> +
>> +try_next_cpu:
>> +     cpu_dev = get_cpu_device(cpu);
>> +     proc_reg = regulator_get_exclusive(cpu_dev, "proc");
>> +     sram_reg = regulator_get_exclusive(cpu_dev, "sram");
>> +     cpu_clk = clk_get(cpu_dev, "cpu");
>> +     inter_pll = clk_get(cpu_dev, "intermediate");
>> +
>> +     if (IS_ERR_OR_NULL(proc_reg) || IS_ERR_OR_NULL(cpu_clk) ||
>> +         IS_ERR_OR_NULL(inter_pll)) {
>> +             cpu = cpumask_next(cpu, &info->cpus);
>> +             if (cpu >= nr_cpu_ids)
>> +                     return -ENODEV;
>> +
>> +             goto try_next_cpu;
>> +     }
>
> Use a loop.

Will do it. Or maybe we don't need a loop here if we have these information
per CPU in the device tree as suggested later in this series by Mark.

>
>> +
>> +     /* Both PROC and SRAM regulators are present. This is a big
>> +      * cluster, and needs to do voltage tracing. */
>> +     if (!(IS_ERR_OR_NULL(proc_reg) || IS_ERR_OR_NULL(sram_reg))) {
>> +             info->opp_tbl = mt8173_b_opp;
>> +             info->nr_opp = sizeof(mt8173_b_opp) / sizeof(mt8173_b_opp[0]);
>> +     } else {
>> +             info->opp_tbl = mt8173_l_opp;
>> +             info->nr_opp = sizeof(mt8173_l_opp) / sizeof(mt8173_l_opp[0]);
>> +     }
>> +
>> +     info->proc_reg = proc_reg;
>> +     info->sram_reg = sram_reg;
>> +     info->cpu_clk = cpu_clk;
>> +     info->inter_pll = inter_pll;
>> +
>> +     ret = mt8173_cpufreq_cpu_opp_fixup(info);
>> +     if (ret) {
>> +             pr_err("%s: Failed to fixup opp table: %d\n", __func__, ret);
>> +             return ret;
>> +     }
>> +
>> +     rate = clk_get_rate(info->inter_pll);
>> +     info->intermediate_opp = cpu_opp_find_freq_ceil(info->opp_tbl,
>> +                                                     info->nr_opp,
>> +                                                     rate);
>> +     if (!info->intermediate_opp) {
>> +             pr_err("%s: Failed to setup intermediate opp\n", __func__);
>> +             return -EINVAL;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void mt8173_cpufreq_dvfs_release(struct cpu_dvfs_info *info)
>> +{
>> +     regulator_put(info->proc_reg);
>> +     regulator_put(info->sram_reg);
>> +     clk_put(info->cpu_clk);
>> +     clk_put(info->inter_pll);
>> +
>> +     kfree(info);
>> +}
>> +
>> +static int mt8173_cpufreq_init(struct cpufreq_policy *policy)
>> +{
>> +     struct cpu_dvfs_info *info;
>> +     struct cpufreq_frequency_table *freq_table;
>> +     int ret, i;
>> +
>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +     if (!info)
>> +             return -ENOMEM;
>> +
>> +     cpumask_copy(&info->cpus, &cpu_topology[policy->cpu].core_sibling);
>> +     ret = mt8173_cpufreq_dvfs_init(info);
>> +     if (ret) {
>> +             pr_err("%s: Failed to initialize DVFS info: %d\n", __func__,
>> +                    ret);
>> +             goto out_dvfs_release;
>> +     }
>> +
>> +     freq_table = kcalloc(info->nr_opp, sizeof(*freq_table), GFP_KERNEL);
>> +     if (!freq_table) {
>> +             ret = -ENOMEM;
>> +             goto out_dvfs_release;
>> +     }
>> +
>> +     for (i = 0; i < info->nr_opp; i++)
>> +             freq_table[i].frequency = info->opp_tbl[i].freq / 1000;
>> +
>> +     freq_table[i].frequency = CPUFREQ_TABLE_END;
>
> You are corrupting memory here.

Will fix it.

Thanks for reviewing again.

Best Regards,
Pi-Cheng

>
> Sascha
>
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

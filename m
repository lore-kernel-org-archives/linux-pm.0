From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Wed, 22 Apr 2015 11:11:34 +0800
Message-ID: <CALx668W6nJkYR325BhxOXMF1z=i7mkYbh3pyBFDNoZC9NZ0dVw@mail.gmail.com>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
	<1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
	<20150420141719.GF27115@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35041 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595AbbDVDLg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2015 23:11:36 -0400
Received: by lbbuc2 with SMTP id uc2so169947285lbb.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2015 20:11:34 -0700 (PDT)
In-Reply-To: <20150420141719.GF27115@jcartwri.amer.corp.natinst.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mturquette@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chen Fan <fan.chen@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, linux-mediatek@lists.infradead.org, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Josh,

Thanks for reviewing.

On Mon, Apr 20, 2015 at 10:17 PM, Josh Cartwright <joshc@ni.com> wrote:
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
>
> I think you want to 'select REGULATOR' here; because REGULATOR isn't
> a user-visible option.

I am not sure but I need it to be "depends on" as other SoC cpufreq
drivers. Please check
ARM_S3C2416_CPUFREQ_VCORESCALE in drivers/cpufreq/Kconfig.arm
By the way, I would like to know more details about the visibility of
these configurable
options, would you kindly point me out some documents about it?

>
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
>
> static const?

Yes. I miss "static" here. But I need those two array to be non-const
so that I could
fix up the exact voltage values by querying the supported voltages of
regulators.
Please check the mt8173_cpufreq_cpu_opp_fixup() function below.

>
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
>
> same here?
>
>> +     OPP(507000000, 828000, 928000),
>> +     OPP(702000000, 867000, 967000),
>> +     OPP(1001000000, 927000, 1027000),
>> +     OPP(1209000000, 968000, 1068000),
>> +     OPP(1404000000, 1007000, 1107000),
>> +     OPP(1612000000, 1049000, 1149000),
>> +     OPP(1807000000, 1089000, 1150000),
>> +     OPP(1989000000, 1125000, 1150000),
>> +};
>> +
> [..]
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
>> +
>> +             old_vproc = vproc;
>> +             goto next_up_step;
>
> Perhaps a naive question: but, is this the correct place to do this?  I
> would expect this stepping behavior to be implemented in the driver
> controlling the regulator you are consuming.  It seems strange to do it
> here.

This was already discussed in the last round of this series of patches.
Please check the discussion[1]. Any suggestion would be welcomed.
Thanks.

[1] http://article.gmane.org/gmane.linux.kernel/1905909

Best Regards,
Pi-Cheng

>
>   Josh

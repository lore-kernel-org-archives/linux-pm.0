From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Thu, 7 May 2015 17:40:36 +0800
Message-ID: <CALx668VMQG98fL943Kku=i4bG5RXRxpTdHu9SerooCBLHKuQBA@mail.gmail.com>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
	<1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
	<20150430074218.GH4946@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:33955 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbbEGJki (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 05:40:38 -0400
Received: by laat2 with SMTP id t2so26428526laa.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 02:40:36 -0700 (PDT)
In-Reply-To: <20150430074218.GH4946@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mturquette@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Chen Fan <fan.chen@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, linux-mediatek@lists.infradead.org

On Thu, Apr 30, 2015 at 3:42 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
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
> Please keep an eye on the error pathes. This one is quite broken. You
> get references to resources here which you never release. Also
> -EPROBE_DEFER is a valid return value from regulator_get which is not
> handled here.
>
> Also IS_ERR_OR_NULL() is most probably wrong here. Should be IS_ERR().

I'll review the error handling path and fix them.
Thanks for reviewing.

Best Regards,
Pi-Cheng

>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v5 14/15] cpufreq: Add module to register cpufreq on Krait
 CPUs
Date: Wed, 20 Dec 2017 11:49:43 +0530
Message-ID: <4c6f337f-ad7f-e533-e10b-f92fbc6dee25@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-15-git-send-email-sricharan@codeaurora.org>
 <20171220033608.GR19815@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171220033608.GR19815@vireshk-i7>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 12/20/2017 9:06 AM, Viresh Kumar wrote:
> On 19-12-17, 21:24, Sricharan R wrote:
>> From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>
>> Register a cpufreq-generic device whenever we detect that a
>> "qcom,krait" compatible CPU is present in DT.
>>
>> Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>> [Sricharan: updated to use dev_pm_opp_set_prop_name]
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  drivers/cpufreq/Kconfig.arm          |   9 ++
>>  drivers/cpufreq/Makefile             |   1 +
>>  drivers/cpufreq/cpufreq-dt-platdev.c |   3 +-
>>  drivers/cpufreq/qcom-cpufreq.c       | 171 +++++++++++++++++++++++++++++++++++
>>  4 files changed, 183 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/cpufreq/qcom-cpufreq.c
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index bdce448..60f28e7 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -100,6 +100,15 @@ config ARM_OMAP2PLUS_CPUFREQ
>>  	depends on ARCH_OMAP2PLUS
>>  	default ARCH_OMAP2PLUS
>>  
>> +config ARM_QCOM_CPUFREQ
>> +	tristate "Qualcomm based"
> 
> Qualcomm based ... ? You want to add something after this ?
> 

 Hmm, got truncated. Will add a proper one.

> And why tristate ? Do you really want to build a module for this ?
> 

 Given that cpufreq-dt that registers the driver already supports module,
 don't think this needs to be a module. So will make it a bool.

>> +	depends on ARCH_QCOM
>> +	select PM_OPP
>> +	help
>> +	  This adds the CPUFreq driver for Qualcomm SoC based boards.
>> +
>> +	  If in doubt, say N.
>> +
>>  config ARM_S3C_CPUFREQ
>>  	bool
>>  	help
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index 812f9e0..1496464 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -62,6 +62,7 @@ obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mediatek-cpufreq.o
>>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
>>  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
>>  obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
>> +obj-$(CONFIG_ARM_QCOM_CPUFREQ)		+= qcom-cpufreq.o
>>  obj-$(CONFIG_ARM_S3C24XX_CPUFREQ)	+= s3c24xx-cpufreq.o
>>  obj-$(CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS) += s3c24xx-cpufreq-debugfs.o
>>  obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index ecc56e2..032ac4f 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -118,7 +118,7 @@
>>  	{ .compatible = "ti,am33xx", },
>>  	{ .compatible = "ti,am43", },
>>  	{ .compatible = "ti,dra7", },
>> -
> 
> Keep this blank line as is..
> 

 ok

>> +	{ .compatible = "qcom,ipq8064", },
> 
> And add another one here.
> 

 ok

>>  	{ }
>>  };
>>  
>> @@ -157,6 +157,7 @@ static int __init cpufreq_dt_platdev_init(void)
>>  
>>  create_pdev:
>>  	of_node_put(np);
>> +
> 
> Remove this.
> 

 ok

>>  	return PTR_ERR_OR_ZERO(platform_device_register_data(NULL, "cpufreq-dt",
>>  			       -1, data,
>>  			       sizeof(struct cpufreq_dt_platform_data)));
>> diff --git a/drivers/cpufreq/qcom-cpufreq.c b/drivers/cpufreq/qcom-cpufreq.c
>> new file mode 100644
>> index 0000000..3e5583d
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq.c
>> @@ -0,0 +1,171 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
>> +
>> +#include <linux/cpu.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_opp.h>
>> +#include <linux/slab.h>
>> +#include "cpufreq-dt.h"
>> +
>> +static void __init get_krait_bin_format_a(int *speed, int *pvs, int *pvs_ver)
>> +{
>> +	void __iomem *base;
>> +	u32 pte_efuse;
>> +
>> +	*speed = *pvs = *pvs_ver = 0;
>> +
>> +	base = ioremap(0x007000c0, 4);
>> +	if (!base) {
>> +		pr_warn("Unable to read efuse data. Defaulting to 0!\n");
>> +		return;
>> +	}
>> +
>> +	pte_efuse = readl_relaxed(base);
>> +	iounmap(base);
>> +
>> +	*speed = pte_efuse & 0xf;
>> +	if (*speed == 0xf)
>> +		*speed = (pte_efuse >> 4) & 0xf;
>> +
>> +	if (*speed == 0xf) {
>> +		*speed = 0;
>> +		pr_warn("Speed bin: Defaulting to %d\n", *speed);
>> +	} else {
>> +		pr_info("Speed bin: %d\n", *speed);
>> +	}
>> +
>> +	*pvs = (pte_efuse >> 10) & 0x7;
>> +	if (*pvs == 0x7)
>> +		*pvs = (pte_efuse >> 13) & 0x7;
>> +
>> +	if (*pvs == 0x7) {
>> +		*pvs = 0;
>> +		pr_warn("PVS bin: Defaulting to %d\n", *pvs);
>> +	} else {
>> +		pr_info("PVS bin: %d\n", *pvs);
>> +	}
>> +}
>> +
>> +static void __init get_krait_bin_format_b(int *speed, int *pvs, int *pvs_ver)
>> +{
>> +	u32 pte_efuse, redundant_sel;
>> +	void __iomem *base;
>> +
>> +	*speed = 0;
>> +	*pvs = 0;
>> +	*pvs_ver = 0;
>> +
>> +	base = ioremap(0xfc4b80b0, 8);
>> +	if (!base) {
>> +		pr_warn("Unable to read efuse data. Defaulting to 0!\n");
>> +		return;
>> +	}
>> +
>> +	pte_efuse = readl_relaxed(base);
>> +	redundant_sel = (pte_efuse >> 24) & 0x7;
>> +	*speed = pte_efuse & 0x7;
>> +	/* 4 bits of PVS are in efuse register bits 31, 8-6. */
>> +	*pvs = ((pte_efuse >> 28) & 0x8) | ((pte_efuse >> 6) & 0x7);
>> +	*pvs_ver = (pte_efuse >> 4) & 0x3;
>> +
>> +	switch (redundant_sel) {
>> +	case 1:
>> +		*speed = (pte_efuse >> 27) & 0xf;
>> +		break;
>> +	case 2:
>> +		*pvs = (pte_efuse >> 27) & 0xf;
>> +		break;
>> +	}
>> +
>> +	/* Check SPEED_BIN_BLOW_STATUS */
>> +	if (pte_efuse & BIT(3)) {
>> +		pr_info("Speed bin: %d\n", *speed);
>> +	} else {
>> +		pr_warn("Speed bin not set. Defaulting to 0!\n");
>> +		*speed = 0;
>> +	}
>> +
>> +	/* Check PVS_BLOW_STATUS */
>> +	pte_efuse = readl_relaxed(base + 0x4) & BIT(21);
>> +	if (pte_efuse) {
>> +		pr_info("PVS bin: %d\n", *pvs);
>> +	} else {
>> +		pr_warn("PVS bin not set. Defaulting to 0!\n");
>> +		*pvs = 0;
>> +	}
>> +
>> +	pr_info("PVS version: %d\n", *pvs_ver);
>> +	iounmap(base);
>> +}
>> +
>> +static int __init qcom_cpufreq_populate_opps(void)
>> +{
>> +	int speed, pvs, pvs_ver;
>> +	struct device_node *np;
>> +	struct device *dev;
>> +	int cpu = 0;
>> +	char pvs_name[] = "speedXX-pvsXX-vXX";
>> +
>> +	np = of_find_node_by_name(NULL, "qcom,pvs");
>> +	if (!np)
>> +		return -ENODEV;
>> +
>> +	if (of_property_read_bool(np, "qcom,pvs-format-a"))
>> +		get_krait_bin_format_a(&speed, &pvs, &pvs_ver);
>> +	else if (of_property_read_bool(np, "qcom,pvs-format-b"))
>> +		get_krait_bin_format_b(&speed, &pvs, &pvs_ver);
>> +	else
>> +		return -ENODEV;
>> +
>> +	snprintf(pvs_name, sizeof(pvs_name), "speed%d-pvs%d-v%d",
>> +		 speed, pvs, pvs_ver);
>> +
>> +	for (cpu = 0; cpu < num_possible_cpus(); cpu++) {
>> +		dev = get_cpu_device(cpu);
>> +		if (!dev)
>> +			return -ENODEV;
>> +
>> +		if (IS_ERR(dev_pm_opp_set_prop_name(dev, pvs_name)))
>> +			pr_warn("failed to add OPP name %s\n", pvs_name);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init qcom_cpufreq_driver_init(void)
>> +{
>> +	struct device *cpu_dev;
>> +	struct device_node *np;
>> +	int ret;
>> +
>> +	cpu_dev = get_cpu_device(0);
>> +	if (!cpu_dev)
>> +		return -ENODEV;
>> +
>> +	np = of_node_get(cpu_dev->of_node);
>> +	if (!np)
>> +		return -ENOENT;
>> +
>> +	if (!of_device_is_compatible(np, "qcom,krait")) {
>> +		of_node_put(np);
>> +		return -ENODEV;
>> +	}
>> +	of_node_put(np);
>> +
>> +	ret = qcom_cpufreq_populate_opps();
>> +	if (ret)
>> +		return ret;
>> +
>> +	return PTR_ERR(platform_device_register_simple("cpufreq-dt",
>> +						       -1, NULL, 0));
>> +}
>> +module_init(qcom_cpufreq_driver_init);
> 
> As there is no module exit, it doesn't make sense to keep this as
> tristate.
> 

 ok

> Looks mostly fine now other than these minor nits.
> 

 Ok, Thanks for the review. Will wait on feedback for rest of the patches
 and repost with these fixed.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

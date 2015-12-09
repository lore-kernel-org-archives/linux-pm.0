From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 09/11] cpufreq: st: Provide runtime initialised driver
 for ST's platforms
Date: Wed, 9 Dec 2015 08:27:19 +0530
Message-ID: <20151209025719.GV3692@ubuntu>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
 <1449585124-15596-10-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35869 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbLIC5Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 21:57:24 -0500
Received: by pfdd184 with SMTP id d184so22078426pfd.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2015 18:57:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449585124-15596-10-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com

Good work Lee, looks mostly okay. Few nits below.

On 08-12-15, 14:32, Lee Jones wrote:
> The bootloader is charged with the responsibility to provide platform
> specific Dynamic Voltage and Frequency Scaling (DVFS) information via
> Device Tree.  This driver takes the supplied configuration and
> registers it with the new generic OPP framework, to then be used with
> CPUFreq.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm   |   7 +
>  drivers/cpufreq/Makefile      |   1 +
>  drivers/cpufreq/sti-cpufreq.c | 296 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 304 insertions(+)
>  create mode 100644 drivers/cpufreq/sti-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 1582c1c..ccde41b 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -216,6 +216,13 @@ config ARM_SPEAR_CPUFREQ
>  	help
>  	  This adds the CPUFreq driver support for SPEAr SOCs.
>  
> +config ARM_STI_CPUFREQ
> +	tristate "STi CPUFreq support"
> +	depends on SOC_STIH407
> +	help
> +	  OPP list for cpufreq-dt driver can be provided through DT or can be
> +	  created at runtime.  Select this if you want create OPP list at runtime.

Really? Where are we creating the list at runtime ?

> +
>  config ARM_TEGRA20_CPUFREQ
>  	bool "Tegra20 CPUFreq support"
>  	depends on ARCH_TEGRA
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index c0af1a1..9e63fb1 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_ARM_SA1100_CPUFREQ)	+= sa1100-cpufreq.o
>  obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
>  obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
>  obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
> +obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> new file mode 100644
> index 0000000..9f6807e
> --- /dev/null
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -0,0 +1,296 @@
> +/*
> + * Create CPUFreq OPP list

No, that's not what we are doing.

> + *
> + * Author: Ajit Pal Singh <ajitpal.singh@st.com>
> + *         Lee Jones <lee.jones@linaro.org>
> + *
> + * Copyright (C) 2015 STMicroelectronics (R&D) Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the version 2 of the GNU General Public License as
> + * published by the Free Software Foundation
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/clk.h>
> +#include <linux/cpufreq.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/pm_opp.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

Keeping them in alphabetical order is considered better, as that is
more human-readable. Up to you.

> +
> +#define VERSION_ELEMENTS	3
> +
> +#define VERSION_SHIFT		28
> +#define HW_INFO_INDEX		1
> +#define MAJOR_ID_INDEX		1
> +#define MINOR_ID_INDEX		2
> +
> +/* Only match on "suitable for ALL versions" entries */
> +#define DEFAULT_VERSION		31

i.e. 0x1F. Is that sufficient for you? I mean, why not keep this value
as 0xFFFFFFFF to be future proof ? (I know there wouldn't be that many
versions, but still its better to use the full 32 bit field). Also
this should be in Hex I believe.

> +static const struct reg_field *sti_cpufreq_match(struct platform_device *pdev)
> +{
> +	if (of_machine_is_compatible("st,stih407") ||
> +	    of_machine_is_compatible("st,stih410"))
> +		return sti_stih407_dvfs_regfields;

You had Kconfig dependency on STI407 only and not 410. Perhaps there
is no STI410 config option?

> +
> +	return NULL;
> +}
> +
> +static int sti_cpufreq_set_opp_info(struct platform_device *pdev)
> +{
> +	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
> +	struct device_node *cpu_np = ddata->cpu->of_node;
> +	const struct reg_field *reg_fields;
> +	unsigned int hw_info_offset;
> +	unsigned int version[VERSION_ELEMENTS];
> +	int pcode, substrate, major, minor;
> +	int ret;
> +	char name[7];
> +
> +	reg_fields = sti_cpufreq_match(pdev);
> +	if (!reg_fields) {
> +		dev_warn(&pdev->dev, "Machine not supported\n");

Continuing comments from the last patch, where I suggested not to
create a platform-device for this enabler driver..

You can make this dev_dbg(), so that we don't warn unnecessarily on
other STI407 platforms.

> +		return -ENODEV;
> +	}
> +
> +	ret = of_property_read_u32_index(cpu_np, "st,syscfg-eng",
> +					 HW_INFO_INDEX, &hw_info_offset);
> +	if (ret) {
> +		dev_warn(&pdev->dev, "Failed to read HW info offset from DT\n");
> +		substrate = DEFAULT_VERSION;
> +		pcode = 0;
> +		goto use_defaults;
> +	}
> +
> +	pcode = st_cpufreq_fetch_regmap_field(pdev, reg_fields,
> +					      hw_info_offset,
> +					      PCODE);
> +	if (pcode < 0) {
> +		dev_warn(&pdev->dev, "Failed to obtain process code\n");
> +		/* Use default pcode */
> +		pcode = 0;
> +	}
> +
> +	substrate = st_cpufreq_fetch_regmap_field(pdev, reg_fields,
> +						  hw_info_offset,
> +						  SUBSTRATE);
> +	if (substrate) {
> +		dev_warn(&pdev->dev, "Failed to obtain substrate code\n");
> +		/* Use default substrate */
> +		substrate = DEFAULT_VERSION;
> +	}
> +
> +use_defaults:
> +	major = st_cpufreq_fetch_major(pdev);
> +	if (major < 0) {
> +		dev_err(&pdev->dev, "Failed to obtain major version\n");
> +		/* Use default major number */
> +		major = DEFAULT_VERSION;
> +	}
> +
> +	minor = st_cpufreq_fetch_minor(pdev);
> +	if (minor < 0) {
> +		dev_err(&pdev->dev, "Failed to obtain minor version\n");
> +		/* Use default minor number */
> +		minor = DEFAULT_VERSION;
> +	}
> +
> +	sprintf(name, "pcode%d", pcode);
> +
> +	ret = dev_pm_opp_set_prop_name(ddata->cpu, name);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to set prop name\n");
> +		return ret;
> +	}
> +
> +	version[0] = BIT(major);
> +	version[1] = BIT(minor);
> +	version[2] = BIT(substrate);
> +
> +	ret = dev_pm_opp_set_supported_hw(ddata->cpu,
> +					  version, VERSION_ELEMENTS);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to set supported hardware\n");
> +		return ret;
> +	}
> +
> +	dev_err(&pdev->dev, "pcode: %d major: %d minor: %d substrate: %d\n",
> +		pcode, major, minor, substrate);
> +	dev_err(&pdev->dev, "version[0]: %x version[1]: %x version[2]: %x\n",
> +		version[0], version[1], version[2]);
> +
> +	return 0;
> +}
> +
> +static void sti_cpufreq_fetch_syscon_regsiters(struct platform_device *pdev)
> +{
> +	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
> +	struct device_node *cpu_np = ddata->cpu->of_node;
> +
> +	ddata->syscfg =
> +		syscon_regmap_lookup_by_phandle(cpu_np, "st,syscfg");
> +	if (IS_ERR(ddata->syscfg))
> +		dev_warn(&pdev->dev,  "\"st,syscfg\" not supplied\n");
> +
> +	ddata->syscfg_eng =
> +		syscon_regmap_lookup_by_phandle(cpu_np, "st,syscfg-eng");
> +	if (IS_ERR(ddata->syscfg_eng))
> +		dev_warn(&pdev->dev, "\"st,syscfg-eng\" not supplied\n");
> +}

Looks good.

> +static int sti_cpufreq_probe(struct platform_device *pdev)
> +{
> +	struct st_cpufreq_ddata *ddata;
> +	int ret;
> +
> +	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ddata);

There is no ->remove() for this driver (and I don't want this to be a
platform-driver, just do all this from module_init() instead). And so
you don't need the above stuff at all. You also don't need to kzalloc
ddata as its never used past this function (and all functions that are
called from here).

> +
> +	ddata->cpu = get_cpu_device(0);
> +	if (!ddata->cpu) {
> +		dev_err(&pdev->dev, "Failed to get cpu0 device\n");
> +		return -ENODEV;
> +	}
> +
> +	sti_cpufreq_fetch_syscon_regsiters(pdev);
> +
> +	ret = sti_cpufreq_set_opp_info(pdev);
> +	if (ret)
> +		dev_warn(&pdev->dev, "Not doing voltage scaling\n");
> +
> +	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);

Your work finishes here. Don't leave any resources behind :)

-- 
viresh

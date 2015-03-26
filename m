From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] cpufreq: hisilicon: add acpu driver
Date: Thu, 26 Mar 2015 14:13:38 +0000
Message-ID: <55141412.6040600@arm.com>
References: <1427370486-14823-1-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:62768 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753128AbbCZOM5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 Mar 2015 10:12:57 -0400
In-Reply-To: <1427370486-14823-1-git-send-email-leo.yan@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dan Zhao <dan.zhao@hisilicon.com>, "zhenwei.wang@hisilicon.com" <zhenwei.wang@hisilicon.com>, "mohaoju@hisilicon.com" <mohaoju@hisilicon.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Wei Xu <xuwei5@hisilicon.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>



On 26/03/15 11:48, Leo Yan wrote:
> Add acpu driver for hisilicon SoC, acpu is application processor
> subsystem. Currently the acpu has the coupled clock domain for two
> clusters, so this driver will directly use cpufreq-dt driver as
> backend.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/cpufreq/Kconfig.arm         |  9 ++++++++
>   drivers/cpufreq/Makefile            |  1 +
>   drivers/cpufreq/hisi-acpu-cpufreq.c | 43 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 53 insertions(+)
>   create mode 100644 drivers/cpufreq/hisi-acpu-cpufreq.c
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 1b06fc4..4f3dbc8 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -108,6 +108,15 @@ config ARM_HIGHBANK_CPUFREQ
>
>   	  If in doubt, say N.
>
> +config ARM_HISI_ACPU_CPUFREQ
> +	tristate "Hisilicon ACPU CPUfreq driver"
> +	depends on ARCH_HISI && CPUFREQ_DT
> +	select PM_OPP
> +	help
> +	  This enables the hisilicon ACPU CPUfreq driver.
> +
> +	  If in doubt, say N.
> +
>   config ARM_IMX6Q_CPUFREQ
>   	tristate "Freescale i.MX6 cpufreq support"
>   	depends on ARCH_MXC
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 82a1821..6b7a3f0 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -59,6 +59,7 @@ arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
>   arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
>   obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
>   obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
> +obj-$(CONFIG_ARM_HISI_ACPU_CPUFREQ)	+= hisi-acpu-cpufreq.o
>   obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
>   obj-$(CONFIG_ARM_INTEGRATOR)		+= integrator-cpufreq.o
>   obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
> diff --git a/drivers/cpufreq/hisi-acpu-cpufreq.c b/drivers/cpufreq/hisi-acpu-cpufreq.c
> new file mode 100644
> index 0000000..2c7a705
> --- /dev/null
> +++ b/drivers/cpufreq/hisi-acpu-cpufreq.c
> @@ -0,0 +1,43 @@
> +/*
> + * Hisilicon Platforms Using ACPU CPUFreq Support
> + *
> + * Copyright (c) 2015 Hisilicon Limited.
> + * Copyright (c) 2015 Linaro Limited.
> + *
> + * Leo Yan <leo.yan@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +static int __init hisi_acpu_cpufreq_driver_init(void)
> +{
> +	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
> +	struct platform_device *pdev;
> +
> +	if (!of_machine_is_compatible("hisilicon,hi6220"))
> +		return -ENODEV;
> +
> +	pdev = platform_device_register_full(&devinfo);
> +	return PTR_ERR_OR_ZERO(pdev);

Since you are not using anything other than name, you can simplify it
further by something like:
	platform_device_register_simple("cpufreq-dt", -1, NULL, 0)

And IMO it need not be a separate driver too, you can add this in mach
if it exists(i.e. arm32 though not recommended) or clock code that
registers cpu clock. Thoughts ?

Regards,
Sudeep


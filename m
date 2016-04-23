From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 8/8] cpufreq: hisilicon: Use generic platdev driver
Date: Sun, 24 Apr 2016 01:14:06 +0800
Message-ID: <20160423171339.GA7345@leoy-linaro>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
 <9d3c6b9bf563ab2bf7514b9f2529a6eed130c335.1461228081.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37470 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbcDWROV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Apr 2016 13:14:21 -0400
Received: by mail-wm0-f45.google.com with SMTP id n3so68888543wmn.0
        for <linux-pm@vger.kernel.org>; Sat, 23 Apr 2016 10:14:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9d3c6b9bf563ab2bf7514b9f2529a6eed130c335.1461228081.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, linux-kernel@vger.kernel.org

On Thu, Apr 21, 2016 at 02:13:54PM +0530, Viresh Kumar wrote:
> The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
> device now, reuse that and remove similar code from platform code.
> 
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Have tested this patch on Hikey, it works well with new driver
cpufreq-dt-platdev.c.

Tested-by: Leo Yan <leo.yan@linaro.org>

Thanks,
Leo Yan

> ---
>  drivers/cpufreq/Kconfig.arm          |  9 --------
>  drivers/cpufreq/Makefile             |  1 -
>  drivers/cpufreq/cpufreq-dt-platdev.c |  2 ++
>  drivers/cpufreq/hisi-acpu-cpufreq.c  | 42 ------------------------------------
>  4 files changed, 2 insertions(+), 52 deletions(-)
>  delete mode 100644 drivers/cpufreq/hisi-acpu-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 14b1f9393b05..d89b8afe23b6 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -50,15 +50,6 @@ config ARM_HIGHBANK_CPUFREQ
>  
>  	  If in doubt, say N.
>  
> -config ARM_HISI_ACPU_CPUFREQ
> -	tristate "Hisilicon ACPU CPUfreq driver"
> -	depends on ARCH_HISI && CPUFREQ_DT
> -	select PM_OPP
> -	help
> -	  This enables the hisilicon ACPU CPUfreq driver.
> -
> -	  If in doubt, say N.
> -
>  config ARM_IMX6Q_CPUFREQ
>  	tristate "Freescale i.MX6 cpufreq support"
>  	depends on ARCH_MXC
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index d7b646c0f2e9..2cce2cd400f9 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -55,7 +55,6 @@ obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
>  obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
>  obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
> -obj-$(CONFIG_ARM_HISI_ACPU_CPUFREQ)	+= hisi-acpu-cpufreq.o
>  obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
>  obj-$(CONFIG_ARM_INTEGRATOR)		+= integrator-cpufreq.o
>  obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index c8a3eceac356..69b2a222c84e 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -24,6 +24,8 @@ static const struct of_device_id machines[] = {
>  	{ .compatible = "allwinner,sun8i-a83t", },
>  	{ .compatible = "allwinner,sun8i-h3", },
>  
> +	{ .compatible = "hisilicon,hi6220", },
> +
>  	{ .compatible = "fsl,imx27", },
>  	{ .compatible = "fsl,imx51", },
>  	{ .compatible = "fsl,imx53", },
> diff --git a/drivers/cpufreq/hisi-acpu-cpufreq.c b/drivers/cpufreq/hisi-acpu-cpufreq.c
> deleted file mode 100644
> index 026d5b2224de..000000000000
> --- a/drivers/cpufreq/hisi-acpu-cpufreq.c
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -/*
> - * Hisilicon Platforms Using ACPU CPUFreq Support
> - *
> - * Copyright (c) 2015 Hisilicon Limited.
> - * Copyright (c) 2015 Linaro Limited.
> - *
> - * Leo Yan <leo.yan@linaro.org>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - */
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/err.h>
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/platform_device.h>
> -
> -static int __init hisi_acpu_cpufreq_driver_init(void)
> -{
> -	struct platform_device *pdev;
> -
> -	if (!of_machine_is_compatible("hisilicon,hi6220"))
> -		return -ENODEV;
> -
> -	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> -	return PTR_ERR_OR_ZERO(pdev);
> -}
> -module_init(hisi_acpu_cpufreq_driver_init);
> -
> -MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
> -MODULE_DESCRIPTION("Hisilicon acpu cpufreq driver");
> -MODULE_LICENSE("GPL v2");
> -- 
> 2.7.1.410.g6faf27b
> 

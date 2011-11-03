From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH 3/3 v3] ARM: EXYNOS4: Delete the power domain
 code depend on samsung SoC
Date: Thu, 03 Nov 2011 11:09:08 +0900
Message-ID: <013401cc99cd$92218f00$b664ad00$%kim@samsung.com>
References: <4EA690F4.6040608@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <4EA690F4.6040608@samsung.com>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: 'Chanwoo Choi' <cw00.choi@samsung.com>
Cc: 'Sylwester Nawrocki' <snjw23@gmail.com>, 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Kyungmin Park' <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, 'linux-arm-kernel' <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Chanwoo Choi wrote:
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos4/Kconfig           |    5 -
>  arch/arm/mach-exynos4/Makefile          |    1 -
>  arch/arm/mach-exynos4/dev-pd.c          |  139 -------------------------------
>  arch/arm/plat-samsung/Kconfig           |    8 --
>  arch/arm/plat-samsung/Makefile          |    4 -
>  arch/arm/plat-samsung/include/plat/pd.h |   30 -------
>  arch/arm/plat-samsung/pd.c              |   95 ---------------------
>  7 files changed, 0 insertions(+), 282 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos4/dev-pd.c
>  delete mode 100644 arch/arm/plat-samsung/include/plat/pd.h
>  delete mode 100644 arch/arm/plat-samsung/pd.c
> 
> diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
> index d042e53..3c16ab0 100644
> --- a/arch/arm/mach-exynos4/Kconfig
> +++ b/arch/arm/mach-exynos4/Kconfig
> @@ -47,11 +47,6 @@ config EXYNOS4_SETUP_FIMD0
>  	help
>  	  Common setup code for FIMD0.
> 
> -config EXYNOS4_DEV_PD
> -	bool
> -	help
> -	  Compile in platform device definitions for Power Domain
> -
>  config EXYNOS4_DEV_SYSMMU
>  	bool
>  	help
> diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
> index d73a4e7..2cad115 100644
> --- a/arch/arm/mach-exynos4/Makefile
> +++ b/arch/arm/mach-exynos4/Makefile
> @@ -42,7 +42,6 @@ obj-$(CONFIG_MACH_SMDK4412)		+= mach-
> smdk4x12.o
> 
>  obj-y					+= dev-audio.o
>  obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
> -obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
>  obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
>  obj-$(CONFIG_EXYNOS4_DEV_DWMCI)	+= dev-dwmci.o
> 
> diff --git a/arch/arm/mach-exynos4/dev-pd.c b/arch/arm/mach-exynos4/dev-pd.c
> deleted file mode 100644
> index 3273f25..0000000
> --- a/arch/arm/mach-exynos4/dev-pd.c
> +++ /dev/null
> @@ -1,139 +0,0 @@
> -/* linux/arch/arm/mach-exynos4/dev-pd.c
> - *
> - * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com
> - *
> - * EXYNOS4 - Power Domain support
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/platform_device.h>
> -#include <linux/delay.h>
> -
> -#include <mach/regs-pmu.h>
> -
> -#include <plat/pd.h>
> -
> -static int exynos4_pd_enable(struct device *dev)
> -{
> -	struct samsung_pd_info *pdata =  dev->platform_data;
> -	u32 timeout;
> -
> -	__raw_writel(S5P_INT_LOCAL_PWR_EN, pdata->base);
> -
> -	/* Wait max 1ms */
> -	timeout = 10;
> -	while ((__raw_readl(pdata->base + 0x4) & S5P_INT_LOCAL_PWR_EN)
> -		!= S5P_INT_LOCAL_PWR_EN) {
> -		if (timeout == 0) {
> -			printk(KERN_ERR "Power domain %s enable failed.\n",
> -				dev_name(dev));
> -			return -ETIMEDOUT;
> -		}
> -		timeout--;
> -		udelay(100);
> -	}
> -
> -	return 0;
> -}
> -
> -static int exynos4_pd_disable(struct device *dev)
> -{
> -	struct samsung_pd_info *pdata =  dev->platform_data;
> -	u32 timeout;
> -
> -	__raw_writel(0, pdata->base);
> -
> -	/* Wait max 1ms */
> -	timeout = 10;
> -	while (__raw_readl(pdata->base + 0x4) & S5P_INT_LOCAL_PWR_EN) {
> -		if (timeout == 0) {
> -			printk(KERN_ERR "Power domain %s disable failed.\n",
> -				dev_name(dev));
> -			return -ETIMEDOUT;
> -		}
> -		timeout--;
> -		udelay(100);
> -	}
> -
> -	return 0;
> -}
> -
> -struct platform_device exynos4_device_pd[] = {
> -	{
> -		.name		= "samsung-pd",
> -		.id		= 0,
> -		.dev = {
> -			.platform_data = &(struct samsung_pd_info) {
> -				.enable		= exynos4_pd_enable,
> -				.disable	= exynos4_pd_disable,
> -				.base		= S5P_PMU_MFC_CONF,
> -			},
> -		},
> -	}, {
> -		.name		= "samsung-pd",
> -		.id		= 1,
> -		.dev = {
> -			.platform_data = &(struct samsung_pd_info) {
> -				.enable		= exynos4_pd_enable,
> -				.disable	= exynos4_pd_disable,
> -				.base		= S5P_PMU_G3D_CONF,
> -			},
> -		},
> -	}, {
> -		.name		= "samsung-pd",
> -		.id		= 2,
> -		.dev = {
> -			.platform_data = &(struct samsung_pd_info) {
> -				.enable		= exynos4_pd_enable,
> -				.disable	= exynos4_pd_disable,
> -				.base		= S5P_PMU_LCD0_CONF,
> -			},
> -		},
> -	}, {
> -		.name		= "samsung-pd",
> -		.id		= 3,
> -		.dev = {
> -			.platform_data = &(struct samsung_pd_info) {
> -				.enable		= exynos4_pd_enable,
> -				.disable	= exynos4_pd_disable,
> -				.base		= S5P_PMU_LCD1_CONF,
> -			},
> -		},
> -	}, {
> -		.name		= "samsung-pd",
> -		.id		= 4,
> -		.dev = {
> -			.platform_data = &(struct samsung_pd_info) {
> -				.enable		= exynos4_pd_enable,
> -				.disable	= exynos4_pd_disable,
> -				.base		= S5P_PMU_TV_CONF,
> -			},
> -		},
> -	}, {
> -		.name		= "samsung-pd",
> -		.id		= 5,
> -		.dev = {
> -			.platform_data = &(struct samsung_pd_info) {
> -				.enable		= exynos4_pd_enable,
> -				.disable	= exynos4_pd_disable,
> -				.base		= S5P_PMU_CAM_CONF,
> -			},
> -		},
> -	}, {
> -		.name		= "samsung-pd",
> -		.id		= 6,
> -		.dev = {
> -			.platform_data = &(struct samsung_pd_info) {
> -				.enable		= exynos4_pd_enable,
> -				.disable	= exynos4_pd_disable,
> -				.base		= S5P_PMU_GPS_CONF,
> -			},
> -		},
> -	},
> -};
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 74714c1..f29c443 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -335,12 +335,4 @@ config SAMSUNG_WAKEMASK
>  	  and above. This code allows a set of interrupt to wakeup-mask
>  	  mappings. See <plat/wakeup-mask.h>
> 
> -comment "Power Domain"
> -
> -config SAMSUNG_PD
> -	bool "Samsung Power Domain"
> -	depends on PM_RUNTIME
> -	help
> -	  Say Y here if you want to control Power Domain by Runtime PM.
> -
>  endif
> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
> index a524fab..bd60e56 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -48,10 +48,6 @@ obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-
> check.o
> 
>  obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
> 
> -# PD support
> -
> -obj-$(CONFIG_SAMSUNG_PD)	+= pd.o
> -
>  # PWM support
> 
>  obj-$(CONFIG_HAVE_PWM)		+= pwm.o
> diff --git a/arch/arm/plat-samsung/include/plat/pd.h b/arch/arm/plat-
> samsung/include/plat/pd.h
> deleted file mode 100644
> index abb4bc3..0000000
> --- a/arch/arm/plat-samsung/include/plat/pd.h
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/* linux/arch/arm/plat-samsung/include/plat/pd.h
> - *
> - * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#ifndef __ASM_PLAT_SAMSUNG_PD_H
> -#define __ASM_PLAT_SAMSUNG_PD_H __FILE__
> -
> -struct samsung_pd_info {
> -	int (*enable)(struct device *dev);
> -	int (*disable)(struct device *dev);
> -	void __iomem *base;
> -};
> -
> -enum exynos4_pd_block {
> -	PD_MFC,
> -	PD_G3D,
> -	PD_LCD0,
> -	PD_LCD1,
> -	PD_TV,
> -	PD_CAM,
> -	PD_GPS
> -};
> -
> -#endif /* __ASM_PLAT_SAMSUNG_PD_H */
> diff --git a/arch/arm/plat-samsung/pd.c b/arch/arm/plat-samsung/pd.c
> deleted file mode 100644
> index efe1d56..0000000
> --- a/arch/arm/plat-samsung/pd.c
> +++ /dev/null
> @@ -1,95 +0,0 @@
> -/* linux/arch/arm/plat-samsung/pd.c
> - *
> - * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com
> - *
> - * Samsung Power domain support
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/err.h>
> -#include <linux/pm_runtime.h>
> -
> -#include <plat/pd.h>
> -
> -static int samsung_pd_probe(struct platform_device *pdev)
> -{
> -	struct samsung_pd_info *pdata = pdev->dev.platform_data;
> -	struct device *dev = &pdev->dev;
> -
> -	if (!pdata) {
> -		dev_err(dev, "no device data specified\n");
> -		return -ENOENT;
> -	}
> -
> -	pm_runtime_set_active(dev);
> -	pm_runtime_enable(dev);
> -
> -	dev_info(dev, "power domain registered\n");
> -	return 0;
> -}
> -
> -static int __devexit samsung_pd_remove(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -
> -	pm_runtime_disable(dev);
> -	return 0;
> -}
> -
> -static int samsung_pd_runtime_suspend(struct device *dev)
> -{
> -	struct samsung_pd_info *pdata = dev->platform_data;
> -	int ret = 0;
> -
> -	if (pdata->disable)
> -		ret = pdata->disable(dev);
> -
> -	dev_dbg(dev, "suspended\n");
> -	return ret;
> -}
> -
> -static int samsung_pd_runtime_resume(struct device *dev)
> -{
> -	struct samsung_pd_info *pdata = dev->platform_data;
> -	int ret = 0;
> -
> -	if (pdata->enable)
> -		ret = pdata->enable(dev);
> -
> -	dev_dbg(dev, "resumed\n");
> -	return ret;
> -}
> -
> -static const struct dev_pm_ops samsung_pd_pm_ops = {
> -	.runtime_suspend	= samsung_pd_runtime_suspend,
> -	.runtime_resume		= samsung_pd_runtime_resume,
> -};
> -
> -static struct platform_driver samsung_pd_driver = {
> -	.driver		= {
> -		.name		= "samsung-pd",
> -		.owner		= THIS_MODULE,
> -		.pm		= &samsung_pd_pm_ops,
> -	},
> -	.probe		= samsung_pd_probe,
> -	.remove		= __devexit_p(samsung_pd_remove),
> -};
> -
> -static int __init samsung_pd_init(void)
> -{
> -	int ret;
> -
> -	ret = platform_driver_register(&samsung_pd_driver);
> -	if (ret)
> -		printk(KERN_ERR "%s: failed to add PD driver\n", __func__);
> -
> -	return ret;
> -}
> -arch_initcall(samsung_pd_init);
> --
> 1.7.0.4

Well, I can't agree on this because you removed power domain codes which can be used for all of Samsung stuff for only EXYNOS4's generic power domain even though it was used for only EXYNOS4.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

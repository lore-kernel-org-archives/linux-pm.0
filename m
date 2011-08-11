From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 3/4] ARM: EXYNOS4: Delete the power-domain code
 depend on Samsung SoC
Date: Thu, 11 Aug 2011 13:55:20 +0900
Message-ID: <4E4360B8.7080601__12190.8372886994$1313038663$gmane$org@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kukjin Kim <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

This patch delete the power domain code depend on Samsung SoC
to use the generic Power domain framework for EXYNOS4210.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig               |    9 --
 arch/arm/mach-exynos4/Makefile              |    1 -
 arch/arm/mach-exynos4/dev-pd.c              |  139 ---------------------------
 arch/arm/mach-exynos4/mach-nuri.c           |    3 -
 arch/arm/mach-exynos4/mach-smdkc210.c       |    8 --
 arch/arm/mach-exynos4/mach-smdkv310.c       |    8 --
 arch/arm/mach-exynos4/mach-universal_c210.c |    3 -
 arch/arm/plat-samsung/Kconfig               |    8 --
 arch/arm/plat-samsung/Makefile              |    4 -
 arch/arm/plat-samsung/include/plat/pd.h     |   30 ------
 arch/arm/plat-samsung/pd.c                  |   95 ------------------
 11 files changed, 0 insertions(+), 308 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/dev-pd.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/pd.h
 delete mode 100644 arch/arm/plat-samsung/pd.c

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 8d5e876..66f1fad 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -32,11 +32,6 @@ config EXYNOS4_SETUP_FIMD0
 	help
 	  Common setup code for FIMD0.
 
-config EXYNOS4_DEV_PD
-	bool
-	help
-	  Compile in platform device definitions for Power Domain
-
 config EXYNOS4_DEV_SYSMMU
 	bool
 	help
@@ -125,7 +120,6 @@ config MACH_SMDKC210
 	select S3C_DEV_HSMMC3
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_BACKLIGHT
-	select EXYNOS4_DEV_PD
 	select EXYNOS4_DEV_SYSMMU
 	select EXYNOS4_SETUP_FIMD0
 	select EXYNOS4_SETUP_I2C1
@@ -147,7 +141,6 @@ config MACH_SMDKV310
 	select SAMSUNG_DEV_BACKLIGHT
 	select EXYNOS4_DEV_AHCI
 	select SAMSUNG_DEV_KEYPAD
-	select EXYNOS4_DEV_PD
 	select SAMSUNG_DEV_PWM
 	select EXYNOS4_DEV_SYSMMU
 	select EXYNOS4_SETUP_FIMD0
@@ -190,7 +183,6 @@ config MACH_UNIVERSAL_C210
 	select S3C_DEV_I2C5
 	select S5P_DEV_MFC
 	select S5P_DEV_ONENAND
-	select EXYNOS4_DEV_PD
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_I2C3
 	select EXYNOS4_SETUP_I2C5
@@ -211,7 +203,6 @@ config MACH_NURI
 	select S3C_DEV_I2C5
 	select S5P_DEV_MFC
 	select S5P_DEV_USB_EHCI
-	select EXYNOS4_DEV_PD
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_I2C3
 	select EXYNOS4_SETUP_I2C5
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 28cdb8b..99828b5 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_MACH_NURI)			+= mach-nuri.o
 
 obj-y					+= dev-audio.o
 obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
-obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
 obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
 obj-$(CONFIG_EXYNOS4_DEV_DWMCI)	+= dev-dwmci.o
 
diff --git a/arch/arm/mach-exynos4/dev-pd.c b/arch/arm/mach-exynos4/dev-pd.c
deleted file mode 100644
index 3273f25..0000000
--- a/arch/arm/mach-exynos4/dev-pd.c
+++ /dev/null
@@ -1,139 +0,0 @@
-/* linux/arch/arm/mach-exynos4/dev-pd.c
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4 - Power Domain support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-
-#include <mach/regs-pmu.h>
-
-#include <plat/pd.h>
-
-static int exynos4_pd_enable(struct device *dev)
-{
-	struct samsung_pd_info *pdata =  dev->platform_data;
-	u32 timeout;
-
-	__raw_writel(S5P_INT_LOCAL_PWR_EN, pdata->base);
-
-	/* Wait max 1ms */
-	timeout = 10;
-	while ((__raw_readl(pdata->base + 0x4) & S5P_INT_LOCAL_PWR_EN)
-		!= S5P_INT_LOCAL_PWR_EN) {
-		if (timeout == 0) {
-			printk(KERN_ERR "Power domain %s enable failed.\n",
-				dev_name(dev));
-			return -ETIMEDOUT;
-		}
-		timeout--;
-		udelay(100);
-	}
-
-	return 0;
-}
-
-static int exynos4_pd_disable(struct device *dev)
-{
-	struct samsung_pd_info *pdata =  dev->platform_data;
-	u32 timeout;
-
-	__raw_writel(0, pdata->base);
-
-	/* Wait max 1ms */
-	timeout = 10;
-	while (__raw_readl(pdata->base + 0x4) & S5P_INT_LOCAL_PWR_EN) {
-		if (timeout == 0) {
-			printk(KERN_ERR "Power domain %s disable failed.\n",
-				dev_name(dev));
-			return -ETIMEDOUT;
-		}
-		timeout--;
-		udelay(100);
-	}
-
-	return 0;
-}
-
-struct platform_device exynos4_device_pd[] = {
-	{
-		.name		= "samsung-pd",
-		.id		= 0,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_MFC_CONF,
-			},
-		},
-	}, {
-		.name		= "samsung-pd",
-		.id		= 1,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_G3D_CONF,
-			},
-		},
-	}, {
-		.name		= "samsung-pd",
-		.id		= 2,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_LCD0_CONF,
-			},
-		},
-	}, {
-		.name		= "samsung-pd",
-		.id		= 3,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_LCD1_CONF,
-			},
-		},
-	}, {
-		.name		= "samsung-pd",
-		.id		= 4,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_TV_CONF,
-			},
-		},
-	}, {
-		.name		= "samsung-pd",
-		.id		= 5,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_CAM_CONF,
-			},
-		},
-	}, {
-		.name		= "samsung-pd",
-		.id		= 6,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_GPS_CONF,
-			},
-		},
-	},
-};
diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index 43be71b..4c358cb 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -42,7 +42,6 @@
 #include <plat/gpio-cfg.h>
 #include <plat/iic.h>
 #include <plat/mfc.h>
-#include <plat/pd.h>
 
 #include <mach/map.h>
 
@@ -1105,7 +1104,6 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&s5p_device_mfc,
 	&s5p_device_mfc_l,
 	&s5p_device_mfc_r,
-	&exynos4_device_pd[PD_MFC],
 
 	/* NURI Devices */
 	&nuri_gpio_keys,
@@ -1147,7 +1145,6 @@ static void __init nuri_machine_init(void)
 
 	/* Last */
 	platform_add_devices(nuri_devices, ARRAY_SIZE(nuri_devices));
-	s5p_device_mfc.dev.parent = &exynos4_device_pd[PD_MFC].dev;
 }
 
 MACHINE_START(NURI, "NURI")
diff --git a/arch/arm/mach-exynos4/mach-smdkc210.c b/arch/arm/mach-exynos4/mach-smdkc210.c
index a7c65e0..4d1976c 100644
--- a/arch/arm/mach-exynos4/mach-smdkc210.c
+++ b/arch/arm/mach-exynos4/mach-smdkc210.c
@@ -33,7 +33,6 @@
 #include <plat/fb.h>
 #include <plat/sdhci.h>
 #include <plat/iic.h>
-#include <plat/pd.h>
 #include <plat/gpio-cfg.h>
 #include <plat/backlight.h>
 
@@ -226,13 +225,6 @@ static struct platform_device *smdkc210_devices[] __initdata = {
 	&s3c_device_wdt,
 	&exynos4_device_ac97,
 	&exynos4_device_i2s0,
-	&exynos4_device_pd[PD_MFC],
-	&exynos4_device_pd[PD_G3D],
-	&exynos4_device_pd[PD_LCD0],
-	&exynos4_device_pd[PD_LCD1],
-	&exynos4_device_pd[PD_CAM],
-	&exynos4_device_pd[PD_TV],
-	&exynos4_device_pd[PD_GPS],
 	&exynos4_device_sysmmu,
 	&samsung_asoc_dma,
 	&s5p_device_fimd0,
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index ea41495..8c2819b 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -29,7 +29,6 @@
 #include <plat/keypad.h>
 #include <plat/sdhci.h>
 #include <plat/iic.h>
-#include <plat/pd.h>
 #include <plat/gpio-cfg.h>
 #include <plat/backlight.h>
 
@@ -177,13 +176,6 @@ static struct platform_device *smdkv310_devices[] __initdata = {
 	&exynos4_device_ac97,
 	&exynos4_device_i2s0,
 	&samsung_device_keypad,
-	&exynos4_device_pd[PD_MFC],
-	&exynos4_device_pd[PD_G3D],
-	&exynos4_device_pd[PD_LCD0],
-	&exynos4_device_pd[PD_LCD1],
-	&exynos4_device_pd[PD_CAM],
-	&exynos4_device_pd[PD_TV],
-	&exynos4_device_pd[PD_GPS],
 	&exynos4_device_spdif,
 	&exynos4_device_sysmmu,
 	&samsung_asoc_dma,
diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-exynos4/mach-universal_c210.c
index 79f0a6f..43998f0 100644
--- a/arch/arm/mach-exynos4/mach-universal_c210.c
+++ b/arch/arm/mach-exynos4/mach-universal_c210.c
@@ -33,7 +33,6 @@
 #include <plat/gpio-cfg.h>
 #include <plat/mfc.h>
 #include <plat/sdhci.h>
-#include <plat/pd.h>
 #include <plat/s5p-time.h>
 
 #include <mach/map.h>
@@ -723,7 +722,6 @@ static struct platform_device *universal_devices[] __initdata = {
 	&s5p_device_mfc,
 	&s5p_device_mfc_l,
 	&s5p_device_mfc_r,
-	&exynos4_device_pd[PD_MFC],
 };
 
 static void __init universal_map_io(void)
@@ -759,7 +757,6 @@ static void __init universal_machine_init(void)
 
 	/* Last */
 	platform_add_devices(universal_devices, ARRAY_SIZE(universal_devices));
-	s5p_device_mfc.dev.parent = &exynos4_device_pd[PD_MFC].dev;
 }
 
 MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index b3e1065..42fda27 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -359,12 +359,4 @@ config SAMSUNG_WAKEMASK
 	  and above. This code allows a set of interrupt to wakeup-mask
 	  mappings. See <plat/wakeup-mask.h>
 
-comment "Power Domain"
-
-config SAMSUNG_PD
-	bool "Samsung Power Domain"
-	depends on PM_RUNTIME
-	help
-	  Say Y here if you want to control Power Domain by Runtime PM.
-
 endif
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 853764b..282212c 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -75,10 +75,6 @@ obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
 
 obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
 
-# PD support
-
-obj-$(CONFIG_SAMSUNG_PD)	+= pd.o
-
 # PWM support
 
 obj-$(CONFIG_HAVE_PWM)		+= pwm.o
diff --git a/arch/arm/plat-samsung/include/plat/pd.h b/arch/arm/plat-samsung/include/plat/pd.h
deleted file mode 100644
index abb4bc3..0000000
--- a/arch/arm/plat-samsung/include/plat/pd.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/pd.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_PLAT_SAMSUNG_PD_H
-#define __ASM_PLAT_SAMSUNG_PD_H __FILE__
-
-struct samsung_pd_info {
-	int (*enable)(struct device *dev);
-	int (*disable)(struct device *dev);
-	void __iomem *base;
-};
-
-enum exynos4_pd_block {
-	PD_MFC,
-	PD_G3D,
-	PD_LCD0,
-	PD_LCD1,
-	PD_TV,
-	PD_CAM,
-	PD_GPS
-};
-
-#endif /* __ASM_PLAT_SAMSUNG_PD_H */
diff --git a/arch/arm/plat-samsung/pd.c b/arch/arm/plat-samsung/pd.c
deleted file mode 100644
index efe1d56..0000000
--- a/arch/arm/plat-samsung/pd.c
+++ /dev/null
@@ -1,95 +0,0 @@
-/* linux/arch/arm/plat-samsung/pd.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Samsung Power domain support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/err.h>
-#include <linux/pm_runtime.h>
-
-#include <plat/pd.h>
-
-static int samsung_pd_probe(struct platform_device *pdev)
-{
-	struct samsung_pd_info *pdata = pdev->dev.platform_data;
-	struct device *dev = &pdev->dev;
-
-	if (!pdata) {
-		dev_err(dev, "no device data specified\n");
-		return -ENOENT;
-	}
-
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
-	dev_info(dev, "power domain registered\n");
-	return 0;
-}
-
-static int __devexit samsung_pd_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-
-	pm_runtime_disable(dev);
-	return 0;
-}
-
-static int samsung_pd_runtime_suspend(struct device *dev)
-{
-	struct samsung_pd_info *pdata = dev->platform_data;
-	int ret = 0;
-
-	if (pdata->disable)
-		ret = pdata->disable(dev);
-
-	dev_dbg(dev, "suspended\n");
-	return ret;
-}
-
-static int samsung_pd_runtime_resume(struct device *dev)
-{
-	struct samsung_pd_info *pdata = dev->platform_data;
-	int ret = 0;
-
-	if (pdata->enable)
-		ret = pdata->enable(dev);
-
-	dev_dbg(dev, "resumed\n");
-	return ret;
-}
-
-static const struct dev_pm_ops samsung_pd_pm_ops = {
-	.runtime_suspend	= samsung_pd_runtime_suspend,
-	.runtime_resume		= samsung_pd_runtime_resume,
-};
-
-static struct platform_driver samsung_pd_driver = {
-	.driver		= {
-		.name		= "samsung-pd",
-		.owner		= THIS_MODULE,
-		.pm		= &samsung_pd_pm_ops,
-	},
-	.probe		= samsung_pd_probe,
-	.remove		= __devexit_p(samsung_pd_remove),
-};
-
-static int __init samsung_pd_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&samsung_pd_driver);
-	if (ret)
-		printk(KERN_ERR "%s: failed to add PD driver\n", __func__);
-
-	return ret;
-}
-arch_initcall(samsung_pd_init);
-- 
1.7.0.4

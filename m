From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 1/1] power: reset: remove unused imx-snvs-poweroff driver
Date: Fri, 22 Dec 2017 18:28:59 +0800
Message-ID: <1513938539-20873-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam03on0082.outbound.protection.outlook.com ([104.47.42.82]:58685
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757624AbdLVK3e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Dec 2017 05:29:34 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org, sre@kernel.org, dongas86@gmail.com, aisheng.dong@nxp.com, yibin.gong@nxp.com, robh+dt@kernel.org, devicetree@vger.kernel.org

There's no user of it in kernel now and it basically functions the same
as the generic syscon-poweroff.c to which we have already switched.
So let's remove it.

Cc: Robin Gong <yibin.gong@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 .../bindings/power/reset/imx-snvs-poweroff.txt     | 23 --------
 drivers/power/reset/Kconfig                        |  9 ---
 drivers/power/reset/Makefile                       |  1 -
 drivers/power/reset/imx-snvs-poweroff.c            | 66 ----------------------
 4 files changed, 99 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/imx-snvs-poweroff.txt
 delete mode 100644 drivers/power/reset/imx-snvs-poweroff.c

diff --git a/Documentation/devicetree/bindings/power/reset/imx-snvs-poweroff.txt b/Documentation/devicetree/bindings/power/reset/imx-snvs-poweroff.txt
deleted file mode 100644
index 1b81fcd..0000000
--- a/Documentation/devicetree/bindings/power/reset/imx-snvs-poweroff.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-i.mx6 Poweroff Driver
-
-SNVS_LPCR in SNVS module can power off the whole system by pull
-PMIC_ON_REQ low if PMIC_ON_REQ is connected with external PMIC.
-If you don't want to use PMIC_ON_REQ as power on/off control,
-please set status='disabled' to disable this driver.
-
-Required Properties:
--compatible: "fsl,sec-v4.0-poweroff"
--reg: Specifies the physical address of the SNVS_LPCR register
-
-Example:
-	snvs@20cc000 {
-		compatible = "fsl,sec-v4.0-mon", "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x020cc000 0x4000>;
-		.....
-		snvs_poweroff: snvs-poweroff@38 {
-			compatible = "fsl,sec-v4.0-poweroff";
-			reg = <0x38 0x4>;
-		};
-	}
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index ca0de1a..a102e74 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -98,15 +98,6 @@ config POWER_RESET_HISI
 	help
 	  Reboot support for Hisilicon boards.
 
-config POWER_RESET_IMX
-	bool "IMX6 power-off driver"
-	depends on POWER_RESET && SOC_IMX6
-	help
-	  This driver support power off external PMIC by PMIC_ON_REQ on i.mx6
-	  boards.If you want to use other pin to control external power,please
-	  say N here or disable in dts to make sure pm_power_off never be
-	  overwrote wrongly by this driver.
-
 config POWER_RESET_MSM
 	bool "Qualcomm MSM power-off driver"
 	depends on ARCH_QCOM
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index aeb65ed..dcc92f5 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) += gemini-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
-obj-$(CONFIG_POWER_RESET_IMX) += imx-snvs-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
diff --git a/drivers/power/reset/imx-snvs-poweroff.c b/drivers/power/reset/imx-snvs-poweroff.c
deleted file mode 100644
index ad6ce50..0000000
--- a/drivers/power/reset/imx-snvs-poweroff.c
+++ /dev/null
@@ -1,66 +0,0 @@
-/* Power off driver for i.mx6
- * Copyright (c) 2014, FREESCALE CORPORATION.  All rights reserved.
- *
- * based on msm-poweroff.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
-
-static void __iomem *snvs_base;
-
-static void do_imx_poweroff(void)
-{
-	u32 value = readl(snvs_base);
-
-	/* set TOP and DP_EN bit */
-	writel(value | 0x60, snvs_base);
-}
-
-static int imx_poweroff_probe(struct platform_device *pdev)
-{
-	snvs_base = of_iomap(pdev->dev.of_node, 0);
-	if (!snvs_base) {
-		dev_err(&pdev->dev, "failed to get memory\n");
-		return -ENODEV;
-	}
-
-	pm_power_off = do_imx_poweroff;
-	return 0;
-}
-
-static const struct of_device_id of_imx_poweroff_match[] = {
-	{ .compatible = "fsl,sec-v4.0-poweroff", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, of_imx_poweroff_match);
-
-static struct platform_driver imx_poweroff_driver = {
-	.probe = imx_poweroff_probe,
-	.driver = {
-		.name = "imx-snvs-poweroff",
-		.of_match_table = of_match_ptr(of_imx_poweroff_match),
-	},
-};
-
-static int __init imx_poweroff_init(void)
-{
-	return platform_driver_register(&imx_poweroff_driver);
-}
-device_initcall(imx_poweroff_init);
-- 
2.7.4

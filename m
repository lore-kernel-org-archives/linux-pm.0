From: Feng Xiao <xf@rock-chips.com>
Subject: [PATCH v2] cpufreq: rockchip: add driver
Date: Wed, 23 Mar 2016 10:18:07 +0800
Message-ID: <1458699487-58470-1-git-send-email-xf@rock-chips.com>
References: <1458647848-48999-1-git-send-email-xf@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:45055 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466AbcCWCT4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2016 22:19:56 -0400
In-Reply-To: <1458647848-48999-1-git-send-email-xf@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux@arm.linux.org.uk, heiko@sntech.de, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.com, Feng Xiao <xf@rock-chips.com>

This driver will directly use cpufreq-dt driver as backend.

As there is not a generic devicetree board file(rockchip.c)
on ARM64 architecture, so remove platform_device_register_simple
in rockchip.c and add a new cpufreq driver to support Rockchip
SoCs.

Signed-off-by: Feng Xiao <xf@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
change in v2:
- add rockchip,rk3036 and rockchip,rk3228 to compatibility list

change in v1:
- add compatible check

 arch/arm/mach-rockchip/rockchip.c  |  1 -
 drivers/cpufreq/Kconfig.arm        | 10 +++++++
 drivers/cpufreq/Makefile           |  1 +
 drivers/cpufreq/rockchip-cpufreq.c | 57 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpufreq/rockchip-cpufreq.c

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index 3f07cc5..beb71da 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -74,7 +74,6 @@ static void __init rockchip_dt_init(void)
 {
 	rockchip_suspend_init();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	platform_device_register_simple("cpufreq-dt", 0, NULL, 0);
 }
 
 static const char * const rockchip_board_dt_compat[] = {
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 14b1f93..1786315 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -97,6 +97,16 @@ config ARM_OMAP2PLUS_CPUFREQ
 	depends on ARCH_OMAP2PLUS
 	default ARCH_OMAP2PLUS
 
+config ARM_ROCKCHIP_CPUFREQ
+	tristate "Rockchip CPUfreq driver"
+	depends on ARCH_ROCKCHIP && CPUFREQ_DT
+	select PM_OPP
+	help
+	  This adds the CPUFreq driver support for Rockchip SoCs.
+	  The driver will directly use cpufreq-dt driver as backend.
+
+	  If in doubt, say N.
+
 config ARM_S3C_CPUFREQ
 	bool
 	help
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 9e63fb1..91d8bb7 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_ARM_MT8173_CPUFREQ)	+= mt8173-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
+obj-$(CONFIG_ARM_ROCKCHIP_CPUFREQ)	+= rockchip-cpufreq.o
 obj-$(CONFIG_ARM_S3C24XX_CPUFREQ)	+= s3c24xx-cpufreq.o
 obj-$(CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS) += s3c24xx-cpufreq-debugfs.o
 obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
diff --git a/drivers/cpufreq/rockchip-cpufreq.c b/drivers/cpufreq/rockchip-cpufreq.c
new file mode 100644
index 0000000..9266614
--- /dev/null
+++ b/drivers/cpufreq/rockchip-cpufreq.c
@@ -0,0 +1,57 @@
+/*
+ * Rockchip Platforms CPUFreq Support
+ *
+ * Copyright (C) 2016 Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * Feng Xiao <xf@rock-chips.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+static const char * const rockchip_compat[] = {
+	"rockchip,rk2928",
+	"rockchip,rk3036",
+	"rockchip,rk3066a",
+	"rockchip,rk3066b",
+	"rockchip,rk3188",
+	"rockchip,rk3228",
+	"rockchip,rk3288",
+	"rockchip,rk3366",
+	"rockchip,rk3368",
+	"rockchip,rk3399",
+};
+
+static int __init rockchip_cpufreq_driver_init(void)
+{
+	struct platform_device *pdev;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rockchip_compat); i++) {
+		if (of_machine_is_compatible(rockchip_compat[i])) {
+			pdev = platform_device_register_simple("cpufreq-dt",
+							       -1, NULL, 0);
+			return PTR_ERR_OR_ZERO(pdev);
+		}
+	}
+
+	return -ENODEV;
+}
+module_init(rockchip_cpufreq_driver_init);
+
+MODULE_AUTHOR("Feng Xiao <xf@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip cpufreq driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1



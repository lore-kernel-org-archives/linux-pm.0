From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] ARM: clps711x: Add cpuidle driver
Date: Sat, 22 Mar 2014 09:44:35 +0400
Message-ID: <1395467076-29462-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.176.135]:39459 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaCVFpP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 22 Mar 2014 01:45:15 -0400
Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [94.100.177.104])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id D1DB0FCA1BBA
	for <linux-pm@vger.kernel.org>; Sat, 22 Mar 2014 09:45:12 +0400 (MSK)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, Alexander Shiyan <shc_work@mail.ru>

Add cpuidle support for ARM Cirrus Logic CLPS711X CPUs.
This CPU has an unique internal register and write to this location
will put the system into the Idle State by halting the clock to the
processor until an interrupt is generated.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/cpuidle/Kconfig.arm        |  6 ++++
 drivers/cpuidle/Makefile           |  1 +
 drivers/cpuidle/cpuidle-clps711x.c | 64 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-clps711x.c

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 97ccc31..371e75d 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -13,6 +13,12 @@ config ARM_BIG_LITTLE_CPUIDLE
 	  define different C-states for little and big cores through the
 	  multiple CPU idle drivers infrastructure.
 
+config ARM_CLPS711X_CPUIDLE
+	bool "CPU Idle Driver for CLPS711X processors"
+	depends on ARCH_CLPS711X || COMPILE_TEST
+	help
+	  Select this to enable cpuidle on Cirrus Logic CLPS711X SOCs.
+
 config ARM_HIGHBANK_CPUIDLE
 	bool "CPU Idle Driver for Calxeda processors"
 	depends on ARM_PSCI
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index f71ae1b..534fff5 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 ##################################################################################
 # ARM SoC drivers
 obj-$(CONFIG_ARM_BIG_LITTLE_CPUIDLE)	+= cpuidle-big_little.o
+obj-$(CONFIG_ARM_CLPS711X_CPUIDLE)	+= cpuidle-clps711x.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
diff --git a/drivers/cpuidle/cpuidle-clps711x.c b/drivers/cpuidle/cpuidle-clps711x.c
new file mode 100644
index 0000000..5243811
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-clps711x.c
@@ -0,0 +1,64 @@
+/*
+ *  CLPS711X CPU idle driver
+ *
+ *  Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define CLPS711X_CPUIDLE_NAME	"clps711x-cpuidle"
+
+static void __iomem *clps711x_halt;
+
+static int clps711x_cpuidle_halt(struct cpuidle_device *dev,
+				 struct cpuidle_driver *drv, int index)
+{
+	writel(0xaa, clps711x_halt);
+
+	return index;
+}
+
+static struct cpuidle_driver clps711x_idle_driver = {
+	.name		= CLPS711X_CPUIDLE_NAME,
+	.owner		= THIS_MODULE,
+	.states[0]	= {
+		.name		= "HALT",
+		.desc		= "CLPS711X HALT",
+		.enter		= clps711x_cpuidle_halt,
+		.exit_latency	= 1,
+	},
+	.state_count	= 1,
+};
+
+static int __init clps711x_cpuidle_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	clps711x_halt = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(clps711x_halt))
+		return PTR_ERR(clps711x_halt);
+
+	return cpuidle_register(&clps711x_idle_driver, NULL);
+}
+
+static struct platform_driver clps711x_cpuidle_driver = {
+	.driver	= {
+		.name	= CLPS711X_CPUIDLE_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+module_platform_driver_probe(clps711x_cpuidle_driver, clps711x_cpuidle_probe);
+
+MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
+MODULE_DESCRIPTION("CLPS711X CPU idle driver");
+MODULE_LICENSE("GPL");
-- 
1.8.3.2


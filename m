From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v2] power/reset: zx: Register restart handler
Date: Mon,  6 Jul 2015 16:35:30 +0800
Message-ID: <1436171730-21175-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34656 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbGFIfs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 04:35:48 -0400
Received: by pdbep18 with SMTP id ep18so102112966pdb.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2015 01:35:47 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, haojian.zhuang@linaro.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, jason.liu@linaro.org, Jun Nie <jun.nie@linaro.org>

Register with kernel restart handler instead of setting arm_pm_restart
directly.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/power/reset/Kconfig     |  7 ++++
 drivers/power/reset/Makefile    |  1 +
 drivers/power/reset/zx-reboot.c | 82 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 drivers/power/reset/zx-reboot.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index aad9c33..4ed90f3 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -165,5 +165,12 @@ config POWER_RESET_RMOBILE
 	help
 	  Reboot support for Renesas R-Mobile and SH-Mobile SoCs.
 
+config POWER_RESET_ZX
+	tristate "ZTE SoCs reset driver"
+	depends on ARCH_ZX || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Reboot support for ZTE SoCs.
+
 endif
 
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index dbe06c3..096fa67 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
 obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
 obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
+obj-$(CONFIG_POWER_RESET_ZX) += zx-reboot.o
diff --git a/drivers/power/reset/zx-reboot.c b/drivers/power/reset/zx-reboot.c
new file mode 100644
index 0000000..e930a44
--- /dev/null
+++ b/drivers/power/reset/zx-reboot.c
@@ -0,0 +1,82 @@
+/*
+ * ZTE zx296702 SoC reset code
+ *
+ * Copyright (c) 2015 Linaro Ltd.
+ *
+ * Author: Jun Nie <jun.nie@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+
+#include <asm/proc-fns.h>
+
+static void __iomem *base;
+static void __iomem *pcu_base;
+
+static int zx_restart_handler(struct notifier_block *this,
+			      unsigned long mode, void *cmd)
+{
+	writel_relaxed(1, base + 0xb0);
+	writel_relaxed(1, pcu_base + 0x34);
+
+	while (1)
+		cpu_do_idle();
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block zx_restart_nb = {
+	.notifier_call = zx_restart_handler,
+	.priority = 128,
+};
+
+static int zx_reboot_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int err;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		WARN(1, "failed to map base address");
+		return -ENODEV;
+	}
+
+	np = of_find_compatible_node(NULL, NULL, "zte,zx296702-pcu");
+	pcu_base = of_iomap(np, 0);
+	if (!pcu_base) {
+		iounmap(base);
+		WARN(1, "failed to map pcu_base address");
+		return -ENODEV;
+	}
+
+	err = register_restart_handler(&zx_restart_nb);
+	if (err)
+		dev_err(&pdev->dev, "Register restart handler failed(err=%d)\n",
+			err);
+
+	return err;
+}
+
+static const struct of_device_id zx_reboot_of_match[] = {
+	{ .compatible = "zte,sysctrl" },
+	{}
+};
+
+static struct platform_driver zx_reboot_driver = {
+	.probe = zx_reboot_probe,
+	.driver = {
+		.name = "zx-reboot",
+		.of_match_table = zx_reboot_of_match,
+	},
+};
+module_platform_driver(zx_reboot_driver);
-- 
1.9.1


From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCHv2 1/2] power: reset: Add generic SYSCON register mapped poweroff.
Date: Wed, 11 Mar 2015 15:32:24 -0700
Message-ID: <1426113145-2921-2-git-send-email-moritz.fischer@ettus.com>
References: <1426113145-2921-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34045 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbbCKWcs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2015 18:32:48 -0400
Received: by pdno5 with SMTP id o5so14699981pdn.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2015 15:32:47 -0700 (PDT)
In-Reply-To: <1426113145-2921-1-git-send-email-moritz.fischer@ettus.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>

Add a generic SYSCON register mapped poweroff mechanism.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 drivers/power/reset/Kconfig           |  7 +++
 drivers/power/reset/Makefile          |  1 +
 drivers/power/reset/syscon-poweroff.c | 97 +++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 27f6646..4bae079 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -151,6 +151,13 @@ config POWER_RESET_SYSCON
 	help
 	  Reboot support for generic SYSCON mapped register reset.
 
+config POWER_RESET_SYSCON_POWEROFF
+	bool "Generic SYSCON regmap poweroff driver"
+	depends on OF
+	select MFD_SYSCON
+	help
+	  Poweroff support for generic SYSCON mapped register poweroff.
+
 config POWER_RESET_RMOBILE
 	tristate "Renesas R-Mobile reset driver"
 	depends on ARCH_RMOBILE || COMPILE_TEST
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 11de15b..dbe06c3 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -17,4 +17,5 @@ obj-$(CONFIG_POWER_RESET_VEXPRESS) += vexpress-poweroff.o
 obj-$(CONFIG_POWER_RESET_XGENE) += xgene-reboot.o
 obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
 obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
+obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/syscon-poweroff.c
new file mode 100644
index 0000000..15a3db7
--- /dev/null
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -0,0 +1,97 @@
+/*
+ * Generic Syscon Poweroff Driver
+ *
+ * Copyright (c) 2015, National Instruments Corp.
+ * Author: Moritz Fischer <moritz.fischer@ettus.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kallsyms.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/notifier.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+
+static struct regmap *map;
+static u32 offset;
+static u32 mask;
+
+void syscon_poweroff(void)
+{
+	/* Issue the poweroff */
+	regmap_write(map, offset, mask);
+
+	mdelay(1000);
+
+	pr_emerg("Unable to poweroff system\n");
+}
+
+static int syscon_poweroff_probe(struct platform_device *pdev)
+{
+	char symname[KSYM_NAME_LEN];
+
+	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "regmap");
+	if (IS_ERR(map)) {
+		dev_err(&pdev->dev, "unable to get syscon");
+		return PTR_ERR(map);
+	}
+
+	if (of_property_read_u32(pdev->dev.of_node, "offset", &offset)) {
+		dev_err(&pdev->dev, "unable to read 'offset'");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(pdev->dev.of_node, "mask", &mask)) {
+		dev_err(&pdev->dev, "unable to read 'mask'");
+		return -EINVAL;
+	}
+
+	if (pm_power_off) {
+		lookup_symbol_name((ulong)pm_power_off, symname);
+		dev_err(&pdev->dev,
+		"pm_power_off already claimed %p %s",
+		pm_power_off, symname);
+		return -EBUSY;
+	}
+
+	pm_power_off = syscon_poweroff;
+
+	return 0;
+}
+
+static int syscon_poweroff_remove(struct platform_device *pdev)
+{
+	if (pm_power_off == syscon_poweroff)
+		pm_power_off = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id syscon_poweroff_of_match[] = {
+	{ .compatible = "syscon-poweroff" },
+	{}
+};
+
+static struct platform_driver syscon_poweroff_driver = {
+	.probe = syscon_poweroff_probe,
+	.remove = syscon_poweroff_remove,
+	.driver = {
+		.name = "syscon-poweroff",
+		.of_match_table = of_match_ptr(syscon_poweroff_of_match),
+	},
+};
+module_platform_driver(syscon_poweroff_driver);
-- 
1.9.3


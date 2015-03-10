From: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] power: reset: Add generic SYSCON register mapped poweroff.
Date: Tue, 10 Mar 2015 16:21:09 -0700
Message-ID: <1426029670-31775-2-git-send-email-moritz.fischer@ettus.com>
References: <1426029670-31775-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426029670-31775-1-git-send-email-moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add a generic SYSCON register mapped poweroff mechanism.

Signed-off-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
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
index 0000000..fee88e2
--- /dev/null
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -0,0 +1,97 @@
+/*
+ * Generic Syscon Poweroff Driver
+ *
+ * Copyright (c) 2015, National Instruments Corp.
+ * Author: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
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
+#include <linux/module.h>
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
+#ifdef CONFIG_OF
+static const struct of_device_id syscon_poweroff_of_match[] = {
+	{ .compatible = "syscon-poweroff" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, syscon_poweroff_of_match);
+#endif
+
+static struct platform_driver syscon_poweroff_driver = {
+	.probe = syscon_poweroff_probe,
+	.driver = {
+		.name = "syscon-poweroff",
+		.of_match_table = syscon_poweroff_of_match,
+	},
+};
+module_platform_driver(syscon_poweroff_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("Generic SYSCON poweroff driver");
+MODULE_ALIAS("platform:syscon-poweroff");
-- 
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

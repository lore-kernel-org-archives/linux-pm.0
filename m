From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH 1/3] power: reset: Add Renesas reset driver
Date: Mon, 13 Feb 2017 13:25:30 -0500
Message-ID: <20170213182532.4042-2-chris.brandt@renesas.com>
References: <20170213182532.4042-1-chris.brandt@renesas.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:46618 "EHLO
        relmlie4.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752144AbdBMS0I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2017 13:26:08 -0500
In-Reply-To: <20170213182532.4042-1-chris.brandt@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>
Cc: linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>

Some Renesas SoCs do not have a reset register and the only way to do a SW
controlled reset is to use the watchdog timer. Additionally, since all the
WDT timeout options are so quick, a system reset is about the only thing
it's good for.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/power/reset/Kconfig         |   9 ++++
 drivers/power/reset/Makefile        |   1 +
 drivers/power/reset/renesas-reset.c | 103 ++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/power/reset/renesas-reset.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index b8caccc..e3100c9 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -130,6 +130,15 @@ config POWER_RESET_QNAP
 
 	  Say Y if you have a QNAP NAS.
 
+config POWER_RESET_RENESAS
+	tristate "Renesas WDT reset driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Reboot support for Renesas SoCs with WDT reset.
+	  Some Renesas SoCs do not have a reset register and the only way
+	  to do a SW controlled reset is to use the watchdog timer.
+
 config POWER_RESET_RESTART
 	bool "Restart power-off driver"
 	help
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 11dae3b..a78a56c 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
+obj-$(CONFIG_POWER_RESET_RENESAS) += renesas-reset.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
 obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
 obj-$(CONFIG_POWER_RESET_VERSATILE) += arm-versatile-reboot.o
diff --git a/drivers/power/reset/renesas-reset.c b/drivers/power/reset/renesas-reset.c
new file mode 100644
index 0000000..dede029
--- /dev/null
+++ b/drivers/power/reset/renesas-reset.c
@@ -0,0 +1,103 @@
+/*
+ * Renesas WDT Reset Driver
+ *
+ * Copyright (C) 2017 Renesas Electronics America, Inc.
+ * Copyright (C) 2017 Chris Brandt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * based on rmobile-reset.c
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/reboot.h>
+
+/* Watchdog Timer Registers */
+#define WTCSR 0
+#define WTCNT 2
+#define WRCSR 4
+
+static void __iomem *base;
+
+static int wdt_reset_handler(struct notifier_block *this,
+			     unsigned long mode, void *cmd)
+{
+	pr_debug("%s %lu\n", __func__, mode);
+
+	/* Dummy read (must read WRCSR:WOVF at least once before clearing) */
+	readw(base + WRCSR);
+
+	writew(0xA500, base + WRCSR);	/* Clear WOVF */
+	writew(0x5A5F, base + WRCSR);	/* Reset Enable */
+	writew(0x5A00, base + WTCNT);	/* Counter to 00 */
+	writew(0xA578, base + WTCSR);	/* Start timer */
+
+	/* Wait for WDT overflow */
+	while (1)
+		;
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block wdt_reset_nb = {
+	.notifier_call = wdt_reset_handler,
+	.priority = 192,
+};
+
+static int wdt_reset_probe(struct platform_device *pdev)
+{
+	int error;
+
+	base = of_iomap(pdev->dev.of_node, 0);
+	if (!base)
+		return -ENODEV;
+
+	error = register_restart_handler(&wdt_reset_nb);
+	if (error) {
+		dev_err(&pdev->dev,
+			"cannot register restart handler (err=%d)\n", error);
+		goto fail_unmap;
+	}
+
+	return 0;
+
+fail_unmap:
+	iounmap(base);
+	return error;
+}
+
+static int wdt_reset_remove(struct platform_device *pdev)
+{
+	unregister_restart_handler(&wdt_reset_nb);
+	iounmap(base);
+	return 0;
+}
+
+static const struct of_device_id wdt_reset_of_match[] = {
+	{ .compatible = "renesas,wdt-reset", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, wdt_reset_of_match);
+
+static struct platform_driver wdt_reset_driver = {
+	.probe = wdt_reset_probe,
+	.remove = wdt_reset_remove,
+	.driver = {
+		.name = "wdt_reset",
+		.of_match_table = wdt_reset_of_match,
+	},
+};
+
+module_platform_driver(wdt_reset_driver);
+
+MODULE_DESCRIPTION("Renesas WDT Reset Driver");
+MODULE_AUTHOR("Chris Brandt <chris.brandt@renesas.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.10.1



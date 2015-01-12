From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] power: reset: Add reset driver for R-Mobile platforms
Date: Mon, 12 Jan 2015 16:57:25 +0100
Message-ID: <1421078245-5531-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a reset driver for Renesas R-Mobile and SH-Mobile SoCs. It registers
a restart handler to trigger a soft power-on reset through the R-Mobile
System Controller.
As this is controlled by DT, the priority of this restart handler is 192,
to allow a watchdog driver to use priority 128.

Note that we do not use syscon-reboot, as the HPB (Peripheral Bus
Bridge) semaphore should be acquired on systems where both the ARM and
SH core are in use. The driver can be extended later to support this,
when needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Tested on R-Mobile A1 (r8a7740) and SH-Mobile AG5 (sh73a0).

v3:
  - Add DT priority explanation,
  - Add Reviewed-by,
v2:
  - This can be considered v2 of "[PATCH 1/4] ARM: shmobile: R-Mobile: Add
    SYSC restart handler"
    (http://www.spinics.net/lists/arm-kernel/msg383402.html),
  - Move to a standalone driver under drivers/power/reset that can be
    modular,
  - Use register_restart_handler() instead of setting arm_pm_restart,
---
 drivers/power/reset/Kconfig         |  6 +++
 drivers/power/reset/Makefile        |  1 +
 drivers/power/reset/rmobile-reset.c | 93 +++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 drivers/power/reset/rmobile-reset.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 028e765045196f89..d743145e0001f466 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -159,5 +159,11 @@ config POWER_RESET_SYSCON
 	help
 	  Reboot support for generic SYSCON mapped register reset.
 
+config POWER_RESET_RMOBILE
+	tristate "Renesas R-Mobile reset driver"
+	depends on ARCH_RMOBILE || COMPILE_TEST
+	help
+	  Reboot support for Renesas R-Mobile and SH-Mobile SoCs.
+
 endif
 
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 1d4804d6b3237c1c..1631652009acc32d 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_POWER_RESET_VEXPRESS) += vexpress-poweroff.o
 obj-$(CONFIG_POWER_RESET_XGENE) += xgene-reboot.o
 obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
 obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
+obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
diff --git a/drivers/power/reset/rmobile-reset.c b/drivers/power/reset/rmobile-reset.c
new file mode 100644
index 0000000000000000..ff3bbcfd03d1e7b4
--- /dev/null
+++ b/drivers/power/reset/rmobile-reset.c
@@ -0,0 +1,93 @@
+/*
+ * Renesas R-Mobile Reset Driver
+ *
+ * Copyright (C) 2014 Glider bvba
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
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
+
+/* SYSC Register Bank 2 */
+#define RESCNT2		0x20		/* Reset Control Register 2 */
+
+/* Reset Control Register 2 */
+#define RESCNT2_PRES	0x80000000	/* Soft power-on reset */
+
+
+static void __iomem *sysc_base2;
+
+static int rmobile_reset_handler(struct notifier_block *this,
+				 unsigned long mode, void *cmd)
+{
+	pr_debug("%s %lu\n", __func__, mode);
+
+	/* Let's assume we have acquired the HPB semaphore */
+	writel(RESCNT2_PRES, sysc_base2 + RESCNT2);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block rmobile_reset_nb = {
+	.notifier_call = rmobile_reset_handler,
+	.priority = 192,
+};
+
+static int rmobile_reset_probe(struct platform_device *pdev)
+{
+	int error;
+
+	sysc_base2 = of_iomap(pdev->dev.of_node, 1);
+	if (!sysc_base2)
+		return -ENODEV;
+
+	error = register_restart_handler(&rmobile_reset_nb);
+	if (error) {
+		dev_err(&pdev->dev,
+			"cannot register restart handler (err=%d)\n", error);
+		goto fail_unmap;
+	}
+
+	return 0;
+
+fail_unmap:
+	iounmap(sysc_base2);
+	return error;
+}
+
+static int rmobile_reset_remove(struct platform_device *pdev)
+{
+	unregister_restart_handler(&rmobile_reset_nb);
+	iounmap(sysc_base2);
+	return 0;
+}
+
+static const struct of_device_id rmobile_reset_of_match[] = {
+	{ .compatible = "renesas,sysc-rmobile", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rmobile_reset_of_match);
+
+static struct platform_driver rmobile_reset_driver = {
+	.probe = rmobile_reset_probe,
+	.remove = rmobile_reset_remove,
+	.driver = {
+		.name = "rmobile_reset",
+		.of_match_table = rmobile_reset_of_match,
+	},
+};
+
+module_platform_driver(rmobile_reset_driver);
+
+MODULE_DESCRIPTION("Renesas R-Mobile Reset Driver");
+MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1


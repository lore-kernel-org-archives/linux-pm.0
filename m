From: Robin Gong <b38343@freescale.com>
Subject: [PATCH v2 2/3] power: reset: imx-snvs-poweroff: add power off driver for i.mx6
Date: Fri, 12 Sep 2014 16:48:58 +0800
Message-ID: <1410511739-31122-3-git-send-email-b38343@freescale.com>
References: <1410511739-31122-1-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410511739-31122-1-git-send-email-b38343@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@freescale.com, kernel@pengutronix.de, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, grant.likely@linaro.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add simple power off driver for i.mx6.

Signed-off-by: Robin Gong <b38343@freescale.com>
---
 drivers/power/reset/Kconfig             |  6 +++
 drivers/power/reset/Makefile            |  1 +
 drivers/power/reset/imx-snvs-poweroff.c | 69 +++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 drivers/power/reset/imx-snvs-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index ca41523..c48d9ba 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -45,6 +45,12 @@ config POWER_RESET_HISI
 	help
 	  Reboot support for Hisilicon boards.
 
+config POWER_RESET_IMX
+	bool "IMX6 power-off driver"
+	depends on POWER_RESET && SOC_IMX6
+	help
+	  Power off support for i.mx6 boards.
+
 config POWER_RESET_MSM
 	bool "Qualcomm MSM power-off driver"
 	depends on POWER_RESET && ARCH_QCOM
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index a42e70e..2524daf 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMSTB) += brcmstb-reboot.o
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
+obj-$(CONFIG_POWER_RESET_IMX) += imx-snvs-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
diff --git a/drivers/power/reset/imx-snvs-poweroff.c b/drivers/power/reset/imx-snvs-poweroff.c
new file mode 100644
index 0000000..55603ba
--- /dev/null
+++ b/drivers/power/reset/imx-snvs-poweroff.c
@@ -0,0 +1,69 @@
+/* Power off driver for i.mx6
+ * Copyright (c) 2014, FREESCALE CORPORATION.  All rights reserved.
+ *
+ * based on msm-poweroff.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include <asm/system_misc.h>
+
+static void __iomem *snvs_base;
+
+static void do_imx_poweroff(void)
+{
+	u32 value = readl(snvs_base);
+
+	/* set TOP and DP_EN bit */
+	writel(value | 0x60, snvs_base);
+}
+
+static int imx_poweroff_probe(struct platform_device *pdev)
+{
+	snvs_base = of_iomap(pdev->dev.of_node, 0);
+	if (!snvs_base) {
+		dev_err(&pdev->dev, "failed to get memory\n");
+		return -EIO;
+	}
+
+	pm_power_off = do_imx_poweroff;
+	return 0;
+}
+
+static const struct of_device_id of_imx_poweroff_match[] = {
+	{ .compatible = "fsl,sec-v4.0-poweroff", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_imx_poweroff_match);
+
+static struct platform_driver imx_poweroff_driver = {
+	.probe = imx_poweroff_probe,
+	.driver = {
+		.name = "imx-snvs-poweroff",
+		.of_match_table = of_match_ptr(of_imx_poweroff_match),
+	},
+};
+
+static int __init imx_poweroff_init(void)
+{
+	return platform_driver_register(&imx_poweroff_driver);
+}
+device_initcall(imx_poweroff_init);
-- 
1.9.1

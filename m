From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v3 3/8] power: reset: Add a driver for the Microsemi Ocelot reset
Date: Tue, 16 Jan 2018 11:12:35 +0100
Message-ID: <20180116101240.5393-4-alexandre.belloni@free-electrons.com>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The Microsemi Ocelot SoC has a register allowing to reset the MIPS core.
Unfortunately, the syscon-reboot driver can't be used directly (but almost)
as the reset control may be disabled using another register.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/Kconfig        |  7 +++
 drivers/power/reset/Makefile       |  1 +
 drivers/power/reset/ocelot-reset.c | 88 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 drivers/power/reset/ocelot-reset.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index ca0de1a78e85..2372f8e1040d 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -113,6 +113,13 @@ config POWER_RESET_MSM
 	help
 	  Power off and restart support for Qualcomm boards.
 
+config POWER_RESET_OCELOT_RESET
+	bool "Microsemi Ocelot reset driver"
+	depends on MSCC_OCELOT || COMPILE_TEST
+	select MFD_SYSCON
+	help
+	  This driver supports restart for Microsemi Ocelot SoC.
+
 config POWER_RESET_PIIX4_POWEROFF
 	tristate "Intel PIIX4 power-off driver"
 	depends on PCI
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index aeb65edb17b7..df9d92291c67 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_IMX) += imx-snvs-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
+obj-$(CONFIG_POWER_RESET_OCELOT_RESET) += ocelot-reset.o
 obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/ocelot-reset.c
new file mode 100644
index 000000000000..5a13a5cc8188
--- /dev/null
+++ b/drivers/power/reset/ocelot-reset.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Microsemi MIPS SoC reset driver
+ *
+ * License: Dual MIT/GPL
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/notifier.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+
+struct ocelot_reset_context {
+	void __iomem *base;
+	struct regmap *cpu_ctrl;
+	struct notifier_block restart_handler;
+};
+
+#define ICPU_CFG_CPU_SYSTEM_CTRL_RESET 0x20
+#define CORE_RST_PROTECT BIT(2)
+
+#define SOFT_CHIP_RST BIT(0)
+
+static int ocelot_restart_handle(struct notifier_block *this,
+				 unsigned long mode, void *cmd)
+{
+	struct ocelot_reset_context *ctx = container_of(this, struct
+							ocelot_reset_context,
+							restart_handler);
+
+	/* Make sure the core is not protected from reset */
+	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_RESET,
+			   CORE_RST_PROTECT, 0);
+
+	writel(SOFT_CHIP_RST, ctx->base);
+
+	pr_emerg("Unable to restart system\n");
+	return NOTIFY_DONE;
+}
+
+static int ocelot_reset_probe(struct platform_device *pdev)
+{
+	struct ocelot_reset_context *ctx;
+	struct resource *res;
+
+	struct device *dev = &pdev->dev;
+	int err;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctx->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ctx->base))
+		return PTR_ERR(ctx->base);
+
+	ctx->cpu_ctrl = syscon_regmap_lookup_by_compatible("mscc,ocelot-cpu-syscon");
+	if (IS_ERR(ctx->cpu_ctrl))
+		return PTR_ERR(ctx->cpu_ctrl);
+
+	ctx->restart_handler.notifier_call = ocelot_restart_handle;
+	ctx->restart_handler.priority = 192;
+	err = register_restart_handler(&ctx->restart_handler);
+	if (err)
+		dev_err(dev, "can't register restart notifier (err=%d)\n", err);
+
+	return err;
+}
+
+static const struct of_device_id ocelot_reset_of_match[] = {
+	{ .compatible = "mscc,ocelot-chip-reset" },
+	{}
+};
+
+static struct platform_driver ocelot_reset_driver = {
+	.probe = ocelot_reset_probe,
+	.driver = {
+		.name = "ocelot-chip-reset",
+		.of_match_table = ocelot_reset_of_match,
+	},
+};
+builtin_platform_driver(ocelot_reset_driver);
-- 
2.15.1

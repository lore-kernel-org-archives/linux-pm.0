From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/7 v6] power: reset: driver for the Versatile syscon reboot
Date: Mon,  8 Sep 2014 13:38:02 +0200
Message-ID: <1410176286-32533-4-git-send-email-linus.walleij@linaro.org>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:51282 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbaIHLi0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Sep 2014 07:38:26 -0400
Received: by mail-wi0-f171.google.com with SMTP id hi2so2457384wib.4
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2014 04:38:24 -0700 (PDT)
In-Reply-To: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>

This driver enabled us to drive the reboot of the Versatile family
of ARM reference boards. Even though only the RealView boards are
supported initially, these boards all have the same procedure for
reboot:

- Write a magic value into an unlocking register
- Write another magic value into a reset control register

The driver will be reusable for Versatile and possibly also the
Integrator family of reference boards.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Do not probe from a platform device, instead use a device_initcall()
  and look up the syscon device from its node. If that device is
  not yet registered, the call will be deferred. This is done so that
  the Linux driver model is not reflected into the device tree, as
  the reboot property of the syscon is not a separate device.
---
 drivers/power/reset/Kconfig                |   9 +++
 drivers/power/reset/Makefile               |   1 +
 drivers/power/reset/arm-versatile-reboot.c | 111 +++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 drivers/power/reset/arm-versatile-reboot.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index ca41523bbebf..2447c76e2f1a 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -75,6 +75,15 @@ config POWER_RESET_SUN6I
 	help
 	  Reboot support for the Allwinner A31 SoCs.
 
+config POWER_RESET_VERSATILE
+	bool "ARM Versatile family reboot driver"
+	depends on ARM
+	depends on MFD_SYSCON
+	depends on OF
+	help
+	  Power off and restart support for ARM Versatile family of
+	  reference boards.
+
 config POWER_RESET_VEXPRESS
 	bool "ARM Versatile Express power-off and reset driver"
 	depends on ARM || ARM64
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index a42e70edd037..41ab0e7b92b8 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
 obj-$(CONFIG_POWER_RESET_SUN6I) += sun6i-reboot.o
+obj-$(CONFIG_POWER_RESET_VERSATILE) += arm-versatile-reboot.o
 obj-$(CONFIG_POWER_RESET_VEXPRESS) += vexpress-poweroff.o
 obj-$(CONFIG_POWER_RESET_XGENE) += xgene-reboot.o
 obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
diff --git a/drivers/power/reset/arm-versatile-reboot.c b/drivers/power/reset/arm-versatile-reboot.c
new file mode 100644
index 000000000000..5b08bffcf1a8
--- /dev/null
+++ b/drivers/power/reset/arm-versatile-reboot.c
@@ -0,0 +1,111 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/init.h>
+#include <linux/mfd/syscon.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+#include <asm/system_misc.h>
+
+#define REALVIEW_SYS_LOCK_OFFSET	0x20
+#define REALVIEW_SYS_LOCK_VAL		0xA05F
+#define REALVIEW_SYS_RESETCTL_OFFSET	0x40
+
+/*
+ * We detect the different syscon types from the compatible strings.
+ */
+enum versatile_reboot {
+	REALVIEW_REBOOT_EB,
+	REALVIEW_REBOOT_PB1176,
+	REALVIEW_REBOOT_PB11MP,
+	REALVIEW_REBOOT_PBA8,
+	REALVIEW_REBOOT_PBX,
+};
+
+/* Pointer to the system controller */
+static struct regmap *syscon_regmap;
+static enum versatile_reboot versatile_reboot_type;
+
+static const struct of_device_id versatile_reboot_of_match[] = {
+	{
+		.compatible = "arm,realview-eb-syscon",
+		.data = (void *)REALVIEW_REBOOT_EB,
+	},
+	{
+		.compatible = "arm,realview-pb1176-syscon",
+		.data = (void *)REALVIEW_REBOOT_PB1176,
+	},
+	{
+		.compatible = "arm,realview-pb11mp-syscon",
+		.data = (void *)REALVIEW_REBOOT_PB11MP,
+	},
+	{
+		.compatible = "arm,realview-pba8-syscon",
+		.data = (void *)REALVIEW_REBOOT_PBA8,
+	},
+	{
+		.compatible = "arm,realview-pbx-syscon",
+		.data = (void *)REALVIEW_REBOOT_PBX,
+	},
+};
+
+static void versatile_reboot(enum reboot_mode mode, const char *cmd)
+{
+	/* Unlock the reset register */
+	regmap_write(syscon_regmap, REALVIEW_SYS_LOCK_OFFSET,
+		     REALVIEW_SYS_LOCK_VAL);
+	/* Then hit reset on the different machines */
+	switch (versatile_reboot_type) {
+	case REALVIEW_REBOOT_EB:
+		regmap_write(syscon_regmap,
+			     REALVIEW_SYS_RESETCTL_OFFSET, 0x0008);
+		break;
+	case REALVIEW_REBOOT_PB1176:
+		regmap_write(syscon_regmap,
+			     REALVIEW_SYS_RESETCTL_OFFSET, 0x0100);
+		break;
+	case REALVIEW_REBOOT_PB11MP:
+	case REALVIEW_REBOOT_PBA8:
+		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
+			     0x0000);
+		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
+			     0x0004);
+		break;
+	case REALVIEW_REBOOT_PBX:
+		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
+			     0x00f0);
+		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
+			     0x00f4);
+		break;
+	}
+	dsb();
+}
+
+static int __init versatile_reboot_probe(void)
+{
+	const struct of_device_id *reboot_id;
+	struct device_node *np;
+
+	np = of_find_matching_node_and_match(NULL, versatile_reboot_of_match,
+						 &reboot_id);
+	if (!np)
+		return -ENODEV;
+	versatile_reboot_type = (enum versatile_reboot)reboot_id->data;
+
+	syscon_regmap = syscon_node_to_regmap(np);
+	if (IS_ERR(syscon_regmap))
+		return PTR_ERR(syscon_regmap);
+
+	arm_pm_restart = versatile_reboot;
+	pr_info("versatile reboot driver registered\n");
+	return 0;
+}
+device_initcall(versatile_reboot_probe);
-- 
1.9.3


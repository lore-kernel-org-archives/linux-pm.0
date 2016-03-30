From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v7 2/4] power: reset: add reboot mode driver
Date: Wed, 30 Mar 2016 10:20:43 +0800
Message-ID: <1459304443-9811-1-git-send-email-andy.yan@rock-chips.com>
References: <1459304304-9713-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.138]:44286 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbcC3CV3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 22:21:29 -0400
In-Reply-To: <1459304304-9713-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, sre@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de
Cc: galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, olof@lixom.net, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, jun.nie@linaro.org, pawel.moll@arm.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, f.fainelli@gmail.com, linux@arm.linux.org.uk, mbrugger@suse.com, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, linux-kernel@vger.kernel.org, wxt@rock-chips.com, dwmw2@infradead.org, mark.rutland@arm.com, k.kozlowski@samsung.com, Andy Yan <andy.yan@rock-chips.com>

This driver parses the reboot commands like "reboot bootloader"
and "reboot recovery" to get a boot mode described in the
device tree , then call the write interfae to store the boot
mode in some place like special register or sram, which can
be read by the bootloader after system reboot, then the bootloader
can take different action according to the mode stored.

This is commonly used on Android based devices, in order to
reboot the device into fastboot or recovery mode.

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
Tested-by: John Stultz <john.stultz@linaro.org>
Acked-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v7:
- address some suggestions from Krzysztof, make syscon-reboot-mode driver data self-contained.

Changes in v6: None
Changes in v5:
- use two blank space under help in Kconfig
- use unsigned int instead of int for member magic in struct mode_info

Changes in v4:
- make this driver depends on OF to avoid kbuild test error

Changes in v3:
- scan multi properities
- add mask value for some platform which only use some bits of the register
  to store boot mode magic value

Changes in v2:
- move to dir drivers/power/reset/
- make syscon-reboot-mode a generic driver

Changes in v1:
- fix the embarrassed compile warning
- correct the maskrom magic number
- check for the normal reboot

 drivers/power/reset/Kconfig              |  13 ++++
 drivers/power/reset/Makefile             |   2 +
 drivers/power/reset/reboot-mode.c        | 115 +++++++++++++++++++++++++++++++
 drivers/power/reset/reboot-mode.h        |   6 ++
 drivers/power/reset/syscon-reboot-mode.c |  86 +++++++++++++++++++++++
 5 files changed, 222 insertions(+)
 create mode 100644 drivers/power/reset/reboot-mode.c
 create mode 100644 drivers/power/reset/reboot-mode.h
 create mode 100644 drivers/power/reset/syscon-reboot-mode.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 1131cf7..cf50630 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -173,5 +173,18 @@ config POWER_RESET_ZX
 	help
 	  Reboot support for ZTE SoCs.
 
+config REBOOT_MODE
+	tristate
+
+config SYSCON_REBOOT_MODE
+	bool "Generic SYSCON regmap reboot mode driver"
+	depends on OF
+	select REBOOT_MODE
+	help
+	  Say y here will enable reboot mode driver. This will
+	  get reboot mode arguments and store it in SYSCON mapped
+	  register, then the bootloader can read it to take different
+	  action according to the mode.
+
 endif
 
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 096fa67..a63865b 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -20,3 +20,5 @@ obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
 obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
 obj-$(CONFIG_POWER_RESET_ZX) += zx-reboot.o
+obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
+obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
new file mode 100644
index 0000000..ae6f931
--- /dev/null
+++ b/drivers/power/reset/reboot-mode.c
@@ -0,0 +1,115 @@
+/*
+ * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/reboot.h>
+#include "reboot-mode.h"
+
+#define PREFIX "mode-"
+
+struct mode_info {
+	const char *mode;
+	unsigned int magic;
+	struct list_head list;
+};
+
+struct reboot_mode_driver {
+	struct device *dev;
+	struct list_head head;
+	int (*write)(struct device *dev, int magic);
+	struct notifier_block reboot_notifier;
+};
+
+static int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
+				 const char *cmd)
+{
+	const char *normal = "normal";
+	int magic = 0;
+	struct mode_info *info;
+
+	if (!cmd)
+		cmd = normal;
+
+	list_for_each_entry(info, &reboot->head, list) {
+		if (!strcmp(info->mode, cmd)) {
+			magic = info->magic;
+			break;
+		}
+	}
+
+	return magic;
+}
+
+static int reboot_mode_notify(struct notifier_block *this,
+			      unsigned long mode, void *cmd)
+{
+	struct reboot_mode_driver *reboot;
+	int magic;
+
+	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
+	magic = get_reboot_mode_magic(reboot, cmd);
+	if (magic)
+		reboot->write(reboot->dev, magic);
+
+	return NOTIFY_DONE;
+}
+
+int reboot_mode_register(struct device *dev, int (*write)(struct device *, int))
+{
+	struct reboot_mode_driver *reboot;
+	struct mode_info *info;
+	struct property *prop;
+	struct device_node *np;
+	size_t len = strlen(PREFIX);
+	int ret;
+
+	reboot = devm_kzalloc(dev, sizeof(*reboot), GFP_KERNEL);
+	if (!reboot)
+		return -ENOMEM;
+
+	reboot->dev = dev;
+	reboot->write = write;
+	INIT_LIST_HEAD(&reboot->head);
+
+	np = of_node_get(dev->of_node);
+	for_each_property_of_node(np, prop) {
+		if (len > strlen(prop->name) || strncmp(prop->name, PREFIX, len))
+			continue;
+
+		info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
+
+		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
+		if (of_property_read_u32(np, prop->name, &info->magic)) {
+			dev_err(dev, "reboot mode %s without magic number\n",
+				info->mode);
+			devm_kfree(dev, info);
+			continue;
+		}
+		list_add_tail(&info->list, &reboot->head);
+	}
+	of_node_put(np);
+
+	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
+	ret = register_reboot_notifier(&reboot->reboot_notifier);
+	if (ret)
+		dev_err(dev, "can't register reboot notifier\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(reboot_mode_register);
+
+MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
+MODULE_DESCRIPTION("System reboot mode driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/reset/reboot-mode.h b/drivers/power/reset/reboot-mode.h
new file mode 100644
index 0000000..c861129
--- /dev/null
+++ b/drivers/power/reset/reboot-mode.h
@@ -0,0 +1,6 @@
+#ifndef __REBOOT_MODE_H__
+#define __REBOOT_MODE_H__
+
+int reboot_mode_register(struct device *dev, int (*write)(struct device *, int));
+
+#endif
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
new file mode 100644
index 0000000..f1b8072
--- /dev/null
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -0,0 +1,86 @@
+/*
+ * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include "reboot-mode.h"
+
+struct syscon_reboot_mode {
+	struct device *dev;
+	struct regmap *map;
+	u32 offset;
+	u32 mask;
+};
+
+static int syscon_reboot_mode_write(struct device *dev, int magic)
+{
+	struct syscon_reboot_mode *syscon_rbm = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
+				 syscon_rbm->mask, magic);
+	if (ret < 0)
+		dev_err(dev, "update reboot mode bits failed\n");
+
+	return ret;
+}
+
+static int syscon_reboot_mode_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct syscon_reboot_mode *syscon_rbm;
+
+	syscon_rbm = devm_kzalloc(&pdev->dev, sizeof(*syscon_rbm), GFP_KERNEL);
+	if (!syscon_rbm)
+		return -ENOMEM;
+
+	syscon_rbm->dev = &pdev->dev;
+	syscon_rbm->mask = 0xffffffff;
+
+	syscon_rbm->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(syscon_rbm->map))
+		return PTR_ERR(syscon_rbm->map);
+
+	if (of_property_read_u32(pdev->dev.of_node, "offset", &syscon_rbm->offset))
+		return -EINVAL;
+
+	of_property_read_u32(pdev->dev.of_node, "mask", &syscon_rbm->mask);
+
+	dev_set_drvdata(&pdev->dev, syscon_rbm);
+
+	ret = reboot_mode_register(&pdev->dev, syscon_reboot_mode_write);
+	if (ret)
+		dev_err(&pdev->dev, "can't register reboot mode\n");
+
+	return ret;
+}
+
+static const struct of_device_id syscon_reboot_mode_of_match[] = {
+	{ .compatible = "syscon-reboot-mode" },
+	{}
+};
+
+static struct platform_driver syscon_reboot_mode_driver = {
+	.probe = syscon_reboot_mode_probe,
+	.driver = {
+		.name = "syscon-reboot-mode",
+		.of_match_table = syscon_reboot_mode_of_match,
+	},
+};
+module_platform_driver(syscon_reboot_mode_driver);
+
+MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
+MODULE_DESCRIPTION("SYSCON reboot mode driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1



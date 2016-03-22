From: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v6 2/4] power: reset: add reboot mode driver
Date: Tue, 22 Mar 2016 19:37:22 +0800
Message-ID: <1458646642-591-1-git-send-email-andy.yan@rock-chips.com>
References: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458646525-491-1-git-send-email-andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, mbrugger-IBi9RG/b67k@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This driver parse the reboot commands like "reboot loader"
and "reboot recovery" to get a boot mode described in the
device tree , then call the write interfae to store the boot
mode in some place like special register or sram , which can
be read by the bootloader after system reboot, then the bootloader
can take different action according to the mode stored.

This is commonly used on Android based devices, in order to
reboot the device into fastboot or recovery mode.

Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Tested-by: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

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
 drivers/power/reset/reboot-mode.c        | 106 +++++++++++++++++++++++++++++++
 drivers/power/reset/reboot-mode.h        |   6 ++
 drivers/power/reset/syscon-reboot-mode.c |  65 +++++++++++++++++++
 5 files changed, 192 insertions(+)
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
index 0000000..9aa7b80
--- /dev/null
+++ b/drivers/power/reset/reboot-mode.c
@@ -0,0 +1,106 @@
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
+	char mode[32];
+	unsigned int magic;
+	struct list_head list;
+};
+
+struct reboot_mode_driver {
+	struct list_head head;
+	int (*write)(int magic);
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
+		reboot->write(magic);
+
+	return NOTIFY_DONE;
+}
+
+int reboot_mode_register(struct device *dev, int (*write)(int))
+{
+	struct reboot_mode_driver *reboot;
+	struct mode_info *info;
+	struct property *prop;
+	size_t len = strlen(PREFIX);
+	int ret;
+
+	reboot = devm_kzalloc(dev, sizeof(*reboot), GFP_KERNEL);
+	if (!reboot)
+		return -ENOMEM;
+
+	reboot->write = write;
+	INIT_LIST_HEAD(&reboot->head);
+	for_each_property_of_node(dev->of_node, prop) {
+		if (len > strlen(prop->name) || strncmp(prop->name, PREFIX, len))
+			continue;
+		info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
+		strcpy(info->mode, prop->name + len);
+		if (of_property_read_u32(dev->of_node, prop->name, &info->magic)) {
+			dev_err(dev, "reboot mode %s without magic number\n",
+				info->mode);
+			devm_kfree(dev, info);
+			continue;
+		}
+		list_add_tail(&info->list, &reboot->head);
+	}
+	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
+	ret = register_reboot_notifier(&reboot->reboot_notifier);
+	if (ret)
+		dev_err(dev, "can't register reboot notifier\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(reboot_mode_register);
+
+MODULE_AUTHOR("Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org");
+MODULE_DESCRIPTION("System reboot mode driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/reset/reboot-mode.h b/drivers/power/reset/reboot-mode.h
new file mode 100644
index 0000000..44ed34f
--- /dev/null
+++ b/drivers/power/reset/reboot-mode.h
@@ -0,0 +1,6 @@
+#ifndef __REBOOT_MODE_H__
+#define __REBOOT_MODE_H__
+
+int reboot_mode_register(struct device *dev, int (*write)(int));
+
+#endif
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
new file mode 100644
index 0000000..d1521d8
--- /dev/null
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -0,0 +1,65 @@
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
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include "reboot-mode.h"
+
+static struct regmap *map;
+static u32 offset;
+static u32 mask = 0xffffffff;
+
+static int syscon_reboot_mode_write(int magic)
+{
+	regmap_update_bits(map, offset, mask, magic);
+
+	return 0;
+}
+
+static int syscon_reboot_mode_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	map = syscon_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+	if (of_property_read_u32(pdev->dev.of_node, "offset", &offset))
+		return -EINVAL;
+	of_property_read_u32(pdev->dev.of_node, "mask", &mask);
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
+MODULE_AUTHOR("Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org");
+MODULE_DESCRIPTION("SYSCON reboot mode driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1



--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

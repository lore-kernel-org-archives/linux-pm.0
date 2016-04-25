From: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v8 2/4] power: reset: add reboot mode driver
Date: Mon, 25 Apr 2016 14:55:36 +0800
Message-ID: <1461567336-21834-1-git-send-email-andy.yan@rock-chips.com>
References: <1461567051-21734-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461567051-21734-1-git-send-email-andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This driver parses the reboot commands like "reboot bootloader"
and "reboot recovery" to get a boot mode described in the
device tree , then call the write interfae to store the boot
mode in some place like special register or sram, which can
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

Changes in v8:
- do some cleanup when driver ubind

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
 drivers/power/reset/reboot-mode.c        | 118 +++++++++++++++++++++++++++++++
 drivers/power/reset/reboot-mode.h        |  14 ++++
 drivers/power/reset/syscon-reboot-mode.c |  99 ++++++++++++++++++++++++++
 5 files changed, 246 insertions(+)
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
index 0000000..cdc4d72
--- /dev/null
+++ b/drivers/power/reset/reboot-mode.c
@@ -0,0 +1,118 @@
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
+		reboot->write(reboot, magic);
+
+	return NOTIFY_DONE;
+}
+
+int reboot_mode_register(struct reboot_mode_driver *reboot)
+{
+	struct mode_info *info;
+	struct property *prop;
+	struct device_node *np = reboot->dev->of_node;
+	size_t len = strlen(PREFIX);
+	int ret;
+
+	INIT_LIST_HEAD(&reboot->head);
+
+	for_each_property_of_node(np, prop) {
+		if (len > strlen(prop->name) || strncmp(prop->name, PREFIX, len))
+			continue;
+
+		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
+		if (!info) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
+		if (of_property_read_u32(np, prop->name, &info->magic)) {
+			dev_err(reboot->dev, "reboot mode %s without magic number\n",
+				info->mode);
+			devm_kfree(reboot->dev, info);
+			continue;
+		}
+		list_add_tail(&info->list, &reboot->head);
+	}
+
+	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
+	ret = register_reboot_notifier(&reboot->reboot_notifier);
+	if (ret)
+		dev_err(reboot->dev, "can't register reboot notifier\n");
+
+	return ret;
+
+error:
+	list_for_each_entry(info, &reboot->head, list)
+		kfree_const(info->mode);
+
+	return ret;
+}
+
+int reboot_mode_unregister(struct reboot_mode_driver *reboot)
+{
+	struct mode_info *info;
+
+	unregister_reboot_notifier(&reboot->reboot_notifier);
+
+	list_for_each_entry(info, &reboot->head, list)
+		kfree_const(info->mode);
+
+	return 0;
+}
+
+MODULE_AUTHOR("Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org");
+MODULE_DESCRIPTION("System reboot mode driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/reset/reboot-mode.h b/drivers/power/reset/reboot-mode.h
new file mode 100644
index 0000000..93ab703
--- /dev/null
+++ b/drivers/power/reset/reboot-mode.h
@@ -0,0 +1,14 @@
+#ifndef __REBOOT_MODE_H__
+#define __REBOOT_MODE_H__
+
+struct reboot_mode_driver {
+	struct device *dev;
+	struct list_head head;
+	int (*write)(struct reboot_mode_driver *reboot, int magic);
+	struct notifier_block reboot_notifier;
+};
+
+int reboot_mode_register(struct reboot_mode_driver *reboot);
+int reboot_mode_unregister(struct reboot_mode_driver *reboot);
+
+#endif
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
new file mode 100644
index 0000000..5489dd9
--- /dev/null
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -0,0 +1,99 @@
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
+	struct regmap *map;
+	struct reboot_mode_driver reboot;
+	u32 offset;
+	u32 mask;
+};
+
+static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
+				    int magic)
+{
+	struct syscon_reboot_mode *syscon_rbm;
+	int ret;
+
+	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
+
+	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
+				 syscon_rbm->mask, magic);
+	if (ret < 0)
+		dev_err(reboot->dev, "update reboot mode bits failed\n");
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
+	syscon_rbm->reboot.dev = &pdev->dev;
+	syscon_rbm->reboot.write = syscon_reboot_mode_write;
+	syscon_rbm->mask = 0xffffffff;
+
+	dev_set_drvdata(&pdev->dev, syscon_rbm);
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
+
+	ret = reboot_mode_register(&syscon_rbm->reboot);
+	if (ret)
+		dev_err(&pdev->dev, "can't register reboot mode\n");
+
+	return ret;
+}
+
+static int syscon_reboot_mode_remove(struct platform_device *pdev)
+{
+	struct syscon_reboot_mode *syscon_rbm = dev_get_drvdata(&pdev->dev);
+
+	return reboot_mode_unregister(&syscon_rbm->reboot);
+}
+
+static const struct of_device_id syscon_reboot_mode_of_match[] = {
+	{ .compatible = "syscon-reboot-mode" },
+	{}
+};
+
+static struct platform_driver syscon_reboot_mode_driver = {
+	.probe = syscon_reboot_mode_probe,
+	.remove = syscon_reboot_mode_remove,
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

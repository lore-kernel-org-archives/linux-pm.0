From: Thierry Reding <thierry.reding@gmail.com>
Subject: [RFC 1/3] system-power: Add system power and restart framework
Date: Mon, 30 Jan 2017 18:15:04 +0100
Message-ID: <20170130171506.3527-2-thierry.reding@gmail.com>
References: <20170130171506.3527-1-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170130171506.3527-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

This adds a very simple framework that allows drivers to register system
power and restart controllers. The goal of this framework is to replace
the current notifier based mechanism for restart handlers and the power
off equivalent that is the global pm_power_off() function.

Both of these approaches currently lack any means of locking against
concurrently registering handlers or formal definitions on what proper
priorities are to order handlers.

The system-power framework attempts to remedy this by adding a system
power chip object that drivers can embed in their driver-specific data.
A chip contains a description of capabilities that the framework uses
to determine a good sequence of handlers to use for restart and power
off.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/base/Makefile        |   3 +-
 drivers/base/system-power.c  | 110 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/system-power.h |  38 +++++++++++++++
 3 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/system-power.c
 create mode 100644 include/linux/system-power.h

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index f2816f6ff76a..eef165221d9d 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -4,7 +4,8 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   driver.o class.o platform.o \
 			   cpu.o firmware.o init.o map.o devres.o \
 			   attribute_container.o transport_class.o \
-			   topology.o container.o property.o cacheinfo.o
+			   topology.o container.o property.o cacheinfo.o \
+			   system-power.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
 obj-y			+= power/
diff --git a/drivers/base/system-power.c b/drivers/base/system-power.c
new file mode 100644
index 000000000000..96c0cb457933
--- /dev/null
+++ b/drivers/base/system-power.c
@@ -0,0 +1,110 @@
+/*
+ * Copyright (c) 2017 NVIDIA Corporation
+ *
+ * This file is released under the GPL v2
+ */
+
+#define pr_fmt(fmt) "system-power: " fmt
+
+#include <linux/system-power.h>
+
+static DEFINE_MUTEX(system_power_lock);
+static LIST_HEAD(system_power_chips);
+
+int system_power_chip_add(struct system_power_chip *chip)
+{
+	if (!chip->ops || (!chip->ops->restart && !chip->ops->power_off)) {
+		WARN(1, pr_fmt("must implement restart or power off\n"));
+		return -EINVAL;
+	}
+
+	mutex_lock(&system_power_lock);
+
+	INIT_LIST_HEAD(&chip->list);
+	list_add_tail(&chip->list, &system_power_chips);
+
+	mutex_unlock(&system_power_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(system_power_chip_add);
+
+int system_power_chip_remove(struct system_power_chip *chip)
+{
+	mutex_lock(&system_power_lock);
+
+	list_del_init(&chip->list);
+
+	mutex_unlock(&system_power_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(system_power_chip_remove);
+
+bool system_can_power_off(void)
+{
+	/* XXX for backwards compatibility */
+	return pm_power_off != NULL;
+}
+
+int system_restart(char *cmd)
+{
+	struct system_power_chip *chip;
+	int err;
+
+	mutex_lock(&system_power_lock);
+
+	list_for_each_entry(chip, &system_power_chips, list) {
+		if (!chip->ops->restart)
+			continue;
+
+		pr_debug("trying to restart using %ps\n", chip);
+
+		err = chip->ops->restart(chip, reboot_mode, cmd);
+		if (err < 0)
+			dev_warn(chip->dev, "failed to restart: %d\n", err);
+	}
+
+	mutex_unlock(&system_power_lock);
+
+	/* XXX for backwards compatibility */
+	do_kernel_restart(cmd);
+
+	return 0;
+}
+
+int system_power_off_prepare(void)
+{
+	/* XXX for backwards compatibility */
+	if (pm_power_off_prepare)
+		pm_power_off_prepare();
+
+	return 0;
+}
+
+int system_power_off(void)
+{
+	struct system_power_chip *chip;
+	int err;
+
+	mutex_lock(&system_power_lock);
+
+	list_for_each_entry(chip, &system_power_chips, list) {
+		if (!chip->ops->power_off)
+			continue;
+
+		pr_debug("trying to power off using %ps\n", chip);
+
+		err = chip->ops->power_off(chip);
+		if (err < 0)
+			dev_warn(chip->dev, "failed to power off: %d\n", err);
+	}
+
+	mutex_unlock(&system_power_lock);
+
+	/* XXX for backwards compatibility */
+	if (pm_power_off)
+		pm_power_off();
+
+	return 0;
+}
diff --git a/include/linux/system-power.h b/include/linux/system-power.h
new file mode 100644
index 000000000000..f709c14c1552
--- /dev/null
+++ b/include/linux/system-power.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (c) 2017 NVIDIA Corporation
+ *
+ * This file is released under the GPL v2
+ */
+
+#ifndef SYSTEM_POWER_H
+#define SYSTEM_POWER_H
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/reboot.h>
+
+struct system_power_chip;
+
+struct system_power_ops {
+	int (*restart)(struct system_power_chip *chip, enum reboot_mode mode,
+		       char *cmd);
+	int (*power_off_prepare)(struct system_power_chip *chip);
+	int (*power_off)(struct system_power_chip *chip);
+};
+
+struct system_power_chip {
+	const struct system_power_ops *ops;
+	struct list_head list;
+	struct device *dev;
+};
+
+int system_power_chip_add(struct system_power_chip *chip);
+int system_power_chip_remove(struct system_power_chip *chip);
+
+bool system_can_power_off(void);
+
+int system_restart(char *cmd);
+int system_power_off_prepare(void);
+int system_power_off(void);
+
+#endif
-- 
2.11.0

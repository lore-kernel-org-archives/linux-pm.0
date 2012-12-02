From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 12/34] Thermal: Add a thermal notifier for user space
Date: Sun,  2 Dec 2012 22:44:46 +0800
Message-ID: <1354459508-3707-12-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:33009 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068Ab2LBOpg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:36 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch registers a governor which will let the
user land manage the platform thermals. Whenever a
trip happens, this governor just notifies the user
space using kobj_uevent().

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/Kconfig      |    6 ++++
 drivers/thermal/Makefile     |    1 +
 drivers/thermal/user_space.c |   68 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100644 drivers/thermal/user_space.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 7e1b6de..f679eea 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -67,3 +67,9 @@ config STEP_WISE
 	depends on THERMAL
 	help
 	  Enable this to manage platform thermals using a simple linear
+
+config USER_SPACE
+	bool "User_space thermal governor"
+	depends on THERMAL
+	help
+	  Enable this to let the user space manage the platform thermals.
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 4e53c00..e5f7974 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
 obj-$(CONFIG_EXYNOS_THERMAL)		+= exynos_thermal.o
 obj-$(CONFIG_FAIR_SHARE)		+= fair_share.o
 obj-$(CONFIG_STEP_WISE)			+= step_wise.o
+obj-$(CONFIG_USER_SPACE)		+= user_space.o
diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
new file mode 100644
index 0000000..fb246b90
--- /dev/null
+++ b/drivers/thermal/user_space.c
@@ -0,0 +1,68 @@
+/*
+ *  user_space.c - A simple user space Thermal events notifier
+ *
+ *  Copyright (C) 2012 Intel Corp
+ *  Copyright (C) 2012 Durgadoss R <durgadoss.r@intel.com>
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/thermal.h>
+
+#include "thermal_core.h"
+
+/**
+ * notify_user_space - Notifies user space about thermal events
+ * @tz - thermal_zone_device
+ *
+ * This function notifies the user space through UEvents.
+ */
+int notify_user_space(struct thermal_zone_device *tz, int trip)
+{
+	mutex_lock(&tz->lock);
+	kobject_uevent(&tz->device.kobj, KOBJ_CHANGE);
+	mutex_unlock(&tz->lock);
+	return 0;
+}
+
+struct thermal_governor thermal_gov_user_space = {
+	.name		= "user_space",
+	.throttle	= notify_user_space,
+	.owner		= THIS_MODULE,
+};
+
+static int __init thermal_gov_user_space_init(void)
+{
+	return thermal_register_governor(&thermal_gov_user_space);
+}
+
+static void __exit thermal_gov_user_space_exit(void)
+{
+	thermal_unregister_governor(&thermal_gov_user_space);
+}
+
+/* This should load after thermal framework */
+fs_initcall(thermal_gov_user_space_init);
+module_exit(thermal_gov_user_space_exit);
+
+MODULE_AUTHOR("Durgadoss R");
+MODULE_DESCRIPTION("A user space Thermal notifier");
+MODULE_LICENSE("GPL");
-- 
1.7.7.6


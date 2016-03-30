From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 2/4] cpufreq: dt: Add generic platform-device creation support
Date: Wed, 30 Mar 2016 13:45:26 +0530
Message-ID: <9de0943d865948c7cffae4be3c6cfc8e5b2743ca.1459325515.git.viresh.kumar@linaro.org>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36579 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758143AbcC3IPn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 04:15:43 -0400
Received: by mail-pa0-f54.google.com with SMTP id tt10so34494649pab.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2016 01:15:42 -0700 (PDT)
In-Reply-To: <cover.1459325515.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1459325515.git.viresh.kumar@linaro.org>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, k.kozlowski@samsung.com, linux-kernel@vger.kernel.org

Multiple platforms are using the generic cpufreq-dt driver now, and all
of them are required to create a platform device with name "cpufreq-dt",
in order to get the cpufreq-dt probed.

Many of them do it from platform code, others have special drivers just
to do that.

It would be more sensible to do this at a generic place, where all such
platform can mark their entries.

This patch adds a separate file to get this device created. Currently
the compat list of platforms that we support is empty, and will be
filled in as and when we move platforms to use it.

It always compiles as part of the kernel and so doesn't need a
module-exit operation.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/cpufreq/Kconfig              | 10 ++++++++++
 drivers/cpufreq/Makefile             |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 drivers/cpufreq/cpufreq-dt-platdev.c

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index a7f45853c103..8c26e3c53498 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -191,6 +191,7 @@ config CPUFREQ_DT
 	depends on HAVE_CLK && OF
 	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
 	depends on !CPU_THERMAL || THERMAL
+	select CPUFREQ_DT_PLATDEV
 	select PM_OPP
 	help
 	  This adds a generic DT based cpufreq driver for frequency management.
@@ -199,6 +200,15 @@ config CPUFREQ_DT
 
 	  If in doubt, say N.
 
+config CPUFREQ_DT_PLATDEV
+	bool
+	help
+	  This adds a generic DT based cpufreq platdev driver for frequency
+	  management.  This creates a 'cpufreq-dt' platform device, on the
+	  supported platforms.
+
+	  If in doubt, say N.
+
 if X86
 source "drivers/cpufreq/Kconfig.x86"
 endif
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 9e63fb1b09f8..b9224fdb8322 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
 obj-$(CONFIG_CPU_FREQ_GOV_COMMON)		+= cpufreq_governor.o
 
 obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
+obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 
 ##################################################################################
 # x86 drivers.
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
new file mode 100644
index 000000000000..2a3532427ecf
--- /dev/null
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2016 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+static const struct of_device_id machines[] = {
+};
+
+static int __init cpufreq_dt_platdev_init(void)
+{
+	struct device_node *np = of_find_node_by_path("/");
+
+	if (!np)
+		return -ENODEV;
+
+	if (!of_match_node(machines, np))
+		return -ENODEV;
+
+	of_node_put(of_root);
+
+	return PTR_ERR_OR_ZERO(platform_device_register_simple("cpufreq-dt", -1,
+							       NULL, 0));
+}
+device_initcall(cpufreq_dt_platdev_init);
-- 
2.7.1.410.g6faf27b


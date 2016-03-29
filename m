From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device creation support
Date: Tue, 29 Mar 2016 12:09:48 +0530
Message-ID: <2f2947872d41ecccc393d6ae95eafc72f205e03c.1459233524.git.viresh.kumar@linaro.org>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459233524.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1459233524.git.viresh.kumar@linaro.org>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, k.kozlowski@samsung.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
 drivers/cpufreq/Kconfig              | 11 +++++++++
 drivers/cpufreq/Makefile             |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c | 48 ++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 drivers/cpufreq/cpufreq-dt-platdev.c

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index a7f45853c103..08573d54105b 100644
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
@@ -199,6 +200,16 @@ config CPUFREQ_DT
 
 	  If in doubt, say N.
 
+config CPUFREQ_DT_PLATDEV
+	bool
+	depends on CPUFREQ_DT
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
index 000000000000..18b81724ca0b
--- /dev/null
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2016 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpufreq-dt.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+struct cpufreq_dt_compat {
+	const char *compatible;
+	const void *data;
+	size_t size;
+};
+
+static struct cpufreq_dt_compat compat[] = {
+};
+
+static int __init cpufreq_dt_platdev_init(void)
+{
+	struct platform_device *pdev;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(compat); i++) {
+		if (!of_machine_is_compatible(compat[i].compatible))
+			continue;
+
+		pdev = platform_device_register_data(NULL, "cpufreq-dt", -1,
+						     compat[i].data,
+						     compat[i].size);
+
+		return PTR_ERR_OR_ZERO(pdev);
+	}
+
+	return -ENODEV;
+}
+module_init(cpufreq_dt_platdev_init);
+
+MODULE_ALIAS("cpufreq-dt-platdev");
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
+MODULE_DESCRIPTION("cpufreq-dt platdev driver");
+MODULE_LICENSE("GPL");
-- 
2.7.1.410.g6faf27b

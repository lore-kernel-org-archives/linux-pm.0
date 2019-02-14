From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] cpufreq: davinci: move configuration to include/linux/platform_data
Date: Thu, 14 Feb 2019 18:05:05 +0100
Message-ID: <20190214170505.27251-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The header containing the configuration structure for davinci cpufreq
driver lives in mach-davinci/include/mach/. This is fine for now but
if we want to make davinci part of the multi_v5 build, no code external
to mach-davinci should include machine-specific headers.

Move the configuration structure to include/linux/platform_data.

While we're at it: convert the GPL-2.0 boilerplate to a proper SPDX
license identifier.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c                 |  2 +-
 arch/arm/mach-davinci/include/mach/cpufreq.h  | 26 -------------------
 drivers/cpufreq/davinci-cpufreq.c             |  5 +---
 include/linux/platform_data/davinci-cpufreq.h | 19 ++++++++++++++
 4 files changed, 21 insertions(+), 31 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/cpufreq.h
 create mode 100644 include/linux/platform_data/davinci-cpufreq.h

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e7b78df2bfef..a02ff431ba47 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -21,6 +21,7 @@
 #include <linux/mfd/da8xx-cfgchip.h>
 #include <linux/platform_data/clk-da8xx-cfgchip.h>
 #include <linux/platform_data/clk-davinci-pll.h>
+#include <linux/platform_data/davinci-cpufreq.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -29,7 +30,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/common.h>
-#include <mach/cpufreq.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-davinci/include/mach/cpufreq.h b/arch/arm/mach-davinci/include/mach/cpufreq.h
deleted file mode 100644
index 3c089cfb6cd6..000000000000
--- a/arch/arm/mach-davinci/include/mach/cpufreq.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * TI DaVinci CPUFreq platform support.
- *
- * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef _MACH_DAVINCI_CPUFREQ_H
-#define _MACH_DAVINCI_CPUFREQ_H
-
-#include <linux/cpufreq.h>
-
-struct davinci_cpufreq_config {
-	struct cpufreq_frequency_table *freq_table;
-	int (*set_voltage) (unsigned int index);
-	int (*init) (void);
-};
-
-#endif
diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index d54a27c99121..940fe85db97a 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -23,13 +23,10 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/platform_data/davinci-cpufreq.h>
 #include <linux/platform_device.h>
 #include <linux/export.h>
 
-#include <mach/hardware.h>
-#include <mach/cpufreq.h>
-#include <mach/common.h>
-
 struct davinci_cpufreq {
 	struct device *dev;
 	struct clk *armclk;
diff --git a/include/linux/platform_data/davinci-cpufreq.h b/include/linux/platform_data/davinci-cpufreq.h
new file mode 100644
index 000000000000..3fbf9f2793b5
--- /dev/null
+++ b/include/linux/platform_data/davinci-cpufreq.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TI DaVinci CPUFreq platform support.
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
+ */
+
+#ifndef _MACH_DAVINCI_CPUFREQ_H
+#define _MACH_DAVINCI_CPUFREQ_H
+
+#include <linux/cpufreq.h>
+
+struct davinci_cpufreq_config {
+	struct cpufreq_frequency_table *freq_table;
+	int (*set_voltage)(unsigned int index);
+	int (*init)(void);
+};
+
+#endif /* _MACH_DAVINCI_CPUFREQ_H */
-- 
2.20.1

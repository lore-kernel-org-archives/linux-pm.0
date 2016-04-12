From: Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH V1 1/5] cpufreq: Loongson1: Rename the file to loongson1-cpufreq.c
Date: Tue, 12 Apr 2016 18:40:15 +0800
Message-ID: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34976 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409AbcDLKki (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 06:40:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kelvin Cheung <keguang.zhang@gmail.com>

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch renames the file to loongson1-cpufreq.c,
and also includes some minor updates.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

---
V1:
   Merge the minor updates into this patch.
---
 drivers/cpufreq/Makefile                                |  2 +-
 drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} (96%)

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 9e63fb1..bebe9c8 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -100,7 +100,7 @@ obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
 obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
 obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
-obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= ls1x-cpufreq.o
+obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
 obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
 obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
 obj-$(CONFIG_SPARC_US3_CPUFREQ)		+= sparc-us3-cpufreq.o
diff --git a/drivers/cpufreq/ls1x-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
similarity index 96%
rename from drivers/cpufreq/ls1x-cpufreq.c
rename to drivers/cpufreq/loongson1-cpufreq.c
index 262581b..57fae9b 100644
--- a/drivers/cpufreq/ls1x-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -1,7 +1,7 @@
 /*
  * CPU Frequency Scaling for Loongson 1 SoC
  *
- * Copyright (C) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (C) 2014-2016 Zhang, Keguang <keguang.zhang@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -208,15 +208,15 @@ out:
 }
 
 static struct platform_driver ls1x_cpufreq_platdrv = {
-	.driver = {
+	.probe	= ls1x_cpufreq_probe,
+	.remove	= ls1x_cpufreq_remove,
+	.driver	= {
 		.name	= "ls1x-cpufreq",
 	},
-	.probe		= ls1x_cpufreq_probe,
-	.remove		= ls1x_cpufreq_remove,
 };
 
 module_platform_driver(ls1x_cpufreq_platdrv);
 
 MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
-MODULE_DESCRIPTION("Loongson 1 CPUFreq driver");
+MODULE_DESCRIPTION("Loongson1 CPUFreq driver");
 MODULE_LICENSE("GPL");
-- 
1.9.1


From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 5/9] ARM: STi: Register CPUFreq device
Date: Wed, 24 Jun 2015 14:59:04 +0100
Message-ID: <1435154348-28840-6-git-send-email-lee.jones@linaro.org>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:34296 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbbFXN7Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2015 09:59:25 -0400
Received: by wgqq4 with SMTP id q4so37160952wgq.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2015 06:59:24 -0700 (PDT)
In-Reply-To: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

DT will not allow pseudo-devices.  Only devices which represent real
hardware are permitted.  So we have to register the CPUFreq driver
from platform code instead.

Rather than create a new file, we're bundling this in with the SMP
functionality and renaming it from 'smp' to the more generic 'cpu'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-sti/Makefile             |  2 +-
 arch/arm/mach-sti/board-dt.c           |  3 ++-
 arch/arm/mach-sti/{platsmp.c => cpu.c} | 17 +++++++++++++++--
 arch/arm/mach-sti/{smp.h => cpu.h}     |  2 ++
 4 files changed, 20 insertions(+), 4 deletions(-)
 rename arch/arm/mach-sti/{platsmp.c => cpu.c} (91%)
 rename arch/arm/mach-sti/{smp.h => cpu.h} (92%)

diff --git a/arch/arm/mach-sti/Makefile b/arch/arm/mach-sti/Makefile
index acb3309..caaeeaa 100644
--- a/arch/arm/mach-sti/Makefile
+++ b/arch/arm/mach-sti/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+obj-$(CONFIG_SMP)		+= cpu.o headsmp.o
 obj-$(CONFIG_ARCH_STI) 		+= board-dt.o
diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index b373aca..482159f 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -12,7 +12,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 
-#include "smp.h"
+#include "cpu.h"
 
 static const char *stih41x_dt_match[] __initdata = {
 	"st,stih415",
@@ -31,4 +31,5 @@ DT_MACHINE_START(STM, "STiH415/416 SoC with Flattened Device Tree")
 			  L2C_AUX_CTRL_WAY_SIZE(4),
 	.l2c_aux_mask	= 0xc0000fff,
 	.smp		= smp_ops(sti_smp_ops),
+	.init_late	= init_cpufreq,
 MACHINE_END
diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/cpu.c
similarity index 91%
rename from arch/arm/mach-sti/platsmp.c
rename to arch/arm/mach-sti/cpu.c
index d4b624f..283cb30 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/cpu.c
@@ -1,5 +1,5 @@
 /*
- *  arch/arm/mach-sti/platsmp.c
+ * arch/arm/mach-sti/cpu.c
  *
  * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
  *		http://www.st.com
@@ -13,6 +13,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
@@ -20,13 +21,17 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
-#include "smp.h"
+#include "cpu.h"
 
+/**
+ * SMP Operations
+ */
 static void write_pen_release(int val)
 {
 	pen_release = val;
@@ -114,3 +119,11 @@ struct smp_operations __initdata sti_smp_ops = {
 	.smp_secondary_init	= sti_secondary_init,
 	.smp_boot_secondary	= sti_boot_secondary,
 };
+
+/**
+ * CPUFreq Registration
+ */
+void init_cpufreq(void)
+{
+	platform_device_register_simple("sti-cpufreq", -1, NULL, 0);
+}
diff --git a/arch/arm/mach-sti/smp.h b/arch/arm/mach-sti/cpu.h
similarity index 92%
rename from arch/arm/mach-sti/smp.h
rename to arch/arm/mach-sti/cpu.h
index 1871b72..39e05ff 100644
--- a/arch/arm/mach-sti/smp.h
+++ b/arch/arm/mach-sti/cpu.h
@@ -14,4 +14,6 @@
 
 extern struct smp_operations	sti_smp_ops;
 
+extern void init_cpufreq(void);
+
 #endif
-- 
1.9.1


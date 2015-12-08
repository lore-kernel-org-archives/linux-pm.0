From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v5 08/11] ARM: STi: Register CPUFreq device
Date: Tue,  8 Dec 2015 14:32:01 +0000
Message-ID: <1449585124-15596-9-git-send-email-lee.jones@linaro.org>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

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
 arch/arm/mach-sti/{smp.h => cpu.h}     |  1 +
 4 files changed, 19 insertions(+), 4 deletions(-)
 rename arch/arm/mach-sti/{platsmp.c => cpu.c} (93%)
 rename arch/arm/mach-sti/{smp.h => cpu.h} (93%)

diff --git a/arch/arm/mach-sti/Makefile b/arch/arm/mach-sti/Makefile
index acb3309..caaeeaa 100644
--- a/arch/arm/mach-sti/Makefile
+++ b/arch/arm/mach-sti/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+obj-$(CONFIG_SMP)		+= cpu.o headsmp.o
 obj-$(CONFIG_ARCH_STI) 		+= board-dt.o
diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index ae10fb2..60b23a7 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -12,7 +12,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 
-#include "smp.h"
+#include "cpu.h"
 
 static const char *const stih41x_dt_match[] __initconst = {
 	"st,stih415",
@@ -31,4 +31,5 @@ DT_MACHINE_START(STM, "STiH415/416 SoC with Flattened Device Tree")
 			  L2C_AUX_CTRL_WAY_SIZE(4),
 	.l2c_aux_mask	= 0xc0000fff,
 	.smp		= smp_ops(sti_smp_ops),
+	.init_late	= init_cpufreq,
 MACHINE_END
diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/cpu.c
similarity index 93%
rename from arch/arm/mach-sti/platsmp.c
rename to arch/arm/mach-sti/cpu.c
index c4ad6ea..335ecaf 100644
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
@@ -21,13 +22,17 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/memblock.h>
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
@@ -161,3 +166,11 @@ struct smp_operations __initdata sti_smp_ops = {
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
similarity index 93%
rename from arch/arm/mach-sti/smp.h
rename to arch/arm/mach-sti/cpu.h
index ae22707..957c4d1 100644
--- a/arch/arm/mach-sti/smp.h
+++ b/arch/arm/mach-sti/cpu.h
@@ -15,5 +15,6 @@
 extern struct smp_operations	sti_smp_ops;
 
 void sti_secondary_startup(void);
+extern void init_cpufreq(void);
 
 #endif
-- 
1.9.1

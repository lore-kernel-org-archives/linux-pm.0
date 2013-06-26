From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/8] ARM: at91: move cpuidle driver to drivers/cpuidle/
Date: Wed, 26 Jun 2013 12:15:40 +0200
Message-ID: <1372241747-21083-2-git-send-email-b.zolnierkie@samsung.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:40694 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab3FZKQU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 06:16:20 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MOZ00F57WJ7O801@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 26 Jun 2013 19:16:19 +0900 (KST)
In-reply-to: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, nsekhar@ti.com, khilman@deeprootsystems.com, kernel@pengutronix.de, shawn.guo@linaro.org, tony@atomide.com, ben-linux@fluff.org, kgene.kim@samsung.com, horms@verge.net.au, magnus.damm@gmail.com, swarren@wwwdotorg.org, srinidhi.kasagar@stericsson.com, linus.walleij@linaro.org, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com, b.zolnierkie@samsung.com

Compile tested only.

Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-at91/Makefile    |  1 -
 arch/arm/mach-at91/cpuidle.c   | 68 ------------------------------------------
 drivers/cpuidle/Makefile       |  3 ++
 drivers/cpuidle/cpuidle-at91.c | 68 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 69 deletions(-)
 delete mode 100644 arch/arm/mach-at91/cpuidle.c
 create mode 100644 drivers/cpuidle/cpuidle-at91.c

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 3b0a953..c1b7370 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -98,7 +98,6 @@ obj-y				+= leds.o
 # Power Management
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_AT91_SLOW_CLOCK)	+= pm_slowclock.o
-obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
 
 ifeq ($(CONFIG_PM_DEBUG),y)
 CFLAGS_pm.o += -DDEBUG
diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
deleted file mode 100644
index 69f9e3b..0000000
--- a/arch/arm/mach-at91/cpuidle.c
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- * based on arch/arm/mach-kirkwood/cpuidle.c
- *
- * CPU idle support for AT91 SoC
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
- * The cpu idle uses wait-for-interrupt and RAM self refresh in order
- * to implement two idle states -
- * #1 wait-for-interrupt
- * #2 wait-for-interrupt and RAM self refresh
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/cpuidle.h>
-#include <linux/io.h>
-#include <linux/export.h>
-#include <asm/proc-fns.h>
-#include <asm/cpuidle.h>
-#include <mach/cpu.h>
-
-#include "pm.h"
-
-#define AT91_MAX_STATES	2
-
-/* Actual code that puts the SoC in different idle states */
-static int at91_enter_idle(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-			       int index)
-{
-	if (cpu_is_at91rm9200())
-		at91rm9200_standby();
-	else if (cpu_is_at91sam9g45())
-		at91sam9g45_standby();
-	else if (cpu_is_at91sam9263())
-		at91sam9263_standby();
-	else
-		at91sam9_standby();
-
-	return index;
-}
-
-static struct cpuidle_driver at91_idle_driver = {
-	.name			= "at91_idle",
-	.owner			= THIS_MODULE,
-	.states[0]		= ARM_CPUIDLE_WFI_STATE,
-	.states[1]		= {
-		.enter			= at91_enter_idle,
-		.exit_latency		= 10,
-		.target_residency	= 100000,
-		.flags			= CPUIDLE_FLAG_TIME_VALID,
-		.name			= "RAM_SR",
-		.desc			= "WFI and DDR Self Refresh",
-	},
-	.state_count = AT91_MAX_STATES,
-};
-
-/* Initialize CPU idle by registering the idle states */
-static int __init at91_init_cpuidle(void)
-{
-	return cpuidle_register(&at91_idle_driver, NULL);
-}
-
-device_initcall(at91_init_cpuidle);
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 8767a7b..9dd4091 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -5,6 +5,9 @@
 obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
+ifeq ($(CONFIG_ARCH_AT91),y)
+	obj-y += cpuidle-at91.o
+endif
 obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
 obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
 obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
diff --git a/drivers/cpuidle/cpuidle-at91.c b/drivers/cpuidle/cpuidle-at91.c
new file mode 100644
index 0000000..2545218
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-at91.c
@@ -0,0 +1,68 @@
+/*
+ * based on arch/arm/mach-kirkwood/cpuidle.c
+ *
+ * CPU idle support for AT91 SoC
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * The cpu idle uses wait-for-interrupt and RAM self refresh in order
+ * to implement two idle states -
+ * #1 wait-for-interrupt
+ * #2 wait-for-interrupt and RAM self refresh
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/cpuidle.h>
+#include <linux/io.h>
+#include <linux/export.h>
+#include <asm/proc-fns.h>
+#include <asm/cpuidle.h>
+#include <mach/cpu.h>
+
+#include "../../arch/arm/mach-at91/pm.h"
+
+#define AT91_MAX_STATES	2
+
+/* Actual code that puts the SoC in different idle states */
+static int at91_enter_idle(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			       int index)
+{
+	if (cpu_is_at91rm9200())
+		at91rm9200_standby();
+	else if (cpu_is_at91sam9g45())
+		at91sam9g45_standby();
+	else if (cpu_is_at91sam9263())
+		at91sam9263_standby();
+	else
+		at91sam9_standby();
+
+	return index;
+}
+
+static struct cpuidle_driver at91_idle_driver = {
+	.name			= "at91_idle",
+	.owner			= THIS_MODULE,
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[1]		= {
+		.enter			= at91_enter_idle,
+		.exit_latency		= 10,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "RAM_SR",
+		.desc			= "WFI and DDR Self Refresh",
+	},
+	.state_count = AT91_MAX_STATES,
+};
+
+/* Initialize CPU idle by registering the idle states */
+static int __init at91_init_cpuidle(void)
+{
+	return cpuidle_register(&at91_idle_driver, NULL);
+}
+
+device_initcall(at91_init_cpuidle);
-- 
1.8.2.3


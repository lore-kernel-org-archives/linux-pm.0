From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 6/8] ARM: shmobile: move cpuidle driver to drivers/cpuidle/
Date: Wed, 26 Jun 2013 12:15:45 +0200
Message-ID: <1372241747-21083-7-git-send-email-b.zolnierkie@samsung.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:15485 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab3FZKQ4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 06:16:56 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MOZ00KSZWK7BDW0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 26 Jun 2013 19:16:55 +0900 (KST)
In-reply-to: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, nsekhar@ti.com, khilman@deeprootsystems.com, kernel@pengutronix.de, shawn.guo@linaro.org, tony@atomide.com, ben-linux@fluff.org, kgene.kim@samsung.com, horms@verge.net.au, magnus.damm@gmail.com, swarren@wwwdotorg.org, srinidhi.kasagar@stericsson.com, linus.walleij@linaro.org, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com, b.zolnierkie@samsung.com

While at it:
- replace <asm/io.h> by <linux/io.h> one

Compile tested only.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-shmobile/Makefile    |  1 -
 arch/arm/mach-shmobile/cpuidle.c   | 37 -------------------------------------
 drivers/cpuidle/Makefile           |  3 +++
 drivers/cpuidle/cpuidle-shmobile.c | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/cpuidle.c
 create mode 100644 drivers/cpuidle/cpuidle-shmobile.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 6165a51..cc84ef2 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -27,7 +27,6 @@ obj-$(CONFIG_ARCH_R8A7740)	+= entry-intc.o
 
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ARCH_SHMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o
diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
deleted file mode 100644
index 0afeb5c..0000000
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * CPUIdle support code for SH-Mobile ARM
- *
- *  Copyright (C) 2011 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/pm.h>
-#include <linux/cpuidle.h>
-#include <linux/suspend.h>
-#include <linux/module.h>
-#include <linux/err.h>
-#include <asm/cpuidle.h>
-#include <asm/io.h>
-
-static struct cpuidle_driver shmobile_cpuidle_default_driver = {
-	.name			= "shmobile_cpuidle",
-	.owner			= THIS_MODULE,
-	.states[0]		= ARM_CPUIDLE_WFI_STATE,
-	.safe_state_index	= 0, /* C1 */
-	.state_count		= 1,
-};
-
-static struct cpuidle_driver *cpuidle_drv = &shmobile_cpuidle_default_driver;
-
-void __init shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
-{
-	cpuidle_drv = drv;
-}
-
-int __init shmobile_cpuidle_init(void)
-{
-	return cpuidle_register(cpuidle_drv, NULL);
-}
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index eed221e..758d0d9 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -34,4 +34,7 @@ endif
 ifeq ($(CONFIG_ARCH_S3C64XX),y)
 	obj-y += cpuidle-s3c64xx.o
 endif
+ifeq ($(CONFIG_ARCH_SHMOBILE),y)
+	obj-y += cpuidle-shmobile.o
+endif
 obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
diff --git a/drivers/cpuidle/cpuidle-shmobile.c b/drivers/cpuidle/cpuidle-shmobile.c
new file mode 100644
index 0000000..5cea47e
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-shmobile.c
@@ -0,0 +1,37 @@
+/*
+ * CPUIdle support code for SH-Mobile ARM
+ *
+ *  Copyright (C) 2011 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/pm.h>
+#include <linux/cpuidle.h>
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <asm/cpuidle.h>
+
+static struct cpuidle_driver shmobile_cpuidle_default_driver = {
+	.name			= "shmobile_cpuidle",
+	.owner			= THIS_MODULE,
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.safe_state_index	= 0, /* C1 */
+	.state_count		= 1,
+};
+
+static struct cpuidle_driver *cpuidle_drv = &shmobile_cpuidle_default_driver;
+
+void __init shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
+{
+	cpuidle_drv = drv;
+}
+
+int __init shmobile_cpuidle_init(void)
+{
+	return cpuidle_register(cpuidle_drv, NULL);
+}
-- 
1.8.2.3


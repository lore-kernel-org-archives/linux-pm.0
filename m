From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [PATCH 3/6] cpuidle: shmobile: Add CPUIdle driver
Date: Fri, 1 Aug 2014 18:48:37 +0900
Message-ID: <53DB6275.1010707@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
Cc: horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

Add the wfi and Core-Standby for CPUIdle power states support for
the shmobile SoCs.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 drivers/cpuidle/Kconfig.arm        |    6 +++
 drivers/cpuidle/Makefile           |    1 +
 drivers/cpuidle/cpuidle-shmobile.c |   71 ++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-shmobile.c

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index b6d69e8..2908cd0 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -61,3 +61,9 @@ config ARM_EXYNOS_CPUIDLE
 	depends on ARCH_EXYNOS
 	help
 	  Select this to enable cpuidle for Exynos processors
+
+config ARM_SHMOBILE_CPUIDLE
+	bool "Cpu Idle Driver for the shmobile SoCs"
+	depends on ARCH_SHMOBILE_MULTI
+	help
+	  Select this to enable cpuidle for shmobile SoCs
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index d8bb1ff..0d24054 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
+obj-$(CONFIG_ARM_SHMOBILE_CPUIDLE)      += cpuidle-shmobile.o

 ###############################################################################
 # MIPS drivers
diff --git a/drivers/cpuidle/cpuidle-shmobile.c b/drivers/cpuidle/cpuidle-shmobile.c
new file mode 100644
index 0000000..538c4ec
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-shmobile.c
@@ -0,0 +1,71 @@
+/*
+ * CPUIdle support code for SH-Mobile ARM
+ *
+ *  Copyright (C) 2014 Renesas Electronics Corporation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/suspend.h>
+
+#include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
+
+static void (*shmobile_enter_corestandby)(void);
+
+int shmobile_enter_cpuidle(struct cpuidle_device *dev,
+			   struct cpuidle_driver *drv,
+			   int index)
+{
+	shmobile_enter_corestandby();
+	return index;
+}
+
+static struct cpuidle_driver renesas_cpuidle_driver = {
+	.name = "shmobile_cpuidle",
+	.owner = THIS_MODULE,
+	.states = {
+		ARM_CPUIDLE_WFI_STATE,
+		{
+			.name			= "C1",
+			.desc			= "Core Standby Mode",
+			.exit_latency		= 500,
+			.target_residency	= 100000,
+			.flags			= CPUIDLE_FLAG_TIME_VALID,
+			.enter			= shmobile_enter_cpuidle,
+		},
+	},
+	.state_count = 2,
+};
+
+static int shmobile_cpuidle_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	shmobile_enter_corestandby = (void *)(pdev->dev.platform_data);
+
+	ret = cpuidle_register(&renesas_cpuidle_driver, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver shmobile_cpuidle_driver = {
+	.probe	= shmobile_cpuidle_probe,
+	.driver	= {
+		.name = "cpuidle-shmobile",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(shmobile_cpuidle_driver);
-- 
1.7.9.5

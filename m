From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] cpufreq: arm_big_little: remove compile-time dependency on BL_SWITCHER
Date: Mon, 11 May 2015 12:24:33 +0100
Message-ID: <1431343473-9915-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Jon Medhurst <tixy@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

With the addition of switcher code, there's compile-time dependency on
BL_SWITCHER to get arm_big_little driver compiling on ARM64. Since ARM64
will never add support for BL_SWITCHER, it's better to remove the
dependency so that the driver can be reused on ARM64 platforms.

This patch adds stubs to remove BL_SWITCHER dependency in the driver.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/Kconfig.arm      |  2 +-
 drivers/cpufreq/arm_big_little.c | 27 ++++++++++++++++++++++-----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index d38f1ce95087..39520a61ea6f 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -5,7 +5,7 @@
 # big LITTLE core layer and glue drivers
 config ARM_BIG_LITTLE_CPUFREQ
 	tristate "Generic ARM big LITTLE CPUfreq driver"
-	depends on ARM && BIG_LITTLE && ARM_CPU_TOPOLOGY && HAVE_CLK
+	depends on (ARM_CPU_TOPOLOGY || ARM64) && HAVE_CLK
 	select PM_OPP
 	help
 	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index e4d75ca9f3b0..f1e42f8ce0fc 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -31,7 +31,6 @@
 #include <linux/slab.h>
 #include <linux/topology.h>
 #include <linux/types.h>
-#include <asm/bL_switcher.h>

 #include "arm_big_little.h"

@@ -41,12 +40,16 @@
 #define MAX_CLUSTERS	2

 #ifdef CONFIG_BL_SWITCHER
+#include <asm/bL_switcher.h>
 static bool bL_switching_enabled;
 #define is_bL_switching_enabled()	bL_switching_enabled
 #define set_switching_enabled(x)	(bL_switching_enabled = (x))
 #else
 #define is_bL_switching_enabled()	false
 #define set_switching_enabled(x)	do { } while (0)
+#define bL_switch_request(...)		do { } while (0)
+#define bL_switcher_put_enabled()	do { } while (0)
+#define bL_switcher_get_enabled()	do { } while (0)
 #endif

 #define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
@@ -513,6 +516,7 @@ static struct cpufreq_driver bL_cpufreq_driver = {
 	.attr			= cpufreq_generic_attr,
 };

+#ifdef CONFIG_BL_SWITCHER
 static int bL_cpufreq_switcher_notifier(struct notifier_block *nfb,
 					unsigned long action, void *_arg)
 {
@@ -545,6 +549,20 @@ static struct notifier_block bL_switcher_notifier = {
 	.notifier_call = bL_cpufreq_switcher_notifier,
 };

+static int __bLs_register_notifier(void)
+{
+	return bL_switcher_register_notifier(&bL_switcher_notifier);
+}
+
+static int __bLs_unregister_notifier(void)
+{
+	return bL_switcher_unregister_notifier(&bL_switcher_notifier);
+}
+#else
+static int __bLs_register_notifier(void) { return 0; }
+static int __bLs_unregister_notifier(void) { return 0; }
+#endif
+
 int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
 {
 	int ret, i;
@@ -562,8 +580,7 @@ int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)

 	arm_bL_ops = ops;

-	ret = bL_switcher_get_enabled();
-	set_switching_enabled(ret);
+	set_switching_enabled(bL_switcher_get_enabled());

 	for (i = 0; i < MAX_CLUSTERS; i++)
 		mutex_init(&cluster_lock[i]);
@@ -574,7 +591,7 @@ int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
 				__func__, ops->name, ret);
 		arm_bL_ops = NULL;
 	} else {
-		ret = bL_switcher_register_notifier(&bL_switcher_notifier);
+		ret = __bLs_register_notifier();
 		if (ret) {
 			cpufreq_unregister_driver(&bL_cpufreq_driver);
 			arm_bL_ops = NULL;
@@ -598,7 +615,7 @@ void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops)
 	}

 	bL_switcher_get_enabled();
-	bL_switcher_unregister_notifier(&bL_switcher_notifier);
+	__bLs_unregister_notifier();
 	cpufreq_unregister_driver(&bL_cpufreq_driver);
 	bL_switcher_put_enabled();
 	pr_info("%s: Un-registered platform driver: %s\n", __func__,
--
1.9.1

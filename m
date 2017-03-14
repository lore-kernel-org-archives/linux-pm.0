From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: dbx500: Manage cooling device from cpufreq driver
Date: Tue, 14 Mar 2017 10:48:31 +0530
Message-ID: <99cc71f22d0470cb164b0fa05e07a863265bf922.1489468688.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34992 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdCNFVh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2017 01:21:37 -0400
Received: by mail-pg0-f41.google.com with SMTP id b129so79176577pgc.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2017 22:21:36 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

The best place to register the CPU cooling device is from the cpufreq
driver as we would know if all the resources are already available or
not. That's what is done for the cpufreq-dt.c driver as well.

The cpu-cooling driver for dbx500 platform was just (un)registering
with the thermal framework and that can be handled easily by the cpufreq
driver as well and in proper sequence as well.

Get rid of the cooling driver and its its users and manage everything
from the cpufreq driver instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Only compile tested.

 arch/arm/boot/dts/ste-dbx5x0.dtsi        |   5 --
 drivers/cpufreq/dbx500-cpufreq.c         |  20 ++++++
 drivers/thermal/Kconfig                  |  12 ----
 drivers/thermal/Makefile                 |   1 -
 drivers/thermal/db8500_cpufreq_cooling.c | 105 -------------------------------
 5 files changed, 20 insertions(+), 123 deletions(-)
 delete mode 100644 drivers/thermal/db8500_cpufreq_cooling.c

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 82d8c4771293..9eea52013914 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -1170,11 +1170,6 @@
 			status = "disabled";
 		};
 
-		cpufreq-cooling {
-			compatible = "stericsson,db8500-cpufreq-cooling";
-			status = "disabled";
-		};
-
 		mcde@a0350000 {
 			compatible = "stericsson,mcde";
 			reg = <0xa0350000 0x1000>, /* MCDE */
diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 5c3ec1dd4921..3575b82210ba 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu_cooling.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
@@ -18,6 +19,7 @@
 
 static struct cpufreq_frequency_table *freq_table;
 static struct clk *armss_clk;
+static struct thermal_cooling_device *cdev;
 
 static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
 				unsigned int index)
@@ -32,6 +34,22 @@ static int dbx500_cpufreq_init(struct cpufreq_policy *policy)
 	return cpufreq_generic_init(policy, freq_table, 20 * 1000);
 }
 
+static int dbx500_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	if (!IS_ERR(cdev))
+		cpufreq_cooling_unregister(cdev);
+	return 0;
+}
+
+static void dbx500_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	cdev = cpufreq_cooling_register(policy->cpus);
+	if (IS_ERR(cdev))
+		pr_err("Failed to register cooling device %ld\n", PTR_ERR(cdev));
+	else
+		pr_info("Cooling device registered: %s\n", cdev->type);
+}
+
 static struct cpufreq_driver dbx500_cpufreq_driver = {
 	.flags  = CPUFREQ_STICKY | CPUFREQ_CONST_LOOPS |
 			CPUFREQ_NEED_INITIAL_FREQ_CHECK,
@@ -39,6 +57,8 @@ static struct cpufreq_driver dbx500_cpufreq_driver = {
 	.target_index = dbx500_cpufreq_target,
 	.get    = cpufreq_generic_get,
 	.init   = dbx500_cpufreq_init,
+	.exit  = dbx500_cpufreq_exit,
+	.ready  = dbx500_cpufreq_ready,
 	.name   = "DBX500",
 	.attr   = cpufreq_generic_attr,
 };
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 776b34396144..0a16cf4bed39 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -291,18 +291,6 @@ config ARMADA_THERMAL
 	  Enable this option if you want to have support for thermal management
 	  controller present in Armada 370 and Armada XP SoC.
 
-config DB8500_CPUFREQ_COOLING
-	tristate "DB8500 cpufreq cooling"
-	depends on ARCH_U8500 || COMPILE_TEST
-	depends on HAS_IOMEM
-	depends on CPU_THERMAL
-	default y
-	help
-	  Adds DB8500 cpufreq cooling devices, and these cooling devices can be
-	  bound to thermal zone trip points. When a trip point reached, the
-	  bound cpufreq cooling device turns active to set CPU frequency low to
-	  cool down the CPU.
-
 config INTEL_POWERCLAMP
 	tristate "Intel PowerClamp idle injection driver"
 	depends on THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 7adae2029355..c2372f10dae5 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -41,7 +41,6 @@ obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
-obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+= db8500_cpufreq_cooling.o
 obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
 obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+= x86_pkg_temp_thermal.o
 obj-$(CONFIG_INTEL_SOC_DTS_IOSF_CORE)	+= intel_soc_dts_iosf.o
diff --git a/drivers/thermal/db8500_cpufreq_cooling.c b/drivers/thermal/db8500_cpufreq_cooling.c
deleted file mode 100644
index e58bd0b658b5..000000000000
--- a/drivers/thermal/db8500_cpufreq_cooling.c
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- * db8500_cpufreq_cooling.c - DB8500 cpufreq works as cooling device.
- *
- * Copyright (C) 2012 ST-Ericsson
- * Copyright (C) 2012 Linaro Ltd.
- *
- * Author: Hongbo Zhang <hongbo.zhang@linaro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/cpu_cooling.h>
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-
-static int db8500_cpufreq_cooling_probe(struct platform_device *pdev)
-{
-	struct thermal_cooling_device *cdev;
-
-	cdev = cpufreq_cooling_register(cpu_present_mask);
-	if (IS_ERR(cdev)) {
-		int ret = PTR_ERR(cdev);
-
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"Failed to register cooling device %d\n",
-				ret);
-				
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, cdev);
-
-	dev_info(&pdev->dev, "Cooling device registered: %s\n",	cdev->type);
-
-	return 0;
-}
-
-static int db8500_cpufreq_cooling_remove(struct platform_device *pdev)
-{
-	struct thermal_cooling_device *cdev = platform_get_drvdata(pdev);
-
-	cpufreq_cooling_unregister(cdev);
-
-	return 0;
-}
-
-static int db8500_cpufreq_cooling_suspend(struct platform_device *pdev,
-		pm_message_t state)
-{
-	return -ENOSYS;
-}
-
-static int db8500_cpufreq_cooling_resume(struct platform_device *pdev)
-{
-	return -ENOSYS;
-}
-
-#ifdef CONFIG_OF
-static const struct of_device_id db8500_cpufreq_cooling_match[] = {
-	{ .compatible = "stericsson,db8500-cpufreq-cooling" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, db8500_cpufreq_cooling_match);
-#endif
-
-static struct platform_driver db8500_cpufreq_cooling_driver = {
-	.driver = {
-		.name = "db8500-cpufreq-cooling",
-		.of_match_table = of_match_ptr(db8500_cpufreq_cooling_match),
-	},
-	.probe = db8500_cpufreq_cooling_probe,
-	.suspend = db8500_cpufreq_cooling_suspend,
-	.resume = db8500_cpufreq_cooling_resume,
-	.remove = db8500_cpufreq_cooling_remove,
-};
-
-static int __init db8500_cpufreq_cooling_init(void)
-{
-	return platform_driver_register(&db8500_cpufreq_cooling_driver);
-}
-
-static void __exit db8500_cpufreq_cooling_exit(void)
-{
-	platform_driver_unregister(&db8500_cpufreq_cooling_driver);
-}
-
-/* Should be later than db8500_cpufreq_register */
-late_initcall(db8500_cpufreq_cooling_init);
-module_exit(db8500_cpufreq_cooling_exit);
-
-MODULE_AUTHOR("Hongbo Zhang <hongbo.zhang@stericsson.com>");
-MODULE_DESCRIPTION("DB8500 cpufreq cooling driver");
-MODULE_LICENSE("GPL");
-- 
2.7.1.410.g6faf27b

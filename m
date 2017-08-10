From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/4] cpufreq: dbx500: Delete obsolete driver
Date: Thu, 10 Aug 2017 14:52:21 +0200
Message-ID: <20170810125221.25818-5-linus.walleij@linaro.org>
References: <20170810125221.25818-1-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36608 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdHJMwr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2017 08:52:47 -0400
Received: by mail-lf0-f52.google.com with SMTP id o85so3008103lff.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2017 05:52:47 -0700 (PDT)
In-Reply-To: <20170810125221.25818-1-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

We have moved the Ux500 over to use the generic DT based
cpufreq driver, so delete the old custom driver.

At the same time select CPUFREQ_DT from the machine's
Kconfig in order to satisfy the "default ARCH_U8500"
selection on the old driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Kconfig      |   1 +
 drivers/cpufreq/Kconfig.arm      |   9 ----
 drivers/cpufreq/Makefile         |   1 -
 drivers/cpufreq/dbx500-cpufreq.c | 103 ---------------------------------------
 4 files changed, 1 insertion(+), 113 deletions(-)
 delete mode 100644 drivers/cpufreq/dbx500-cpufreq.c

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 4740ac393297..2b56e4af5a27 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -9,6 +9,7 @@ menuconfig ARCH_U8500
 	select ARM_GIC
 	select CACHE_L2X0
 	select CLKSRC_NOMADIK_MTU
+	select CPUFREQ_DT
 	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 2011fec2d6ad..74ed7e9a7f27 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -71,15 +71,6 @@ config ARM_HIGHBANK_CPUFREQ
 
 	  If in doubt, say N.
 
-config ARM_DB8500_CPUFREQ
-	tristate "ST-Ericsson DB8500 cpufreq" if COMPILE_TEST && !ARCH_U8500
-	default ARCH_U8500
-	depends on HAS_IOMEM
-	depends on !CPU_THERMAL || THERMAL
-	help
-	  This adds the CPUFreq driver for ST-Ericsson Ux500 (DB8500) SoC
-	  series.
-
 config ARM_IMX6Q_CPUFREQ
 	tristate "Freescale i.MX6 cpufreq support"
 	depends on ARCH_MXC
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index ab3a42cd29ef..a07c6efe4910 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -53,7 +53,6 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 
 obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
-obj-$(CONFIG_ARM_DB8500_CPUFREQ)	+= dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
deleted file mode 100644
index 4ee0431579c1..000000000000
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- * Copyright (C) STMicroelectronics 2009
- * Copyright (C) ST-Ericsson SA 2010-2012
- *
- * License Terms: GNU General Public License v2
- * Author: Sundar Iyer <sundar.iyer@stericsson.com>
- * Author: Martin Persson <martin.persson@stericsson.com>
- * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/cpufreq.h>
-#include <linux/cpu_cooling.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-
-static struct cpufreq_frequency_table *freq_table;
-static struct clk *armss_clk;
-static struct thermal_cooling_device *cdev;
-
-static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
-				unsigned int index)
-{
-	/* update armss clk frequency */
-	return clk_set_rate(armss_clk, freq_table[index].frequency * 1000);
-}
-
-static int dbx500_cpufreq_init(struct cpufreq_policy *policy)
-{
-	policy->clk = armss_clk;
-	return cpufreq_generic_init(policy, freq_table, 20 * 1000);
-}
-
-static int dbx500_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	if (!IS_ERR(cdev))
-		cpufreq_cooling_unregister(cdev);
-	return 0;
-}
-
-static void dbx500_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	cdev = cpufreq_cooling_register(policy);
-	if (IS_ERR(cdev))
-		pr_err("Failed to register cooling device %ld\n", PTR_ERR(cdev));
-	else
-		pr_info("Cooling device registered: %s\n", cdev->type);
-}
-
-static struct cpufreq_driver dbx500_cpufreq_driver = {
-	.flags  = CPUFREQ_STICKY | CPUFREQ_CONST_LOOPS |
-			CPUFREQ_NEED_INITIAL_FREQ_CHECK,
-	.verify = cpufreq_generic_frequency_table_verify,
-	.target_index = dbx500_cpufreq_target,
-	.get    = cpufreq_generic_get,
-	.init   = dbx500_cpufreq_init,
-	.exit  = dbx500_cpufreq_exit,
-	.ready  = dbx500_cpufreq_ready,
-	.name   = "DBX500",
-	.attr   = cpufreq_generic_attr,
-};
-
-static int dbx500_cpufreq_probe(struct platform_device *pdev)
-{
-	struct cpufreq_frequency_table *pos;
-
-	freq_table = dev_get_platdata(&pdev->dev);
-	if (!freq_table) {
-		pr_err("dbx500-cpufreq: Failed to fetch cpufreq table\n");
-		return -ENODEV;
-	}
-
-	armss_clk = clk_get(&pdev->dev, "armss");
-	if (IS_ERR(armss_clk)) {
-		pr_err("dbx500-cpufreq: Failed to get armss clk\n");
-		return PTR_ERR(armss_clk);
-	}
-
-	pr_info("dbx500-cpufreq: Available frequencies:\n");
-	cpufreq_for_each_entry(pos, freq_table)
-		pr_info("  %d Mhz\n", pos->frequency / 1000);
-
-	return cpufreq_register_driver(&dbx500_cpufreq_driver);
-}
-
-static struct platform_driver dbx500_cpufreq_plat_driver = {
-	.driver = {
-		.name = "cpufreq-ux500",
-	},
-	.probe = dbx500_cpufreq_probe,
-};
-
-static int __init dbx500_cpufreq_register(void)
-{
-	return platform_driver_register(&dbx500_cpufreq_plat_driver);
-}
-device_initcall(dbx500_cpufreq_register);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("cpufreq driver for DBX500");
-- 
2.9.4

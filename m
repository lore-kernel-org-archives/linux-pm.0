From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH Resend] cpufreq: cpu0: rename driver and internals to 'cpufreq_dt'
Date: Thu,  2 Oct 2014 10:54:14 +0530
Message-ID: <036b9f8e91c1f1b3fc36ffaab67c8f99925b73cd.1412227347.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:41085 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbaJBFYU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 01:24:20 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so1486523pde.14
        for <linux-pm@vger.kernel.org>; Wed, 01 Oct 2014 22:24:19 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, viresh kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

From: viresh kumar <viresh.kumar@linaro.org>

The naming convention of this driver was always under the scanner, people
complained that it should have a more generic name than cpu0, as it manages all
CPUs that are sharing clock lines.

Also, in future it will be modified to support any number of clusters with
separate clock/voltage lines.

Lets rename it to 'cpufreq_dt' from 'cpufreq_cpu0'.

Tested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 .../cpufreq/{cpufreq-cpu0.txt => cpufreq-dt.txt}   |  8 ++---
 arch/arm/configs/mvebu_v7_defconfig                |  2 +-
 arch/arm/mach-imx/imx27-dt.c                       |  2 +-
 arch/arm/mach-imx/mach-imx51.c                     |  2 +-
 arch/arm/mach-mvebu/pmsu.c                         |  2 +-
 arch/arm/mach-omap2/pm.c                           |  2 +-
 arch/arm/mach-shmobile/board-ape6evm-reference.c   |  2 +-
 arch/arm/mach-shmobile/cpufreq.c                   |  2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c              |  4 +--
 arch/arm/mach-zynq/common.c                        |  2 +-
 drivers/cpufreq/Kconfig                            |  8 ++---
 drivers/cpufreq/Kconfig.arm                        |  2 +-
 drivers/cpufreq/Makefile                           |  2 +-
 drivers/cpufreq/{cpufreq-cpu0.c => cpufreq-dt.c}   | 41 +++++++++++-----------
 drivers/cpufreq/exynos4210-cpufreq.c               |  2 +-
 drivers/cpufreq/exynos4x12-cpufreq.c               |  2 +-
 drivers/cpufreq/exynos5250-cpufreq.c               |  2 +-
 drivers/cpufreq/highbank-cpufreq.c                 |  6 ++--
 drivers/cpufreq/s5pv210-cpufreq.c                  |  2 +-
 19 files changed, 48 insertions(+), 47 deletions(-)
 rename Documentation/devicetree/bindings/cpufreq/{cpufreq-cpu0.txt => cpufreq-dt.txt} (85%)
 rename drivers/cpufreq/{cpufreq-cpu0.c => cpufreq-dt.c} (90%)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
similarity index 85%
rename from Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
rename to Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
index 366690c..e41c98f 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
@@ -1,8 +1,8 @@
-Generic CPU0 cpufreq driver
+Generic cpufreq driver
 
-It is a generic cpufreq driver for CPU0 frequency management.  It
-supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
-systems which share clock and voltage across all CPUs.
+It is a generic DT based cpufreq driver for frequency management.  It supports
+both uniprocessor (UP) and symmetric multiprocessor (SMP) systems which share
+clock and voltage across all CPUs.
 
 Both required and optional properties listed below must be defined
 under node /cpus/cpu@0.
diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index fdfda1f..7309988b 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -32,7 +32,7 @@ CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_MVEBU_V7_CPUIDLE=y
 CONFIG_CPU_FREQ=y
-CONFIG_CPUFREQ_GENERIC=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_VFP=y
 CONFIG_NET=y
 CONFIG_INET=y
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index 080e66c..dc8f1a6 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -20,7 +20,7 @@
 
 static void __init imx27_dt_init(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
 
 	mxc_arch_reset_init_dt();
 
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index c77deb3..2c5fcaf 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -51,7 +51,7 @@ static void __init imx51_ipu_mipi_setup(void)
 
 static void __init imx51_dt_init(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
 
 	mxc_arch_reset_init_dt();
 	imx51_ipu_mipi_setup();
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 8a70a51..bbd8664 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -644,7 +644,7 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 		}
 	}
 
-	platform_device_register_simple("cpufreq-generic", -1, NULL, 0);
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 828aee9..58920bc 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -282,7 +282,7 @@ static inline void omap_init_cpufreq(void)
 	if (!of_have_populated_dt())
 		devinfo.name = "omap-cpufreq";
 	else
-		devinfo.name = "cpufreq-cpu0";
+		devinfo.name = "cpufreq-dt";
 	platform_device_register_full(&devinfo);
 }
 
diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 2f7723e..0110751 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -50,7 +50,7 @@ static void __init ape6evm_add_standard_devices(void)
 
 	r8a73a4_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 }
 
 static const char *ape6evm_boards_compat_dt[] __initdata = {
diff --git a/arch/arm/mach-shmobile/cpufreq.c b/arch/arm/mach-shmobile/cpufreq.c
index 8a24b2b..57fbff0 100644
--- a/arch/arm/mach-shmobile/cpufreq.c
+++ b/arch/arm/mach-shmobile/cpufreq.c
@@ -12,6 +12,6 @@
 
 int __init shmobile_cpufreq_init(void)
 {
-	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 	return 0;
 }
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 2c802ae..15b990c 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -775,7 +775,7 @@ void __init sh73a0_add_early_devices(void)
 
 void __init sh73a0_add_standard_devices_dt(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
+	struct platform_device_info devinfo = { .name = "cpufreq-dt", .id = -1, };
 
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
@@ -784,7 +784,7 @@ void __init sh73a0_add_standard_devices_dt(void)
 			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
-	/* Instantiate cpufreq-cpu0 */
+	/* Instantiate cpufreq-dt */
 	platform_device_register_full(&devinfo);
 }
 
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 31a6fa4..ec03ec4 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -104,7 +104,7 @@ static int __init zynq_get_revision(void)
  */
 static void __init zynq_init_machine(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
 	struct device *parent = NULL;
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index ffe350f..3489f8f 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -183,14 +183,14 @@ config CPU_FREQ_GOV_CONSERVATIVE
 
 	  If in doubt, say N.
 
-config GENERIC_CPUFREQ_CPU0
-	tristate "Generic CPU0 cpufreq driver"
+config CPUFREQ_DT
+	tristate "Generic DT based cpufreq driver"
 	depends on HAVE_CLK && OF
-	# if CPU_THERMAL is on and THERMAL=m, CPU0 cannot be =y:
+	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
 	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
-	  This adds a generic cpufreq driver for CPU0 frequency management.
+	  This adds a generic DT based cpufreq driver for frequency management.
 	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
 	  systems which share clock and voltage across all CPUs.
 
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 7364a53..48ed28b 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -92,7 +92,7 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
 
 config ARM_HIGHBANK_CPUFREQ
 	tristate "Calxeda Highbank-based"
-	depends on ARCH_HIGHBANK && GENERIC_CPUFREQ_CPU0 && REGULATOR
+	depends on ARCH_HIGHBANK && CPUFREQ_DT && REGULATOR
 	default m
 	help
 	  This adds the CPUFreq driver for Calxeda Highbank SoC
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index db6d9a2..40c53dc 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+= cpufreq_ondemand.o
 obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
 obj-$(CONFIG_CPU_FREQ_GOV_COMMON)		+= cpufreq_governor.o
 
-obj-$(CONFIG_GENERIC_CPUFREQ_CPU0)	+= cpufreq-cpu0.o
+obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
 
 ##################################################################################
 # x86 drivers.
diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-dt.c
similarity index 90%
rename from drivers/cpufreq/cpufreq-cpu0.c
rename to drivers/cpufreq/cpufreq-dt.c
index a5f8c5f..6bbb8b9 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2014 Linaro.
  * Viresh Kumar <viresh.kumar@linaro.org>
  *
- * The OPP code in function cpu0_set_target() is reused from
+ * The OPP code in function set_target() is reused from
  * drivers/cpufreq/omap-cpufreq.c
  *
  * This program is free software; you can redistribute it and/or modify
@@ -35,7 +35,7 @@ struct private_data {
 	unsigned int voltage_tolerance; /* in percentage */
 };
 
-static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
+static int set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct dev_pm_opp *opp;
 	struct cpufreq_frequency_table *freq_table = policy->freq_table;
@@ -176,7 +176,7 @@ static int allocate_resources(int cpu, struct device **cdev,
 	return ret;
 }
 
-static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
+static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
 	struct thermal_cooling_device *cdev;
@@ -259,7 +259,6 @@ static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
 		else
 			priv->cdev = cdev;
 	}
-	of_node_put(np);
 
 	priv->cpu_dev = cpu_dev;
 	priv->cpu_reg = cpu_reg;
@@ -270,6 +269,8 @@ static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto out_cooling_unregister;
 
+	of_node_put(np);
+
 	return 0;
 
 out_cooling_unregister:
@@ -287,7 +288,7 @@ static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
-static int cpu0_cpufreq_exit(struct cpufreq_policy *policy)
+static int cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct private_data *priv = policy->driver_data;
 
@@ -301,18 +302,18 @@ static int cpu0_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static struct cpufreq_driver cpu0_cpufreq_driver = {
+static struct cpufreq_driver dt_cpufreq_driver = {
 	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify = cpufreq_generic_frequency_table_verify,
-	.target_index = cpu0_set_target,
+	.target_index = set_target,
 	.get = cpufreq_generic_get,
-	.init = cpu0_cpufreq_init,
-	.exit = cpu0_cpufreq_exit,
-	.name = "generic_cpu0",
+	.init = cpufreq_init,
+	.exit = cpufreq_exit,
+	.name = "cpufreq-dt",
 	.attr = cpufreq_generic_attr,
 };
 
-static int cpu0_cpufreq_probe(struct platform_device *pdev)
+static int dt_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
@@ -334,30 +335,30 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 	if (!IS_ERR(cpu_reg))
 		regulator_put(cpu_reg);
 
-	ret = cpufreq_register_driver(&cpu0_cpufreq_driver);
+	ret = cpufreq_register_driver(&dt_cpufreq_driver);
 	if (ret)
 		dev_err(cpu_dev, "failed register driver: %d\n", ret);
 
 	return ret;
 }
 
-static int cpu0_cpufreq_remove(struct platform_device *pdev)
+static int dt_cpufreq_remove(struct platform_device *pdev)
 {
-	cpufreq_unregister_driver(&cpu0_cpufreq_driver);
+	cpufreq_unregister_driver(&dt_cpufreq_driver);
 	return 0;
 }
 
-static struct platform_driver cpu0_cpufreq_platdrv = {
+static struct platform_driver dt_cpufreq_platdrv = {
 	.driver = {
-		.name	= "cpufreq-cpu0",
+		.name	= "cpufreq-dt",
 		.owner	= THIS_MODULE,
 	},
-	.probe		= cpu0_cpufreq_probe,
-	.remove		= cpu0_cpufreq_remove,
+	.probe		= dt_cpufreq_probe,
+	.remove		= dt_cpufreq_remove,
 };
-module_platform_driver(cpu0_cpufreq_platdrv);
+module_platform_driver(dt_cpufreq_platdrv);
 
 MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
 MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
-MODULE_DESCRIPTION("Generic CPU0 cpufreq driver");
+MODULE_DESCRIPTION("Generic cpufreq driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
index 61a5431..843ec82 100644
--- a/drivers/cpufreq/exynos4210-cpufreq.c
+++ b/drivers/cpufreq/exynos4210-cpufreq.c
@@ -127,7 +127,7 @@ int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
 	 * dependencies on platform headers. It is necessary to enable
 	 * Exynos multi-platform support and will be removed together with
 	 * this whole driver as soon as Exynos gets migrated to use
-	 * cpufreq-cpu0 driver.
+	 * cpufreq-dt driver.
 	 */
 	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-clock");
 	if (!np) {
diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
index 351a207..9e78a85 100644
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ b/drivers/cpufreq/exynos4x12-cpufreq.c
@@ -174,7 +174,7 @@ int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
 	 * dependencies on platform headers. It is necessary to enable
 	 * Exynos multi-platform support and will be removed together with
 	 * this whole driver as soon as Exynos gets migrated to use
-	 * cpufreq-cpu0 driver.
+	 * cpufreq-dt driver.
 	 */
 	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4412-clock");
 	if (!np) {
diff --git a/drivers/cpufreq/exynos5250-cpufreq.c b/drivers/cpufreq/exynos5250-cpufreq.c
index c91ce69..3eafdc7 100644
--- a/drivers/cpufreq/exynos5250-cpufreq.c
+++ b/drivers/cpufreq/exynos5250-cpufreq.c
@@ -153,7 +153,7 @@ int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
 	 * dependencies on platform headers. It is necessary to enable
 	 * Exynos multi-platform support and will be removed together with
 	 * this whole driver as soon as Exynos gets migrated to use
-	 * cpufreq-cpu0 driver.
+	 * cpufreq-dt driver.
 	 */
 	np = of_find_compatible_node(NULL, NULL, "samsung,exynos5250-clock");
 	if (!np) {
diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
index bf8902a..ec399ad 100644
--- a/drivers/cpufreq/highbank-cpufreq.c
+++ b/drivers/cpufreq/highbank-cpufreq.c
@@ -6,7 +6,7 @@
  * published by the Free Software Foundation.
  *
  * This driver provides the clk notifier callbacks that are used when
- * the cpufreq-cpu0 driver changes to frequency to alert the highbank
+ * the cpufreq-dt driver changes to frequency to alert the highbank
  * EnergyCore Management Engine (ECME) about the need to change
  * voltage. The ECME interfaces with the actual voltage regulators.
  */
@@ -60,7 +60,7 @@ static struct notifier_block hb_cpufreq_clk_nb = {
 
 static int hb_cpufreq_driver_init(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
 	struct device *cpu_dev;
 	struct clk *cpu_clk;
 	struct device_node *np;
@@ -95,7 +95,7 @@ static int hb_cpufreq_driver_init(void)
 		goto out_put_node;
 	}
 
-	/* Instantiate cpufreq-cpu0 */
+	/* Instantiate cpufreq-dt */
 	platform_device_register_full(&devinfo);
 
 out_put_node:
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 3f9791f..567caa6 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -597,7 +597,7 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 	 * and dependencies on platform headers. It is necessary to enable
 	 * S5PV210 multi-platform support and will be removed together with
 	 * this whole driver as soon as S5PV210 gets migrated to use
-	 * cpufreq-cpu0 driver.
+	 * cpufreq-dt driver.
 	 */
 	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
 	if (!np) {
-- 
2.0.3.693.g996b0fd


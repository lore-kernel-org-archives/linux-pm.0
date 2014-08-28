From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 10/10] cpufreq: generic: set platform_{driver|device} '.name' to 'cpufreq-generic'
Date: Thu, 28 Aug 2014 11:22:32 +0530
Message-ID: <c2645161b693c22f745019569bda2ba4db96d645.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:50174 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933927AbaH1Fxe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 01:53:34 -0400
Received: by mail-pa0-f45.google.com with SMTP id bj1so1119392pad.32
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 22:53:34 -0700 (PDT)
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, t.figa@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com, Viresh Kumar <viresh.kumar@linaro.org>

We have already renamed cpufreq-cpu0 to cpufreq-generic at most of the places,
the only one left is in the '.name' field of platform driver and devices.

Lets do it now for all users.

Updates cpufreq-cpu0 from comments as well.

Tested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-imx/imx27-dt.c                     | 2 +-
 arch/arm/mach-imx/mach-imx51.c                   | 2 +-
 arch/arm/mach-omap2/pm.c                         | 2 +-
 arch/arm/mach-shmobile/board-ape6evm-reference.c | 2 +-
 arch/arm/mach-shmobile/cpufreq.c                 | 2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c            | 4 ++--
 arch/arm/mach-zynq/common.c                      | 2 +-
 drivers/cpufreq/cpufreq-generic.c                | 2 +-
 drivers/cpufreq/exynos4210-cpufreq.c             | 2 +-
 drivers/cpufreq/exynos4x12-cpufreq.c             | 2 +-
 drivers/cpufreq/exynos5250-cpufreq.c             | 2 +-
 drivers/cpufreq/highbank-cpufreq.c               | 6 +++---
 drivers/cpufreq/s5pv210-cpufreq.c                | 2 +-
 13 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index 080e66c..e15db8a 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -20,7 +20,7 @@
 
 static void __init imx27_dt_init(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+	struct platform_device_info devinfo = { .name = "cpufreq-generic", };
 
 	mxc_arch_reset_init_dt();
 
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index c77deb3..7298136 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -51,7 +51,7 @@ static void __init imx51_ipu_mipi_setup(void)
 
 static void __init imx51_dt_init(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+	struct platform_device_info devinfo = { .name = "cpufreq-generic", };
 
 	mxc_arch_reset_init_dt();
 	imx51_ipu_mipi_setup();
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 828aee9..7ec2fbb 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -282,7 +282,7 @@ static inline void omap_init_cpufreq(void)
 	if (!of_have_populated_dt())
 		devinfo.name = "omap-cpufreq";
 	else
-		devinfo.name = "cpufreq-cpu0";
+		devinfo.name = "cpufreq-generic";
 	platform_device_register_full(&devinfo);
 }
 
diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 2f7723e..4e98972 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -50,7 +50,7 @@ static void __init ape6evm_add_standard_devices(void)
 
 	r8a73a4_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
+	platform_device_register_simple("cpufreq-generic", -1, NULL, 0);
 }
 
 static const char *ape6evm_boards_compat_dt[] __initdata = {
diff --git a/arch/arm/mach-shmobile/cpufreq.c b/arch/arm/mach-shmobile/cpufreq.c
index 8a24b2b..6817204 100644
--- a/arch/arm/mach-shmobile/cpufreq.c
+++ b/arch/arm/mach-shmobile/cpufreq.c
@@ -12,6 +12,6 @@
 
 int __init shmobile_cpufreq_init(void)
 {
-	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
+	platform_device_register_simple("cpufreq-generic", -1, NULL, 0);
 	return 0;
 }
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 2c802ae..297c629 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -775,7 +775,7 @@ void __init sh73a0_add_early_devices(void)
 
 void __init sh73a0_add_standard_devices_dt(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
+	struct platform_device_info devinfo = { .name = "cpufreq-generic", .id = -1, };
 
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
@@ -784,7 +784,7 @@ void __init sh73a0_add_standard_devices_dt(void)
 			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
-	/* Instantiate cpufreq-cpu0 */
+	/* Instantiate cpufreq-generic */
 	platform_device_register_full(&devinfo);
 }
 
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 31a6fa4..79f3c61 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -104,7 +104,7 @@ static int __init zynq_get_revision(void)
  */
 static void __init zynq_init_machine(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+	struct platform_device_info devinfo = { .name = "cpufreq-generic", };
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
 	struct device *parent = NULL;
diff --git a/drivers/cpufreq/cpufreq-generic.c b/drivers/cpufreq/cpufreq-generic.c
index 9b85055..549c2e9 100644
--- a/drivers/cpufreq/cpufreq-generic.c
+++ b/drivers/cpufreq/cpufreq-generic.c
@@ -349,7 +349,7 @@ static int generic_cpufreq_remove(struct platform_device *pdev)
 
 static struct platform_driver generic_cpufreq_platdrv = {
 	.driver = {
-		.name	= "cpufreq-cpu0",
+		.name	= "cpufreq-generic",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= generic_cpufreq_probe,
diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
index 61a5431..728c9f4 100644
--- a/drivers/cpufreq/exynos4210-cpufreq.c
+++ b/drivers/cpufreq/exynos4210-cpufreq.c
@@ -127,7 +127,7 @@ int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
 	 * dependencies on platform headers. It is necessary to enable
 	 * Exynos multi-platform support and will be removed together with
 	 * this whole driver as soon as Exynos gets migrated to use
-	 * cpufreq-cpu0 driver.
+	 * cpufreq-generic driver.
 	 */
 	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-clock");
 	if (!np) {
diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
index 351a207..7bbe5ef 100644
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ b/drivers/cpufreq/exynos4x12-cpufreq.c
@@ -174,7 +174,7 @@ int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
 	 * dependencies on platform headers. It is necessary to enable
 	 * Exynos multi-platform support and will be removed together with
 	 * this whole driver as soon as Exynos gets migrated to use
-	 * cpufreq-cpu0 driver.
+	 * cpufreq-generic driver.
 	 */
 	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4412-clock");
 	if (!np) {
diff --git a/drivers/cpufreq/exynos5250-cpufreq.c b/drivers/cpufreq/exynos5250-cpufreq.c
index c91ce69..d39864c 100644
--- a/drivers/cpufreq/exynos5250-cpufreq.c
+++ b/drivers/cpufreq/exynos5250-cpufreq.c
@@ -153,7 +153,7 @@ int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
 	 * dependencies on platform headers. It is necessary to enable
 	 * Exynos multi-platform support and will be removed together with
 	 * this whole driver as soon as Exynos gets migrated to use
-	 * cpufreq-cpu0 driver.
+	 * cpufreq-generic driver.
 	 */
 	np = of_find_compatible_node(NULL, NULL, "samsung,exynos5250-clock");
 	if (!np) {
diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
index bf8902a..dc7a9ab 100644
--- a/drivers/cpufreq/highbank-cpufreq.c
+++ b/drivers/cpufreq/highbank-cpufreq.c
@@ -6,7 +6,7 @@
  * published by the Free Software Foundation.
  *
  * This driver provides the clk notifier callbacks that are used when
- * the cpufreq-cpu0 driver changes to frequency to alert the highbank
+ * the cpufreq-generic driver changes to frequency to alert the highbank
  * EnergyCore Management Engine (ECME) about the need to change
  * voltage. The ECME interfaces with the actual voltage regulators.
  */
@@ -60,7 +60,7 @@ static struct notifier_block hb_cpufreq_clk_nb = {
 
 static int hb_cpufreq_driver_init(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+	struct platform_device_info devinfo = { .name = "cpufreq-generic", };
 	struct device *cpu_dev;
 	struct clk *cpu_clk;
 	struct device_node *np;
@@ -95,7 +95,7 @@ static int hb_cpufreq_driver_init(void)
 		goto out_put_node;
 	}
 
-	/* Instantiate cpufreq-cpu0 */
+	/* Instantiate cpufreq-generic */
 	platform_device_register_full(&devinfo);
 
 out_put_node:
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 9a68225..11aa3f4 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -597,7 +597,7 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 	 * and dependencies on platform headers. It is necessary to enable
 	 * S5PV210 multi-platform support and will be removed together with
 	 * this whole driver as soon as S5PV210 gets migrated to use
-	 * cpufreq-cpu0 driver.
+	 * cpufreq-generic driver.
 	 */
 	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
 	if (!np) {
-- 
2.0.3.693.g996b0fd


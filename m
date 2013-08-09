From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] cpufreq: fix EXYNOS drivers selection
Date: Fri, 09 Aug 2013 14:04:55 +0200
Message-ID: <2522264.d7vsK7QKUi@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

* remove superfluous pr_debug() call from exynos_cpufreq_init()
  (init errors are always logged anyway)
* add dummy per-SoC type init functions to exynos-cpufreq.h
* make per-SoC type cpufreq config options selectable
* make CONFIG_ARM_EXYNOS_CPUFREQ config option invisible to user and
  automatically enable it when needed

This patch fixes following issues:
* EXYNOS per-SoC type cpufreq support (i.e. exynos4210-cpufreq.c) being
  always built if given SoC support was enabled (i.e. CPU_EXYNOS4210),
  even if common EXYNOS cpufreq support was disabled
* inability to select cpufreq for each SoC type separately (it could
  be only enabled/disabled for all SoCs for which support was enabled)
* EXYNOS5440 cpufreq support was always enabled when EXYNOS5440
  support was enabled and couldn't be disabled

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/cpufreq/Kconfig.arm      |   36 ++++++++++++++++++++++++------------
 drivers/cpufreq/exynos-cpufreq.c |    1 -
 drivers/cpufreq/exynos-cpufreq.h |   21 +++++++++++++++++++++
 3 files changed, 45 insertions(+), 13 deletions(-)

Index: b/drivers/cpufreq/Kconfig.arm
===================================================================
--- a/drivers/cpufreq/Kconfig.arm	2013-08-08 14:36:09.000000000 +0200
+++ b/drivers/cpufreq/Kconfig.arm	2013-08-08 15:50:58.099420242 +0200
@@ -17,37 +17,47 @@ config ARM_DT_BL_CPUFREQ
 	  big.LITTLE platform. This gets frequency tables from DT.
 
 config ARM_EXYNOS_CPUFREQ
-	bool "SAMSUNG EXYNOS SoCs"
-	depends on ARCH_EXYNOS
+	bool
 	select CPU_FREQ_TABLE
-	default y
-	help
-	  This adds the CPUFreq driver common part for Samsung
-	  EXYNOS SoCs.
-
-	  If in doubt, say N.
 
 config ARM_EXYNOS4210_CPUFREQ
-	def_bool CPU_EXYNOS4210
+	bool "SAMSUNG EXYNOS4210"
+	depends on CPU_EXYNOS4210
+	default y
+	select ARM_EXYNOS_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS4210
 	  SoC (S5PV310 or S5PC210).
 
+	  If in doubt, say N.
+
 config ARM_EXYNOS4X12_CPUFREQ
-	def_bool (SOC_EXYNOS4212 || SOC_EXYNOS4412)
+	bool "SAMSUNG EXYNOS4x12"
+	depends on (SOC_EXYNOS4212 || SOC_EXYNOS4412)
+	default y
+	select ARM_EXYNOS_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS4X12
 	  SoC (EXYNOS4212 or EXYNOS4412).
 
+	  If in doubt, say N.
+
 config ARM_EXYNOS5250_CPUFREQ
-	def_bool SOC_EXYNOS5250
+	bool "SAMSUNG EXYNOS5250"
+	depends on SOC_EXYNOS5250
+	default y
+	select ARM_EXYNOS_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS5250
 	  SoC.
 
+	  If in doubt, say N.
+
 config ARM_EXYNOS5440_CPUFREQ
-	def_bool SOC_EXYNOS5440
+	bool "SAMSUNG EXYNOS5440"
+	depends on SOC_EXYNOS5440
 	depends on HAVE_CLK && PM_OPP && OF
+	default y
 	select CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS5440
@@ -55,6 +65,8 @@ config ARM_EXYNOS5440_CPUFREQ
 	  different than previous exynos controllers so not using
 	  the common exynos framework.
 
+	  If in doubt, say N.
+
 config ARM_HIGHBANK_CPUFREQ
 	tristate "Calxeda Highbank-based"
 	depends on ARCH_HIGHBANK
Index: b/drivers/cpufreq/exynos-cpufreq.c
===================================================================
--- a/drivers/cpufreq/exynos-cpufreq.c	2013-08-08 14:36:09.000000000 +0200
+++ b/drivers/cpufreq/exynos-cpufreq.c	2013-08-08 15:47:39.619423270 +0200
@@ -332,7 +332,6 @@ err_cpufreq:
 	regulator_put(arm_regulator);
 err_vdd_arm:
 	kfree(exynos_info);
-	pr_debug("%s: failed initialization\n", __func__);
 	return -EINVAL;
 }
 late_initcall(exynos_cpufreq_init);
Index: b/drivers/cpufreq/exynos-cpufreq.h
===================================================================
--- a/drivers/cpufreq/exynos-cpufreq.h	2013-08-08 14:28:57.000000000 +0200
+++ b/drivers/cpufreq/exynos-cpufreq.h	2013-08-08 15:47:39.619423270 +0200
@@ -43,6 +43,27 @@ struct exynos_dvfs_info {
 	bool (*need_apll_change)(unsigned int, unsigned int);
 };
 
+#ifdef CONFIG_ARM_EXYNOS4210_CPUFREQ
 extern int exynos4210_cpufreq_init(struct exynos_dvfs_info *);
+#else
+static inline int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+#ifdef CONFIG_ARM_EXYNOS4X12_CPUFREQ
 extern int exynos4x12_cpufreq_init(struct exynos_dvfs_info *);
+#else
+static inline int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+#ifdef CONFIG_ARM_EXYNOS5250_CPUFREQ
 extern int exynos5250_cpufreq_init(struct exynos_dvfs_info *);
+#else
+static inline int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
+{
+	return -EOPNOTSUPP;
+}
+#endif

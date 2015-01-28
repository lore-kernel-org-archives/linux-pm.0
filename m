From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] cpufreq: exynos: allow modular build
Date: Wed, 28 Jan 2015 14:16:55 +0100
Message-ID: <1422451015-390439-4-git-send-email-arnd@arndb.de>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422451015-390439-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The exynos cpufreq driver code recently gained a dependency on the
cooling code, which may be a loadable module. This breaks an ARM
allmodconfig build:

drivers/built-in.o: In function `exynos_cpufreq_probe':
:(.text+0x1748e8): undefined reference to `of_cpufreq_cooling_register'

To avoid this problem, change cpufreq Kconfig to allow the drivers
to be loadable modules as well and enforce a dependency on the
thermal module. Also, export the symbols that are used for communicating
between the three cpu-specific parts of the driver and the main module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e725d26c4857 ("cpufreq: exynos: Use device tree to determine if cpufreq cooling should be registered")
---
 drivers/cpufreq/Kconfig.arm          | 14 +++++++++-----
 drivers/cpufreq/exynos-cpufreq.h     |  6 +++---
 drivers/cpufreq/exynos4210-cpufreq.c |  1 +
 drivers/cpufreq/exynos4x12-cpufreq.c |  1 +
 drivers/cpufreq/exynos5250-cpufreq.c |  1 +
 5 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0f9a2c3c0e0d..99ac56746ebd 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -26,11 +26,12 @@ config ARM_VEXPRESS_SPC_CPUFREQ
 
 
 config ARM_EXYNOS_CPUFREQ
-	bool
+	tristate
 
 config ARM_EXYNOS4210_CPUFREQ
-	bool "SAMSUNG EXYNOS4210"
+	tristate "SAMSUNG EXYNOS4210"
 	depends on CPU_EXYNOS4210
+	depends on THERMAL
 	default y
 	select ARM_EXYNOS_CPUFREQ
 	help
@@ -40,8 +41,9 @@ config ARM_EXYNOS4210_CPUFREQ
 	  If in doubt, say N.
 
 config ARM_EXYNOS4X12_CPUFREQ
-	bool "SAMSUNG EXYNOS4x12"
+	tristate "SAMSUNG EXYNOS4x12"
 	depends on SOC_EXYNOS4212 || SOC_EXYNOS4412
+	depends on THERMAL
 	default y
 	select ARM_EXYNOS_CPUFREQ
 	help
@@ -51,8 +53,9 @@ config ARM_EXYNOS4X12_CPUFREQ
 	  If in doubt, say N.
 
 config ARM_EXYNOS5250_CPUFREQ
-	bool "SAMSUNG EXYNOS5250"
+	tristate "SAMSUNG EXYNOS5250"
 	depends on SOC_EXYNOS5250
+	depends on THERMAL
 	default y
 	select ARM_EXYNOS_CPUFREQ
 	help
@@ -62,9 +65,10 @@ config ARM_EXYNOS5250_CPUFREQ
 	  If in doubt, say N.
 
 config ARM_EXYNOS5440_CPUFREQ
-	bool "SAMSUNG EXYNOS5440"
+	tristate "SAMSUNG EXYNOS5440"
 	depends on SOC_EXYNOS5440
 	depends on HAVE_CLK && OF
+	depends on THERMAL
 	select PM_OPP
 	default y
 	help
diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
index 9f2062a7cc02..32a895af4961 100644
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ b/drivers/cpufreq/exynos-cpufreq.h
@@ -53,7 +53,7 @@ struct exynos_dvfs_info {
 	void __iomem	*cmu_regs;
 };
 
-#ifdef CONFIG_ARM_EXYNOS4210_CPUFREQ
+#if IS_ENABLED(CONFIG_ARM_EXYNOS4210_CPUFREQ)
 extern int exynos4210_cpufreq_init(struct exynos_dvfs_info *);
 #else
 static inline int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
@@ -61,7 +61,7 @@ static inline int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
 	return -EOPNOTSUPP;
 }
 #endif
-#ifdef CONFIG_ARM_EXYNOS4X12_CPUFREQ
+#if IS_ENABLED(CONFIG_ARM_EXYNOS4X12_CPUFREQ)
 extern int exynos4x12_cpufreq_init(struct exynos_dvfs_info *);
 #else
 static inline int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
@@ -69,7 +69,7 @@ static inline int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
 	return -EOPNOTSUPP;
 }
 #endif
-#ifdef CONFIG_ARM_EXYNOS5250_CPUFREQ
+#if IS_ENABLED(CONFIG_ARM_EXYNOS5250_CPUFREQ)
 extern int exynos5250_cpufreq_init(struct exynos_dvfs_info *);
 #else
 static inline int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
index 843ec824fd91..4b5de19f0ea2 100644
--- a/drivers/cpufreq/exynos4210-cpufreq.c
+++ b/drivers/cpufreq/exynos4210-cpufreq.c
@@ -182,3 +182,4 @@ err_moutcore:
 	pr_debug("%s: failed initialization\n", __func__);
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(exynos4210_cpufreq_init);
diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
index 9e78a850e29f..d2924e1bc909 100644
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ b/drivers/cpufreq/exynos4x12-cpufreq.c
@@ -234,3 +234,4 @@ err_moutcore:
 	pr_debug("%s: failed initialization\n", __func__);
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(exynos4x12_cpufreq_init);
diff --git a/drivers/cpufreq/exynos5250-cpufreq.c b/drivers/cpufreq/exynos5250-cpufreq.c
index 3eafdc7ba787..b2810b839331 100644
--- a/drivers/cpufreq/exynos5250-cpufreq.c
+++ b/drivers/cpufreq/exynos5250-cpufreq.c
@@ -208,3 +208,4 @@ err_moutcore:
 	pr_err("%s: failed initialization\n", __func__);
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(exynos5250_cpufreq_init);
-- 
2.1.0.rc2

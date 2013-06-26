From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/3] ARM: EXYNOS: init cpuidle driver in exynos_init_late()
Date: Wed, 26 Jun 2013 12:13:46 +0200
Message-ID: <1372241627-22695-3-git-send-email-b.zolnierkie@samsung.com>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: kgene.kim@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, amit.kachhap@linaro.org, t.figa@samsung.com, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Init cpuidle driver in exynos_init_late() instead of using
device_initcall().  This is needed for multiplatform support.

Tested on Exynos4210 (Universal C210 board).

Cc: Jaecheol Lee <jc.lee@samsung.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/common.c  | 8 ++++----
 arch/arm/mach-exynos/common.h  | 6 ++++++
 arch/arm/mach-exynos/cpuidle.c | 3 +--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index f7e504b..1c78a16 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -346,11 +346,11 @@ void exynos5_restart(char mode, const char *cmd)
 
 void __init exynos_init_late(void)
 {
-	if (of_machine_is_compatible("samsung,exynos5440"))
-		/* to be supported later */
-		return;
+	/* exynos5440 to be supported later */
+	if (!of_machine_is_compatible("samsung,exynos5440"))
+		exynos_pm_late_initcall();
 
-	exynos_pm_late_initcall();
+	exynos4_init_cpuidle();
 }
 
 #ifdef CONFIG_OF
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 11fc1e2..a3b95a6 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -40,6 +40,12 @@ int exynos_pm_late_initcall(void);
 static inline int exynos_pm_late_initcall(void) { return 0; }
 #endif
 
+#ifdef CONFIG_CPU_IDLE
+int exynos4_init_cpuidle(void);
+#else
+static inline int exynos4_init_cpuidle(void) { return 0; }
+#endif
+
 #ifdef CONFIG_ARCH_EXYNOS4
 void exynos4_register_clocks(void);
 void exynos4_setup_clocks(void);
diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 0a657ac..d6e5115 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -66,7 +66,7 @@ static void __init exynos5_core_down_clk(void)
 	__raw_writel(tmp, EXYNOS5_PWR_CTRL2);
 }
 
-static int __init exynos4_init_cpuidle(void)
+int __init exynos4_init_cpuidle(void)
 {
 	int cpu_id, ret;
 	struct cpuidle_device *device;
@@ -93,4 +93,3 @@ static int __init exynos4_init_cpuidle(void)
 
 	return 0;
 }
-device_initcall(exynos4_init_cpuidle);
-- 
1.8.2.3

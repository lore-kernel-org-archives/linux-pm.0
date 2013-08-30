From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/2] ARM: EXYNOS: add cpuidle-exynos.max_states kernel parameter
Date: Fri, 30 Aug 2013 12:21:07 +0200
Message-ID: <4002844.4ZqqJexTv4@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tomasz Figa <t.figa@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add "cpuidle-exynos.max_states=" parameter to allow user to specify
the maximum of allowed CPU idle states for ARM EXYNOS cpuidle driver.

This change is needed because C1 state (AFTR mode) is often not able
to work properly due to incompatibility with some bootloader versions.

Usage examples:

"cpuidle-exynos.max_states=1" disables C1 state (AFTR mode).

"cpuidle-exynos.max_states=0" disables the driver completely.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 8e881e0..ead0f71 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/time.h>
 #include <linux/platform_device.h>
+#include <linux/moduleparam.h>
 
 #include <asm/proc-fns.h>
 #include <asm/smp_scu.h>
@@ -30,6 +31,9 @@
 
 #include "common.h"
 
+#define MODULE_PARAM_PREFIX	"cpuidle-exynos."
+#define PREFIX			"cpuidle-exynos: "
+
 #define REG_DIRECTGO_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
 			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
 			(S5P_VA_SYSRAM + 0x24) : S5P_INFORM0))
@@ -63,6 +67,9 @@ static struct cpuidle_driver exynos4_idle_driver = {
 	.safe_state_index = 0,
 };
 
+/* cpuidle-exynos.max_states=0 disables driver */
+static int max_states = CPUIDLE_STATE_MAX;
+
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
 static void exynos4_set_wakeupmask(void)
 {
@@ -198,6 +205,16 @@ static int __init exynos_cpuidle_probe(struct platform_device *pdev)
 	int cpu_id, ret;
 	struct cpuidle_device *device;
 
+	if (max_states == 0) {
+		pr_info(PREFIX "disabled\n");
+		return 0;
+	}
+
+	if (max_states < exynos4_idle_driver.state_count) {
+		pr_info(PREFIX "limiting to %d state(s)\n", max_states);
+		exynos4_idle_driver.state_count = max_states;
+	}
+
 	if (soc_is_exynos5250())
 		exynos5_core_down_clk();
 
@@ -234,3 +251,5 @@ static struct platform_driver exynos_cpuidle_driver = {
 };
 
 module_platform_driver(exynos_cpuidle_driver);
+
+module_param(max_states, int, 0444);
-- 
1.8.2.3

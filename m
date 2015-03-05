From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH v2 4/6] ARM: shmobile: r8a7791: Add Core-Standby CPUIdle support for r8a7791
Date: Thu, 5 Mar 2015 17:59:01 +0900
Message-ID: <1425545943-1440-5-git-send-email-keita.kobayashi.ym@renesas.com>
References: <1425545943-1440-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1425545943-1440-1-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: horms@verge.net.au, rjw@rjwysocki.net
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, badarkhe.manish@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>
List-Id: linux-pm@vger.kernel.org

This patch Add the wfi and Core-Standby for CPUIdle power states
support for the r8a7791 SoC.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/mach-shmobile/pm-r8a7791.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7791.c b/arch/arm/mach-shmobile/pm-r8a7791.c
index 25f107b..784c284 100644
--- a/arch/arm/mach-shmobile/pm-r8a7791.c
+++ b/arch/arm/mach-shmobile/pm-r8a7791.c
@@ -10,8 +10,13 @@
  * for more details.
  */
 
+#include <linux/cpuidle.h>
 #include <linux/kernel.h>
 #include <linux/smp.h>
+#include <linux/platform_data/renesas-cpuidle.h>
+#include <linux/pm.h>
+#include <asm/cpuidle.h>
+#include <asm/cputype.h>
 #include <asm/io.h>
 #include "common.h"
 #include "pm-rcar.h"
@@ -43,6 +48,32 @@ static inline void r8a7791_sysc_init(void) {}
 
 #endif /* CONFIG_SMP */
 
+static struct cpuidle_driver r8a7791_cpuidle_driver = {
+	.name = "rcar_r8a7791_cpuidle",
+	.owner = THIS_MODULE,
+	.states = {
+		[0] = ARM_CPUIDLE_WFI_STATE,
+		[1] = {
+			.name = "Core-Standby",
+			.desc = "Core Standby Mode",
+			.exit_latency = 2800,
+			.target_residency = 2800,
+			.enter = shmobile_smp_apmu_enter_cpuidle,
+		},
+	},
+	.state_count = 2,
+};
+
+static struct renesas_cpuidle_driver r8a7791_cpuidle = {
+	.target_cpu	= ARM_CPU_PART_CORTEX_A15,
+	.renesas_drv	= &r8a7791_cpuidle_driver,
+};
+
+static struct renesas_cpuidle r8a7791_data = {
+	.num_drvs	= 1,
+	.rcd		= &r8a7791_cpuidle,
+};
+
 void __init r8a7791_pm_init(void)
 {
 	void __iomem *p;
@@ -70,4 +101,7 @@ void __init r8a7791_pm_init(void)
 
 	r8a7791_sysc_init();
 	shmobile_smp_apmu_suspend_init();
+
+	if (IS_ENABLED(CONFIG_ARM_RENESAS_CPUIDLE))
+		shmobile_cpuidle_set_driver(&r8a7791_data);
 }
-- 
1.9.1


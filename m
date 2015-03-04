From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH 5/6] ARM: shmobile: r8a7790: Add Core-Standby CPUIdle support for r8a7790
Date: Wed, 4 Mar 2015 13:55:45 +0900
Message-ID: <1425444946-3084-6-git-send-email-keita.kobayashi.ym@renesas.com>
References: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: horms@verge.net.au, rjw@rjwysocki.net
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>
List-Id: linux-pm@vger.kernel.org

Add the CPUIdle support power state support for the r8a7790 SoC.
This patch add the wfi and Core-Standby for CPUIdle power states
support for the Cortex-A15 and add the wfi power state support for
the Cortex-A7.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/mach-shmobile/pm-r8a7790.c | 55 +++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7790.c b/arch/arm/mach-shmobile/pm-r8a7790.c
index 80e8d95..6a3751f 100644
--- a/arch/arm/mach-shmobile/pm-r8a7790.c
+++ b/arch/arm/mach-shmobile/pm-r8a7790.c
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
@@ -48,6 +53,55 @@ static inline void r8a7790_sysc_init(void) {}
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_ARM_RENESAS_CPUIDLE
+static struct cpuidle_driver r8a7790_ca15_cpuidle_driver = {
+	.name = "rcar_r8a7790_ca15_cpuidle",
+	.owner = THIS_MODULE,
+	.states = {
+		[0] = ARM_CPUIDLE_WFI_STATE,
+		[1] = {
+			.name = "Core-Standby",
+			.desc = "Core Standby Mode",
+			.exit_latency = 3000,
+			.target_residency = 3000,
+			.enter = shmobile_smp_apmu_enter_cpuidle,
+		},
+	},
+	.state_count = 2,
+};
+
+static struct cpuidle_driver r8a7790_ca7_cpuidle_driver = {
+	.name			= "rcar_r8a7790_ca7_cpuidle",
+	.owner			= THIS_MODULE,
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.safe_state_index	= 0, /* C1 */
+	.state_count		= 1,
+};
+
+static struct renesas_cpuidle_driver r8a7790_cpuidle[] = {
+	[0] = {
+		.target_cpu	= ARM_CPU_PART_CORTEX_A15,
+		.renesas_drv	= &r8a7790_ca15_cpuidle_driver,
+	},
+	[1] = {
+		.target_cpu	= ARM_CPU_PART_CORTEX_A7,
+		.renesas_drv	= &r8a7790_ca7_cpuidle_driver,
+	},
+};
+
+static struct renesas_cpuidle r8a7790_data = {
+	.num_drvs	= ARRAY_SIZE(r8a7790_cpuidle),
+	.rcd		= r8a7790_cpuidle,
+};
+
+static void __init r8a7790_cpuidle_init(void)
+{
+	shmobile_cpuidle_set_driver(&r8a7790_data);
+}
+#else
+static void __init r8a7790_cpuidle_init(void) {}
+#endif
+
 void __init r8a7790_pm_init(void)
 {
 	void __iomem *p;
@@ -79,4 +133,5 @@ void __init r8a7790_pm_init(void)
 
 	r8a7790_sysc_init();
 	shmobile_smp_apmu_suspend_init();
+	r8a7790_cpuidle_init();
 }
-- 
1.9.1


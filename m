From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH 2/4] ARM: shmobile: Add cpuidle_ops for R-Car cpuidle
Date: Mon, 6 Apr 2015 12:50:42 +0900
Message-ID: <1428292244-2160-3-git-send-email-keita.kobayashi.ym@renesas.com>
References: <1428292244-2160-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1428292244-2160-1-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: horms@verge.net.au, rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>
List-Id: linux-pm@vger.kernel.org

This patch add Core-Standby support for R-Car cpuidle.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 11 +++++++++--
 arch/arm/mach-shmobile/platsmp-apmu.h |  1 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 17 +++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index f483b56..c8de95d 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -215,7 +215,7 @@ int shmobile_smp_apmu_cpu_kill(unsigned int cpu)
 }
 #endif
 
-#if defined(CONFIG_SUSPEND)
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_ARM_RCAR_CPUIDLE)
 static int shmobile_smp_apmu_do_suspend(unsigned long cpu)
 {
 	shmobile_smp_hook(cpu, virt_to_phys(cpu_resume), 0);
@@ -224,10 +224,17 @@ static int shmobile_smp_apmu_do_suspend(unsigned long cpu)
 	return 1;
 }
 
-static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
+void shmobile_smp_apmu_enter_corestandby(void)
 {
 	cpu_suspend(smp_processor_id(), shmobile_smp_apmu_do_suspend);
 	cpu_leave_lowpower();
+}
+#endif
+
+#if defined(CONFIG_SUSPEND)
+static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
+{
+	shmobile_smp_apmu_enter_corestandby();
 	return 0;
 }
 
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.h b/arch/arm/mach-shmobile/platsmp-apmu.h
index 76512c9..c7dc00a 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.h
+++ b/arch/arm/mach-shmobile/platsmp-apmu.h
@@ -28,5 +28,6 @@ extern int shmobile_smp_apmu_boot_secondary(unsigned int cpu,
 					    struct task_struct *idle);
 extern void shmobile_smp_apmu_cpu_die(unsigned int cpu);
 extern int shmobile_smp_apmu_cpu_kill(unsigned int cpu);
+extern void shmobile_smp_apmu_enter_corestandby(void);
 
 #endif /* PLATSMP_APMU_H */
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 6815781..846b8ae 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -10,11 +10,15 @@
  * for more details.
  */
 
+#include <linux/cpuidle.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <asm/cpuidle.h>
 #include <asm/io.h>
 #include "common.h"
+#include "platsmp-apmu.h"
 #include "pm-rcar.h"
 #include "rcar-gen2.h"
 
@@ -113,3 +117,16 @@ void __init rcar_gen2_pm_init(void)
 	rcar_gen2_sysc_init(syscier);
 	shmobile_smp_apmu_suspend_init();
 }
+
+#if defined(CONFIG_ARM_RCAR_CPUIDLE)
+static int rcar_cpuidle_enter(int cpu, unsigned long index)
+{
+	shmobile_smp_apmu_enter_corestandby();
+	return 0;
+}
+
+struct cpuidle_ops rcar_cpuidle_ops __initdata = {
+	.suspend = rcar_cpuidle_enter,
+};
+CPUIDLE_METHOD_OF_DECLARE(rcar, "renesas,rcar-idle", &rcar_cpuidle_ops);
+#endif
-- 
1.9.1


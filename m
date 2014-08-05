From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v5 3/5] ARM: EXYNOS: cpuidle: add secure firmware support to
 AFTR mode code
Date: Tue, 05 Aug 2014 15:34:24 +0200
Message-ID: <1407245666-20016-4-git-send-email-b.zolnierkie@samsung.com>
References: <1407245666-20016-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1407245666-20016-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

* Move cp15 registers saving to exynos_save_cp15() helper and add
  additional helper usage to do_idle firmware method.

* Use resume firmware method instead of exynos_cpu_restore_register()
  and skip exynos_cpu_save_register() on boards with secure firmware
  enabled.

* Use sysram_ns_base_addr + 0x24/0x20 addresses instead of the default
  ones used by exynos_cpu_set_boot_vector() on boards with secure
  firmware enabled.

* Use do_idle firmware method instead of cpu_do_idle() on boards with
  secure firmware enabled.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/firmware.c | 24 +++++++++++++++++-------
 arch/arm/mach-exynos/pm.c       | 17 ++++++++++++-----
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index e57b7c3..2c5bc6b 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -25,13 +25,28 @@
 #include "smc.h"
 
 #define EXYNOS_SLEEP_MAGIC	0x00000bad
+#define EXYNOS_AFTR_MAGIC	0xfcba0d10
 #define EXYNOS_BOOT_ADDR	0x8
 #define EXYNOS_BOOT_FLAG	0xc
 
+static void exynos_save_cp15(void)
+{
+	/* Save Power control and Diagnostic registers */
+	asm ("mrc p15, 0, %0, c15, c0, 0\n"
+	     "mrc p15, 0, %1, c15, c0, 1\n"
+	     : "=r" (cp15_save_power), "=r" (cp15_save_diag)
+	     : : "cc");
+}
+
 static int exynos_do_idle(unsigned long mode)
 {
 	switch (mode) {
 	case FW_DO_IDLE_AFTR:
+		if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
+			exynos_save_cp15();
+		__raw_writel(virt_to_phys(exynos_cpu_resume_ns),
+			     sysram_ns_base_addr + 0x24);
+		__raw_writel(EXYNOS_AFTR_MAGIC, sysram_ns_base_addr + 0x20);
 		exynos_smc(SMC_CMD_CPU0AFTR, 0, 0, 0);
 		break;
 	case FW_DO_IDLE_SLEEP:
@@ -96,13 +111,8 @@ static int exynos_cpu_suspend(unsigned long arg)
 
 static int exynos_suspend(void)
 {
-	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
-		/* Save Power control and Diagnostic registers */
-		asm ("mrc p15, 0, %0, c15, c0, 0\n"
-			"mrc p15, 0, %1, c15, c0, 1\n"
-			: "=r" (cp15_save_power), "=r" (cp15_save_diag)
-			: : "cc");
-	}
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
+		exynos_save_cp15();
 
 	writel(EXYNOS_SLEEP_MAGIC, sysram_ns_base_addr + EXYNOS_BOOT_FLAG);
 	writel(virt_to_phys(exynos_cpu_resume_ns),
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 78e50ed..e0b6885 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -209,11 +209,19 @@ static void exynos_cpu_set_boot_vector(long flags)
 
 static int exynos_aftr_finisher(unsigned long flags)
 {
+	int ret;
+
 	exynos_set_wakeupmask(0x0000ff3e);
-	exynos_cpu_set_boot_vector(S5P_CHECK_AFTR);
 	/* Set value of power down register for aftr mode */
 	exynos_sys_powerdown_conf(SYS_AFTR);
-	cpu_do_idle();
+
+	ret = call_firmware_op(do_idle, FW_DO_IDLE_AFTR);
+	if (ret == -ENOSYS) {
+		if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
+			exynos_cpu_save_register();
+		exynos_cpu_set_boot_vector(S5P_CHECK_AFTR);
+		cpu_do_idle();
+	}
 
 	return 1;
 }
@@ -223,14 +231,13 @@ void exynos_enter_aftr(void)
 	cpu_pm_enter();
 
 	exynos_pm_central_suspend();
-	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
-		exynos_cpu_save_register();
 
 	cpu_suspend(0, exynos_aftr_finisher);
 
 	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
 		scu_enable(S5P_VA_SCU);
-		exynos_cpu_restore_register();
+		if (call_firmware_op(resume) == -ENOSYS)
+			exynos_cpu_restore_register();
 	}
 
 	exynos_pm_central_resume();
-- 
1.8.2.3

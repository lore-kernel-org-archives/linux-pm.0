From: preeti <preeti@linux.vnet.ibm.com>
Subject: Cpuidle drivers,Suspend : Fix suspend/resume hang with intel_idle
 driver
Date: Thu, 28 Jun 2012 14:46:02 +0530
Message-ID: <4FEC20D2.2070501@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Dave Hansen <dave@linux.vnet.ibm.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, "Rafael .J. Wysocki" <rjw@sisk.pl>
Cc: "Srivatsa.S.Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org


From: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Dave Hansen reported problems with suspend/resume when used
with intel_idle driver.More such problems were noticed.
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/674075.

The reason for this could not be suspected till he reported
resume hang issue when used with acpi idle driver on his Lenovo-S10-3
Atom netbook.

The patch-[PM / ACPI: Fix suspend/resume regression caused by cpuidle
cleanup],fixed this issue by ensuring that acpi idle drivers prevent
cpus from going into deeper sleep states during suspend to prevent
resume hang on certain bios.
http://marc.info/?l=linux-pm&m=133958534231884&w=2

Commit b04e7bdb984e3b7f62fb7f44146a529f88cc7639
(ACPI: disable lower idle C-states across suspend/resume) throws
light on the resume hang issue on certain specific bios.

Also the following lines in drivers/idle/intel_idle.c suggest intel_idle
drivers should also ensure cpus are prevented from entering idle states
during suspend to avoid a resume hang.

/*
 * Known limitations
 * [..]
 *
 * ACPI has a .suspend hack to turn off deep c-states during suspend
 * to avoid complications with the lapic timer workaround.
 * Have not seen issues with suspend, but may need same workaround here.
 *
 */
This patch aims at having this fix in a place common to both the idle
drivers.

Suspend is enabled only if ACPI is active on x86.Thus the setting of
acpi_idle_suspend during suspend is moved up to ACPI specific code with
both acpi and intel idle drivers checking if it is valid to enter deeper
idle states.The setting of acpi_idle_suspend is done via PM_SUSPEND_PREPARE
notifiers to avoid race conditions between processors entering idle states
and the ongoing process of suspend.

The check on acpi_idle_suspend is included in the most appropriate header
so as to be visible to both the idle drivers irrespective of the
different configurations.Even if ACPI is disabled intel idle drivers can
still carry out the acpi_idle_suspend check.

Reported-by: Dave Hansen <dave@linux.vnet.ibm.com>
Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Reviewed-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
Dave, does this patch ensure suspend/resume works
fine on your netbook if intel_idle driver is enabled?

 drivers/acpi/processor_idle.c |   46 +++++++++++++++++++----------------------
 drivers/acpi/sleep.c          |   38 ++++++++++++++++++++++++++++++++++
 drivers/idle/intel_idle.c     |   10 +++++++++
 include/linux/suspend.h       |   24 +++++++++++++++++++++
 4 files changed, 93 insertions(+), 25 deletions(-)


diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index c2ffd84..3ab0963 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -41,7 +41,7 @@
 #include <linux/clockchips.h>
 #include <linux/cpuidle.h>
 #include <linux/irqflags.h>
-
+#include <linux/suspend.h>
 /*
  * Include the apic definitions for x86 to have the APIC timer related defines
  * available also for UP (on SMP it gets magically included via linux/smp.h).
@@ -221,10 +221,6 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
 
 #endif
 
-/*
- * Suspend / resume control
- */
-static int acpi_idle_suspend;
 static u32 saved_bm_rld;
 
 static void acpi_idle_bm_rld_save(void)
@@ -243,21 +239,13 @@ static void acpi_idle_bm_rld_restore(void)
 
 int acpi_processor_suspend(struct acpi_device * device, pm_message_t state)
 {
-	if (acpi_idle_suspend == 1)
-		return 0;
-
 	acpi_idle_bm_rld_save();
-	acpi_idle_suspend = 1;
 	return 0;
 }
 
 int acpi_processor_resume(struct acpi_device * device)
 {
-	if (acpi_idle_suspend == 0)
-		return 0;
-
 	acpi_idle_bm_rld_restore();
-	acpi_idle_suspend = 0;
 	return 0;
 }
 
@@ -762,11 +750,13 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 		return -EINVAL;
 
 	local_irq_disable();
-
-	if (acpi_idle_suspend) {
+	/*
+	 * Do not enter idle states if you are in suspend path
+	 */
+	if (in_suspend_path()) {
 		local_irq_enable();
 		cpu_relax();
-		return -EINVAL;
+		return -EBUSY;
 	}
 
 	lapic_timer_state_broadcast(pr, cx, 1);
@@ -838,10 +828,13 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 
 	local_irq_disable();
 
-	if (acpi_idle_suspend) {
+	/*
+	 * Do not enter idle states if you are in suspend path
+	 */
+	if (in_suspend_path()) {
 		local_irq_enable();
 		cpu_relax();
-		return -EINVAL;
+		return -EBUSY;
 	}
 
 	if (cx->entry_method != ACPI_CSTATE_FFH) {
@@ -922,12 +915,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	if (unlikely(!pr))
 		return -EINVAL;
 
-	if (acpi_idle_suspend) {
-		if (irqs_disabled())
-			local_irq_enable();
-		cpu_relax();
-		return -EINVAL;
-	}
 
 	if (!cx->bm_sts_skip && acpi_idle_bm_check()) {
 		if (drv->safe_state_index >= 0) {
@@ -935,13 +922,22 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 						drv, drv->safe_state_index);
 		} else {
 			local_irq_disable();
-			acpi_safe_halt();
+			if (!(in_suspend_path()))
+				acpi_safe_halt();
 			local_irq_enable();
 			return -EINVAL;
 		}
 	}
 
 	local_irq_disable();
+	/*
+	 * Do not enter idle states if you are in suspend path
+	 */
+	if (in_suspend_path()) {
+		local_irq_enable();
+		cpu_relax();
+		return -EBUSY;
+	}
 
 	if (cx->entry_method != ACPI_CSTATE_FFH) {
 		current_thread_info()->status &= ~TS_POLLING;
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 8856102..4ec77db 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -28,6 +28,11 @@
 #include "internal.h"
 #include "sleep.h"
 
+/*
+ * Suspend/Resume control
+ */
+int acpi_idle_suspend;
+
 u8 wake_sleep_flags = ACPI_NO_OPTIONAL_METHODS;
 static unsigned int gts, bfs;
 static int set_param_wake_flag(const char *val, struct kernel_param *kp)
@@ -905,6 +910,36 @@ static void __init acpi_gts_bfs_check(void)
 	}
 }
 
+/**
+ * cpuidle_pm_callback - On some bios, resume hangs
+ * if idle states are entered during suspend.
+ *
+ * acpi_idle_suspend is used by the x86 idle drivers
+ * to decide whether to go into idle states or not.
+ */
+static int
+cpuidle_pm_callback(struct notifier_block *nb,
+			unsigned long action, void *ptr)
+{
+	switch (action) {
+
+	case PM_SUSPEND_PREPARE:
+		if (acpi_idle_suspend == 0)
+			acpi_idle_suspend = 1;
+		break;
+
+	case PM_POST_SUSPEND:
+		if (acpi_idle_suspend == 1)
+			acpi_idle_suspend = 0;
+		break;
+
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
 int __init acpi_sleep_init(void)
 {
 	acpi_status status;
@@ -932,6 +967,9 @@ int __init acpi_sleep_init(void)
 
 	suspend_set_ops(old_suspend_ordering ?
 		&acpi_suspend_ops_old : &acpi_suspend_ops);
+
+	pm_notifier(cpuidle_pm_callback, 0);
+
 #endif
 
 #ifdef CONFIG_HIBERNATION
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d0f59c3..a595207 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -65,6 +65,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <linux/suspend.h>
 
 #define INTEL_IDLE_VERSION "0.4"
 #define PREFIX "intel_idle: "
@@ -255,6 +256,15 @@ static int intel_idle(struct cpuidle_device *dev,
 	cstate = (((eax) >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) + 1;
 
 	/*
+	 * Do not enter idle states if you are in suspend path
+	 */
+	if (in_suspend_path()) {
+		local_irq_enable();
+		cpu_relax();
+		return -EBUSY;
+	}
+
+	/*
 	 * leave_mm() to avoid costly and often unnecessary wakeups
 	 * for flushing the user TLB's associated with the active mm.
 	 */
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 0c808d7..eb96670 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -38,6 +38,30 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_MEM		((__force suspend_state_t) 3)
 #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
 
+extern int acpi_idle_suspend;
+
+/**
+ * in_suspend_path - X86 idle drivers make a call
+ * to this function before entering idle states.
+ *
+ * Entering idle states is prevented if it is in suspend
+ * path.
+ */
+#ifdef CONFIG_ACPI
+static inline int in_suspend_path(void)
+{
+	if (acpi_idle_suspend == 1)
+		return 1;
+	else
+		return 0;
+}
+#else
+static inline int in_suspend_path(void)
+{
+	return 0;
+}
+#endif
+
 enum suspend_stat_step {
 	SUSPEND_FREEZE = 1,
 	SUSPEND_PREPARE,

Regards,
Preeti U Murthy


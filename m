From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] ACPI PM: Add suspend sequence workaround
Date: Tue, 6 May 2008 23:44:30 +0200
Message-ID: <200805062344.31117.rjw__18569.6377921433$1210110685$gmane$org@sisk.pl>
References: <200805062342.42789.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805062342.42789.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There are some systems out there that don't work correctly with
our current suspend/hibernation code ordering.  Provide a workaround
for these systems allowing them to pass the
'acpi_old_suspend_ordering' command line parameter to the kernel that
will make it use the pre-ACPI 2.0 suspend code ordering.

Unfortunately, that requires us to add a platform hook to the
resuming of devices for recovering the platform in case one of the
device drivers' .suspend() routines returns error code.  Namely,
ACPI 1.0 specifies that _PTS should be called before suspending
devices, but _WAK still should be called before resuming them in
order to undo the changes made by _PTS.  However, if there is an
error during suspending devices, they are automatically resumed
without returning control to the PM core, so the _WAK has to be
called from within device_resume() in that cases.

The patch also reorders and refactors the ACPI suspend/hibernation
code to avoid duplication as far as reasonably possible.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/kernel-parameters.txt |    5 
 drivers/acpi/sleep/main.c           |  301 +++++++++++++++++++++---------------
 drivers/base/power/main.c           |   15 +
 include/linux/pm.h                  |    2 
 4 files changed, 201 insertions(+), 122 deletions(-)

Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -170,6 +170,11 @@ and is between 256 and 4096 characters. 
 	acpi_irq_isa=	[HW,ACPI] If irq_balance, mark listed IRQs used by ISA
 			Format: <irq>,<irq>...
 
+       acpi_old_suspend_ordering [HW,ACPI]
+                       Enforce the ACPI 1.0 ordering of the _PTS control
+                       method wrt putting devices into low power states
+                       default: ACPI 2.0 ordering of _PTS
+
 	acpi_no_auto_ssdt	[HW,ACPI] Disable automatic loading of SSDT
 
 	acpi_os_name=	[HW,ACPI] Tell ACPI BIOS the name of the OS
Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -15,6 +15,7 @@
 #include <linux/dmi.h>
 #include <linux/device.h>
 #include <linux/suspend.h>
+#include <linux/pm.h>
 
 #include <asm/io.h>
 
@@ -24,10 +25,6 @@
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
 
-#ifdef CONFIG_PM_SLEEP
-static u32 acpi_target_sleep_state = ACPI_STATE_S0;
-#endif
-
 static int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
@@ -50,9 +47,107 @@ static int acpi_sleep_prepare(u32 acpi_s
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
-static struct platform_suspend_ops acpi_suspend_ops;
+#ifdef CONFIG_PM_SLEEP
+static u32 acpi_target_sleep_state = ACPI_STATE_S0;
+
+static int init_8259A_after_S1;
+
+/*
+ * ACPI 1.0 wants us to execute _PTS before suspending devices, so we allow the
+ * user to request that behavior by using the 'acpi_old_suspend_ordering'
+ * kernel command line option that causes the following variable to be set.
+ */
+static bool old_suspend_ordering;
+
+static int __init acpi_old_suspend_ordering(char *str)
+{
+	old_suspend_ordering = true;
+	return 1;
+}
+__setup("acpi_old_suspend_ordering", acpi_old_suspend_ordering);
+
+/**
+ *	acpi_pm_disable_gpes - Disable the GPEs.
+ */
+static int acpi_pm_disable_gpes(void)
+{
+	acpi_hw_disable_all_gpes();
+	return 0;
+}
+
+/**
+ *	__acpi_pm_prepare - Prepare the platform to enter the target state.
+ *
+ *	If necessary, set the firmware waking vector and do arch-specific
+ *	nastiness to get the wakeup code to the waking vector.
+ */
+static int __acpi_pm_prepare(void)
+{
+	int error = acpi_sleep_prepare(acpi_target_sleep_state);
+
+	if (error)
+		acpi_target_sleep_state = ACPI_STATE_S0;
+	return error;
+}
+
+/**
+ *	acpi_pm_prepare - Prepare the platform to enter the target sleep
+ *		state and disable the GPEs.
+ */
+static int acpi_pm_prepare(void)
+{
+	int error = __acpi_pm_prepare();
+
+	if (!error)
+		acpi_hw_disable_all_gpes();
+	return error;
+}
+
+/**
+ *	acpi_pm_finish - Instruct the platform to leave a sleep state.
+ *
+ *	This is called after we wake back up (or if entering the sleep state
+ *	failed).
+ */
+static void acpi_pm_finish(void)
+{
+	u32 acpi_state = acpi_target_sleep_state;
+
+	if (acpi_state == ACPI_STATE_S0)
+		return;
+
+	printk(KERN_INFO PREFIX "Waking up from system sleep state S%d\n",
+		acpi_state);
+	acpi_disable_wakeup_device(acpi_state);
+	acpi_leave_sleep_state(acpi_state);
+
+	/* reset firmware waking vector */
+	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
+
+	acpi_target_sleep_state = ACPI_STATE_S0;
+
+#ifdef CONFIG_X86
+	if (acpi_state == ACPI_STATE_S1 && init_8259A_after_S1) {
+		printk("Broken toshiba laptop -> kicking interrupts\n");
+		init_8259A(0);
+	}
+#endif
+}
+
+/**
+ *	acpi_pm_end - Finish up suspend sequence.
+ */
+static void acpi_pm_end(void)
+{
+	/*
+	 * This is necessary in case acpi_pm_finish() is not called during a
+	 * failing transition to a sleep state.
+	 */
+	acpi_target_sleep_state = ACPI_STATE_S0;
+}
+#endif /* CONFIG_PM_SLEEP */
 
+#ifdef CONFIG_SUSPEND
 extern void do_suspend_lowlevel(void);
 
 static u32 acpi_suspend_states[] = {
@@ -62,13 +157,10 @@ static u32 acpi_suspend_states[] = {
 	[PM_SUSPEND_MAX] = ACPI_STATE_S5
 };
 
-static int init_8259A_after_S1;
-
 /**
  *	acpi_suspend_begin - Set the target system sleep state to the state
  *		associated with given @pm_state, if supported.
  */
-
 static int acpi_suspend_begin(suspend_state_t pm_state)
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
@@ -85,25 +177,6 @@ static int acpi_suspend_begin(suspend_st
 }
 
 /**
- *	acpi_suspend_prepare - Do preliminary suspend work.
- *
- *	If necessary, set the firmware waking vector and do arch-specific
- *	nastiness to get the wakeup code to the waking vector.
- */
-
-static int acpi_suspend_prepare(void)
-{
-	int error = acpi_sleep_prepare(acpi_target_sleep_state);
-
-	if (error) {
-		acpi_target_sleep_state = ACPI_STATE_S0;
-		return error;
-	}
-
-	return ACPI_SUCCESS(acpi_hw_disable_all_gpes()) ? 0 : -EFAULT;
-}
-
-/**
  *	acpi_suspend_enter - Actually enter a sleep state.
  *	@pm_state: ignored
  *
@@ -111,7 +184,6 @@ static int acpi_suspend_prepare(void)
  *	assembly, which in turn call acpi_enter_sleep_state().
  *	It's unfortunate, but it works. Please fix if you're feeling frisky.
  */
-
 static int acpi_suspend_enter(suspend_state_t pm_state)
 {
 	acpi_status status = AE_OK;
@@ -168,46 +240,6 @@ static int acpi_suspend_enter(suspend_st
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
-/**
- *	acpi_suspend_finish - Instruct the platform to leave a sleep state.
- *
- *	This is called after we wake back up (or if entering the sleep state
- *	failed). 
- */
-
-static void acpi_suspend_finish(void)
-{
-	u32 acpi_state = acpi_target_sleep_state;
-
-	acpi_disable_wakeup_device(acpi_state);
-	acpi_leave_sleep_state(acpi_state);
-
-	/* reset firmware waking vector */
-	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
-
-	acpi_target_sleep_state = ACPI_STATE_S0;
-
-#ifdef CONFIG_X86
-	if (init_8259A_after_S1) {
-		printk("Broken toshiba laptop -> kicking interrupts\n");
-		init_8259A(0);
-	}
-#endif
-}
-
-/**
- *	acpi_suspend_end - Finish up suspend sequence.
- */
-
-static void acpi_suspend_end(void)
-{
-	/*
-	 * This is necessary in case acpi_suspend_finish() is not called during a
-	 * failing transition to a sleep state.
-	 */
-	acpi_target_sleep_state = ACPI_STATE_S0;
-}
-
 static int acpi_suspend_state_valid(suspend_state_t pm_state)
 {
 	u32 acpi_state;
@@ -227,10 +259,38 @@ static int acpi_suspend_state_valid(susp
 static struct platform_suspend_ops acpi_suspend_ops = {
 	.valid = acpi_suspend_state_valid,
 	.begin = acpi_suspend_begin,
-	.prepare = acpi_suspend_prepare,
+	.prepare = acpi_pm_prepare,
+	.enter = acpi_suspend_enter,
+	.finish = acpi_pm_finish,
+	.end = acpi_pm_end,
+};
+
+/**
+ *	acpi_suspend_begin_old - Set the target system sleep state to the
+ *		state associated with given @pm_state, if supported, and
+ *		execute the _PTS control method.  This function is used if the
+ *		pre-ACPI 2.0 suspend ordering has been requested.
+ */
+static int acpi_suspend_begin_old(suspend_state_t pm_state)
+{
+	int error = acpi_suspend_begin(pm_state);
+
+	if (!error)
+		error = __acpi_pm_prepare();
+	return error;
+}
+
+/*
+ * The following callbacks are used if the pre-ACPI 2.0 suspend ordering has
+ * been requested.
+ */
+static struct platform_suspend_ops acpi_suspend_ops_old = {
+	.valid = acpi_suspend_state_valid,
+	.begin = acpi_suspend_begin_old,
+	.prepare = acpi_pm_disable_gpes,
 	.enter = acpi_suspend_enter,
-	.finish = acpi_suspend_finish,
-	.end = acpi_suspend_end,
+	.finish = acpi_pm_finish,
+	.end = acpi_pm_end,
 };
 
 /*
@@ -269,22 +329,9 @@ __setup("acpi_s4_nosigcheck", acpi_s4_no
 static int acpi_hibernation_begin(void)
 {
 	acpi_target_sleep_state = ACPI_STATE_S4;
-
 	return 0;
 }
 
-static int acpi_hibernation_prepare(void)
-{
-	int error = acpi_sleep_prepare(ACPI_STATE_S4);
-
-	if (error) {
-		acpi_target_sleep_state = ACPI_STATE_S0;
-		return error;
-	}
-
-	return ACPI_SUCCESS(acpi_hw_disable_all_gpes()) ? 0 : -EFAULT;
-}
-
 static int acpi_hibernation_enter(void)
 {
 	acpi_status status = AE_OK;
@@ -320,52 +367,54 @@ static void acpi_hibernation_leave(void)
 	}
 }
 
-static void acpi_hibernation_finish(void)
+static void acpi_pm_enable_gpes(void)
 {
-	acpi_disable_wakeup_device(ACPI_STATE_S4);
-	acpi_leave_sleep_state(ACPI_STATE_S4);
-
-	/* reset firmware waking vector */
-	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
-
-	acpi_target_sleep_state = ACPI_STATE_S0;
+	acpi_hw_enable_all_runtime_gpes();
 }
 
-static void acpi_hibernation_end(void)
-{
-	/*
-	 * This is necessary in case acpi_hibernation_finish() is not called
-	 * during a failing transition to the sleep state.
-	 */
-	acpi_target_sleep_state = ACPI_STATE_S0;
-}
+static struct platform_hibernation_ops acpi_hibernation_ops = {
+	.begin = acpi_hibernation_begin,
+	.end = acpi_pm_end,
+	.pre_snapshot = acpi_pm_prepare,
+	.finish = acpi_pm_finish,
+	.prepare = acpi_pm_prepare,
+	.enter = acpi_hibernation_enter,
+	.leave = acpi_hibernation_leave,
+	.pre_restore = acpi_pm_disable_gpes,
+	.restore_cleanup = acpi_pm_enable_gpes,
+};
 
-static int acpi_hibernation_pre_restore(void)
+/**
+ *	acpi_hibernation_begin_old - Set the target system sleep state to
+ *		ACPI_STATE_S4 and execute the _PTS control method.  This
+ *		function is used if the pre-ACPI 2.0 suspend ordering has been
+ *		requested.
+ */
+static int acpi_hibernation_begin_old(void)
 {
-	acpi_status status;
-
-	status = acpi_hw_disable_all_gpes();
-
-	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
-}
+	int error = acpi_sleep_prepare(ACPI_STATE_S4);
 
-static void acpi_hibernation_restore_cleanup(void)
-{
-	acpi_hw_enable_all_runtime_gpes();
+	if (!error)
+		acpi_target_sleep_state = ACPI_STATE_S4;
+	return error;
 }
 
-static struct platform_hibernation_ops acpi_hibernation_ops = {
-	.begin = acpi_hibernation_begin,
-	.end = acpi_hibernation_end,
-	.pre_snapshot = acpi_hibernation_prepare,
-	.finish = acpi_hibernation_finish,
-	.prepare = acpi_hibernation_prepare,
+/*
+ * The following callbacks are used if the pre-ACPI 2.0 suspend ordering has
+ * been requested.
+ */
+static struct platform_hibernation_ops acpi_hibernation_ops_old = {
+	.begin = acpi_hibernation_begin_old,
+	.end = acpi_pm_end,
+	.pre_snapshot = acpi_pm_disable_gpes,
+	.finish = acpi_pm_finish,
+	.prepare = acpi_pm_disable_gpes,
 	.enter = acpi_hibernation_enter,
 	.leave = acpi_hibernation_leave,
-	.pre_restore = acpi_hibernation_pre_restore,
-	.restore_cleanup = acpi_hibernation_restore_cleanup,
+	.pre_restore = acpi_pm_disable_gpes,
+	.restore_cleanup = acpi_pm_enable_gpes,
 };
-#endif				/* CONFIG_HIBERNATION */
+#endif /* CONFIG_HIBERNATION */
 
 int acpi_suspend(u32 acpi_state)
 {
@@ -509,13 +558,15 @@ int __init acpi_sleep_init(void)
 		}
 	}
 
-	suspend_set_ops(&acpi_suspend_ops);
+	suspend_set_ops(old_suspend_ordering ?
+		&acpi_suspend_ops_old : &acpi_suspend_ops);
 #endif
 
 #ifdef CONFIG_HIBERNATION
 	status = acpi_get_sleep_type_data(ACPI_STATE_S4, &type_a, &type_b);
 	if (ACPI_SUCCESS(status)) {
-		hibernation_set_ops(&acpi_hibernation_ops);
+		hibernation_set_ops(old_suspend_ordering ?
+			&acpi_hibernation_ops_old : &acpi_hibernation_ops);
 		sleep_states[ACPI_STATE_S4] = 1;
 		printk(" S4");
 		if (!nosigcheck) {
@@ -527,6 +578,12 @@ int __init acpi_sleep_init(void)
 		}
 	}
 #endif
+
+#ifdef CONFIG_PM_SLEEP
+	if (old_suspend_ordering)
+		platform_pm_recover = acpi_pm_finish;
+#endif
+
 	status = acpi_get_sleep_type_data(ACPI_STATE_S5, &type_a, &type_b);
 	if (ACPI_SUCCESS(status)) {
 		sleep_states[ACPI_STATE_S5] = 1;
Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -28,6 +28,20 @@
 #include "power.h"
 
 /*
+ * Some platforms (most importantly ACPI) may need to be prepared for
+ * resuming devices in case of a failure to suspend them.  They should set
+ * this pointer to the routine that will always be called just prior to resuming
+ * devices.
+ */
+void (*platform_pm_recover)(void);
+
+static inline void recover_platform(void)
+{
+	if (platform_pm_recover)
+		platform_pm_recover();
+}
+
+/*
  * The entries in the dpm_list list are in a depth first order, simply
  * because children are guaranteed to be discovered after parents, and
  * are inserted at the back of the list on discovery.
@@ -511,6 +525,7 @@ static void dpm_complete(pm_message_t st
 void device_resume(pm_message_t state)
 {
 	might_sleep();
+	recover_platform();
 	dpm_resume(state);
 	dpm_complete(state);
 }
Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -445,6 +445,8 @@ struct dev_pm_info {
  */
 
 #ifdef CONFIG_PM_SLEEP
+extern void (*platform_pm_recover)(void);
+
 extern void device_pm_lock(void);
 extern void device_power_up(pm_message_t state);
 extern void device_resume(pm_message_t state);

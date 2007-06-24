From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 1/4] PM: Introduce set_target method
	in pm_ops
Date: Sun, 24 Jun 2007 22:40:39 +0200
Message-ID: <200706242240.40476.rjw__10318.8370158479$1182720677$gmane$org@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706242239.05678.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Some drivers may need to use ACPI to determine the low power states in which
to place their devices, but to provide the drivers with this information the
ACPI core needs to know what sleep state the system is going to enter.
Namely, the device's state should not be too high power for given system sleep
state and, if the device is supposed to be able to wake up the system, its state
should not be too low power for the wake up to be possible).  However,
pm_ops->prepare() is only called after the drivers' .suspend() callbacks have
been executed, so we need an additional means to pass the information of the
target system sleep state to the ACPI core.  For this purpose, we can introduce
an additional member function in 'struct pm_ops'.

Additionally, the at91 platform code incorrectly assumes that pm_ops->prepare()
will be called before devices are suspended and uses it for setting the target
system sleep state, so pm_ops->prepare() should to be replaced with the new
operation, pm_ops->set_target(), for this architecture.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-at91/pm.c   |    4 +-
 drivers/acpi/sleep/main.c |   84 ++++++++++++++++++++++++++++------------------
 include/linux/pm.h        |   53 +++++++++++++++++++----------
 kernel/power/main.c       |    6 ++-
 4 files changed, 95 insertions(+), 52 deletions(-)

Index: linux-2.6.22-rc5/include/linux/pm.h
===================================================================
--- linux-2.6.22-rc5.orig/include/linux/pm.h	2007-06-24 01:41:12.000000000 +0200
+++ linux-2.6.22-rc5/include/linux/pm.h	2007-06-24 20:38:33.000000000 +0200
@@ -110,37 +110,54 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
 
 /**
- * struct pm_ops - Callbacks for managing platform dependent suspend states.
- * @valid: Callback to determine whether the given state can be entered.
- *	Valid states are advertised in /sys/power/state but can still
- *	be rejected by prepare or enter if the conditions aren't right.
- *	There is a %pm_valid_only_mem function available that can be assigned
- *	to this if you only implement mem sleep.
+ * struct pm_ops - Callbacks for managing platform dependent system sleep
+ *	states.
  *
- * @prepare: Prepare the platform for the given suspend state. Can return a
- *	negative error code if necessary.
- *
- * @enter: Enter the given suspend state, must be assigned. Can return a
- *	negative error code if necessary.
- *
- * @finish: Called when the system has left the given state and all devices
- *	are resumed. The return value is ignored.
+ * @valid: Callback to determine if given system sleep state is supported by
+ *	the platform.  Valid (ie. supported) states are advertised in
+ *	/sys/power/state.  Note that it still may be impossible to enter given
+ *	system sleep state if the conditions aren't right.
+ *	There is the %pm_valid_only_mem function available that can be assigned
+ *	to this if the platform only supports mem sleep.
+ *
+ * @set_target: Tell the platform which system sleep state is going to be
+ *	entered.  The information passed to @set_target should be disregarded
+ *	by the platform as soon as @finish() is executed and if	@prepare()
+ *	fails.
+ *	This callback is optional.  However, if it is implemented, the
+ *	argument passed to @prepare(), @enter and @finish() must be ignored.
+ *
+ * @prepare: Prepare the platform for entering the system sleep state indicated
+ *	by @set_target().
+ *	This callback is optional.  It returns 0 on success or a negative
+ *	error code otherwise, in which case the system cannot enter given
+ *	sleep state.
+ *
+ * @enter: Enter the system sleep state indicated by @set_target().
+ *	This callback is mandatory.  It returns 0 on success or a negative
+ *	error code otherwise, in which case the system cannot enter given
+ *	sleep state.
+ *
+ * @finish: Called when the system has just left a sleep state.
+ *	This callback is optional, but should be implemented by platforms that
+ *	implement @prepare().  It is always called after @enter() (even if
+ *	@enter() fails).
  */
 struct pm_ops {
 	int (*valid)(suspend_state_t state);
+	int (*set_target)(suspend_state_t state);
 	int (*prepare)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
 };
 
+extern struct pm_ops *pm_ops;
+
 /**
  * pm_set_ops - set platform dependent power management ops
  * @pm_ops: The new power management operations to set.
  */
 extern void pm_set_ops(struct pm_ops *pm_ops);
-extern struct pm_ops *pm_ops;
-extern int pm_suspend(suspend_state_t state);
-
 extern int pm_valid_only_mem(suspend_state_t state);
 
 /**
@@ -161,6 +178,8 @@ extern void arch_suspend_disable_irqs(vo
  */
 extern void arch_suspend_enable_irqs(void);
 
+extern int pm_suspend(suspend_state_t state);
+
 /*
  * Device power management
  */
Index: linux-2.6.22-rc5/kernel/power/main.c
===================================================================
--- linux-2.6.22-rc5.orig/kernel/power/main.c	2007-06-24 01:41:49.000000000 +0200
+++ linux-2.6.22-rc5/kernel/power/main.c	2007-06-24 20:38:30.000000000 +0200
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/pm.h>
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/resume-trace.h>
@@ -161,6 +160,11 @@ int suspend_devices_and_enter(suspend_st
 	if (!pm_ops)
 		return -ENOSYS;
 
+	if (pm_ops->set_target) {
+		error = pm_ops->set_target(state);
+		if (error)
+			return error;
+	}
 	suspend_console();
 	error = device_suspend(PMSG_SUSPEND);
 	if (error) {
Index: linux-2.6.22-rc5/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.22-rc5.orig/drivers/acpi/sleep/main.c	2007-06-24 01:40:38.000000000 +0200
+++ linux-2.6.22-rc5/drivers/acpi/sleep/main.c	2007-06-24 20:38:30.000000000 +0200
@@ -34,34 +34,54 @@ static u32 acpi_suspend_states[] = {
 
 static int init_8259A_after_S1;
 
+extern int acpi_sleep_prepare(u32 acpi_state);
+extern void acpi_power_off(void);
+
+static u32 acpi_target_suspend_state = ACPI_STATE_S0;
+
+/**
+ *	acpi_pm_set_target - Set the target system sleep state to the state
+ *		associated with given @pm_state, if supported.
+ */
+
+static int acpi_pm_set_target(suspend_state_t pm_state)
+{
+	u32 acpi_state = acpi_suspend_states[pm_state];
+	int error = 0;
+
+	if (sleep_states[acpi_state]) {
+		acpi_target_suspend_state = acpi_state;
+	} else {
+		printk(KERN_ERR "ACPI does not support this state: %d\n",
+			pm_state);
+		error = -ENOSYS;
+	}
+	return error;
+}
+
 /**
  *	acpi_pm_prepare - Do preliminary suspend work.
- *	@pm_state:		suspend state we're entering.
+ *	@pm_state: ignored
  *
- *	Make sure we support the state. If we do, and we need it, set the
- *	firmware waking vector and do arch-specific nastiness to get the 
- *	wakeup code to the waking vector. 
+ *	If necessary, set the firmware waking vector and do arch-specific
+ *	nastiness to get the wakeup code to the waking vector.
  */
 
-extern int acpi_sleep_prepare(u32 acpi_state);
-extern void acpi_power_off(void);
-
 static int acpi_pm_prepare(suspend_state_t pm_state)
 {
-	u32 acpi_state = acpi_suspend_states[pm_state];
+	int error = acpi_sleep_prepare(acpi_target_suspend_state);
 
-	if (!sleep_states[acpi_state]) {
-		printk("acpi_pm_prepare does not support %d \n", pm_state);
-		return -EPERM;
-	}
-	return acpi_sleep_prepare(acpi_state);
+	if (error)
+		acpi_target_suspend_state = ACPI_STATE_S0;
+
+	return error;
 }
 
 /**
  *	acpi_pm_enter - Actually enter a sleep state.
- *	@pm_state:		State we're entering.
+ *	@pm_state: ignored
  *
- *	Flush caches and go to sleep. For STR or STD, we have to call 
+ *	Flush caches and go to sleep. For STR or S2, we have to call
  *	arch-specific assembly, which in turn call acpi_enter_sleep_state().
  *	It's unfortunate, but it works. Please fix if you're feeling frisky.
  */
@@ -70,31 +90,32 @@ static int acpi_pm_enter(suspend_state_t
 {
 	acpi_status status = AE_OK;
 	unsigned long flags = 0;
-	u32 acpi_state = acpi_suspend_states[pm_state];
+	u32 acpi_state = acpi_target_suspend_state;
 
 	ACPI_FLUSH_CPU_CACHE();
 
 	/* Do arch specific saving of state. */
-	if (pm_state > PM_SUSPEND_STANDBY) {
+	if (acpi_state == ACPI_STATE_S2 || acpi_state == ACPI_STATE_S3) {
 		int error = acpi_save_state_mem();
-		if (error)
+
+		if (error) {
+			acpi_target_suspend_state = ACPI_STATE_S0;
 			return error;
+		}
 	}
 
 	local_irq_save(flags);
 	acpi_enable_wakeup_device(acpi_state);
-	switch (pm_state) {
-	case PM_SUSPEND_STANDBY:
+	switch (acpi_state) {
+	case ACPI_STATE_S1:
 		barrier();
 		status = acpi_enter_sleep_state(acpi_state);
 		break;
 
-	case PM_SUSPEND_MEM:
+	case ACPI_STATE_S2:
+	case ACPI_STATE_S3:
 		do_suspend_lowlevel();
 		break;
-
-	default:
-		return -EINVAL;
 	}
 
 	/* ACPI 3.0 specs (P62) says that it's the responsabilty
@@ -114,12 +135,8 @@ static int acpi_pm_enter(suspend_state_t
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 
-	/* restore processor state
-	 * We should only be here if we're coming back from STR or STD.
-	 * And, in the case of the latter, the memory image should have already
-	 * been loaded from disk.
-	 */
-	if (pm_state > PM_SUSPEND_STANDBY)
+	/* restore processor state */
+	if (acpi_state == ACPI_STATE_S2 || acpi_state == ACPI_STATE_S3)
 		acpi_restore_state_mem();
 
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
@@ -127,7 +144,7 @@ static int acpi_pm_enter(suspend_state_t
 
 /**
  *	acpi_pm_finish - Finish up suspend sequence.
- *	@pm_state:		State we're coming out of.
+ *	@pm_state: ignored
  *
  *	This is called after we wake back up (or if entering the sleep state
  *	failed). 
@@ -135,7 +152,7 @@ static int acpi_pm_enter(suspend_state_t
 
 static int acpi_pm_finish(suspend_state_t pm_state)
 {
-	u32 acpi_state = acpi_suspend_states[pm_state];
+	u32 acpi_state = acpi_target_suspend_state;
 
 	acpi_leave_sleep_state(acpi_state);
 	acpi_disable_wakeup_device(acpi_state);
@@ -143,6 +160,8 @@ static int acpi_pm_finish(suspend_state_
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
+	acpi_target_suspend_state = ACPI_STATE_S0;
+
 	if (init_8259A_after_S1) {
 		printk("Broken toshiba laptop -> kicking interrupts\n");
 		init_8259A(0);
@@ -183,6 +202,7 @@ static int acpi_pm_state_valid(suspend_s
 
 static struct pm_ops acpi_pm_ops = {
 	.valid = acpi_pm_state_valid,
+	.set_target = acpi_pm_set_target,
 	.prepare = acpi_pm_prepare,
 	.enter = acpi_pm_enter,
 	.finish = acpi_pm_finish,
Index: linux-2.6.22-rc5/arch/arm/mach-at91/pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/arm/mach-at91/pm.c	2007-06-24 20:38:33.000000000 +0200
+++ linux-2.6.22-rc5/arch/arm/mach-at91/pm.c	2007-06-24 20:40:20.000000000 +0200
@@ -53,7 +53,7 @@ static suspend_state_t target_state;
 /*
  * Called after processes are frozen, but before we shutdown devices.
  */
-static int at91_pm_prepare(suspend_state_t state)
+static int at91_pm_set_target(suspend_state_t state)
 {
 	target_state = state;
 	return 0;
@@ -201,7 +201,7 @@ error:
 
 static struct pm_ops at91_pm_ops ={
 	.valid		= at91_pm_valid_state,
-	.prepare	= at91_pm_prepare,
+	.set_target	= at91_pm_set_target,
 	.enter		= at91_pm_enter,
 };
 

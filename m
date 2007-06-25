From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 2/8] ACPI: Implement the
	set_target() callback from pm_ops
Date: Tue, 26 Jun 2007 00:43:17 +0200
Message-ID: <200706260043.18150.rjw__39278.8120233037$1182811957$gmane$org@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl> <200706260039.17530.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706260039.17530.rjw@sisk.pl>
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

In the future some drivers may need to use ACPI to determine the low power
states in which to place their devices, but to provide the drivers with this
information the ACPI core needs to know what sleep state the system is going to
enter.  Namely, the device's state should not be too high power for given system
sleep state and, if the device is supposed to be able to wake up the system, its
state should not be too low power for the wake up to be possible).  For this
purpose, the ACPI core needs to implement the set_target() method from 'struct
pm_ops' and store the target system sleep state passed by the PM core in a
variable.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |   84 ++++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 32 deletions(-)

Index: linux-2.6.22-rc6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.22-rc6.orig/drivers/acpi/sleep/main.c	2007-06-25 21:09:18.000000000 +0200
+++ linux-2.6.22-rc6/drivers/acpi/sleep/main.c	2007-06-25 21:34:46.000000000 +0200
@@ -34,34 +34,54 @@ static u32 acpi_suspend_states[] = {
 
 static int init_8259A_after_S1;
 
+extern int acpi_sleep_prepare(u32 acpi_state);
+extern void acpi_power_off(void);
+
+static u32 acpi_target_sleep_state = ACPI_STATE_S0;
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
+		acpi_target_sleep_state = acpi_state;
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
+	int error = acpi_sleep_prepare(acpi_target_sleep_state);
 
-	if (!sleep_states[acpi_state]) {
-		printk("acpi_pm_prepare does not support %d \n", pm_state);
-		return -EPERM;
-	}
-	return acpi_sleep_prepare(acpi_state);
+	if (error)
+		acpi_target_sleep_state = ACPI_STATE_S0;
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
+	u32 acpi_state = acpi_target_sleep_state;
 
 	ACPI_FLUSH_CPU_CACHE();
 
 	/* Do arch specific saving of state. */
-	if (pm_state > PM_SUSPEND_STANDBY) {
+	if (acpi_state == ACPI_STATE_S2 || acpi_state == ACPI_STATE_S3) {
 		int error = acpi_save_state_mem();
-		if (error)
+
+		if (error) {
+			acpi_target_sleep_state = ACPI_STATE_S0;
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
+	u32 acpi_state = acpi_target_sleep_state;
 
 	acpi_leave_sleep_state(acpi_state);
 	acpi_disable_wakeup_device(acpi_state);
@@ -143,6 +160,8 @@ static int acpi_pm_finish(suspend_state_
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
+	acpi_target_sleep_state = ACPI_STATE_S0;
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

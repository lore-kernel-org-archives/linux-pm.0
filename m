From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] ACPI PM: Add possibility to change
	suspend sequence
Date: Tue, 13 May 2008 01:03:25 +0200
Message-ID: <200805130103.26644.rjw__6973.26820013604$1210633575$gmane$org@sisk.pl>
References: <200805062342.42789.rjw@sisk.pl>
	<20080512072301.GC24094@elf.ucw.cz>
	<200805130034.06604.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805130034.06604.rjw@sisk.pl>
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
To: Pavel Machek <pavel@suse.cz>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 13 of May 2008, Rafael J. Wysocki wrote:
> On Monday, 12 of May 2008, Pavel Machek wrote:
> > Hi!
> > 
> > > Index: linux-2.6/Documentation/kernel-parameters.txt
> > > ===================================================================
> > > --- linux-2.6.orig/Documentation/kernel-parameters.txt
> > > +++ linux-2.6/Documentation/kernel-parameters.txt
> > > @@ -157,6 +157,11 @@ and is between 256 and 4096 characters. 
> > >  			default: The hardware signature is checked during
> > >  			         resume from S4.
> > >  
> > > +	acpi_old_suspend_ordering [HW,ACPI] ACPI suspend ordering
> > > +			Enforce the ACPI 1.0 ordering of the _PTS control
> > > +			method wrt putting devices into low power states
> > > +			default: ACPI 2.0 ordering of _PTS
> > > +
> > >  	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
> > >  			Format: { level | edge | high | low }
> > >
> > 
> > Hmm, I have a wild idea...
> > 
> > acpi_sleep=old_ordering
> > 
> > ...and reuse the same variable we already use for
> > s3_bios/s3_mode. Then, we'd be able to blacklist the systems needing
> > old_ordering from s2ram...
> > 
> > I guess this whitelist should better be done in kernel, but short-term
> > ability to whitelist from userland could not hurt...?
> 
> There's one problem with that, acpi_sleep is x86-specific and it's actually
> handled in arch/x86/kernel/acpi/sleep.c .  Well, ok, I think I can handle that,
> but it won't look nice.

Below is the result, please have a look.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

There are some systems out there that don't work correctly with
our current suspend/hibernation code ordering.  Provide a workaround
for these systems allowing them to pass the
'acpi_sleep=old_ordering' in the kernel command line which will make
the kernel use the pre-ACPI 2.0 suspend code ordering.

Unfortunately, that requires us to rework the resuming of devices for
recovering the platform in case one of the device drivers' .suspend()
routines returns error code.  Namely, ACPI 1.0 specifies that _PTS
should be called before suspending devices, but _WAK still should be
called before resuming them in order to undo the changes made by
_PTS.  However, if there is an error during suspending devices, they
are automatically resumed without returning control to the PM core
and that has to be changed.  For this reason, the high-level suspend
and hibernation code has to be changed as well and new platform
callbacks are necessary.

The patch also reorders and refactors the ACPI suspend/hibernation
code to avoid duplication as far as reasonably possible.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/kernel-parameters.txt |    6 
 arch/x86/kernel/acpi/sleep.c        |    2 
 drivers/acpi/sleep/main.c           |  276 +++++++++++++++++++++---------------
 drivers/base/power/main.c           |    2 
 include/linux/acpi.h                |    3 
 include/linux/suspend.h             |   14 +
 kernel/power/disk.c                 |   28 ++-
 kernel/power/main.c                 |   10 -
 8 files changed, 215 insertions(+), 126 deletions(-)

Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -147,10 +147,14 @@ and is between 256 and 4096 characters. 
 			default: 0
 
 	acpi_sleep=	[HW,ACPI] Sleep options
-			Format: { s3_bios, s3_mode, s3_beep }
+			Format: { s3_bios, s3_mode, s3_beep, old_ordering }
 			See Documentation/power/video.txt for s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
 			as soon as the kernel's real-mode entry point is called.
+			old_ordering causes the ACPI 1.0 ordering of the _PTS
+			control method, wrt putting devices into low power
+			states, to be enforced (the ACPI 2.0 ordering of _PTS is
+			used by default).
 
 	acpi_s4_nosigcheck [HW,ACPI] S4 hardware signature
 			ACPI will ignore the S4 hardware signature
Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -24,10 +24,6 @@
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
 
-#ifdef CONFIG_PM_SLEEP
-static u32 acpi_target_sleep_state = ACPI_STATE_S0;
-#endif
-
 static int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
@@ -50,9 +46,96 @@ static int acpi_sleep_prepare(u32 acpi_s
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
-static struct platform_suspend_ops acpi_suspend_ops;
+#ifdef CONFIG_PM_SLEEP
+static u32 acpi_target_sleep_state = ACPI_STATE_S0;
+
+/*
+ * ACPI 1.0 wants us to execute _PTS before suspending devices, so we allow the
+ * user to request that behavior by using the 'acpi_old_suspend_ordering'
+ * kernel command line option that causes the following variable to be set.
+ */
+static bool old_suspend_ordering;
+
+void __init acpi_old_suspend_ordering(void)
+{
+	old_suspend_ordering = true;
+}
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
@@ -66,7 +149,6 @@ static u32 acpi_suspend_states[] = {
  *	acpi_suspend_begin - Set the target system sleep state to the state
  *		associated with given @pm_state, if supported.
  */
-
 static int acpi_suspend_begin(suspend_state_t pm_state)
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
@@ -83,25 +165,6 @@ static int acpi_suspend_begin(suspend_st
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
@@ -109,7 +172,6 @@ static int acpi_suspend_prepare(void)
  *	assembly, which in turn call acpi_enter_sleep_state().
  *	It's unfortunate, but it works. Please fix if you're feeling frisky.
  */
-
 static int acpi_suspend_enter(suspend_state_t pm_state)
 {
 	acpi_status status = AE_OK;
@@ -166,39 +228,6 @@ static int acpi_suspend_enter(suspend_st
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
@@ -218,10 +247,39 @@ static int acpi_suspend_state_valid(susp
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
+	.recover = acpi_pm_finish,
 };
 #endif /* CONFIG_SUSPEND */
 
@@ -240,22 +298,9 @@ __setup("acpi_s4_nosigcheck", acpi_s4_no
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
@@ -291,52 +336,55 @@ static void acpi_hibernation_leave(void)
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
+	.recover = acpi_pm_finish,
 };
-#endif				/* CONFIG_HIBERNATION */
+#endif /* CONFIG_HIBERNATION */
 
 int acpi_suspend(u32 acpi_state)
 {
@@ -478,13 +526,15 @@ int __init acpi_sleep_init(void)
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
Index: linux-2.6/include/linux/suspend.h
===================================================================
--- linux-2.6.orig/include/linux/suspend.h
+++ linux-2.6/include/linux/suspend.h
@@ -86,6 +86,11 @@ typedef int __bitwise suspend_state_t;
  *	that implement @begin(), but platforms implementing @begin() should
  *	also provide a @end() which cleans up transitions aborted before
  *	@enter().
+ *
+ * @recover: Recover the platform from a suspend failure.
+ *	Called by the PM core if the suspending of devices fails.
+ *	This callback is optional and should only be implemented by platforms
+ *	which require special recovery actions in that situation.
  */
 struct platform_suspend_ops {
 	int (*valid)(suspend_state_t state);
@@ -94,6 +99,7 @@ struct platform_suspend_ops {
 	int (*enter)(suspend_state_t state);
 	void (*finish)(void);
 	void (*end)(void);
+	void (*recover)(void);
 };
 
 #ifdef CONFIG_SUSPEND
@@ -149,7 +155,7 @@ extern void mark_free_pages(struct zone 
  * The methods in this structure allow a platform to carry out special
  * operations required by it during a hibernation transition.
  *
- * All the methods below must be implemented.
+ * All the methods below, except for @recover(), must be implemented.
  *
  * @begin: Tell the platform driver that we're starting hibernation.
  *	Called right after shrinking memory and before freezing devices.
@@ -189,6 +195,11 @@ extern void mark_free_pages(struct zone 
  * @restore_cleanup: Clean up after a failing image restoration.
  *	Called right after the nonboot CPUs have been enabled and before
  *	thawing devices (runs with IRQs on).
+ *
+ * @recover: Recover the platform from a failure to suspend devices.
+ *	Called by the PM core if the suspending of devices during hibernation
+ *	fails.  This callback is optional and should only be implemented by
+ *	platforms which require special recovery actions in that situation.
  */
 struct platform_hibernation_ops {
 	int (*begin)(void);
@@ -200,6 +211,7 @@ struct platform_hibernation_ops {
 	void (*leave)(void);
 	int (*pre_restore)(void);
 	void (*restore_cleanup)(void);
+	void (*recover)(void);
 };
 
 #ifdef CONFIG_HIBERNATION
Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -269,11 +269,11 @@ int suspend_devices_and_enter(suspend_st
 	error = device_suspend(PMSG_SUSPEND);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to suspend\n");
-		goto Resume_console;
+		goto Recover_platform;
 	}
 
 	if (suspend_test(TEST_DEVICES))
-		goto Resume_devices;
+		goto Recover_platform;
 
 	if (suspend_ops->prepare) {
 		error = suspend_ops->prepare();
@@ -294,12 +294,16 @@ int suspend_devices_and_enter(suspend_st
 		suspend_ops->finish();
  Resume_devices:
 	device_resume(PMSG_RESUME);
- Resume_console:
 	resume_console();
  Close:
 	if (suspend_ops->end)
 		suspend_ops->end();
 	return error;
+
+ Recover_platform:
+	if (suspend_ops->recover)
+		suspend_ops->recover();
+	goto Resume_devices;
 }
 
 /**
Index: linux-2.6/kernel/power/disk.c
===================================================================
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -180,6 +180,17 @@ static void platform_restore_cleanup(int
 }
 
 /**
+ *	platform_recover - recover the platform from a failure to suspend
+ *	devices.
+ */
+
+static void platform_recover(int platform_mode)
+{
+	if (platform_mode && hibernation_ops && hibernation_ops->recover)
+		hibernation_ops->recover();
+}
+
+/**
  *	create_image - freeze devices that need to be frozen with interrupts
  *	off, create the hibernation image and thaw those devices.  Control
  *	reappears in this routine after a restore.
@@ -258,10 +269,10 @@ int hibernation_snapshot(int platform_mo
 	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
 	if (error)
-		goto Resume_console;
+		goto Recover_platform;
 
 	if (hibernation_test(TEST_DEVICES))
-		goto Resume_devices;
+		goto Recover_platform;
 
 	error = platform_pre_snapshot(platform_mode);
 	if (error || hibernation_test(TEST_PLATFORM))
@@ -285,11 +296,14 @@ int hibernation_snapshot(int platform_mo
  Resume_devices:
 	device_resume(in_suspend ?
 		(error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE);
- Resume_console:
 	resume_console();
  Close:
 	platform_end(platform_mode);
 	return error;
+
+ Recover_platform:
+	platform_recover(platform_mode);
+	goto Resume_devices;
 }
 
 /**
@@ -398,8 +412,11 @@ int hibernation_platform_enter(void)
 
 	suspend_console();
 	error = device_suspend(PMSG_HIBERNATE);
-	if (error)
-		goto Resume_console;
+	if (error) {
+		if (hibernation_ops->recover)
+			hibernation_ops->recover();
+		goto Resume_devices;
+	}
 
 	error = hibernation_ops->prepare();
 	if (error)
@@ -428,7 +445,6 @@ int hibernation_platform_enter(void)
 	hibernation_ops->finish();
  Resume_devices:
 	device_resume(PMSG_RESTORE);
- Resume_console:
 	resume_console();
  Close:
 	hibernation_ops->end();
Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -781,8 +781,6 @@ int device_suspend(pm_message_t state)
 	error = dpm_prepare(state);
 	if (!error)
 		error = dpm_suspend(state);
-	if (error)
-		device_resume(resume_event(state));
 	return error;
 }
 EXPORT_SYMBOL_GPL(device_suspend);
Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-2.6/arch/x86/kernel/acpi/sleep.c
@@ -124,6 +124,8 @@ static int __init acpi_sleep_setup(char 
 			acpi_realmode_flags |= 2;
 		if (strncmp(str, "s3_beep", 7) == 0)
 			acpi_realmode_flags |= 4;
+		if (strncmp(str, "old_ordering", 12) == 0)
+			acpi_old_suspend_ordering();
 		str = strchr(str, ',');
 		if (str != NULL)
 			str += strspn(str, ", \t");
Index: linux-2.6/include/linux/acpi.h
===================================================================
--- linux-2.6.orig/include/linux/acpi.h
+++ linux-2.6/include/linux/acpi.h
@@ -233,6 +233,9 @@ int acpi_check_region(resource_size_t st
 		      const char *name);
 int acpi_check_mem_region(resource_size_t start, resource_size_t n,
 		      const char *name);
+#ifdef CONFIG_PM_SLEEP
+void __init acpi_old_suspend_ordering(void);
+#endif /* CONFIG_PM_SLEEP */
 
 #else	/* CONFIG_ACPI */
 

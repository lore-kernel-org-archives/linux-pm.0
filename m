From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: do not use pm_ops (was: Re: suspend2
	merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Tue, 1 May 2007 16:05:16 +0200
Message-ID: <200705011605.16993.rjw@sisk.pl>
References: <20070425072350.GA6866@ucw.cz> <200704301651.46376.rjw@sisk.pl>
	<1177945191.5102.93.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177945191.5102.93.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Monday, 30 April 2007 16:59, Johannes Berg wrote:
> On Mon, 2007-04-30 at 16:51 +0200, Rafael J. Wysocki wrote:
> 
> > > That comment doesn't seem right. This is in ->enter so afaict the image
> > > hasn't been loaded yet at this point. I don't know if you just moved
> > > code but if you did then I don't think it was correct before.
> > 
> > It was in your patch, so I kept it, but I don't think it's correct too.
> 
> If it was in my patch then it must be there in the original code, iirc I
> just shuffled it a bit :)
> 
> > Moreover, it seems that acpi_save_state_mem() and acpi_restore_state_mem() are
> > only needed by s2ram, so we can safely remove them from the hibernation code
> > path.  Pavel, is that correct?
> 
> This I don't know. They seemed to be done on hibernate too.

The previous version of the patch was missing the changes in suspend.h.

Apart from this I've cleaned up some changes in disk.c and main.c to make
the sysfs interface work again and dropped some ACPI code that I think was
not necessary.

Patch appended (tested on x86_64, but not extensively), comments welcome. :-)

Greetings,
Rafael

---
This patch:
 * removes the definitions related to hibernation (aka suspend to disk) from
   include/linux/pm.h
 * introduces struct hibernation_ops and a new function to hibernate the system
   called  hibernate(), defined in include/linux/suspend.h
 * separates suspend code in kernel/power/main.c from hibernation-related code
   in kernel/power/disk.c and kernel/power/user.c (with the help of
   hibernation_ops)
 * switches ACPI (the only user of pm_ops.pm_disk_mode) to hibernation_ops
---

 Documentation/power/userland-swsusp.txt |   26 ++--
 drivers/acpi/sleep/main.c               |   67 +++++++++--
 drivers/acpi/sleep/proc.c               |    2 
 drivers/i2c/chips/tps65010.c            |    2 
 include/linux/pm.h                      |   31 -----
 include/linux/suspend.h                 |   32 +++++
 kernel/power/disk.c                     |  186 +++++++++++++++++---------------
 kernel/power/main.c                     |   42 ++-----
 kernel/power/power.h                    |    7 -
 kernel/power/user.c                     |   13 +-
 kernel/sys.c                            |    2 
 11 files changed, 225 insertions(+), 185 deletions(-)

Index: linux-2.6.21/include/linux/pm.h
===================================================================
--- linux-2.6.21.orig/include/linux/pm.h	2007-05-01 13:35:33.000000000 +0200
+++ linux-2.6.21/include/linux/pm.h	2007-05-01 13:35:33.000000000 +0200
@@ -107,26 +107,11 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_ON		((__force suspend_state_t) 0)
 #define PM_SUSPEND_STANDBY	((__force suspend_state_t) 1)
 #define PM_SUSPEND_MEM		((__force suspend_state_t) 3)
-#define PM_SUSPEND_DISK		((__force suspend_state_t) 4)
-#define PM_SUSPEND_MAX		((__force suspend_state_t) 5)
-
-typedef int __bitwise suspend_disk_method_t;
-
-/* invalid must be 0 so struct pm_ops initialisers can leave it out */
-#define PM_DISK_INVALID		((__force suspend_disk_method_t) 0)
-#define	PM_DISK_PLATFORM	((__force suspend_disk_method_t) 1)
-#define	PM_DISK_SHUTDOWN	((__force suspend_disk_method_t) 2)
-#define	PM_DISK_REBOOT		((__force suspend_disk_method_t) 3)
-#define	PM_DISK_TEST		((__force suspend_disk_method_t) 4)
-#define	PM_DISK_TESTPROC	((__force suspend_disk_method_t) 5)
-#define	PM_DISK_MAX		((__force suspend_disk_method_t) 6)
+#define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
 
 /**
  * struct pm_ops - Callbacks for managing platform dependent suspend states.
  * @valid: Callback to determine whether the given state can be entered.
- * 	If %CONFIG_SOFTWARE_SUSPEND is set then %PM_SUSPEND_DISK is
- *	always valid and never passed to this call. If not assigned,
- *	no suspend states are valid.
  *	Valid states are advertised in /sys/power/state but can still
  *	be rejected by prepare or enter if the conditions aren't right.
  *	There is a %pm_valid_only_mem function available that can be assigned
@@ -140,24 +125,12 @@ typedef int __bitwise suspend_disk_metho
  *
  * @finish: Called when the system has left the given state and all devices
  *	are resumed. The return value is ignored.
- *
- * @pm_disk_mode: The generic code always allows one of the shutdown methods
- *	%PM_DISK_SHUTDOWN, %PM_DISK_REBOOT, %PM_DISK_TEST and
- *	%PM_DISK_TESTPROC. If this variable is set, the mode it is set
- *	to is allowed in addition to those modes and is also made default.
- *	When this mode is sent selected, the @prepare call will be called
- *	before suspending to disk (if present), the @enter call should be
- *	present and will be called after all state has been saved and the
- *	machine is ready to be powered off; the @finish callback is called
- *	after state has been restored. All these calls are called with
- *	%PM_SUSPEND_DISK as the state.
  */
 struct pm_ops {
 	int (*valid)(suspend_state_t state);
 	int (*prepare)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
-	suspend_disk_method_t pm_disk_mode;
 };
 
 /**
@@ -276,8 +249,6 @@ extern void device_power_up(void);
 extern void device_resume(void);
 
 #ifdef CONFIG_PM
-extern suspend_disk_method_t pm_disk_mode;
-
 extern int device_suspend(pm_message_t state);
 extern int device_prepare_suspend(pm_message_t state);
 
Index: linux-2.6.21/kernel/power/main.c
===================================================================
--- linux-2.6.21.orig/kernel/power/main.c	2007-05-01 13:35:33.000000000 +0200
+++ linux-2.6.21/kernel/power/main.c	2007-05-01 15:14:00.000000000 +0200
@@ -30,7 +30,6 @@
 DEFINE_MUTEX(pm_mutex);
 
 struct pm_ops *pm_ops;
-suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
 
 /**
  *	pm_set_ops - Set the global power method table. 
@@ -41,10 +40,6 @@ void pm_set_ops(struct pm_ops * ops)
 {
 	mutex_lock(&pm_mutex);
 	pm_ops = ops;
-	if (ops && ops->pm_disk_mode != PM_DISK_INVALID) {
-		pm_disk_mode = ops->pm_disk_mode;
-	} else
-		pm_disk_mode = PM_DISK_SHUTDOWN;
 	mutex_unlock(&pm_mutex);
 }
 
@@ -184,24 +179,12 @@ static void suspend_finish(suspend_state
 static const char * const pm_states[PM_SUSPEND_MAX] = {
 	[PM_SUSPEND_STANDBY]	= "standby",
 	[PM_SUSPEND_MEM]	= "mem",
-	[PM_SUSPEND_DISK]	= "disk",
 };
 
 static inline int valid_state(suspend_state_t state)
 {
-	/* Suspend-to-disk does not really need low-level support.
-	 * It can work with shutdown/reboot if needed. If it isn't
-	 * configured, then it cannot be supported.
-	 */
-	if (state == PM_SUSPEND_DISK)
-#ifdef CONFIG_SOFTWARE_SUSPEND
-		return 1;
-#else
-		return 0;
-#endif
-
-	/* all other states need lowlevel support and need to be
-	 * valid to the lowlevel implementation, no valid callback
+	/* All states need lowlevel support and need to be valid
+	 * to the lowlevel implementation, no valid callback
 	 * implies that none are valid. */
 	if (!pm_ops || !pm_ops->valid || !pm_ops->valid(state))
 		return 0;
@@ -229,11 +212,6 @@ static int enter_state(suspend_state_t s
 	if (!mutex_trylock(&pm_mutex))
 		return -EBUSY;
 
-	if (state == PM_SUSPEND_DISK) {
-		error = pm_suspend_disk();
-		goto Unlock;
-	}
-
 	pr_debug("PM: Preparing system for %s sleep\n", pm_states[state]);
 	if ((error = suspend_prepare(state)))
 		goto Unlock;
@@ -251,7 +229,7 @@ static int enter_state(suspend_state_t s
 
 /**
  *	pm_suspend - Externally visible function for suspending system.
- *	@state:		Enumarted value of state to enter.
+ *	@state:		Enumerated value of state to enter.
  *
  *	Determine whether or not value is within range, get state 
  *	structure, and enter (above).
@@ -289,7 +267,13 @@ static ssize_t state_show(struct subsyst
 		if (pm_states[i] && valid_state(i))
 			s += sprintf(s,"%s ", pm_states[i]);
 	}
-	s += sprintf(s,"\n");
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	s += sprintf(s, "%s\n", "disk");
+#else
+	if (s != buf)
+		/* convert the last space to a newline */
+		*(s-1) = "\n";
+#endif
 	return (s - buf);
 }
 
@@ -304,6 +288,12 @@ static ssize_t state_store(struct subsys
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
+	/* First, check if we are requested to hibernate */
+	if (!strncmp(buf, "disk", len)) {
+		error = hibernate();
+		return error ? error : n;
+	}
+
 	for (s = &pm_states[state]; state < PM_SUSPEND_MAX; s++, state++) {
 		if (*s && !strncmp(buf, *s, len))
 			break;
Index: linux-2.6.21/kernel/power/disk.c
===================================================================
--- linux-2.6.21.orig/kernel/power/disk.c	2007-05-01 13:35:33.000000000 +0200
+++ linux-2.6.21/kernel/power/disk.c	2007-05-01 15:14:13.000000000 +0200
@@ -30,30 +30,60 @@ char resume_file[256] = CONFIG_PM_STD_PA
 dev_t swsusp_resume_device;
 sector_t swsusp_resume_block;
 
+static int hibernation_mode;
+
+enum {
+	HIBERNATION_INVALID,
+	HIBERNATION_PLATFORM,
+	HIBERNATION_TEST,
+	HIBERNATION_TESTPROC,
+	HIBERNATION_SHUTDOWN,
+	HIBERNATION_REBOOT,
+	/* keep last */
+	__HIBERNATION_AFTER_LAST
+};
+#define HIBERNATION_MAX (__HIBERNATION_AFTER_LAST-1)
+#define HIBERNATION_FIRST (HIBERNATION_INVALID + 1)
+
+struct hibernation_ops *hibernation_ops;
+
+void hibernation_set_ops(struct hibernation_ops *ops)
+{
+	if (ops && !(ops->prepare && ops->enter && ops->finish)) {
+		printk(KERN_ERR "Wrong definition of hibernation operations! "
+			"Using defaults\n");
+		return;
+	}
+	mutex_lock(&pm_mutex);
+	hibernation_ops = ops;
+	mutex_unlock(&pm_mutex);
+}
+
+
 /**
  *	platform_prepare - prepare the machine for hibernation using the
  *	platform driver if so configured and return an error code if it fails
  */
 
-static inline int platform_prepare(void)
+static int platform_prepare(void)
 {
-	int error = 0;
+	return (hibernation_mode == HIBERNATION_PLATFORM && hibernation_ops) ?
+		hibernation_ops->prepare() : 0;
+}
 
-	switch (pm_disk_mode) {
-	case PM_DISK_TEST:
-	case PM_DISK_TESTPROC:
-	case PM_DISK_SHUTDOWN:
-	case PM_DISK_REBOOT:
-		break;
-	default:
-		if (pm_ops && pm_ops->prepare)
-			error = pm_ops->prepare(PM_SUSPEND_DISK);
-	}
-	return error;
+/**
+ *	platform_finish - switch the machine to the normal mode of operation
+ *	using the platform driver (must be called after platform_prepare())
+ */
+
+static void platform_finish(void)
+{
+	if (hibernation_mode == HIBERNATION_PLATFORM && hibernation_ops)
+		hibernation_ops->finish();
 }
 
 /**
- *	power_down - Shut machine down for hibernate.
+ *	power_down - Shut the machine down for hibernation.
  *
  *	Use the platform driver, if configured so; otherwise try
  *	to power off or reboot.
@@ -61,20 +91,20 @@ static inline int platform_prepare(void)
 
 static void power_down(void)
 {
-	switch (pm_disk_mode) {
-	case PM_DISK_TEST:
-	case PM_DISK_TESTPROC:
+	switch (hibernation_mode) {
+	case HIBERNATION_TEST:
+	case HIBERNATION_TESTPROC:
 		break;
-	case PM_DISK_SHUTDOWN:
+	case HIBERNATION_SHUTDOWN:
 		kernel_power_off();
 		break;
-	case PM_DISK_REBOOT:
+	case HIBERNATION_REBOOT:
 		kernel_restart(NULL);
 		break;
-	default:
-		if (pm_ops && pm_ops->enter) {
+	case HIBERNATION_PLATFORM:
+		if (hibernation_ops) {
 			kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
-			pm_ops->enter(PM_SUSPEND_DISK);
+			hibernation_ops->enter();
 			break;
 		}
 	}
@@ -87,20 +117,6 @@ static void power_down(void)
 	while(1);
 }
 
-static inline void platform_finish(void)
-{
-	switch (pm_disk_mode) {
-	case PM_DISK_TEST:
-	case PM_DISK_TESTPROC:
-	case PM_DISK_SHUTDOWN:
-	case PM_DISK_REBOOT:
-		break;
-	default:
-		if (pm_ops && pm_ops->finish)
-			pm_ops->finish(PM_SUSPEND_DISK);
-	}
-}
-
 static void unprepare_processes(void)
 {
 	thaw_processes();
@@ -120,13 +136,10 @@ static int prepare_processes(void)
 }
 
 /**
- *	pm_suspend_disk - The granpappy of hibernation power management.
- *
- *	If not, then call swsusp to do its thing, then figure out how
- *	to power down the system.
+ *	hibernate - The granpappy of the built-in hibernation management
  */
 
-int pm_suspend_disk(void)
+int hibernate(void)
 {
 	int error;
 
@@ -143,7 +156,8 @@ int pm_suspend_disk(void)
 	if (error)
 		goto Finish;
 
-	if (pm_disk_mode == PM_DISK_TESTPROC) {
+	mutex_lock(&pm_mutex);
+	if (hibernation_mode == HIBERNATION_TESTPROC) {
 		printk("swsusp debug: Waiting for 5 seconds.\n");
 		mdelay(5000);
 		goto Thaw;
@@ -168,7 +182,7 @@ int pm_suspend_disk(void)
 	if (error)
 		goto Enable_cpus;
 
-	if (pm_disk_mode == PM_DISK_TEST) {
+	if (hibernation_mode == HIBERNATION_TEST) {
 		printk("swsusp debug: Waiting for 5 seconds.\n");
 		mdelay(5000);
 		goto Enable_cpus;
@@ -205,6 +219,7 @@ int pm_suspend_disk(void)
 	device_resume();
 	resume_console();
  Thaw:
+	mutex_unlock(&pm_mutex);
 	unprepare_processes();
  Finish:
 	free_basic_memory_bitmaps();
@@ -220,7 +235,7 @@ int pm_suspend_disk(void)
  *	Called as a late_initcall (so all devices are discovered and
  *	initialized), we call swsusp to see if we have a saved image or not.
  *	If so, we quiesce devices, the restore the saved image. We will
- *	return above (in pm_suspend_disk() ) if everything goes well.
+ *	return above (in hibernate() ) if everything goes well.
  *	Otherwise, we fail gracefully and return to the normally
  *	scheduled program.
  *
@@ -315,25 +330,26 @@ static int software_resume(void)
 late_initcall(software_resume);
 
 
-static const char * const pm_disk_modes[] = {
-	[PM_DISK_PLATFORM]	= "platform",
-	[PM_DISK_SHUTDOWN]	= "shutdown",
-	[PM_DISK_REBOOT]	= "reboot",
-	[PM_DISK_TEST]		= "test",
-	[PM_DISK_TESTPROC]	= "testproc",
+static const char * const hibernation_modes[] = {
+	[HIBERNATION_PLATFORM]	= "platform",
+	[HIBERNATION_SHUTDOWN]	= "shutdown",
+	[HIBERNATION_REBOOT]	= "reboot",
+	[HIBERNATION_TEST]	= "test",
+	[HIBERNATION_TESTPROC]	= "testproc",
 };
 
 /**
- *	disk - Control suspend-to-disk mode
+ *	disk - Control hibernation mode
  *
  *	Suspend-to-disk can be handled in several ways. We have a few options
  *	for putting the system to sleep - using the platform driver (e.g. ACPI
- *	or other pm_ops), powering off the system or rebooting the system
- *	(for testing) as well as the two test modes.
+ *	or other hibernation_ops), powering off the system or rebooting the
+ *	system (for testing) as well as the two test modes.
  *
  *	The system can support 'platform', and that is known a priori (and
- *	encoded in pm_ops). However, the user may choose 'shutdown' or 'reboot'
- *	as alternatives, as well as the test modes 'test' and 'testproc'.
+ *	encoded by the presence of hibernation_ops). However, the user may
+ *	choose 'shutdown' or 'reboot' as alternatives, as well as one fo the
+ *	test modes, 'test' or 'testproc'.
  *
  *	show() will display what the mode is currently set to.
  *	store() will accept one of
@@ -345,7 +361,7 @@ static const char * const pm_disk_modes[
  *	'testproc'
  *
  *	It will only change to 'platform' if the system
- *	supports it (as determined from pm_ops->pm_disk_mode).
+ *	supports it (as determined by having hibernation_ops).
  */
 
 static ssize_t disk_show(struct subsystem * subsys, char * buf)
@@ -353,28 +369,25 @@ static ssize_t disk_show(struct subsyste
 	int i;
 	char *start = buf;
 
-	for (i = PM_DISK_PLATFORM; i < PM_DISK_MAX; i++) {
-		if (!pm_disk_modes[i])
+	for (i = HIBERNATION_FIRST; i <= HIBERNATION_MAX; i++) {
+		if (!hibernation_modes[i])
 			continue;
 		switch (i) {
-		case PM_DISK_SHUTDOWN:
-		case PM_DISK_REBOOT:
-		case PM_DISK_TEST:
-		case PM_DISK_TESTPROC:
+		case HIBERNATION_SHUTDOWN:
+		case HIBERNATION_REBOOT:
+		case HIBERNATION_TEST:
+		case HIBERNATION_TESTPROC:
 			break;
-		default:
-			if (pm_ops && pm_ops->enter &&
-			    (i == pm_ops->pm_disk_mode))
+		case HIBERNATION_PLATFORM:
+			if (hibernation_ops)
 				break;
 			/* not a valid mode, continue with loop */
 			continue;
 		}
-		if (i == pm_disk_mode)
-			buf += sprintf(buf, "[%s]", pm_disk_modes[i]);
+		if (i == hibernation_mode)
+			buf += sprintf(buf, "[%s] ", hibernation_modes[i]);
 		else
-			buf += sprintf(buf, "%s", pm_disk_modes[i]);
-		if (i+1 != PM_DISK_MAX)
-			buf += sprintf(buf, " ");
+			buf += sprintf(buf, "%s ", hibernation_modes[i]);
 	}
 	buf += sprintf(buf, "\n");
 	return buf-start;
@@ -387,39 +400,38 @@ static ssize_t disk_store(struct subsyst
 	int i;
 	int len;
 	char *p;
-	suspend_disk_method_t mode = 0;
+	int mode = HIBERNATION_INVALID;
 
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
 	mutex_lock(&pm_mutex);
-	for (i = PM_DISK_PLATFORM; i < PM_DISK_MAX; i++) {
-		if (!strncmp(buf, pm_disk_modes[i], len)) {
+	for (i = HIBERNATION_FIRST; i <= HIBERNATION_MAX; i++) {
+		if (!strncmp(buf, hibernation_modes[i], len)) {
 			mode = i;
 			break;
 		}
 	}
-	if (mode) {
+	if (mode != HIBERNATION_INVALID) {
 		switch (mode) {
-		case PM_DISK_SHUTDOWN:
-		case PM_DISK_REBOOT:
-		case PM_DISK_TEST:
-		case PM_DISK_TESTPROC:
-			pm_disk_mode = mode;
+		case HIBERNATION_SHUTDOWN:
+		case HIBERNATION_REBOOT:
+		case HIBERNATION_TEST:
+		case HIBERNATION_TESTPROC:
+			hibernation_mode = mode;
 			break;
-		default:
-			if (pm_ops && pm_ops->enter &&
-			    (mode == pm_ops->pm_disk_mode))
-				pm_disk_mode = mode;
+		case HIBERNATION_PLATFORM:
+			if (hibernation_ops)
+				hibernation_mode = mode;
 			else
 				error = -EINVAL;
 		}
-	} else {
+	} else
 		error = -EINVAL;
-	}
 
-	pr_debug("PM: suspend-to-disk mode set to '%s'\n",
-		 pm_disk_modes[mode]);
+	if (!error)
+		pr_debug("PM: suspend-to-disk mode set to '%s'\n",
+			 hibernation_modes[mode]);
 	mutex_unlock(&pm_mutex);
 	return error ? error : n;
 }
Index: linux-2.6.21/Documentation/power/userland-swsusp.txt
===================================================================
--- linux-2.6.21.orig/Documentation/power/userland-swsusp.txt	2007-05-01 13:35:25.000000000 +0200
+++ linux-2.6.21/Documentation/power/userland-swsusp.txt	2007-05-01 13:35:33.000000000 +0200
@@ -93,21 +93,23 @@ SNAPSHOT_S2RAM - suspend to RAM; using t
 	to resume the system from RAM if there's enough battery power or restore
 	its state on the basis of the saved suspend image otherwise)
 
-SNAPSHOT_PMOPS - enable the usage of the pmops->prepare, pmops->enter and
-	pmops->finish methods (the in-kernel swsusp knows these as the "platform
-	method") which are needed on many machines to (among others) speed up
-	the resume by letting the BIOS skip some steps or to let the system
-	recognise the correct state of the hardware after the resume (in
-	particular on many machines this ensures that unplugged AC
-	adapters get correctly detected and that kacpid does not run wild after
-	the resume).  The last ioctl() argument can take one of the three
-	values, defined in kernel/power/power.h:
+SNAPSHOT_PMOPS - enable the usage of the hibernation_ops->prepare,
+	hibernate_ops->enter and hibernation_ops->finish methods (the in-kernel
+	swsusp knows these as the "platform method") which are needed on many
+	machines to (among others) speed up the resume by letting the BIOS skip
+	some steps or to let the system recognise the correct state of the
+	hardware after the resume (in particular on many machines this ensures
+	that unplugged AC adapters get correctly detected and that kacpid does
+	not run wild after the resume).  The last ioctl() argument can take one
+	of the three values, defined in kernel/power/power.h:
 	PMOPS_PREPARE - make the kernel carry out the
-		pm_ops->prepare(PM_SUSPEND_DISK) operation
+		hibernation_ops->prepare() operation
 	PMOPS_ENTER - make the kernel power off the system by calling
-		pm_ops->enter(PM_SUSPEND_DISK)
+		hibernation_ops->enter()
 	PMOPS_FINISH - make the kernel carry out the
-		pm_ops->finish(PM_SUSPEND_DISK) operation
+		hibernation_ops->finish() operation
+	Note that the actual constants are misnamed because they surface
+	internal kernel implementation details that have changed.
 
 The device's read() operation can be used to transfer the snapshot image from
 the kernel.  It has the following limitations:
Index: linux-2.6.21/drivers/i2c/chips/tps65010.c
===================================================================
--- linux-2.6.21.orig/drivers/i2c/chips/tps65010.c	2007-05-01 13:35:33.000000000 +0200
+++ linux-2.6.21/drivers/i2c/chips/tps65010.c	2007-05-01 13:35:33.000000000 +0200
@@ -354,7 +354,7 @@ static void tps65010_interrupt(struct tp
 			 * also needs to get error handling and probably
 			 * an #ifdef CONFIG_SOFTWARE_SUSPEND
 			 */
-			pm_suspend(PM_SUSPEND_DISK);
+			hibernate();
 #endif
 			poll = 1;
 		}
Index: linux-2.6.21/kernel/sys.c
===================================================================
--- linux-2.6.21.orig/kernel/sys.c	2007-05-01 13:35:33.000000000 +0200
+++ linux-2.6.21/kernel/sys.c	2007-05-01 13:35:33.000000000 +0200
@@ -881,7 +881,7 @@ asmlinkage long sys_reboot(int magic1, i
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
 		{
-			int ret = pm_suspend(PM_SUSPEND_DISK);
+			int ret = hibernate();
 			unlock_kernel();
 			return ret;
 		}
Index: linux-2.6.21/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.21.orig/drivers/acpi/sleep/main.c	2007-05-01 13:35:33.000000000 +0200
+++ linux-2.6.21/drivers/acpi/sleep/main.c	2007-05-01 14:20:45.000000000 +0200
@@ -29,7 +29,6 @@ static u32 acpi_suspend_states[] = {
 	[PM_SUSPEND_ON] = ACPI_STATE_S0,
 	[PM_SUSPEND_STANDBY] = ACPI_STATE_S1,
 	[PM_SUSPEND_MEM] = ACPI_STATE_S3,
-	[PM_SUSPEND_DISK] = ACPI_STATE_S4,
 	[PM_SUSPEND_MAX] = ACPI_STATE_S5
 };
 
@@ -94,14 +93,6 @@ static int acpi_pm_enter(suspend_state_t
 		do_suspend_lowlevel();
 		break;
 
-	case PM_SUSPEND_DISK:
-		if (acpi_pm_ops.pm_disk_mode == PM_DISK_PLATFORM)
-			status = acpi_enter_sleep_state(acpi_state);
-		break;
-	case PM_SUSPEND_MAX:
-		acpi_power_off();
-		break;
-
 	default:
 		return -EINVAL;
 	}
@@ -157,12 +148,13 @@ int acpi_suspend(u32 acpi_state)
 	suspend_state_t states[] = {
 		[1] = PM_SUSPEND_STANDBY,
 		[3] = PM_SUSPEND_MEM,
-		[4] = PM_SUSPEND_DISK,
 		[5] = PM_SUSPEND_MAX
 	};
 
 	if (acpi_state < 6 && states[acpi_state])
 		return pm_suspend(states[acpi_state]);
+	if (acpi_state == 4)
+		return hibernate();
 	return -EINVAL;
 }
 
@@ -189,6 +181,49 @@ static struct pm_ops acpi_pm_ops = {
 	.finish = acpi_pm_finish,
 };
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+static int acpi_hibernation_prepare(void)
+{
+	return acpi_sleep_prepare(ACPI_STATE_S4);
+}
+
+static int acpi_hibernation_enter(void)
+{
+	acpi_status status = AE_OK;
+	unsigned long flags = 0;
+
+	ACPI_FLUSH_CPU_CACHE();
+
+	local_irq_save(flags);
+	acpi_enable_wakeup_device(ACPI_STATE_S4);
+	/* This shouldn't return.  If it returns, we have a problem */
+	status = acpi_enter_sleep_state(ACPI_STATE_S4);
+	local_irq_restore(flags);
+
+	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
+}
+
+static void acpi_hibernation_finish(void)
+{
+	acpi_leave_sleep_state(ACPI_STATE_S4);
+	acpi_disable_wakeup_device(ACPI_STATE_S4);
+
+	/* reset firmware waking vector */
+	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
+
+	if (init_8259A_after_S1) {
+		printk("Broken toshiba laptop -> kicking interrupts\n");
+		init_8259A(0);
+	}
+}
+
+static struct hibernation_ops acpi_hibernation_ops = {
+	.prepare = acpi_hibernation_prepare,
+	.enter = acpi_hibernation_enter,
+	.finish = acpi_hibernation_finish,
+};
+#endif /* CONFIG_SOFTWARE_SUSPEND */
+
 /*
  * Toshiba fails to preserve interrupts over S1, reinitialization
  * of 8259 is needed after S1 resume.
@@ -227,14 +262,18 @@ int __init acpi_sleep_init(void)
 			sleep_states[i] = 1;
 			printk(" S%d", i);
 		}
-		if (i == ACPI_STATE_S4) {
-			if (sleep_states[i])
-				acpi_pm_ops.pm_disk_mode = PM_DISK_PLATFORM;
-		}
 	}
 	printk(")\n");
 
 	pm_set_ops(&acpi_pm_ops);
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	if (sleep_states[ACPI_STATE_S4])
+		hibernation_set_ops(&acpi_hibernation_ops);
+#else
+	sleep_states[ACPI_STATE_S4] = 0;
+#endif
+
 	return 0;
 }
 
Index: linux-2.6.21/kernel/power/power.h
===================================================================
--- linux-2.6.21.orig/kernel/power/power.h	2007-05-01 13:35:33.000000000 +0200
+++ linux-2.6.21/kernel/power/power.h	2007-05-01 13:35:33.000000000 +0200
@@ -25,12 +25,7 @@ struct swsusp_info {
  */
 #define SPARE_PAGES	((1024 * 1024) >> PAGE_SHIFT)
 
-extern int pm_suspend_disk(void);
-#else
-static inline int pm_suspend_disk(void)
-{
-	return -EPERM;
-}
+extern struct hibernation_ops *hibernation_ops;
 #endif
 
 extern struct mutex pm_mutex;
Index: linux-2.6.21/drivers/acpi/sleep/proc.c
===================================================================
--- linux-2.6.21.orig/drivers/acpi/sleep/proc.c	2007-05-01 13:35:33.000000000 +0200
+++ linux-2.6.21/drivers/acpi/sleep/proc.c	2007-05-01 13:35:33.000000000 +0200
@@ -60,7 +60,7 @@ acpi_system_write_sleep(struct file *fil
 	state = simple_strtoul(str, NULL, 0);
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	if (state == 4) {
-		error = pm_suspend(PM_SUSPEND_DISK);
+		error = hibernate();
 		goto Done;
 	}
 #endif
Index: linux-2.6.21/kernel/power/user.c
===================================================================
--- linux-2.6.21.orig/kernel/power/user.c	2007-05-01 13:35:33.000000000 +0200
+++ linux-2.6.21/kernel/power/user.c	2007-05-01 13:35:33.000000000 +0200
@@ -130,16 +130,16 @@ static inline int platform_prepare(void)
 {
 	int error = 0;
 
-	if (pm_ops && pm_ops->prepare)
-		error = pm_ops->prepare(PM_SUSPEND_DISK);
+	if (hibernation_ops)
+		error = hibernation_ops->prepare();
 
 	return error;
 }
 
 static inline void platform_finish(void)
 {
-	if (pm_ops && pm_ops->finish)
-		pm_ops->finish(PM_SUSPEND_DISK);
+	if (hibernation_ops)
+		hibernation_ops->finish();
 }
 
 static inline int snapshot_suspend(int platform_suspend)
@@ -384,7 +384,7 @@ static int snapshot_ioctl(struct inode *
 		switch (arg) {
 
 		case PMOPS_PREPARE:
-			if (pm_ops && pm_ops->enter) {
+			if (hibernation_ops) {
 				data->platform_suspend = 1;
 				error = 0;
 			} else {
@@ -395,8 +395,7 @@ static int snapshot_ioctl(struct inode *
 		case PMOPS_ENTER:
 			if (data->platform_suspend) {
 				kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
-				error = pm_ops->enter(PM_SUSPEND_DISK);
-				error = 0;
+				error = hibernation_ops->enter();
 			}
 			break;
 
Index: linux-2.6.21/include/linux/suspend.h
===================================================================
--- linux-2.6.21.orig/include/linux/suspend.h	2007-05-01 13:35:33.000000000 +0200
+++ linux-2.6.21/include/linux/suspend.h	2007-05-01 13:35:33.000000000 +0200
@@ -32,6 +32,24 @@ static inline int pm_prepare_console(voi
 static inline void pm_restore_console(void) {}
 #endif
 
+/**
+ * struct hibernation_ops - hibernation platform support
+ *
+ * The methods in this structure allow a platform to override the default
+ * mechanism of shutting down the machine during a hibernation transition.
+ *
+ * All three methods must be assigned.
+ *
+ * @prepare: prepare system for hibernation
+ * @enter: shut down system after state has been saved to disk
+ * @finish: finish/clean up after state has been reloaded
+ */
+struct hibernation_ops {
+	int (*prepare)(void);
+	int (*enter)(void);
+	void (*finish)(void);
+};
+
 #if defined(CONFIG_PM) && defined(CONFIG_SOFTWARE_SUSPEND)
 /* kernel/power/snapshot.c */
 extern void __init register_nosave_region(unsigned long, unsigned long);
@@ -39,11 +57,25 @@ extern int swsusp_page_is_forbidden(stru
 extern void swsusp_set_page_free(struct page *);
 extern void swsusp_unset_page_free(struct page *);
 extern unsigned long get_safe_page(gfp_t gfp_mask);
+
+/**
+ * hibernation_set_ops - set the global hibernate operations
+ * @ops: the hibernation operations to use in subsequent hibernation transitions
+ */
+void hibernation_set_ops(struct hibernation_ops *ops);
+
+/**
+ * hibernate - hibernate the system
+ */
+extern int hibernate(void);
 #else
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
 static inline void swsusp_set_page_free(struct page *p) {}
 static inline void swsusp_unset_page_free(struct page *p) {}
+
+static inline void hibernation_set_ops(struct hibernation_ops *ops) {}
+extern inline int hibernate(void) { return -ENOSYS; }
 #endif /* defined(CONFIG_PM) && defined(CONFIG_SOFTWARE_SUSPEND) */
 
 void save_processor_state(void);

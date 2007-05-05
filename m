From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] swsusp: Reduce code duplication between
	user.c and disk.c
Date: Sat, 5 May 2007 22:27:13 +0200
Message-ID: <200705052227.14265.rjw__35590.5578508557$1178396682$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Johannes Berg <johannes@sipsolutions.net>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>
List-Id: linux-pm@vger.kernel.org

Hi,

Currently much of the code in kernel/power/disk.c is duplicated in
kernel/power/user.c , mainly for historical reasons.  By eliminating this
duplication we can reduce the size of user.c quite substantially and remove
the maintenance difficulty with making essentially the same changes in two
different places.

However, this modifies the user-observable behavior in such a way that
if the user sets 'shutdown mode = platform' in the s2disk's configuration file,
the kernel will use the hibernation mode resulting from the sysfs interface
settings.  That is, if there is 'shutdown mode = platform' in the s2disk's
configuration file, but the hibernation mode is set to 'reboot' in the sysfs
interface, the system will be rebooted instead of going for the 'ACPI S0->S4
transition'.

Still, this change will only be observable by the users who change the PM
settings using the sysfs interface.  The users who use s2disk only will not
observe any change.

Comments welcome.

Greetings,
Rafael

---
 kernel/power/disk.c  |  165 ++++++++++++++++++++++++++++-----------------------
 kernel/power/power.h |    5 +
 kernel/power/user.c  |  116 +----------------------------------
 3 files changed, 101 insertions(+), 185 deletions(-)

Index: linux-2.6.21/kernel/power/disk.c
===================================================================
--- linux-2.6.21.orig/kernel/power/disk.c	2007-05-05 15:45:23.000000000 +0200
+++ linux-2.6.21/kernel/power/disk.c	2007-05-05 21:36:29.000000000 +0200
@@ -90,13 +90,95 @@ static void platform_finish(void)
 }
 
 /**
- *	power_down - Shut the machine down for hibernation.
+ *	hibernation_snapshot - quiesce devices and create the hibernation
+ *	snapshot image.  Use the platform driver, if available, to prepare the
+ *	platform frimware for the power transition.
+ *
+ *	Must be called with pm_mutex held
+ */
+
+int hibernation_snapshot(void)
+{
+	int error;
+
+	/* Free memory before shutting down devices. */
+	error = swsusp_shrink_memory();
+	if (error)
+		goto Finish;
+
+	error = platform_prepare();
+	if (error)
+		goto Finish;
+
+	suspend_console();
+	error = device_suspend(PMSG_FREEZE);
+	if (error)
+		goto Resume_devices;
+
+	error = disable_nonboot_cpus();
+	if (!error) {
+		if (hibernation_mode != HIBERNATION_TEST) {
+			in_suspend = 1;
+			error = swsusp_suspend();
+			/* Control returns here after successful restore */
+		} else {
+			printk("swsusp debug: Waiting for 5 seconds.\n");
+			mdelay(5000);
+		}
+	}
+	enable_nonboot_cpus();
+ Resume_devices:
+	platform_finish();
+	device_resume();
+	resume_console();
+ Finish:
+	return error;
+}
+
+/**
+ *	hibernation_restore - quiesce devices and restore the hibernation
+ *	snapshot image.  If successful, cotrol reappears in
+ *	hibernation_snaphot()
+ *
+ *	Must be called with pm_mutex held
+ */
+
+int hibernation_restore(void)
+{
+	int error;
+
+	pm_prepare_console();
+	error = platform_prepare();
+	if (error)
+		goto Finish;
+
+	suspend_console();
+	error = device_suspend(PMSG_PRETHAW);
+	if (error)
+		goto Resume_devices;
+
+	error = disable_nonboot_cpus();
+	if (!error)
+		error = swsusp_resume();
+
+	enable_nonboot_cpus();
+ Resume_devices:
+	platform_finish();
+	device_resume();
+	resume_console();
+ Finish:
+	pm_restore_console();
+	return error;
+}
+
+/**
+ *	hibernation_power_down - Shut the machine down for hibernation.
  *
  *	Use the platform driver, if configured so; otherwise try
  *	to power off or reboot.
  */
 
-static void power_down(void)
+void hibernation_power_down(void)
 {
 	switch (hibernation_mode) {
 	case HIBERNATION_TEST:
@@ -169,62 +251,17 @@ int hibernate(void)
 		mdelay(5000);
 		goto Thaw;
 	}
-
-	/* Free memory before shutting down devices. */
-	error = swsusp_shrink_memory();
-	if (error)
-		goto Thaw;
-
-	error = platform_prepare();
-	if (error)
-		goto Thaw;
-
-	suspend_console();
-	error = device_suspend(PMSG_FREEZE);
-	if (error) {
-		printk(KERN_ERR "PM: Some devices failed to suspend\n");
-		goto Resume_devices;
-	}
-	error = disable_nonboot_cpus();
-	if (error)
-		goto Enable_cpus;
-
-	if (hibernation_mode == HIBERNATION_TEST) {
-		printk("swsusp debug: Waiting for 5 seconds.\n");
-		mdelay(5000);
-		goto Enable_cpus;
-	}
-
-	pr_debug("PM: snapshotting memory.\n");
-	in_suspend = 1;
-	error = swsusp_suspend();
-	if (error)
-		goto Enable_cpus;
-
-	if (in_suspend) {
-		enable_nonboot_cpus();
-		platform_finish();
-		device_resume();
-		resume_console();
+	error = hibernation_snapshot();
+	if (in_suspend && !error) {
 		pr_debug("PM: writing image.\n");
 		error = swsusp_write();
+		swsusp_free();
 		if (!error)
-			power_down();
-		else {
-			swsusp_free();
-			goto Thaw;
-		}
+			hibernation_power_down();
 	} else {
 		pr_debug("PM: Image restored successfully.\n");
+		swsusp_free();
 	}
-
-	swsusp_free();
- Enable_cpus:
-	enable_nonboot_cpus();
- Resume_devices:
-	platform_finish();
-	device_resume();
-	resume_console();
  Thaw:
 	mutex_unlock(&pm_mutex);
 	unprepare_processes();
@@ -299,29 +336,11 @@ static int software_resume(void)
 	pr_debug("PM: Reading swsusp image.\n");
 
 	error = swsusp_read();
-	if (error) {
-		swsusp_free();
-		goto Thaw;
-	}
-
-	pr_debug("PM: Preparing devices for restore.\n");
-
-	suspend_console();
-	error = device_suspend(PMSG_PRETHAW);
-	if (error)
-		goto Free;
-
-	error = disable_nonboot_cpus();
 	if (!error)
-		swsusp_resume();
+		hibernation_restore();
 
-	enable_nonboot_cpus();
- Free:
-	swsusp_free();
-	device_resume();
-	resume_console();
- Thaw:
 	printk(KERN_ERR "PM: Restore failed, recovering.\n");
+	swsusp_free();
 	unprepare_processes();
  Done:
 	free_basic_memory_bitmaps();
@@ -331,7 +350,7 @@ static int software_resume(void)
  Unlock:
 	mutex_unlock(&pm_mutex);
 	pr_debug("PM: Resume from disk failed.\n");
-	return 0;
+	return error;
 }
 
 late_initcall(software_resume);
Index: linux-2.6.21/kernel/power/power.h
===================================================================
--- linux-2.6.21.orig/kernel/power/power.h	2007-05-05 00:39:53.000000000 +0200
+++ linux-2.6.21/kernel/power/power.h	2007-05-05 22:08:01.000000000 +0200
@@ -25,7 +25,10 @@ struct swsusp_info {
  */
 #define SPARE_PAGES	((1024 * 1024) >> PAGE_SHIFT)
 
-extern struct hibernation_ops *hibernation_ops;
+/* kernel/power/disk.c */
+extern int hibernation_snapshot(void);
+extern int hibernation_restore(void);
+extern void hibernation_power_down(void);
 #endif
 
 extern struct mutex pm_mutex;
Index: linux-2.6.21/kernel/power/user.c
===================================================================
--- linux-2.6.21.orig/kernel/power/user.c	2007-05-05 00:57:20.000000000 +0200
+++ linux-2.6.21/kernel/power/user.c	2007-05-05 22:07:49.000000000 +0200
@@ -36,7 +36,6 @@ static struct snapshot_data {
 	int mode;
 	char frozen;
 	char ready;
-	char platform_suspend;
 } snapshot_state;
 
 atomic_t snapshot_device_available = ATOMIC_INIT(1);
@@ -70,7 +69,6 @@ static int snapshot_open(struct inode *i
 	}
 	data->frozen = 0;
 	data->ready = 0;
-	data->platform_suspend = 0;
 
 	return 0;
 }
@@ -126,92 +124,6 @@ static ssize_t snapshot_write(struct fil
 	return res;
 }
 
-static inline int platform_prepare(void)
-{
-	int error = 0;
-
-	if (hibernation_ops)
-		error = hibernation_ops->prepare();
-
-	return error;
-}
-
-static inline void platform_finish(void)
-{
-	if (hibernation_ops)
-		hibernation_ops->finish();
-}
-
-static inline int snapshot_suspend(int platform_suspend)
-{
-	int error;
-
-	mutex_lock(&pm_mutex);
-	/* Free memory before shutting down devices. */
-	error = swsusp_shrink_memory();
-	if (error)
-		goto Finish;
-
-	if (platform_suspend) {
-		error = platform_prepare();
-		if (error)
-			goto Finish;
-	}
-	suspend_console();
-	error = device_suspend(PMSG_FREEZE);
-	if (error)
-		goto Resume_devices;
-
-	error = disable_nonboot_cpus();
-	if (!error) {
-		in_suspend = 1;
-		error = swsusp_suspend();
-	}
-	enable_nonboot_cpus();
- Resume_devices:
-	if (platform_suspend)
-		platform_finish();
-
-	device_resume();
-	resume_console();
- Finish:
-	mutex_unlock(&pm_mutex);
-	return error;
-}
-
-static inline int snapshot_restore(int platform_suspend)
-{
-	int error;
-
-	mutex_lock(&pm_mutex);
-	pm_prepare_console();
-	if (platform_suspend) {
-		error = platform_prepare();
-		if (error)
-			goto Finish;
-	}
-	suspend_console();
-	error = device_suspend(PMSG_PRETHAW);
-	if (error)
-		goto Resume_devices;
-
-	error = disable_nonboot_cpus();
-	if (!error)
-		error = swsusp_resume();
-
-	enable_nonboot_cpus();
- Resume_devices:
-	if (platform_suspend)
-		platform_finish();
-
-	device_resume();
-	resume_console();
- Finish:
-	pm_restore_console();
-	mutex_unlock(&pm_mutex);
-	return error;
-}
-
 static int snapshot_ioctl(struct inode *inode, struct file *filp,
                           unsigned int cmd, unsigned long arg)
 {
@@ -258,7 +170,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		error = snapshot_suspend(data->platform_suspend);
+		error = hibernation_snapshot();
 		if (!error)
 			error = put_user(in_suspend, (unsigned int __user *)arg);
 		if (!error)
@@ -272,7 +184,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		error = snapshot_restore(data->platform_suspend);
+		error = hibernation_restore();
 		break;
 
 	case SNAPSHOT_FREE:
@@ -382,32 +294,14 @@ static int snapshot_ioctl(struct inode *
 		error = -EINVAL;
 
 		switch (arg) {
-
-		case PMOPS_PREPARE:
-			if (hibernation_ops) {
-				data->platform_suspend = 1;
-				error = 0;
-			} else {
-				error = -ENOSYS;
-			}
-			break;
-
 		case PMOPS_ENTER:
-			if (data->platform_suspend) {
-				kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
-				error = hibernation_ops->enter();
-			}
-			break;
-
+			hibernation_power_down();
 		case PMOPS_FINISH:
-			if (data->platform_suspend)
-				error = 0;
-
+		case PMOPS_PREPARE:
+			error = 0;
 			break;
-
 		default:
 			printk(KERN_ERR "SNAPSHOT_PMOPS: invalid argument %ld\n", arg);
-
 		}
 		break;
 

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] PM: Remove code duplication between main.c
	and user.c
Date: Mon, 18 Jun 2007 22:31:03 +0200
Message-ID: <200706182231.04203.rjw@sisk.pl>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The SNAPSHOT_S2RAM ioctl code is outdated and it should not duplicate the
suspend code in kernel/power/main.c.  Fix that.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/main.c  |   79 +++++++++++++++++++++++++++++----------------------
 kernel/power/power.h |    3 +
 kernel/power/user.c  |   38 +++---------------------
 3 files changed, 53 insertions(+), 67 deletions(-)

Index: linux-2.6.22-rc5/kernel/power/main.c
===================================================================
--- linux-2.6.22-rc5.orig/kernel/power/main.c	2007-06-17 12:49:49.000000000 +0200
+++ linux-2.6.22-rc5/kernel/power/main.c	2007-06-17 23:57:30.000000000 +0200
@@ -71,11 +71,9 @@ static inline void pm_finish(suspend_sta
  *	suspend_prepare - Do prep work before entering low-power state.
  *	@state:		State we're entering.
  *
- *	This is common code that is called for each state that we're 
- *	entering. Allocate a console, stop all processes, then make sure
- *	the platform can enter the requested state.
+ *	This is common code that is called for each state that we're entering.
+ *	Run suspend notifiers, allocate a console and stop all processes.
  */
-
 static int suspend_prepare(suspend_state_t state)
 {
 	int error;
@@ -95,38 +93,18 @@ static int suspend_prepare(suspend_state
 		goto Thaw;
 	}
 
-	if ((free_pages = global_page_state(NR_FREE_PAGES))
-			< FREE_PAGE_NUMBER) {
+	free_pages = global_page_state(NR_FREE_PAGES);
+	if (free_pages < FREE_PAGE_NUMBER) {
 		pr_debug("PM: free some memory\n");
 		shrink_all_memory(FREE_PAGE_NUMBER - free_pages);
 		if (nr_free_pages() < FREE_PAGE_NUMBER) {
 			error = -ENOMEM;
 			printk(KERN_ERR "PM: No enough memory\n");
-			goto Thaw;
 		}
 	}
-
-	suspend_console();
-	error = device_suspend(PMSG_SUSPEND);
-	if (error) {
-		printk(KERN_ERR "Some devices failed to suspend\n");
-		goto Resume_console;
-	}
-	if (pm_ops->prepare) {
-		if ((error = pm_ops->prepare(state)))
-			goto Resume_devices;
-	}
-
-	error = disable_nonboot_cpus();
 	if (!error)
 		return 0;
 
-	enable_nonboot_cpus();
-	pm_finish(state);
- Resume_devices:
-	device_resume();
- Resume_console:
-	resume_console();
  Thaw:
 	thaw_processes();
 	pm_restore_console();
@@ -147,6 +125,12 @@ void __attribute__ ((weak)) arch_suspend
 	local_irq_enable();
 }
 
+/**
+ *	suspend_enter - enter the desired system sleep state.
+ *	@state:		state to enter
+ *
+ *	This function should be called after devices have been suspended.
+ */
 int suspend_enter(suspend_state_t state)
 {
 	int error = 0;
@@ -166,6 +150,41 @@ int suspend_enter(suspend_state_t state)
 	return error;
 }
 
+/**
+ *	suspend_suspend - suspend devices and enter the desired system sleep
+ *			  state.
+ *	@state:		  state to enter
+ */
+int suspend_suspend(suspend_state_t state)
+{
+	int error;
+
+	if (!pm_ops)
+		return -ENOSYS;
+
+	suspend_console();
+	error = device_suspend(PMSG_SUSPEND);
+	if (error) {
+		printk(KERN_ERR "Some devices failed to suspend\n");
+		goto Resume_console;
+	}
+	if (pm_ops->prepare) {
+		error = pm_ops->prepare(state);
+		if (error)
+			goto Resume_devices;
+	}
+	error = disable_nonboot_cpus();
+	if (!error)
+		suspend_enter(state);
+
+	enable_nonboot_cpus();
+	pm_finish(state);
+ Resume_devices:
+	device_resume();
+ Resume_console:
+	resume_console();
+	return error;
+}
 
 /**
  *	suspend_finish - Do final work before exiting suspend sequence.
@@ -174,13 +193,8 @@ int suspend_enter(suspend_state_t state)
  *	Call platform code to clean up, restart processes, and free the 
  *	console that we've allocated. This is not called for suspend-to-disk.
  */
-
 static void suspend_finish(suspend_state_t state)
 {
-	enable_nonboot_cpus();
-	pm_finish(state);
-	device_resume();
-	resume_console();
 	thaw_processes();
 	pm_restore_console();
 	pm_notifier_call_chain(PM_POST_SUSPEND);
@@ -215,7 +229,6 @@ static inline int valid_state(suspend_st
  *	Then, do the setup for suspend, enter the state, and cleaup (after
  *	we've woken up).
  */
-
 static int enter_state(suspend_state_t state)
 {
 	int error;
@@ -230,7 +243,7 @@ static int enter_state(suspend_state_t s
 		goto Unlock;
 
 	pr_debug("PM: Entering %s sleep\n", pm_states[state]);
-	error = suspend_enter(state);
+	error = suspend_suspend(state);
 
 	pr_debug("PM: Finishing wakeup.\n");
 	suspend_finish(state);
Index: linux-2.6.22-rc5/kernel/power/power.h
===================================================================
--- linux-2.6.22-rc5.orig/kernel/power/power.h	2007-06-17 12:49:49.000000000 +0200
+++ linux-2.6.22-rc5/kernel/power/power.h	2007-06-17 23:47:10.000000000 +0200
@@ -170,7 +170,6 @@ extern int swsusp_resume(void);
 extern int swsusp_read(unsigned int *flags_p);
 extern int swsusp_write(unsigned int flags);
 extern void swsusp_close(void);
-extern int suspend_enter(suspend_state_t state);
 
 struct timeval;
 /* kernel/power/swsusp.c */
@@ -178,6 +177,8 @@ extern void swsusp_show_speed(struct tim
 				unsigned int, char *);
 
 /* kernel/power/main.c */
+extern int suspend_enter(suspend_state_t state);
+extern int suspend_suspend(suspend_state_t state);
 extern struct blocking_notifier_head pm_chain_head;
 
 static inline int pm_notifier_call_chain(unsigned long val)
Index: linux-2.6.22-rc5/kernel/power/user.c
===================================================================
--- linux-2.6.22-rc5.orig/kernel/power/user.c	2007-06-17 12:49:49.000000000 +0200
+++ linux-2.6.22-rc5/kernel/power/user.c	2007-06-17 23:56:24.000000000 +0200
@@ -255,47 +255,19 @@ static int snapshot_ioctl(struct inode *
 		break;
 
 	case SNAPSHOT_S2RAM:
-		if (!pm_ops) {
-			error = -ENOSYS;
-			break;
-		}
-
 		if (!data->frozen) {
 			error = -EPERM;
 			break;
 		}
-
 		if (!mutex_trylock(&pm_mutex)) {
 			error = -EBUSY;
 			break;
 		}
-
-		if (pm_ops->prepare) {
-			error = pm_ops->prepare(PM_SUSPEND_MEM);
-			if (error)
-				goto OutS3;
-		}
-
-		/* Put devices to sleep */
-		suspend_console();
-		error = device_suspend(PMSG_SUSPEND);
-		if (error) {
-			printk(KERN_ERR "Failed to suspend some devices.\n");
-		} else {
-			error = disable_nonboot_cpus();
-			if (!error) {
-				/* Enter S3, system is already frozen */
-				suspend_enter(PM_SUSPEND_MEM);
-				enable_nonboot_cpus();
-			}
-			/* Wake up devices */
-			device_resume();
-		}
-		resume_console();
-		if (pm_ops->finish)
-			pm_ops->finish(PM_SUSPEND_MEM);
-
- OutS3:
+		/*
+		 * Tasks are frozen and the notifiers have been called with
+		 * PM_HIBERNATION_PREPARE
+		 */
+		error = suspend_suspend(PM_SUSPEND_MEM);
 		mutex_unlock(&pm_mutex);
 		break;
 

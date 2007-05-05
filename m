From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH] Reduce code duplication between main.c
	and user.c
Date: Sat, 5 May 2007 22:26:55 +0200
Message-ID: <200705052226.56578.rjw__7880.34395450286$1178396673$gmane$org@sisk.pl>
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

Some code from kernel/power/main.c is currently duplicated in
kernel/power/user.c , which leads to maintenance complications, so it seems
reasonable to eliminate that duplication.

This patch has only been compilation tested, so if anyone with working s2ram
can test it, please do so.

Greetings,
Rafael

---
 kernel/power/main.c  |   82 +++++++++++++++++++++++++++------------------------
 kernel/power/power.h |    4 ++
 kernel/power/user.c  |   28 +----------------
 3 files changed, 50 insertions(+), 64 deletions(-)

Index: linux-2.6.21/kernel/power/main.c
===================================================================
--- linux-2.6.21.orig/kernel/power/main.c	2007-05-05 00:39:53.000000000 +0200
+++ linux-2.6.21/kernel/power/main.c	2007-05-05 22:05:34.000000000 +0200
@@ -63,6 +63,18 @@ static inline void pm_finish(suspend_sta
 }
 
 /**
+ *	suspend_finish - Do final work before exiting suspend sequence.
+ *
+ *	Restart processes and free the console that we've allocated.
+ */
+
+static void suspend_finish(void)
+{
+	thaw_processes();
+	pm_restore_console();
+}
+
+/**
  *	suspend_prepare - Do prep work before entering low-power state.
  *	@state:		State we're entering.
  *
@@ -97,29 +109,10 @@ static int suspend_prepare(suspend_state
 		}
 	}
 
-	if (pm_ops->prepare) {
-		if ((error = pm_ops->prepare(state)))
-			goto Thaw;
-	}
-
-	suspend_console();
-	error = device_suspend(PMSG_SUSPEND);
-	if (error) {
-		printk(KERN_ERR "Some devices failed to suspend\n");
-		goto Resume_devices;
-	}
-	error = disable_nonboot_cpus();
-	if (!error)
-		return 0;
+	return 0;
 
-	enable_nonboot_cpus();
- Resume_devices:
-	pm_finish(state);
-	device_resume();
-	resume_console();
  Thaw:
-	thaw_processes();
-	pm_restore_console();
+	suspend_finish();
 	return error;
 }
 
@@ -155,32 +148,46 @@ int suspend_enter(suspend_state_t state)
 }
 
 
+static const char * const pm_states[PM_SUSPEND_MAX] = {
+	[PM_SUSPEND_STANDBY]	= "standby",
+	[PM_SUSPEND_MEM]	= "mem",
+};
+
 /**
- *	suspend_finish - Do final work before exiting suspend sequence.
- *	@state:		State we're coming out of.
+ *	pm_enter_state - carry out the state transition
  *
- *	Call platform code to clean up, restart processes, and free the 
- *	console that we've allocated. This is not called for suspend-to-disk.
+ *	Must be called with pm_mutex held
  */
 
-static void suspend_finish(suspend_state_t state)
+int pm_enter_state(suspend_state_t state)
 {
+	int error;
+
+	if (pm_ops->prepare) {
+		error = pm_ops->prepare(state);
+		if (error)
+			return error;
+	}
+	suspend_console();
+	error = device_suspend(PMSG_SUSPEND);
+	if (error) {
+		printk(KERN_ERR "Some devices failed to suspend\n");
+		goto Resume_devices;
+	}
+	error = disable_nonboot_cpus();
+	if (!error) {
+		pr_debug("PM: Entering %s sleep\n", pm_states[state]);
+		error = suspend_enter(state);
+	}
 	enable_nonboot_cpus();
+ Resume_devices:
 	pm_finish(state);
 	device_resume();
 	resume_console();
-	thaw_processes();
-	pm_restore_console();
+	return error;
 }
 
 
-
-
-static const char * const pm_states[PM_SUSPEND_MAX] = {
-	[PM_SUSPEND_STANDBY]	= "standby",
-	[PM_SUSPEND_MEM]	= "mem",
-};
-
 static inline int valid_state(suspend_state_t state)
 {
 	/* All states need lowlevel support and need to be valid
@@ -216,11 +223,10 @@ static int enter_state(suspend_state_t s
 	if ((error = suspend_prepare(state)))
 		goto Unlock;
 
-	pr_debug("PM: Entering %s sleep\n", pm_states[state]);
-	error = suspend_enter(state);
+	error = pm_enter_state(state);
 
 	pr_debug("PM: Finishing wakeup.\n");
-	suspend_finish(state);
+	suspend_finish();
  Unlock:
 	mutex_unlock(&pm_mutex);
 	return error;
Index: linux-2.6.21/kernel/power/user.c
===================================================================
--- linux-2.6.21.orig/kernel/power/user.c	2007-05-05 21:34:30.000000000 +0200
+++ linux-2.6.21/kernel/power/user.c	2007-05-05 22:05:34.000000000 +0200
@@ -246,7 +246,7 @@ static int snapshot_ioctl(struct inode *
 		break;
 
 	case SNAPSHOT_S2RAM:
-		if (!pm_ops) {
+		if (!pm_ops || !pm_ops->enter) {
 			error = -ENOSYS;
 			break;
 		}
@@ -261,32 +261,8 @@ static int snapshot_ioctl(struct inode *
 			break;
 		}
 
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
+		error = pm_enter_state(PM_SUSPEND_MEM);
 
- OutS3:
 		mutex_unlock(&pm_mutex);
 		break;
 
Index: linux-2.6.21/kernel/power/power.h
===================================================================
--- linux-2.6.21.orig/kernel/power/power.h	2007-05-05 21:18:23.000000000 +0200
+++ linux-2.6.21/kernel/power/power.h	2007-05-05 22:07:25.000000000 +0200
@@ -32,6 +32,10 @@ extern void hibernation_power_down(void)
 
 extern struct mutex pm_mutex;
 
+/* kernel/power/main.c */
+/* This function must be called with pm_mutex held */
+extern int pm_enter_state(suspend_state_t state);
+
 #define power_attr(_name) \
 static struct subsys_attribute _name##_attr = {	\
 	.attr	= {				\

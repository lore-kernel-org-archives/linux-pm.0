From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 2/2] PM: Introduce suspend notifiers
Date: Sun, 22 Apr 2007 00:07:13 +0200
Message-ID: <200704220007.14028.rjw@sisk.pl>
References: <200704220002.37083.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704220002.37083.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make it possible to register suspend notifiers so that subsystems can perform
suspend-related operations which should not be carried out by device drivers'
.suspend() and .resume() routines.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/suspend-notifiers.txt |   41 ++++++++++++++++++++++++
 include/linux/notifier.h                  |    6 +++
 include/linux/suspend.h                   |   27 +++++++++++++--
 kernel/power/Makefile                     |    2 -
 kernel/power/disk.c                       |   21 ++++++++++++
 kernel/power/main.c                       |   13 +++++++
 kernel/power/notify.c                     |   51 ++++++++++++++++++++++++++++++
 kernel/power/power.h                      |    3 +
 kernel/power/user.c                       |   19 +++++++++++
 9 files changed, 178 insertions(+), 5 deletions(-)

Index: linux-2.6.21-rc6-mm1/kernel/power/notify.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.21-rc6-mm1/kernel/power/notify.c	2007-04-21 23:24:50.000000000 +0200
@@ -0,0 +1,51 @@
+/*
+ * linux/kernel/power/notify.c
+ *
+ * This file contains functions used for registering and calling suspend
+ * notifiers that can be used by subsystems for carrying out some special
+ * suspend-related operations.
+ *
+ * Copyright (C) 2007 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * This file is released under the GPLv2.
+ *
+ */
+
+#include <linux/smp.h>
+#include <linux/notifier.h>
+#include <linux/module.h>
+#include <linux/suspend.h>
+
+static DEFINE_MUTEX(suspend_notifier_lock);
+
+static RAW_NOTIFIER_HEAD(suspend_chain);
+
+int register_suspend_notifier(struct notifier_block *nb)
+{
+	int ret;
+	mutex_lock(&suspend_notifier_lock);
+	ret = raw_notifier_chain_register(&suspend_chain, nb);
+	mutex_unlock(&suspend_notifier_lock);
+	return ret;
+}
+EXPORT_SYMBOL(register_suspend_notifier);
+
+void unregister_suspend_notifier(struct notifier_block *nb)
+{
+	mutex_lock(&suspend_notifier_lock);
+	raw_notifier_chain_unregister(&suspend_chain, nb);
+	mutex_unlock(&suspend_notifier_lock);
+}
+EXPORT_SYMBOL(unregister_suspend_notifier);
+
+int suspend_notifier_call_chain(unsigned long val)
+{
+	int error = 0;
+
+	mutex_lock(&suspend_notifier_lock);
+	if (raw_notifier_call_chain(&suspend_chain, val, NULL) == NOTIFY_BAD)
+		error = -EINVAL;
+
+	mutex_unlock(&suspend_notifier_lock);
+	return error;
+}
Index: linux-2.6.21-rc6-mm1/include/linux/suspend.h
===================================================================
--- linux-2.6.21-rc6-mm1.orig/include/linux/suspend.h	2007-04-21 23:24:44.000000000 +0200
+++ linux-2.6.21-rc6-mm1/include/linux/suspend.h	2007-04-21 23:24:50.000000000 +0200
@@ -24,15 +24,16 @@ struct pbe {
 extern void drain_local_pages(void);
 extern void mark_free_pages(struct zone *zone);
 
-#if defined(CONFIG_PM) && defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
+#ifdef CONFIG_PM
+#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
 extern int pm_prepare_console(void);
 extern void pm_restore_console(void);
 #else
 static inline int pm_prepare_console(void) { return 0; }
 static inline void pm_restore_console(void) {}
-#endif
+#endif /* defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE) */
 
-#if defined(CONFIG_PM) && defined(CONFIG_SOFTWARE_SUSPEND)
+#ifdef CONFIG_SOFTWARE_SUSPEND
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
 /* kernel/power/snapshot.c */
@@ -52,7 +53,7 @@ static inline void register_nosave_regio
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
 static inline void swsusp_set_page_free(struct page *p) {}
 static inline void swsusp_unset_page_free(struct page *p) {}
-#endif /* defined(CONFIG_PM) && defined(CONFIG_SOFTWARE_SUSPEND) */
+#endif /* CONFIG_SOFTWARE_SUSPEND */
 
 void save_processor_state(void);
 void restore_processor_state(void);
@@ -60,4 +61,22 @@ struct saved_context;
 void __save_processor_state(struct saved_context *ctxt);
 void __restore_processor_state(struct saved_context *ctxt);
 
+int register_suspend_notifier(struct notifier_block *nb);
+void unregister_suspend_notifier(struct notifier_block *nb);
+
+#define suspend_notifier(fn, pri) {				\
+	static struct notifier_block fn##_nb =			\
+		{ .notifier_call = fn, .priority = pri };	\
+	register_suspend_notifier(&fn##_nb);			\
+}
+#else /* CONFIG_PM */
+static inline int register_suspend_notifier(struct notifier_block *nb) {
+	return 0;
+}
+static inline void unregister_suspend_notifier(struct notifier_block *nb) {
+}
+
+#define suspend_notifier(fn, pri)	do { (void)(fn); } while (0)
+#endif
+
 #endif /* _LINUX_SWSUSP_H */
Index: linux-2.6.21-rc6-mm1/kernel/power/Makefile
===================================================================
--- linux-2.6.21-rc6-mm1.orig/kernel/power/Makefile	2007-04-21 23:24:28.000000000 +0200
+++ linux-2.6.21-rc6-mm1/kernel/power/Makefile	2007-04-21 23:24:50.000000000 +0200
@@ -3,7 +3,7 @@ ifeq ($(CONFIG_PM_DEBUG),y)
 EXTRA_CFLAGS	+=	-DDEBUG
 endif
 
-obj-y				:= main.o process.o console.o
+obj-y				:= main.o process.o console.o notify.o
 obj-$(CONFIG_PM_LEGACY)		+= pm.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o swap.o user.o
 
Index: linux-2.6.21-rc6-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.21-rc6-mm1.orig/kernel/power/power.h	2007-04-21 23:24:44.000000000 +0200
+++ linux-2.6.21-rc6-mm1/kernel/power/power.h	2007-04-21 23:24:50.000000000 +0200
@@ -170,3 +170,6 @@ extern int suspend_enter(suspend_state_t
 struct timeval;
 extern void swsusp_show_speed(struct timeval *, struct timeval *,
 				unsigned int, char *);
+
+/* kernel/power/notify.c */
+extern int suspend_notifier_call_chain(unsigned long val);
Index: linux-2.6.21-rc6-mm1/include/linux/notifier.h
===================================================================
--- linux-2.6.21-rc6-mm1.orig/include/linux/notifier.h	2007-04-21 23:24:28.000000000 +0200
+++ linux-2.6.21-rc6-mm1/include/linux/notifier.h	2007-04-21 23:24:50.000000000 +0200
@@ -197,5 +197,11 @@ extern int __srcu_notifier_call_chain(st
 #define CPU_LOCK_ACQUIRE	0x0008 /* Acquire all hotcpu locks */
 #define CPU_LOCK_RELEASE	0x0009 /* Release all hotcpu locks */
 
+#define SUSPEND_PREPARE		0x0002 /* Going to freeze tasks */
+#define SUSPEND_ENTER_PREPARE	0x0003 /* Tasks are frozen, we are suspending */
+#define SUSPEND_THAW_PREPARE	0x0004 /* Going to thaw frozen tasks */
+#define SUSPEND_FINISHED	0x0005 /* Tasks have been thawed */
+#define SUSPEND_RESTORE_PREPARE	0x0006 /* STD restore is going to happen */
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
Index: linux-2.6.21-rc6-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.21-rc6-mm1.orig/kernel/power/disk.c	2007-04-21 23:24:28.000000000 +0200
+++ linux-2.6.21-rc6-mm1/kernel/power/disk.c	2007-04-21 23:24:50.000000000 +0200
@@ -114,6 +114,7 @@ static int prepare_processes(void)
 	pm_prepare_console();
 	if (freeze_processes()) {
 		error = -EBUSY;
+		suspend_notifier_call_chain(SUSPEND_THAW_PREPARE);
 		unprepare_processes();
 	}
 	return error;
@@ -139,6 +140,10 @@ int pm_suspend_disk(void)
 	if (error)
 		goto Exit;
 
+	error = suspend_notifier_call_chain(SUSPEND_PREPARE);
+	if (error)
+		goto Finish;
+
 	error = prepare_processes();
 	if (error)
 		goto Finish;
@@ -149,6 +154,10 @@ int pm_suspend_disk(void)
 		goto Thaw;
 	}
 
+	error = suspend_notifier_call_chain(SUSPEND_ENTER_PREPARE);
+	if (error)
+		goto Thaw;
+
 	/* Free memory before shutting down devices. */
 	error = swsusp_shrink_memory();
 	if (error)
@@ -205,8 +214,10 @@ int pm_suspend_disk(void)
 	device_resume();
 	resume_console();
  Thaw:
+	suspend_notifier_call_chain(SUSPEND_THAW_PREPARE);
 	unprepare_processes();
  Finish:
+	suspend_notifier_call_chain(SUSPEND_FINISHED);
 	free_basic_memory_bitmaps();
  Exit:
 	atomic_inc(&snapshot_device_available);
@@ -267,6 +278,10 @@ static int software_resume(void)
 	if (error)
 		goto Finish;
 
+	error = suspend_notifier_call_chain(SUSPEND_PREPARE);
+	if (error)
+		goto Done;
+
 	pr_debug("PM: Preparing processes for restore.\n");
 	error = prepare_processes();
 	if (error) {
@@ -282,6 +297,10 @@ static int software_resume(void)
 		goto Thaw;
 	}
 
+	error = suspend_notifier_call_chain(SUSPEND_RESTORE_PREPARE);
+	if (error)
+		goto Thaw;
+
 	pr_debug("PM: Preparing devices for restore.\n");
 
 	suspend_console();
@@ -300,8 +319,10 @@ static int software_resume(void)
 	resume_console();
  Thaw:
 	printk(KERN_ERR "PM: Restore failed, recovering.\n");
+	suspend_notifier_call_chain(SUSPEND_THAW_PREPARE);
 	unprepare_processes();
  Done:
+	suspend_notifier_call_chain(SUSPEND_FINISHED);
 	free_basic_memory_bitmaps();
  Finish:
 	atomic_inc(&snapshot_device_available);
Index: linux-2.6.21-rc6-mm1/kernel/power/main.c
===================================================================
--- linux-2.6.21-rc6-mm1.orig/kernel/power/main.c	2007-04-21 23:24:28.000000000 +0200
+++ linux-2.6.21-rc6-mm1/kernel/power/main.c	2007-04-21 23:24:50.000000000 +0200
@@ -86,11 +86,19 @@ static int suspend_prepare(suspend_state
 
 	pm_prepare_console();
 
+	error = suspend_notifier_call_chain(SUSPEND_PREPARE);
+	if (error)
+		goto Finish;
+
 	if (freeze_processes()) {
 		error = -EAGAIN;
 		goto Thaw;
 	}
 
+	error = suspend_notifier_call_chain(SUSPEND_ENTER_PREPARE);
+	if (error)
+		goto Thaw;
+
 	if ((free_pages = global_page_state(NR_FREE_PAGES))
 			< FREE_PAGE_NUMBER) {
 		pr_debug("PM: free some memory\n");
@@ -123,8 +131,11 @@ static int suspend_prepare(suspend_state
 	device_resume();
 	resume_console();
  Thaw:
+	suspend_notifier_call_chain(SUSPEND_THAW_PREPARE);
 	thaw_processes();
+ Finish:
 	pm_restore_console();
+	suspend_notifier_call_chain(SUSPEND_FINISHED);
 	return error;
 }
 
@@ -162,8 +173,10 @@ static void suspend_finish(suspend_state
 	pm_finish(state);
 	device_resume();
 	resume_console();
+	suspend_notifier_call_chain(SUSPEND_THAW_PREPARE);
 	thaw_processes();
 	pm_restore_console();
+	suspend_notifier_call_chain(SUSPEND_FINISHED);
 }
 
 
Index: linux-2.6.21-rc6-mm1/kernel/power/user.c
===================================================================
--- linux-2.6.21-rc6-mm1.orig/kernel/power/user.c	2007-04-21 23:24:28.000000000 +0200
+++ linux-2.6.21-rc6-mm1/kernel/power/user.c	2007-04-21 23:24:50.000000000 +0200
@@ -148,6 +148,10 @@ static inline int snapshot_suspend(int p
 	int error;
 
 	mutex_lock(&pm_mutex);
+	error = suspend_notifier_call_chain(SUSPEND_ENTER_PREPARE);
+	if (error)
+		goto Finish;
+
 	/* Free memory before shutting down devices. */
 	error = swsusp_shrink_memory();
 	if (error)
@@ -186,6 +190,10 @@ static inline int snapshot_restore(int p
 
 	mutex_lock(&pm_mutex);
 	pm_prepare_console();
+	error = suspend_notifier_call_chain(SUSPEND_RESTORE_PREPARE);
+	if (error)
+		goto Finish;
+
 	if (platform_suspend) {
 		error = platform_prepare();
 		if (error)
@@ -236,7 +244,12 @@ static int snapshot_ioctl(struct inode *
 		if (data->frozen)
 			break;
 		mutex_lock(&pm_mutex);
+		error = suspend_notifier_call_chain(SUSPEND_PREPARE);
+		if (error)
+			break;
+
 		if (freeze_processes()) {
+			suspend_notifier_call_chain(SUSPEND_THAW_PREPARE);
 			thaw_processes();
 			error = -EBUSY;
 		}
@@ -249,7 +262,9 @@ static int snapshot_ioctl(struct inode *
 		if (!data->frozen)
 			break;
 		mutex_lock(&pm_mutex);
+		suspend_notifier_call_chain(SUSPEND_THAW_PREPARE);
 		thaw_processes();
+		suspend_notifier_call_chain(SUSPEND_FINISHED);
 		mutex_unlock(&pm_mutex);
 		data->frozen = 0;
 		break;
@@ -350,6 +365,10 @@ static int snapshot_ioctl(struct inode *
 			break;
 		}
 
+		error = suspend_notifier_call_chain(SUSPEND_ENTER_PREPARE);
+		if (error)
+			break;
+
 		if (pm_ops->prepare) {
 			error = pm_ops->prepare(PM_SUSPEND_MEM);
 			if (error)
Index: linux-2.6.21-rc6-mm1/Documentation/power/suspend-notifiers.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.21-rc6-mm1/Documentation/power/suspend-notifiers.txt	2007-04-21 23:24:50.000000000 +0200
@@ -0,0 +1,41 @@
+Suspend notifiers
+	(C) 2007 Rafael J. Wysocki <rjw@sisk.pl>, GPL
+
+There are some operations that device drivers may want to carry out in their
+.suspend() routines, but shouldn't, because they can cause a suspend to fail.
+For example, a driver may want to allocate a substantial amount of memory
+(like 50 MB) in .suspend(), but that shouldn't be done after the swsusp's memory
+shrinker has run.  Also, there may be some operations, that subsystems may want
+to carry out before a suspend or after a resume, requiring the system to be
+fully functional, so the drivers' .suspend() and .resume() routines are not
+suitable for this purpose.
+
+The subsystems that have such needs can register suspend notifiers that will be
+notified of the following events by the suspend core:
+
+SUSPEND_PREPARE		the system is going to suspend, tasks will be frozen
+			immediately
+
+SUSPEND_ENTER_PREPARE	tasks have been frozen, memory is going to be freed
+			and devices are going to be suspended
+
+SUSPEND_THAW_PREPARE	devices have been resumed, tasks will be thawed
+			immediately
+
+SUSPEND_FINISHED	the resume is complete, the system is fully functional
+
+SUSPEND_RESTORE_PREPARE	the system is preparing to restore the swsusp's suspend
+			image, tasks have been frozen and devices are going to
+			be suspended
+
+It is generally assumed that whatever the notifiers do for SUSPEND_PREPARE,
+should be undone for SUSPEND_FINISHED, and what is done for
+SUSPEND_ENTER_PREPARE, should be undone for SUSPEND_FINISHED (eg. if memory is
+allocated for SUSPEND_ENTER_PREPARE, it should be freed for SUSPEND_FINISHED).
+
+The suspend notifiers are defined in the usual way, but their last argument is
+meaningless (it is always NULL).  To register and/or unregister a suspend
+notifier use the functions register_suspend_notifier() and
+unregister_suspend_notifier(), respectively, defined in kernel/power/notify.c .
+If you don't need to unregister the notifier, you can also use the
+suspend_notifier() macro, defined in include/linux/suspend.h .

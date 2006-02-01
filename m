From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm][Experimental] swsusp: freeze userspace
	processes first
Date: Wed, 1 Feb 2006 01:41:52 +0100
Message-ID: <200602010141.53974.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============81998313781652632=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============81998313781652632==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This is an experimantal patch aimed at the "unable to freeze processes under
load" problem.

On my box the 2.6.16-rc1-mm4 kernel with this patch applied survives the
"dd if=/dev/hda of=/dev/null" test.

Please have a look.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 include/linux/kmod.h    |    3 ++
 include/linux/suspend.h |    4 +++
 kernel/kmod.c           |   23 +++++++++++++++++
 kernel/power/process.c  |   62 +++++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 83 insertions(+), 9 deletions(-)

Index: linux-2.6.16-rc1-mm4/kernel/power/process.c
===================================================================
--- linux-2.6.16-rc1-mm4.orig/kernel/power/process.c	2006-01-31 23:45:59.000000000 +0100
+++ linux-2.6.16-rc1-mm4/kernel/power/process.c	2006-02-01 01:12:14.000000000 +0100
@@ -12,12 +12,19 @@
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
+#include <linux/kmod.h>
+#include <linux/mutex.h>
 
 /* 
  * Timeout for stopping processes
  */
 #define TIMEOUT	(6 * HZ)
 
+/* This is used to disable usermodehelper invocations while
+ * freeze_processes() is being executed
+ */
+int freezing_processes;
+DEFINE_MUTEX(freezer_lock);
 
 static inline int freezeable(struct task_struct * p)
 {
@@ -54,40 +61,77 @@ void refrigerator(void)
 	current->state = save;
 }
 
+static inline void freeze_process(struct task_struct *p)
+{
+	unsigned long flags;
+
+	freeze(p);
+	spin_lock_irqsave(&p->sighand->siglock, flags);
+	signal_wake_up(p, 0);
+	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+}
+
 /* 0 = success, else # of processes that we failed to stop */
 int freeze_processes(void)
 {
-	int todo;
+	int todo, nr_kernel, nr_user, user_frozen;
 	unsigned long start_time;
 	struct task_struct *g, *p;
 	unsigned long flags;
 
+	mutex_lock(&freezer_lock);
+	freezing_processes = 1;
+	mutex_unlock(&freezer_lock);
+	while (atomic_read(&usermodehelper_waiting))
+		schedule();
+
 	printk( "Stopping tasks: " );
 	start_time = jiffies;
+	user_frozen = 0;
 	do {
-		todo = 0;
+		nr_kernel = 0;
+		nr_user = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			if (!freezeable(p))
 				continue;
 			if (frozen(p))
 				continue;
-
-			freeze(p);
-			spin_lock_irqsave(&p->sighand->siglock, flags);
-			signal_wake_up(p, 0);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			todo++;
+			if (p->mm) {
+				/* The task is a user-space one. Freeze it */
+				printk("  freezing %s\n", p->comm);
+				freeze_process(p);
+				nr_user++;
+			} else {
+				/* Freeze only if the user space is frozen */
+				if (user_frozen) {
+					printk("  freezing [%s]\n", p->comm);
+					freeze_process(p);
+				}
+				nr_kernel++;
+			}
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
+		user_frozen = !nr_user;
+		todo = nr_user + nr_kernel;
 		yield();			/* Yield is okay here */
 		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
-			printk(KERN_ERR " stopping tasks timed out (%d tasks remaining)\n", todo );
+			printk(KERN_ERR " stopping tasks timed out "
+				"after %d seconds (%d tasks remaining):\n",
+				TIMEOUT / HZ, todo);
+			do_each_thread(g, p) {
+				if (freezeable(p) && !frozen(p))
+					printk(KERN_ERR "  %s\n", p->comm);
+			} while_each_thread(g, p);
 			break;
 		}
 	} while(todo);
 
+	mutex_lock(&freezer_lock);
+	freezing_processes = 0;
+	mutex_unlock(&freezer_lock);
+
 	/* This does not unfreeze processes that are already frozen
 	 * (we have slightly ugly calling convention in that respect,
 	 * and caller must call thaw_processes() if something fails),
Index: linux-2.6.16-rc1-mm4/kernel/kmod.c
===================================================================
--- linux-2.6.16-rc1-mm4.orig/kernel/kmod.c	2006-01-31 23:45:59.000000000 +0100
+++ linux-2.6.16-rc1-mm4/kernel/kmod.c	2006-02-01 00:20:10.000000000 +0100
@@ -36,6 +36,8 @@
 #include <linux/mount.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/suspend.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 
 extern int max_threads;
@@ -216,6 +218,10 @@ static void __call_usermodehelper(void *
 		complete(sub_info->complete);
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+atomic_t usermodehelper_waiting = ATOMIC_INIT(0);
+#endif
+
 /**
  * call_usermodehelper_keys - start a usermode application
  * @path: pathname for the application
@@ -249,11 +255,28 @@ int call_usermodehelper_keys(char *path,
 	if (!khelper_wq)
 		return -EBUSY;
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	mutex_lock(&freezer_lock);
+	if (freezing_processes) {
+		mutex_unlock(&freezer_lock);
+		return 0;
+	}
+	if (wait)
+		atomic_inc(&usermodehelper_waiting);
+	mutex_unlock(&freezer_lock);
+#endif
+
 	if (path[0] == '\0')
 		return 0;
 
 	queue_work(khelper_wq, &work);
 	wait_for_completion(&done);
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	if (wait)
+		atomic_dec(&usermodehelper_waiting);
+#endif
+
 	return sub_info.retval;
 }
 EXPORT_SYMBOL(call_usermodehelper_keys);
Index: linux-2.6.16-rc1-mm4/include/linux/suspend.h
===================================================================
--- linux-2.6.16-rc1-mm4.orig/include/linux/suspend.h	2006-01-31 23:45:59.000000000 +0100
+++ linux-2.6.16-rc1-mm4/include/linux/suspend.h	2006-02-01 00:20:20.000000000 +0100
@@ -40,6 +40,10 @@ extern void drain_local_pages(void);
 extern void mark_free_pages(struct zone *zone);
 
 #ifdef CONFIG_PM
+struct mutex;
+extern struct mutex freezer_lock;
+extern int freezing_processes;
+
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
 
Index: linux-2.6.16-rc1-mm4/include/linux/kmod.h
===================================================================
--- linux-2.6.16-rc1-mm4.orig/include/linux/kmod.h	2006-01-31 23:45:59.000000000 +0100
+++ linux-2.6.16-rc1-mm4/include/linux/kmod.h	2006-02-01 00:06:19.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/compiler.h>
+#include <asm/atomic.h>
 
 #define KMOD_PATH_LEN 256
 
@@ -36,6 +37,8 @@ static inline int request_module(const c
 
 #define try_then_request_module(x, mod...) ((x) ?: (request_module(mod), (x)))
 
+extern atomic_t usermodehelper_waiting;
+
 struct key;
 extern int call_usermodehelper_keys(char *path, char *argv[], char *envp[],
 				    struct key *session_keyring, int wait);

--===============81998313781652632==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============81998313781652632==--

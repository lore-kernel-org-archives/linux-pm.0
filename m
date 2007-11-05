From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: convert PM notifiers to out-of-line code
Date: Mon, 5 Nov 2007 15:58:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711051556210.2800-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1008) converts the PM notifier routines from inline
calls to out-of-line code.  It also prevents pm_chain_head from
being created when CONFIG_PM_SLEEP isn't enabled, and EXPORTs the
notifier registration and unregistration routines.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/include/linux/suspend.h
===================================================================
--- usb-2.6.orig/include/linux/suspend.h
+++ usb-2.6/include/linux/suspend.h
@@ -216,17 +216,8 @@ void __save_processor_state(struct saved
 void __restore_processor_state(struct saved_context *ctxt);
 
 /* kernel/power/main.c */
-extern struct blocking_notifier_head pm_chain_head;
-
-static inline int register_pm_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&pm_chain_head, nb);
-}
-
-static inline int unregister_pm_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&pm_chain_head, nb);
-}
+extern int register_pm_notifier(struct notifier_block *nb);
+extern int unregister_pm_notifier(struct notifier_block *nb);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
Index: usb-2.6/kernel/power/main.c
===================================================================
--- usb-2.6.orig/kernel/power/main.c
+++ usb-2.6/kernel/power/main.c
@@ -24,8 +24,6 @@
 
 #include "power.h"
 
-BLOCKING_NOTIFIER_HEAD(pm_chain_head);
-
 DEFINE_MUTEX(pm_mutex);
 
 #ifdef CONFIG_SUSPEND
Index: usb-2.6/kernel/power/power.h
===================================================================
--- usb-2.6.orig/kernel/power/power.h
+++ usb-2.6/kernel/power/power.h
@@ -203,11 +203,5 @@ static inline int suspend_devices_and_en
 }
 #endif /* !CONFIG_SUSPEND */
 
-/* kernel/power/common.c */
-extern struct blocking_notifier_head pm_chain_head;
-
-static inline int pm_notifier_call_chain(unsigned long val)
-{
-	return (blocking_notifier_call_chain(&pm_chain_head, val, NULL)
-			== NOTIFY_BAD) ? -EINVAL : 0;
-}
+/* kernel/power/process.c */
+extern int pm_notifier_call_chain(unsigned long val);
Index: usb-2.6/kernel/power/process.c
===================================================================
--- usb-2.6.orig/kernel/power/process.c
+++ usb-2.6/kernel/power/process.c
@@ -283,3 +283,25 @@ void thaw_processes(void)
 }
 
 EXPORT_SYMBOL(refrigerator);
+
+/* Routines for PM-transition notifications */
+
+static BLOCKING_NOTIFIER_HEAD(pm_chain_head);
+
+int register_pm_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&pm_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(register_pm_notifier);
+
+int unregister_pm_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&pm_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_pm_notifier);
+
+int pm_notifier_call_chain(unsigned long val)
+{
+	return (blocking_notifier_call_chain(&pm_chain_head, val, NULL)
+			== NOTIFY_BAD) ? -EINVAL : 0;
+}

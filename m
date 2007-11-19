From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 8/8] PM: Convert PM notifiers to out-of-line code
Date: Mon, 19 Nov 2007 23:49:18 +0100
Message-ID: <200711192349.19063.rjw__16298.5731535175$1195512410$gmane$org@sisk.pl>
References: <200711192332.15078.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711192332.15078.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: Adrian Bunk <bunk@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch (as1008b) converts the PM notifier routines from inline
calls to out-of-line code.  It also prevents pm_chain_head from
being created when CONFIG_PM_SLEEP isn't enabled, and EXPORTs the
notifier registration and unregistration routines.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/suspend.h |   13 ++-----------
 kernel/power/main.c     |   28 ++++++++++++++++++++++++++--
 kernel/power/power.h    |   12 ++++--------
 3 files changed, 32 insertions(+), 21 deletions(-)

Index: linux-2.6/include/linux/suspend.h
===================================================================
--- linux-2.6.orig/include/linux/suspend.h
+++ linux-2.6/include/linux/suspend.h
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
Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -24,10 +24,34 @@
 
 #include "power.h"
 
-BLOCKING_NOTIFIER_HEAD(pm_chain_head);
-
 DEFINE_MUTEX(pm_mutex);
 
+#ifdef CONFIG_PM_SLEEP
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
+
+#endif /* CONFIG_PM_SLEEP */
+
 #ifdef CONFIG_PM_DEBUG
 int pm_test_level = TEST_NONE;
 
Index: linux-2.6/kernel/power/power.h
===================================================================
--- linux-2.6.orig/kernel/power/power.h
+++ linux-2.6/kernel/power/power.h
@@ -174,14 +174,10 @@ static inline int suspend_devices_and_en
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
+#ifdef CONFIG_PM_SLEEP
+/* kernel/power/main.c */
+extern int pm_notifier_call_chain(unsigned long val);
+#endif
 
 #ifdef CONFIG_HIGHMEM
 unsigned int count_highmem_pages(void);

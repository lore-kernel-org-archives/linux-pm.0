From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] ACPI / EC / PM: Fix race between EC
	transactions and system suspend
Date: Fri, 9 Apr 2010 01:39:40 +0200
Message-ID: <201004090139.40251.rjw__33848.2659463354$1270770123$gmane$org@sisk.pl>
References: <201004090138.13522.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004090138.13522.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

There still is a race that may result in suspending the system in
the middle of an EC transaction in progress, which leads to problems
(like the kernel thinking that the ACPI global lock is held during
resume while in fact it's not).

To remove the race condition, modify the ACPI platform suspend and
hibernate callbacks so that EC transactions are blocked right after
executing the _PTS global control method and are allowed to happen
again right after the low-level wakeup.

Introduce acpi_pm_freeze() that will disable GPEs, wait until the
event queues are empty and block EC transactions.  Use it wherever
GPEs are disabled in preparation for switching local interrupts off.
Introduce acpi_pm_thaw() that will allow EC transactions to happen
again and enable runtime GPEs.  Use it to balance acpi_pm_freeze()
wherever necessary.

In addition to that use acpi_ec_resume_transactions_early() to
unblock EC transactions as early as reasonably possible during
resume.  Also unblock EC transactions in acpi_hibernation_finish()
and in the analogous suspend routine to make sure that the EC
transactions are enabled in all error paths.

Fixes https://bugzilla.kernel.org/show_bug.cgi?id=14668

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-and-tested-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 drivers/acpi/ec.c       |   10 ++++++++
 drivers/acpi/internal.h |    1 
 drivers/acpi/sleep.c    |   55 +++++++++++++++++++++++++-----------------------
 3 files changed, 40 insertions(+), 26 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -485,6 +485,16 @@ void acpi_ec_resume_transactions(void)
 	mutex_unlock(&ec->lock);
 }
 
+void acpi_ec_resume_transactions_early(void)
+{
+	/*
+	 * Allow transactions to happen again (this function is called from
+	 * atomic context during wakeup, so we don't need to acquire the mutex).
+	 */
+	if (first_ec)
+		clear_bit(EC_FLAGS_FROZEN, &first_ec->flags);
+}
+
 static int acpi_ec_query_unlocked(struct acpi_ec *ec, u8 * data)
 {
 	int result;
Index: linux-2.6/drivers/acpi/internal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/internal.h
+++ linux-2.6/drivers/acpi/internal.h
@@ -51,6 +51,7 @@ int acpi_ec_ecdt_probe(void);
 int acpi_boot_ec_enable(void);
 void acpi_ec_suspend_transactions(void);
 void acpi_ec_resume_transactions(void);
+void acpi_ec_resume_transactions_early(void);
 
 /*--------------------------------------------------------------------------
                                   Suspend/Resume
Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -110,11 +110,13 @@ void __init acpi_old_suspend_ordering(vo
 }
 
 /**
- *	acpi_pm_disable_gpes - Disable the GPEs.
+ * acpi_pm_freeze - Disable the GPEs and suspend EC transactions.
  */
-static int acpi_pm_disable_gpes(void)
+static int acpi_pm_freeze(void)
 {
 	acpi_disable_all_gpes();
+	acpi_os_wait_events_complete(NULL);
+	acpi_ec_suspend_transactions();
 	return 0;
 }
 
@@ -142,7 +144,8 @@ static int acpi_pm_prepare(void)
 	int error = __acpi_pm_prepare();
 
 	if (!error)
-		acpi_disable_all_gpes();
+		acpi_pm_freeze();
+
 	return error;
 }
 
@@ -275,6 +278,8 @@ static int acpi_suspend_enter(suspend_st
 	 * acpi_leave_sleep_state will reenable specific GPEs later
 	 */
 	acpi_disable_all_gpes();
+	/* Allow EC transactions to happen. */
+	acpi_ec_resume_transactions_early();
 
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
@@ -286,6 +291,12 @@ static int acpi_suspend_enter(suspend_st
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
+static void acpi_suspend_finish(void)
+{
+	acpi_ec_resume_transactions();
+	acpi_pm_finish();
+}
+
 static int acpi_suspend_state_valid(suspend_state_t pm_state)
 {
 	u32 acpi_state;
@@ -307,7 +318,7 @@ static struct platform_suspend_ops acpi_
 	.begin = acpi_suspend_begin,
 	.prepare_late = acpi_pm_prepare,
 	.enter = acpi_suspend_enter,
-	.wake = acpi_pm_finish,
+	.wake = acpi_suspend_finish,
 	.end = acpi_pm_end,
 };
 
@@ -333,9 +344,9 @@ static int acpi_suspend_begin_old(suspen
 static struct platform_suspend_ops acpi_suspend_ops_old = {
 	.valid = acpi_suspend_state_valid,
 	.begin = acpi_suspend_begin_old,
-	.prepare_late = acpi_pm_disable_gpes,
+	.prepare_late = acpi_pm_freeze,
 	.enter = acpi_suspend_enter,
-	.wake = acpi_pm_finish,
+	.wake = acpi_suspend_finish,
 	.end = acpi_pm_end,
 	.recover = acpi_pm_finish,
 };
@@ -530,6 +541,7 @@ static int acpi_hibernation_enter(void)
 static void acpi_hibernation_finish(void)
 {
 	hibernate_nvs_free();
+	acpi_ec_resume_transactions();
 	acpi_pm_finish();
 }
 
@@ -550,17 +562,11 @@ static void acpi_hibernation_leave(void)
 	}
 	/* Restore the NVS memory area */
 	hibernate_nvs_restore();
+	/* Allow EC transactions to happen. */
+	acpi_ec_resume_transactions_early();
 }
 
-static int acpi_pm_pre_restore(void)
-{
-	acpi_disable_all_gpes();
-	acpi_os_wait_events_complete(NULL);
-	acpi_ec_suspend_transactions();
-	return 0;
-}
-
-static void acpi_pm_restore_cleanup(void)
+static void acpi_pm_thaw(void)
 {
 	acpi_ec_resume_transactions();
 	acpi_enable_all_runtime_gpes();
@@ -574,8 +580,8 @@ static struct platform_hibernation_ops a
 	.prepare = acpi_pm_prepare,
 	.enter = acpi_hibernation_enter,
 	.leave = acpi_hibernation_leave,
-	.pre_restore = acpi_pm_pre_restore,
-	.restore_cleanup = acpi_pm_restore_cleanup,
+	.pre_restore = acpi_pm_freeze,
+	.restore_cleanup = acpi_pm_thaw,
 };
 
 /**
@@ -607,12 +613,9 @@ static int acpi_hibernation_begin_old(vo
 
 static int acpi_hibernation_pre_snapshot_old(void)
 {
-	int error = acpi_pm_disable_gpes();
-
-	if (!error)
-		hibernate_nvs_save();
-
-	return error;
+	acpi_pm_freeze();
+	hibernate_nvs_save();
+	return 0;
 }
 
 /*
@@ -624,11 +627,11 @@ static struct platform_hibernation_ops a
 	.end = acpi_pm_end,
 	.pre_snapshot = acpi_hibernation_pre_snapshot_old,
 	.finish = acpi_hibernation_finish,
-	.prepare = acpi_pm_disable_gpes,
+	.prepare = acpi_pm_freeze,
 	.enter = acpi_hibernation_enter,
 	.leave = acpi_hibernation_leave,
-	.pre_restore = acpi_pm_pre_restore,
-	.restore_cleanup = acpi_pm_restore_cleanup,
+	.pre_restore = acpi_pm_freeze,
+	.restore_cleanup = acpi_pm_thaw,
 	.recover = acpi_pm_finish,
 };
 #endif /* CONFIG_HIBERNATION */

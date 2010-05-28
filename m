From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 2/2] ACPI / EC / PM: Fix race between EC
	transactions and system suspend
Date: Fri, 28 May 2010 23:22:17 +0300
Message-ID: <1275078137-21139-2-git-send-email-maximlevitsky__32100.3672121607$1275078204$gmane$org@gmail.com>
References: <1275077971.20606.20.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275077971.20606.20.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59-kernel@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There still is a race that may result in suspending the system in
the middle of an EC transaction in progress, which leads to problems
(like the kernel thinking that the ACPI global lock is held during
resume while in fact it's not).

To remove the race condition, modify the ACPI platform suspend and
hibernate callbacks so that EC transactions are blocked right after
executing the _PTS global control method and are allowed to happen
again right after the low-level wakeup.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 drivers/acpi/ec.c       |   10 +++++++
 drivers/acpi/internal.h |    1 +
 drivers/acpi/sleep.c    |   63 ++++++++++++++++++++++++++--------------------
 3 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f2234db..2c2b73a 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
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
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index e284113..0ec48c7 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -51,6 +51,7 @@ int acpi_ec_ecdt_probe(void);
 int acpi_boot_ec_enable(void);
 void acpi_ec_suspend_transactions(void);
 void acpi_ec_resume_transactions(void);
+void acpi_ec_resume_transactions_early(void);
 
 /*--------------------------------------------------------------------------
                                   Suspend/Resume
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 18aa074..76ee92c 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -110,11 +110,13 @@ void __init acpi_old_suspend_ordering(void)
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
 
@@ -144,7 +146,8 @@ static int acpi_pm_prepare(void)
 	int error = __acpi_pm_prepare();
 
 	if (!error)
-		acpi_disable_all_gpes();
+		acpi_pm_freeze();
+
 	return error;
 }
 
@@ -284,6 +287,8 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	 * acpi_leave_sleep_state will reenable specific GPEs later
 	 */
 	acpi_disable_all_gpes();
+	/* Allow EC transactions to happen. */
+	acpi_ec_resume_transactions_early();
 
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
@@ -297,6 +302,12 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
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
@@ -318,7 +329,7 @@ static struct platform_suspend_ops acpi_suspend_ops = {
 	.begin = acpi_suspend_begin,
 	.prepare_late = acpi_pm_prepare,
 	.enter = acpi_suspend_enter,
-	.wake = acpi_pm_finish,
+	.wake = acpi_suspend_finish,
 	.end = acpi_pm_end,
 };
 
@@ -344,9 +355,9 @@ static int acpi_suspend_begin_old(suspend_state_t pm_state)
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
@@ -594,6 +605,13 @@ static int acpi_hibernation_enter(void)
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
+static void acpi_hibernation_finish(void)
+{
+	suspend_nvs_free();
+	acpi_ec_resume_transactions();
+	acpi_pm_finish();
+}
+
 static void acpi_hibernation_leave(void)
 {
 	/*
@@ -611,17 +629,11 @@ static void acpi_hibernation_leave(void)
 	}
 	/* Restore the NVS memory area */
 	suspend_nvs_restore();
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
@@ -635,8 +647,8 @@ static struct platform_hibernation_ops acpi_hibernation_ops = {
 	.prepare = acpi_pm_prepare,
 	.enter = acpi_hibernation_enter,
 	.leave = acpi_hibernation_leave,
-	.pre_restore = acpi_pm_pre_restore,
-	.restore_cleanup = acpi_pm_restore_cleanup,
+	.pre_restore = acpi_pm_freeze,
+	.restore_cleanup = acpi_pm_thaw,
 };
 
 /**
@@ -668,12 +680,9 @@ static int acpi_hibernation_begin_old(void)
 
 static int acpi_hibernation_pre_snapshot_old(void)
 {
-	int error = acpi_pm_disable_gpes();
-
-	if (!error)
-		suspend_nvs_save();
-
-	return error;
+	acpi_pm_freeze();
+	suspend_nvs_save();
+	return 0;
 }
 
 /*
@@ -684,12 +693,12 @@ static struct platform_hibernation_ops acpi_hibernation_ops_old = {
 	.begin = acpi_hibernation_begin_old,
 	.end = acpi_pm_end,
 	.pre_snapshot = acpi_hibernation_pre_snapshot_old,
-	.finish = acpi_pm_finish,
-	.prepare = acpi_pm_disable_gpes,
+	.finish = acpi_hibernation_finish,
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
-- 
1.7.0.4

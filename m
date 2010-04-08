From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] ACPI / EC / PM: Fix names of functions that
	block/unblock EC transactions
Date: Fri, 9 Apr 2010 01:40:38 +0200
Message-ID: <201004090140.38499.rjw__16350.0642324381$1270770120$gmane$org@sisk.pl>
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

The names of the functions used for blocking/unblocking EC
transactions during suspend/hibernation suggest that the transactions
are suspended and resumed by them, while in fact they are disabled
and enabled.  Rename the functions (and the flag used by them) to
better reflect what they really do.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/ec.c       |   16 ++++++++--------
 drivers/acpi/internal.h |    6 +++---
 drivers/acpi/sleep.c    |   12 ++++++------
 3 files changed, 17 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -79,7 +79,7 @@ enum {
 	EC_FLAGS_GPE_STORM,		/* GPE storm detected */
 	EC_FLAGS_HANDLERS_INSTALLED,	/* Handlers for GPE and
 					 * OpReg are installed */
-	EC_FLAGS_FROZEN,		/* Transactions are suspended */
+	EC_FLAGS_BLOCKED,		/* Transactions are blocked */
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -293,7 +293,7 @@ static int acpi_ec_transaction(struct ac
 	if (t->rdata)
 		memset(t->rdata, 0, t->rlen);
 	mutex_lock(&ec->lock);
-	if (test_bit(EC_FLAGS_FROZEN, &ec->flags)) {
+	if (test_bit(EC_FLAGS_BLOCKED, &ec->flags)) {
 		status = -EINVAL;
 		goto unlock;
 	}
@@ -459,7 +459,7 @@ int ec_transaction(u8 command,
 
 EXPORT_SYMBOL(ec_transaction);
 
-void acpi_ec_suspend_transactions(void)
+void acpi_ec_block_transactions(void)
 {
 	struct acpi_ec *ec = first_ec;
 
@@ -468,11 +468,11 @@ void acpi_ec_suspend_transactions(void)
 
 	mutex_lock(&ec->lock);
 	/* Prevent transactions from being carried out */
-	set_bit(EC_FLAGS_FROZEN, &ec->flags);
+	set_bit(EC_FLAGS_BLOCKED, &ec->flags);
 	mutex_unlock(&ec->lock);
 }
 
-void acpi_ec_resume_transactions(void)
+void acpi_ec_unblock_transactions(void)
 {
 	struct acpi_ec *ec = first_ec;
 
@@ -481,18 +481,18 @@ void acpi_ec_resume_transactions(void)
 
 	mutex_lock(&ec->lock);
 	/* Allow transactions to be carried out again */
-	clear_bit(EC_FLAGS_FROZEN, &ec->flags);
+	clear_bit(EC_FLAGS_BLOCKED, &ec->flags);
 	mutex_unlock(&ec->lock);
 }
 
-void acpi_ec_resume_transactions_early(void)
+void acpi_ec_unblock_transactions_early(void)
 {
 	/*
 	 * Allow transactions to happen again (this function is called from
 	 * atomic context during wakeup, so we don't need to acquire the mutex).
 	 */
 	if (first_ec)
-		clear_bit(EC_FLAGS_FROZEN, &first_ec->flags);
+		clear_bit(EC_FLAGS_BLOCKED, &first_ec->flags);
 }
 
 static int acpi_ec_query_unlocked(struct acpi_ec *ec, u8 * data)
Index: linux-2.6/drivers/acpi/internal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/internal.h
+++ linux-2.6/drivers/acpi/internal.h
@@ -49,9 +49,9 @@ void acpi_early_processor_set_pdc(void);
 int acpi_ec_init(void);
 int acpi_ec_ecdt_probe(void);
 int acpi_boot_ec_enable(void);
-void acpi_ec_suspend_transactions(void);
-void acpi_ec_resume_transactions(void);
-void acpi_ec_resume_transactions_early(void);
+void acpi_ec_block_transactions(void);
+void acpi_ec_unblock_transactions(void);
+void acpi_ec_unblock_transactions_early(void);
 
 /*--------------------------------------------------------------------------
                                   Suspend/Resume
Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -116,7 +116,7 @@ static int acpi_pm_freeze(void)
 {
 	acpi_disable_all_gpes();
 	acpi_os_wait_events_complete(NULL);
-	acpi_ec_suspend_transactions();
+	acpi_ec_block_transactions();
 	return 0;
 }
 
@@ -279,7 +279,7 @@ static int acpi_suspend_enter(suspend_st
 	 */
 	acpi_disable_all_gpes();
 	/* Allow EC transactions to happen. */
-	acpi_ec_resume_transactions_early();
+	acpi_ec_unblock_transactions_early();
 
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
@@ -293,7 +293,7 @@ static int acpi_suspend_enter(suspend_st
 
 static void acpi_suspend_finish(void)
 {
-	acpi_ec_resume_transactions();
+	acpi_ec_unblock_transactions();
 	acpi_pm_finish();
 }
 
@@ -541,7 +541,7 @@ static int acpi_hibernation_enter(void)
 static void acpi_hibernation_finish(void)
 {
 	hibernate_nvs_free();
-	acpi_ec_resume_transactions();
+	acpi_ec_unblock_transactions();
 	acpi_pm_finish();
 }
 
@@ -563,12 +563,12 @@ static void acpi_hibernation_leave(void)
 	/* Restore the NVS memory area */
 	hibernate_nvs_restore();
 	/* Allow EC transactions to happen. */
-	acpi_ec_resume_transactions_early();
+	acpi_ec_unblock_transactions_early();
 }
 
 static void acpi_pm_thaw(void)
 {
-	acpi_ec_resume_transactions();
+	acpi_ec_unblock_transactions();
 	acpi_enable_all_runtime_gpes();
 }
 

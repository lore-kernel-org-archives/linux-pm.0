From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/6] ACPI / PM: Drop acpi_restore_state_mem()
Date: Mon, 7 Feb 2011 23:18:02 +0100
Message-ID: <201102072318.02829.rjw__4889.7577602931$1297117965$gmane$org@sisk.pl>
References: <201102072316.41270.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102072316.41270.rjw@sisk.pl>
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
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The function acpi_restore_state_mem() has never been and most likely
never will be used, so remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/ia64/include/asm/acpi.h |    4 ++--
 arch/ia64/kernel/acpi.c      |    5 -----
 arch/x86/include/asm/acpi.h  |    3 +--
 arch/x86/kernel/acpi/sleep.c |    8 --------
 drivers/acpi/sleep.c         |    4 ----
 5 files changed, 3 insertions(+), 21 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -293,10 +293,6 @@ static int acpi_suspend_enter(suspend_st
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 
-	/* restore processor state */
-	if (acpi_state == ACPI_STATE_S3)
-		acpi_restore_state_mem();
-
 	suspend_nvs_restore();
 
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
Index: linux-2.6/arch/ia64/include/asm/acpi.h
===================================================================
--- linux-2.6.orig/arch/ia64/include/asm/acpi.h
+++ linux-2.6/arch/ia64/include/asm/acpi.h
@@ -128,9 +128,9 @@ static inline const char *acpi_get_sysna
 int acpi_request_vector (u32 int_type);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 
-/* routines for saving/restoring kernel state */
+/* Routine for saving kernel state during suspend. */
 extern int acpi_save_state_mem(void);
-extern void acpi_restore_state_mem(void);
+
 extern unsigned long acpi_wakeup_address;
 
 /*
Index: linux-2.6/arch/ia64/kernel/acpi.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/acpi.c
+++ linux-2.6/arch/ia64/kernel/acpi.c
@@ -1041,11 +1041,6 @@ EXPORT_SYMBOL(acpi_unregister_ioapic);
 int acpi_save_state_mem(void) { return 0; } 
 
 /*
- * acpi_restore_state()
- */
-void acpi_restore_state_mem(void) {}
-
-/*
  * do_suspend_lowlevel()
  */
 void do_suspend_lowlevel(void) {}
Index: linux-2.6/arch/x86/include/asm/acpi.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/acpi.h
+++ linux-2.6/arch/x86/include/asm/acpi.h
@@ -112,9 +112,8 @@ static inline void acpi_disable_pci(void
 	acpi_noirq_set();
 }
 
-/* routines for saving/restoring kernel state */
+/* Routine for saving kernel state during suspend. */
 extern int acpi_save_state_mem(void);
-extern void acpi_restore_state_mem(void);
 
 extern unsigned long acpi_wakeup_address;
 
Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-2.6/arch/x86/kernel/acpi/sleep.c
@@ -112,14 +112,6 @@ int acpi_save_state_mem(void)
 	return 0;
 }
 
-/*
- * acpi_restore_state - undo effects of acpi_save_state_mem
- */
-void acpi_restore_state_mem(void)
-{
-}
-
-
 /**
  * acpi_reserve_wakeup_memory - do _very_ early ACPI initialisation
  *

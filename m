From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/6] ACPI / PM: Merge do_suspend_lowlevel() into
	acpi_save_state_mem()
Date: Mon, 7 Feb 2011 23:21:37 +0100
Message-ID: <201102072321.37565.rjw__12258.9916027666$1297118163$gmane$org@sisk.pl>
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

The function do_suspend_lowlevel() is specific to x86 and defined in
assembly code, so it should be called from the x86 low-level suspend
code rather than from acpi_suspend_enter().

Merge do_suspend_lowlevel() into the x86's acpi_save_state_mem() and
change the name of the latter to acpi_suspend_lowlevel(), so that the
function's purpose is better reflected by its name.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/ia64/include/asm/acpi.h |    4 ++--
 arch/ia64/kernel/acpi.c      |    9 ++-------
 arch/x86/include/asm/acpi.h  |    4 ++--
 arch/x86/kernel/acpi/sleep.c |    5 +++--
 arch/x86/kernel/acpi/sleep.h |    2 ++
 drivers/acpi/sleep.c         |    5 +----
 6 files changed, 12 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -199,8 +199,6 @@ static void acpi_pm_end(void)
 #endif /* CONFIG_ACPI_SLEEP */
 
 #ifdef CONFIG_SUSPEND
-extern void do_suspend_lowlevel(void);
-
 static u32 acpi_suspend_states[] = {
 	[PM_SUSPEND_ON] = ACPI_STATE_S0,
 	[PM_SUSPEND_STANDBY] = ACPI_STATE_S1,
@@ -255,10 +253,9 @@ static int acpi_suspend_enter(suspend_st
 		break;
 
 	case ACPI_STATE_S3:
-		error = acpi_save_state_mem();
+		error = acpi_suspend_lowlevel();
 		if (error)
 			return error;
-		do_suspend_lowlevel();
 		pr_info(PREFIX "Low-level resume complete\n");
 		break;
 	}
Index: linux-2.6/arch/ia64/include/asm/acpi.h
===================================================================
--- linux-2.6.orig/arch/ia64/include/asm/acpi.h
+++ linux-2.6/arch/ia64/include/asm/acpi.h
@@ -128,8 +128,8 @@ static inline const char *acpi_get_sysna
 int acpi_request_vector (u32 int_type);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 
-/* Routine for saving kernel state during suspend. */
-extern int acpi_save_state_mem(void);
+/* Low-level suspend routine. */
+extern int acpi_suspend_lowlevel(void);
 
 extern unsigned long acpi_wakeup_address;
 
Index: linux-2.6/arch/ia64/kernel/acpi.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/acpi.c
+++ linux-2.6/arch/ia64/kernel/acpi.c
@@ -1034,13 +1034,8 @@ int acpi_unregister_ioapic(acpi_handle h
 EXPORT_SYMBOL(acpi_unregister_ioapic);
 
 /*
- * acpi_save_state_mem() - save kernel state
+ * acpi_suspend_lowlevel() - save kernel state and suspend.
  *
  * TBD when when IA64 starts to support suspend...
  */
-int acpi_save_state_mem(void) { return 0; } 
-
-/*
- * do_suspend_lowlevel()
- */
-void do_suspend_lowlevel(void) {}
+int acpi_suspend_lowlevel(void) { return 0; }
Index: linux-2.6/arch/x86/include/asm/acpi.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/acpi.h
+++ linux-2.6/arch/x86/include/asm/acpi.h
@@ -112,8 +112,8 @@ static inline void acpi_disable_pci(void
 	acpi_noirq_set();
 }
 
-/* Routine for saving kernel state during suspend. */
-extern int acpi_save_state_mem(void);
+/* Low-level suspend routine. */
+extern int acpi_suspend_lowlevel(void);
 
 extern unsigned long acpi_wakeup_address;
 
Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-2.6/arch/x86/kernel/acpi/sleep.c
@@ -31,14 +31,14 @@ static char temp_stack[4096];
 #endif
 
 /**
- * acpi_save_state_mem - save kernel state
+ * acpi_suspend_lowlevel - save kernel state
  *
  * Create an identity mapped page table and copy the wakeup routine to
  * low memory.
  *
  * Note that this is too late to change acpi_wakeup_address.
  */
-int acpi_save_state_mem(void)
+int acpi_suspend_lowlevel(void)
 {
 	struct wakeup_header *header;
 
@@ -109,6 +109,7 @@ int acpi_save_state_mem(void)
        saved_magic = 0x123456789abcdef0L;
 #endif /* CONFIG_64BIT */
 
+	do_suspend_lowlevel();
 	return 0;
 }
 
Index: linux-2.6/arch/x86/kernel/acpi/sleep.h
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/sleep.h
+++ linux-2.6/arch/x86/kernel/acpi/sleep.h
@@ -14,3 +14,5 @@ extern char swsusp_pg_dir[PAGE_SIZE];
 
 extern unsigned long acpi_copy_wakeup_routine(unsigned long);
 extern void wakeup_long64(void);
+
+extern void do_suspend_lowlevel(void);

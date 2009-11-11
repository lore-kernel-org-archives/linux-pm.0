From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] x86: make sure wakeup code is below 1M -v2
Date: Tue, 10 Nov 2009 18:27:23 -0800
Message-ID: <4AFA210B.3020207__34650.8396477022$1257906655$gmane$org@kernel.org>
References: <4AF7D820.5040503@kernel.org> <200911091315.13151.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911091315.13151.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


try to find_e820_area/reserve_early, and call acpi_reserve_memory early

to get area is below 1M

-v2: change function name to acpi_reserve_wakeup_memory according to Rafael

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 arch/x86/include/asm/acpi.h  |    2 +-
 arch/x86/kernel/acpi/sleep.c |   15 +++++++++------
 arch/x86/kernel/setup.c      |   13 +++++++------
 3 files changed, 17 insertions(+), 13 deletions(-)

Index: linux-2.6/arch/x86/include/asm/acpi.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/acpi.h
+++ linux-2.6/arch/x86/include/asm/acpi.h
@@ -118,7 +118,7 @@ extern void acpi_restore_state_mem(void)
 extern unsigned long acpi_wakeup_address;
 
 /* early initialization routine */
-extern void acpi_reserve_bootmem(void);
+extern void acpi_reserve_wakeup_memory(void);
 
 /*
  * Check if the CPU can handle C2 and deeper
Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-2.6/arch/x86/kernel/acpi/sleep.c
@@ -119,29 +119,32 @@ void acpi_restore_state_mem(void)
 
 
 /**
- * acpi_reserve_bootmem - do _very_ early ACPI initialisation
+ * acpi_reserve_wakeup_memory - do _very_ early ACPI initialisation
  *
  * We allocate a page from the first 1MB of memory for the wakeup
  * routine for when we come back from a sleep state. The
  * runtime allocator allows specification of <16MB pages, but not
  * <1MB pages.
  */
-void __init acpi_reserve_bootmem(void)
+void __init acpi_reserve_wakeup_memory(void)
 {
+	unsigned long mem;
+
 	if ((&wakeup_code_end - &wakeup_code_start) > WAKEUP_SIZE) {
 		printk(KERN_ERR
 		       "ACPI: Wakeup code way too big, S3 disabled.\n");
 		return;
 	}
 
-	acpi_realmode = (unsigned long)alloc_bootmem_low(WAKEUP_SIZE);
+	mem = find_e820_area(0, 1<<20, WAKEUP_SIZE, PAGE_SIZE);
 
-	if (!acpi_realmode) {
+	if (mem == -1L) {
 		printk(KERN_ERR "ACPI: Cannot allocate lowmem, S3 disabled.\n");
 		return;
 	}
-
-	acpi_wakeup_address = virt_to_phys((void *)acpi_realmode);
+	acpi_realmode = (unsigned long) phys_to_virt(mem);
+	acpi_wakeup_address = mem;
+	reserve_early(mem, mem + WAKEUP_SIZE, "ACPI WAKEUP");
 }
 
 
Index: linux-2.6/arch/x86/kernel/setup.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/setup.c
+++ linux-2.6/arch/x86/kernel/setup.c
@@ -905,6 +905,13 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_brk();
 
+#ifdef CONFIG_ACPI_SLEEP
+	/*
+	 * Reserve low memory region for sleep support.
+	 * even before init_memory_mapping
+	 */
+	acpi_reserve_wakeup_memory();
+#endif
 	init_gbpages();
 
 	/* max_pfn_mapped is updated here */
@@ -956,12 +963,6 @@ void __init setup_arch(char **cmdline_p)
 
 	initmem_init(0, max_pfn, acpi, k8);
 
-#ifdef CONFIG_ACPI_SLEEP
-	/*
-	 * Reserve low memory region for sleep support.
-	 */
-	acpi_reserve_bootmem();
-#endif
 	/*
 	 * Find and reserve possible boot-time SMP configuration:
 	 */

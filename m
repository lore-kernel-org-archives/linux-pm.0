From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: x86: Change static allocation of trampoline area
Date: Mon, 8 Dec 2008 00:50:22 +0100
Message-ID: <200812080050.23275.rjw__16246.0120198832$1228693996$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: x86: Change static allocation of trampoline area
Impact: Improvement

While debugging a suspend-to-RAM related issue it occured to me that
if the trampoline code had grown past 4 KB, we would have been
allocating too little memory for it, since the 4 KB size of the
trampoline is hardcoded into arch/x86/kernel/e820.c .  Change that
by making the kernel compute the trampoline size and allocate as much
memory as necessary.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/include/asm/trampoline.h |    7 +++++++
 arch/x86/kernel/e820.c            |   16 ----------------
 arch/x86/kernel/head32.c          |    3 +++
 arch/x86/kernel/head64.c          |    3 +++
 arch/x86/kernel/trampoline.c      |   19 +++++++++++++++++--
 5 files changed, 30 insertions(+), 18 deletions(-)

Index: linux-2.6/arch/x86/include/asm/trampoline.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/trampoline.h
+++ linux-2.6/arch/x86/include/asm/trampoline.h
@@ -3,6 +3,7 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_X86_TRAMPOLINE
 /*
  * Trampoline 80x86 program as an array.
  */
@@ -13,8 +14,14 @@ extern unsigned char *trampoline_base;
 extern unsigned long init_rsp;
 extern unsigned long initial_code;
 
+#define TRAMPOLINE_SIZE roundup(trampoline_end - trampoline_data, PAGE_SIZE)
 #define TRAMPOLINE_BASE 0x6000
+
 extern unsigned long setup_trampoline(void);
+extern void __init reserve_trampoline_memory(void);
+#else
+static inline void reserve_trampoline_memory(void) {};
+#endif /* CONFIG_X86_TRAMPOLINE */
 
 #endif /* __ASSEMBLY__ */
 
Index: linux-2.6/arch/x86/kernel/e820.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/e820.c
+++ linux-2.6/arch/x86/kernel/e820.c
@@ -698,22 +698,6 @@ struct early_res {
 };
 static struct early_res early_res[MAX_EARLY_RES] __initdata = {
 	{ 0, PAGE_SIZE, "BIOS data page" },	/* BIOS data page */
-#if defined(CONFIG_X86_64) && defined(CONFIG_X86_TRAMPOLINE)
-	{ TRAMPOLINE_BASE, TRAMPOLINE_BASE + 2 * PAGE_SIZE, "TRAMPOLINE" },
-#endif
-#if defined(CONFIG_X86_32) && defined(CONFIG_SMP)
-	/*
-	 * But first pinch a few for the stack/trampoline stuff
-	 * FIXME: Don't need the extra page at 4K, but need to fix
-	 * trampoline before removing it. (see the GDT stuff)
-	 */
-	{ PAGE_SIZE, PAGE_SIZE + PAGE_SIZE, "EX TRAMPOLINE" },
-	/*
-	 * Has to be in very low memory so we can execute
-	 * real-mode AP code.
-	 */
-	{ TRAMPOLINE_BASE, TRAMPOLINE_BASE + PAGE_SIZE, "TRAMPOLINE" },
-#endif
 	{}
 };
 
Index: linux-2.6/arch/x86/kernel/trampoline.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/trampoline.c
+++ linux-2.6/arch/x86/kernel/trampoline.c
@@ -1,10 +1,26 @@
 #include <linux/io.h>
 
 #include <asm/trampoline.h>
+#include <asm/e820.h>
 
 /* ready for x86_64 and x86 */
 unsigned char *trampoline_base = __va(TRAMPOLINE_BASE);
 
+void __init reserve_trampoline_memory(void)
+{
+#ifdef CONFIG_X86_32
+	/*
+	 * But first pinch a few for the stack/trampoline stuff
+	 * FIXME: Don't need the extra page at 4K, but need to fix
+	 * trampoline before removing it. (see the GDT stuff)
+	 */
+	reserve_early(PAGE_SIZE, PAGE_SIZE + PAGE_SIZE, "EX TRAMPOLINE");
+#endif
+	/* Has to be in very low memory so we can execute real-mode AP code. */
+	reserve_early(TRAMPOLINE_BASE, TRAMPOLINE_BASE + TRAMPOLINE_SIZE,
+			"TRAMPOLINE");
+}
+
 /*
  * Currently trivial. Write the real->protected mode
  * bootstrap into the page concerned. The caller
@@ -12,7 +28,6 @@ unsigned char *trampoline_base = __va(TR
  */
 unsigned long setup_trampoline(void)
 {
-	memcpy(trampoline_base, trampoline_data,
-	       trampoline_end - trampoline_data);
+	memcpy(trampoline_base, trampoline_data, TRAMPOLINE_SIZE);
 	return virt_to_phys(trampoline_base);
 }
Index: linux-2.6/arch/x86/kernel/head32.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/head32.c
+++ linux-2.6/arch/x86/kernel/head32.c
@@ -12,9 +12,12 @@
 #include <asm/sections.h>
 #include <asm/e820.h>
 #include <asm/bios_ebda.h>
+#include <asm/trampoline.h>
 
 void __init i386_start_kernel(void)
 {
+	reserve_trampoline_memory();
+
 	reserve_early(__pa_symbol(&_text), __pa_symbol(&_end), "TEXT DATA BSS");
 
 #ifdef CONFIG_BLK_DEV_INITRD
Index: linux-2.6/arch/x86/kernel/head64.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/head64.c
+++ linux-2.6/arch/x86/kernel/head64.c
@@ -24,6 +24,7 @@
 #include <asm/kdebug.h>
 #include <asm/e820.h>
 #include <asm/bios_ebda.h>
+#include <asm/trampoline.h>
 
 /* boot cpu pda */
 static struct x8664_pda _boot_cpu_pda __read_mostly;
@@ -120,6 +121,8 @@ void __init x86_64_start_reservations(ch
 {
 	copy_bootdata(__va(real_mode_data));
 
+	reserve_trampoline_memory();
+
 	reserve_early(__pa_symbol(&_text), __pa_symbol(&_end), "TEXT DATA BSS");
 
 #ifdef CONFIG_BLK_DEV_INITRD

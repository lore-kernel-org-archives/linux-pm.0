From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] pm: cleanup includes
Date: Wed, 25 Feb 2009 13:06:04 +0900
Message-ID: <20090225040604.18532.22158.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: linux-pm@lists.linux-foundation.org
Cc: akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch removes unused/duplicate cruft from asm/suspend.h:
 - x86_32: remove unused acpi code
 - powerpc: remove duplicate prototypes, see linux/suspend.h

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 allmodconfig bzImage builds on x86, powerpc untested

 arch/powerpc/include/asm/suspend.h |    3 ---
 arch/x86/include/asm/suspend_32.h  |   24 ------------------------
 2 files changed, 27 deletions(-)

--- 0001/arch/powerpc/include/asm/suspend.h
+++ work/arch/powerpc/include/asm/suspend.h	2009-02-25 12:44:53.000000000 +0900
@@ -3,7 +3,4 @@
 
 static inline int arch_prepare_suspend(void) { return 0; }
 
-void save_processor_state(void);
-void restore_processor_state(void);
-
 #endif /* __ASM_POWERPC_SUSPEND_H */
--- 0001/arch/x86/include/asm/suspend_32.h
+++ work/arch/x86/include/asm/suspend_32.h	2009-02-25 12:46:42.000000000 +0900
@@ -24,28 +24,4 @@ struct saved_context {
 	unsigned long return_address;
 } __attribute__((packed));
 
-#ifdef CONFIG_ACPI
-extern unsigned long saved_eip;
-extern unsigned long saved_esp;
-extern unsigned long saved_ebp;
-extern unsigned long saved_ebx;
-extern unsigned long saved_esi;
-extern unsigned long saved_edi;
-
-static inline void acpi_save_register_state(unsigned long return_point)
-{
-	saved_eip = return_point;
-	asm volatile("movl %%esp,%0" : "=m" (saved_esp));
-	asm volatile("movl %%ebp,%0" : "=m" (saved_ebp));
-	asm volatile("movl %%ebx,%0" : "=m" (saved_ebx));
-	asm volatile("movl %%edi,%0" : "=m" (saved_edi));
-	asm volatile("movl %%esi,%0" : "=m" (saved_esi));
-}
-
-#define acpi_restore_register_state()  do {} while (0)
-
-/* routines for saving/restoring kernel state */
-extern int acpi_save_state_mem(void);
-#endif
-
 #endif /* _ASM_X86_SUSPEND_32_H */

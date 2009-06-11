From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 04/19] x86: unify power/cpu_(32|64) regarding
	saving processor state
Date: Thu, 11 Jun 2009 21:48:35 +0000 (UTC)
Message-ID: <S4AoGnG.A.D7H.mZXMKB__8301.64996809817$1244756915$gmane$org@chimera>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Date: Thu Jun 11 23:25:58 CEST 2009
In-Reply-To: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM List <linux-pm@lists.linux-foundation.org>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, Ingo Molnar <mingo@elte.hu>, Wu Fengguang <fengguang.wu@intel.com>, Jaswinder Singh Rajput <jaswinder@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Sergio Luis <sergio@larces.uece.br>

In this step we do unify cpu_32.c and cpu_64.c functions that
work on saving the processor state.

Signed-off-by: Sergio Luis <sergio@larces.uece.br>
Signed-off-by: Lauro Salmito <laurosalmito@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/power/cpu_32.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/power/cpu_64.c |   29 +++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/arch/x86/power/cpu_32.c b/arch/x86/power/cpu_32.c
index de1a86b..294e78b 100644
--- a/arch/x86/power/cpu_32.c
+++ b/arch/x86/power/cpu_32.c
@@ -32,25 +32,65 @@ static void fix_processor_context(void);
 struct saved_context saved_context;
 #endif
 
+/**
+ *	__save_processor_state - save CPU registers before creating a
+ *		hibernation image and before restoring the memory state from it
+ *	@ctxt - structure to store the registers contents in
+ *
+ *	NOTE: If there is a CPU register the modification of which by the
+ *	boot kernel (ie. the kernel used for loading the hibernation image)
+ *	might affect the operations of the restored target kernel (ie. the one
+ *	saved in the hibernation image), then its contents must be saved by this
+ *	function.  In other words, if kernel A is hibernated and different
+ *	kernel B is used for loading the hibernation image into memory, the
+ *	kernel A's __save_processor_state() function must save all registers
+ *	needed by kernel A, so that it can operate correctly after the resume
+ *	regardless of what kernel B does in the meantime.
+ */
 static void __save_processor_state(struct saved_context *ctxt)
 {
+#ifdef CONFIG_X86_32
 	mtrr_save_fixed_ranges(NULL);
+#endif
 	kernel_fpu_begin();
 
 	/*
 	 * descriptor tables
 	 */
+#ifdef CONFIG_X86_32
 	store_gdt(&ctxt->gdt);
 	store_idt(&ctxt->idt);
+#else
+/* CONFIG_X86_64 */
+	store_gdt((struct desc_ptr *)&ctxt->gdt_limit);
+	store_idt((struct desc_ptr *)&ctxt->idt_limit);
+#endif
 	store_tr(ctxt->tr);
 
+	/* XMM0..XMM15 should be handled by kernel_fpu_begin(). */
 	/*
 	 * segment registers
 	 */
+#ifdef CONFIG_X86_32
 	savesegment(es, ctxt->es);
 	savesegment(fs, ctxt->fs);
 	savesegment(gs, ctxt->gs);
 	savesegment(ss, ctxt->ss);
+#else
+/* CONFIG_X86_64 */
+	asm volatile ("movw %%ds, %0" : "=m" (ctxt->ds));
+	asm volatile ("movw %%es, %0" : "=m" (ctxt->es));
+	asm volatile ("movw %%fs, %0" : "=m" (ctxt->fs));
+	asm volatile ("movw %%gs, %0" : "=m" (ctxt->gs));
+	asm volatile ("movw %%ss, %0" : "=m" (ctxt->ss));
+
+	rdmsrl(MSR_FS_BASE, ctxt->fs_base);
+	rdmsrl(MSR_GS_BASE, ctxt->gs_base);
+	rdmsrl(MSR_KERNEL_GS_BASE, ctxt->gs_kernel_base);
+	mtrr_save_fixed_ranges(NULL);
+
+	rdmsrl(MSR_EFER, ctxt->efer);
+#endif
 
 	/*
 	 * control registers
@@ -58,7 +98,13 @@ static void __save_processor_state(struct saved_context *ctxt)
 	ctxt->cr0 = read_cr0();
 	ctxt->cr2 = read_cr2();
 	ctxt->cr3 = read_cr3();
+#ifdef CONFIG_X86_32
 	ctxt->cr4 = read_cr4_safe();
+#else
+/* CONFIG_X86_64 */
+	ctxt->cr4 = read_cr4();
+	ctxt->cr8 = read_cr8();
+#endif
 }
 
 /* Needed by apm.c */
@@ -66,7 +112,9 @@ void save_processor_state(void)
 {
 	__save_processor_state(&saved_context);
 }
+#ifdef CONFIG_X86_32
 EXPORT_SYMBOL(save_processor_state);
+#endif
 
 static void do_fpu_end(void)
 {
diff --git a/arch/x86/power/cpu_64.c b/arch/x86/power/cpu_64.c
index 6ce0eca..11ea7d0 100644
--- a/arch/x86/power/cpu_64.c
+++ b/arch/x86/power/cpu_64.c
@@ -50,19 +50,35 @@ struct saved_context saved_context;
  */
 static void __save_processor_state(struct saved_context *ctxt)
 {
+#ifdef CONFIG_X86_32
+	mtrr_save_fixed_ranges(NULL);
+#endif
 	kernel_fpu_begin();
 
 	/*
 	 * descriptor tables
 	 */
+#ifdef CONFIG_X86_32
+	store_gdt(&ctxt->gdt);
+	store_idt(&ctxt->idt);
+#else
+/* CONFIG_X86_64 */
 	store_gdt((struct desc_ptr *)&ctxt->gdt_limit);
 	store_idt((struct desc_ptr *)&ctxt->idt_limit);
+#endif
 	store_tr(ctxt->tr);
 
 	/* XMM0..XMM15 should be handled by kernel_fpu_begin(). */
 	/*
 	 * segment registers
 	 */
+#ifdef CONFIG_X86_32
+	savesegment(es, ctxt->es);
+	savesegment(fs, ctxt->fs);
+	savesegment(gs, ctxt->gs);
+	savesegment(ss, ctxt->ss);
+#else
+/* CONFIG_X86_64 */
 	asm volatile ("movw %%ds, %0" : "=m" (ctxt->ds));
 	asm volatile ("movw %%es, %0" : "=m" (ctxt->es));
 	asm volatile ("movw %%fs, %0" : "=m" (ctxt->fs));
@@ -74,21 +90,32 @@ static void __save_processor_state(struct saved_context *ctxt)
 	rdmsrl(MSR_KERNEL_GS_BASE, ctxt->gs_kernel_base);
 	mtrr_save_fixed_ranges(NULL);
 
+	rdmsrl(MSR_EFER, ctxt->efer);
+#endif
+
 	/*
 	 * control registers
 	 */
-	rdmsrl(MSR_EFER, ctxt->efer);
 	ctxt->cr0 = read_cr0();
 	ctxt->cr2 = read_cr2();
 	ctxt->cr3 = read_cr3();
+#ifdef CONFIG_X86_32
+	ctxt->cr4 = read_cr4_safe();
+#else
+/* CONFIG_X86_64 */
 	ctxt->cr4 = read_cr4();
 	ctxt->cr8 = read_cr8();
+#endif
 }
 
+/* Needed by apm.c */
 void save_processor_state(void)
 {
 	__save_processor_state(&saved_context);
 }
+#ifdef CONFIG_X86_32
+EXPORT_SYMBOL(save_processor_state);
+#endif
 
 static void do_fpu_end(void)
 {
-- 
1.5.2.4

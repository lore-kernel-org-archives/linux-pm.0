From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] [RFC] Save/restore MISC_ENABLE register
Date: Mon, 7 Jun 2010 18:14:49 +0200
Message-ID: <201006071814.53583.linux__19001.6484972604$1275927463$gmane$org@rainbow-software.org>
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
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Cc: Len Brown <len.brown@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

Save/restore MISC_ENABLE register on suspend/resume.
This fixes OOPS (invalid opcode) on resume from STR on Asus P4P800-VM, which
wakes up with MWAIT disabled.

Is this a correct thing to do? Is it OK on x86_64?

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

diff -urp linux-2.6.35-rc1-git2-orig/arch/x86/include/asm/suspend_32.h linux-2.6.35-rc1-git2/arch/x86/include/asm/suspend_32.h
--- linux-2.6.35-rc1-git2-orig/arch/x86/include/asm/suspend_32.h	2010-05-30 22:21:02.000000000 +0200
+++ linux-2.6.35-rc1-git2/arch/x86/include/asm/suspend_32.h	2010-06-04 23:52:22.000000000 +0200
@@ -15,6 +15,7 @@ static inline int arch_prepare_suspend(v
 struct saved_context {
 	u16 es, fs, gs, ss;
 	unsigned long cr0, cr2, cr3, cr4;
+	unsigned long misc_enable;
 	struct desc_ptr gdt;
 	struct desc_ptr idt;
 	u16 ldt;
diff -urp linux-2.6.35-rc1-git2-orig/arch/x86/include/asm/suspend_64.h linux-2.6.35-rc1-git2/arch/x86/include/asm/suspend_64.h
--- linux-2.6.35-rc1-git2-orig/arch/x86/include/asm/suspend_64.h	2010-05-30 22:21:02.000000000 +0200
+++ linux-2.6.35-rc1-git2/arch/x86/include/asm/suspend_64.h	2010-06-04 23:52:21.000000000 +0200
@@ -27,6 +27,7 @@ struct saved_context {
 	u16 ds, es, fs, gs, ss;
 	unsigned long gs_base, gs_kernel_base, fs_base;
 	unsigned long cr0, cr2, cr3, cr4, cr8;
+	unsigned long misc_enable;
 	unsigned long efer;
 	u16 gdt_pad;
 	u16 gdt_limit;
diff -urp linux-2.6.35-rc1-git2-orig/arch/x86/power/cpu.c linux-2.6.35-rc1-git2/arch/x86/power/cpu.c
--- linux-2.6.35-rc1-git2-orig/arch/x86/power/cpu.c	2010-05-30 22:21:02.000000000 +0200
+++ linux-2.6.35-rc1-git2/arch/x86/power/cpu.c	2010-06-04 23:50:52.000000000 +0200
@@ -105,6 +105,7 @@ static void __save_processor_state(struc
 	ctxt->cr4 = read_cr4();
 	ctxt->cr8 = read_cr8();
 #endif
+	rdmsrl(MSR_IA32_MISC_ENABLE, ctxt->misc_enable);
 }
 
 /* Needed by apm.c */
@@ -152,6 +153,7 @@ static void fix_processor_context(void)
  */
 static void __restore_processor_state(struct saved_context *ctxt)
 {
+	wrmsrl(MSR_IA32_MISC_ENABLE, ctxt->misc_enable);
 	/*
 	 * control registers
 	 */

-- 
Ondrej Zary

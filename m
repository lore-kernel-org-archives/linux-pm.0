From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH] [RFC] Save/restore MISC_ENABLE register
Date: Mon, 7 Jun 2010 20:51:07 +0200
Message-ID: <201006072051.10421.linux@rainbow-software.org>
References: <201006071814.53583.linux@rainbow-software.org>
	<4C0D2BFB.2090200@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C0D2BFB.2090200@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Len Brown <len.brown@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 07 June 2010 19:27:23 H. Peter Anvin wrote:
> On 06/07/2010 09:14 AM, Ondrej Zary wrote:
> > Save/restore MISC_ENABLE register on suspend/resume.
> > This fixes OOPS (invalid opcode) on resume from STR on Asus P4P800-VM,
> > which wakes up with MWAIT disabled.
> >
> > Is this a correct thing to do? Is it OK on x86_64?
>
> This MSR isn't available on all processors, and thus cannot be saved and
> restored unconditionally like this.  On the save path, one can use
> rdmsr_safe(); on the wakeup path it's not clear to me it is safe to do
> so, so it would be better to save a presence flag on the save path and
> conditionalize the write.

Something like this?

Save/restore MISC_ENABLE register on suspend/resume.
This fixes OOPS (invalid opcode) on resume from STR on Asus P4P800-VM, which
wakes up with MWAIT disabled.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

diff -urp linux-2.6.35-rc1-git2-orig/arch/x86//include/asm/suspend_32.h linux-2.6.35-rc1-git2/arch/x86//include/asm/suspend_32.h
--- linux-2.6.35-rc1-git2-orig/arch/x86//include/asm/suspend_32.h	2010-05-30 22:21:02.000000000 +0200
+++ linux-2.6.35-rc1-git2/arch/x86//include/asm/suspend_32.h	2010-06-07 20:41:44.000000000 +0200
@@ -15,6 +15,8 @@ static inline int arch_prepare_suspend(v
 struct saved_context {
 	u16 es, fs, gs, ss;
 	unsigned long cr0, cr2, cr3, cr4;
+	u64 misc_enable;
+	bool misc_enable_saved;
 	struct desc_ptr gdt;
 	struct desc_ptr idt;
 	u16 ldt;
diff -urp linux-2.6.35-rc1-git2-orig/arch/x86//include/asm/suspend_64.h linux-2.6.35-rc1-git2/arch/x86//include/asm/suspend_64.h
--- linux-2.6.35-rc1-git2-orig/arch/x86//include/asm/suspend_64.h	2010-05-30 22:21:02.000000000 +0200
+++ linux-2.6.35-rc1-git2/arch/x86//include/asm/suspend_64.h	2010-06-07 20:38:42.000000000 +0200
@@ -27,6 +27,8 @@ struct saved_context {
 	u16 ds, es, fs, gs, ss;
 	unsigned long gs_base, gs_kernel_base, fs_base;
 	unsigned long cr0, cr2, cr3, cr4, cr8;
+	u64 misc_enable;
+	bool misc_enable_saved;
 	unsigned long efer;
 	u16 gdt_pad;
 	u16 gdt_limit;
diff -urp linux-2.6.35-rc1-git2-orig/arch/x86//power/cpu.c linux-2.6.35-rc1-git2/arch/x86//power/cpu.c
--- linux-2.6.35-rc1-git2-orig/arch/x86//power/cpu.c	2010-05-30 22:21:02.000000000 +0200
+++ linux-2.6.35-rc1-git2/arch/x86//power/cpu.c	2010-06-07 20:41:13.000000000 +0200
@@ -105,6 +105,8 @@ static void __save_processor_state(struc
 	ctxt->cr4 = read_cr4();
 	ctxt->cr8 = read_cr8();
 #endif
+	ctxt->misc_enable_saved = !rdmsrl_safe(MSR_IA32_MISC_ENABLE,
+					       &ctxt->misc_enable);
 }
 
 /* Needed by apm.c */
@@ -152,6 +154,8 @@ static void fix_processor_context(void)
  */
 static void __restore_processor_state(struct saved_context *ctxt)
 {
+	if (ctxt->misc_enable_saved)
+		wrmsrl(MSR_IA32_MISC_ENABLE, ctxt->misc_enable);
 	/*
 	 * control registers
 	 */



-- 
Ondrej Zary

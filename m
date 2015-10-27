From: James Morse <james.morse@arm.com>
Subject: [PATCH v2 07/11] arm64: Change cpu_resume() to enable mmu early then access sleep_sp by va
Date: Tue, 27 Oct 2015 17:29:16 +0000
Message-ID: <1445966960-31724-8-git-send-email-james.morse@arm.com>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57908 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619AbbJ0Ran (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 27 Oct 2015 13:30:43 -0400
In-Reply-To: <1445966960-31724-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

By enabling the MMU early in cpu_resume(), the sleep_save_sp and stack can
be accessed by VA, which avoids the need to convert-addresses and clean to
PoC on the suspend path.

MMU setup is shared with the boot path, meaning the swapper_pg_dir is
restored directly: ttbr1_el1 is no longer saved/restored.

struct sleep_save_sp is removed, replacing it with a single array of
pointers.

cpu_do_{suspend,resume} could be further reduced to not restore: cpacr_el1,
mdscr_el1, tcr_el1, vbar_el1 and sctlr_el1, all of which are set by
__cpu_setup(). However these values all contain res0 bits that may be used
to enable future features.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/suspend.h |  7 +----
 arch/arm64/kernel/asm-offsets.c  |  3 ---
 arch/arm64/kernel/head.S         |  2 +-
 arch/arm64/kernel/setup.c        |  1 -
 arch/arm64/kernel/sleep.S        | 57 ++++++++++++++--------------------------
 arch/arm64/kernel/suspend.c      | 52 +++---------------------------------
 arch/arm64/mm/proc.S             | 27 +++++--------------
 7 files changed, 33 insertions(+), 116 deletions(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index ccd26da93d03..5faa3ce1fa3a 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-#define NR_CTX_REGS 11
+#define NR_CTX_REGS 10
 #define NR_CALLEE_SAVED_REGS 12
 
 /*
@@ -17,11 +17,6 @@ struct cpu_suspend_ctx {
 	u64 sp;
 } __aligned(16);
 
-struct sleep_save_sp {
-	phys_addr_t *save_ptr_stash;
-	phys_addr_t save_ptr_stash_phys;
-};
-
 /*
  * Memory to save the cpu state is allocated on the stack by
  * __cpu_suspend_enter()'s caller, and populated by __cpu_suspend_enter().
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 5daa4e692932..3cb1383d3deb 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -157,9 +157,6 @@ int main(void)
   DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
   DEFINE(MPIDR_HASH_MASK,	offsetof(struct mpidr_hash, mask));
   DEFINE(MPIDR_HASH_SHIFTS,	offsetof(struct mpidr_hash, shift_aff));
-  DEFINE(SLEEP_SAVE_SP_SZ,	sizeof(struct sleep_save_sp));
-  DEFINE(SLEEP_SAVE_SP_PHYS,	offsetof(struct sleep_save_sp, save_ptr_stash_phys));
-  DEFINE(SLEEP_SAVE_SP_VIRT,	offsetof(struct sleep_save_sp, save_ptr_stash));
   DEFINE(SLEEP_STACK_DATA_SYSTEM_REGS,	offsetof(struct sleep_stack_data, system_regs));
   DEFINE(SLEEP_STACK_DATA_CALLEE_REGS,	offsetof(struct sleep_stack_data, callee_saved_regs));
 #endif
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 9ad8b1f15b19..cf4e0bdf6533 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -630,7 +630,7 @@ ENDPROC(__secondary_switched)
  * other registers depend on the function called upon completion
  */
 	.section	".idmap.text", "ax"
-__enable_mmu:
+ENTRY(__enable_mmu)
 	ldr	x5, =vectors
 	msr	vbar_el1, x5
 	msr	ttbr0_el1, x25			// load TTBR0
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 232247945b1c..5a338235ba1a 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -192,7 +192,6 @@ static void __init smp_build_mpidr_hash(void)
 	 */
 	if (mpidr_hash_size() > 4 * num_possible_cpus())
 		pr_warn("Large number of MPIDR hash buckets detected\n");
-	__flush_dcache_area(&mpidr_hash, sizeof(struct mpidr_hash));
 }
 
 static void __init setup_processor(void)
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 1fa40573db13..07e005d756b0 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -73,8 +73,8 @@ ENTRY(__cpu_suspend_enter)
 	str	x2, [x0, #SLEEP_STACK_DATA_SYSTEM_REGS + CPU_CTX_SP]
 
 	/* find the mpidr_hash */
-	ldr	x1, =sleep_save_sp
-	ldr	x1, [x1, #SLEEP_SAVE_SP_VIRT]
+	ldr	x1, =sleep_save_stash
+	ldr	x1, [x1]
 	mrs	x7, mpidr_el1
 	ldr	x9, =mpidr_hash
 	ldr	x10, [x9, #MPIDR_HASH_MASK]
@@ -87,40 +87,26 @@ ENTRY(__cpu_suspend_enter)
 	compute_mpidr_hash x8, x3, x4, x5, x6, x7, x10
 	add	x1, x1, x8, lsl #3
 
+	str	x0, [x1]
+	add	x0, x0, #SLEEP_STACK_DATA_SYSTEM_REGS
 	push	x29, lr
-	bl	__cpu_suspend_save
+	bl	cpu_do_suspend
 	pop	x29, lr
 	mov	x0, #1
 	ret
 ENDPROC(__cpu_suspend_enter)
 	.ltorg
 
-/*
- * x0 must contain the sctlr value retrieved from restored context
- */
-	.pushsection	".idmap.text", "ax"
-ENTRY(cpu_resume_mmu)
-	ldr	x3, =cpu_resume_after_mmu
-	msr	sctlr_el1, x0		// restore sctlr_el1
-	isb
-	/*
-	 * Invalidate the local I-cache so that any instructions fetched
-	 * speculatively from the PoC are discarded, since they may have
-	 * been dynamically patched at the PoU.
-	 */
-	ic	iallu
-	dsb	nsh
-	isb
-	br	x3			// global jump to virtual address
-ENDPROC(cpu_resume_mmu)
-	.popsection
-cpu_resume_after_mmu:
-	mov	x0, #0			// return zero on success
-	ret
-ENDPROC(cpu_resume_after_mmu)
-
 ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
+	/* enable the MMU early - so we can access sleep_save_stash by va */
+	adr_l	lr, __enable_mmu	/* __cpu_setup will return here */
+	ldr	x27, =_cpu_resume	/* __enable_mmu will branch here */
+	adrp	x25, idmap_pg_dir
+	adrp	x26, swapper_pg_dir
+	b	__cpu_setup
+
+ENTRY(_cpu_resume)
 	mrs	x1, mpidr_el1
 	adrp	x8, mpidr_hash
 	add x8, x8, #:lo12:mpidr_hash // x8 = struct mpidr_hash phys address
@@ -130,26 +116,23 @@ ENTRY(cpu_resume)
 	ldp	w5, w6, [x8, #(MPIDR_HASH_SHIFTS + 8)]
 	compute_mpidr_hash x7, x3, x4, x5, x6, x1, x2
         /* x7 contains hash index, let's use it to grab context pointer */
-	ldr_l	x0, sleep_save_sp + SLEEP_SAVE_SP_PHYS
+	ldr_l	x0, sleep_save_stash
 	ldr	x0, [x0, x7, lsl #3]
 	add	x29, x0, #SLEEP_STACK_DATA_CALLEE_REGS
 	add	x0, x0, #SLEEP_STACK_DATA_SYSTEM_REGS
 	/* load sp from context */
 	ldr	x2, [x0, #CPU_CTX_SP]
-	/* load physical address of identity map page table in x1 */
-	adrp	x1, idmap_pg_dir
 	mov	sp, x2
-	/*
-	 * cpu_do_resume expects x0 to contain context physical address
-	 * pointer and x1 to contain physical address of 1:1 page tables
-	 */
-	bl	cpu_do_resume		// PC relative jump, MMU off
-	/* Can't access these by physical address once the MMU is on */
+	bl	cpu_do_resume
+	msr	sctlr_el1, x0
+	isb
+
 	ldp	x19, x20, [x29, #16]
 	ldp	x21, x22, [x29, #32]
 	ldp	x23, x24, [x29, #48]
 	ldp	x25, x26, [x29, #64]
 	ldp	x27, x28, [x29, #80]
 	ldp	x29, lr, [x29]
-	b	cpu_resume_mmu		// Resume MMU, never returns
+	mov	x0, #0
+	ret
 ENDPROC(cpu_resume)
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index eeb088d15bcb..03ef74c02939 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -11,30 +11,6 @@
 
 
 /*
- * This is called by __cpu_suspend_enter() to save the state, and do whatever
- * flushing is required to ensure that when the CPU goes to sleep we have
- * the necessary data available when the caches are not searched.
- *
- * ptr: sleep_stack_data containing cpu state virtual address.
- * save_ptr: address of the location where the context physical address
- *           must be saved
- */
-void notrace __cpu_suspend_save(struct sleep_stack_data *ptr,
-				phys_addr_t *save_ptr)
-{
-	*save_ptr = virt_to_phys(ptr);
-
-	cpu_do_suspend(&ptr->system_regs);
-	/*
-	 * Only flush the context that must be retrieved with the MMU
-	 * off. VA primitives ensure the flush is applied to all
-	 * cache levels so context is pushed to DRAM.
-	 */
-	__flush_dcache_area(ptr, sizeof(*ptr));
-	__flush_dcache_area(save_ptr, sizeof(*save_ptr));
-}
-
-/*
  * This hook is provided so that cpu_suspend code can restore HW
  * breakpoints as early as possible in the resume path, before reenabling
  * debug exceptions. Code cannot be run from a CPU PM notifier since by the
@@ -52,21 +28,6 @@ void __init cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *))
 
 void notrace __cpu_suspend_exit(struct mm_struct *mm)
 {
-	/*
-	 * We are resuming from reset with TTBR0_EL1 set to the
-	 * idmap to enable the MMU; set the TTBR0 to the reserved
-	 * page tables to prevent speculative TLB allocations, flush
-	 * the local tlb and set the default tcr_el1.t0sz so that
-	 * the TTBR0 address space set-up is properly restored.
-	 * If the current active_mm != &init_mm we entered cpu_suspend
-	 * with mappings in TTBR0 that must be restored, so we switch
-	 * them back to complete the address space configuration
-	 * restoration before returning.
-	 */
-	cpu_set_reserved_ttbr0();
-	flush_tlb_all();
-	cpu_set_default_tcr_t0sz();
-
 	if (mm != &init_mm)
 		cpu_switch_mm(mm->pgd, mm);
 
@@ -138,22 +99,17 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	return ret;
 }
 
-struct sleep_save_sp sleep_save_sp;
+unsigned long *sleep_save_stash;
 
 static int __init cpu_suspend_init(void)
 {
-	void *ctx_ptr;
-
 	/* ctx_ptr is an array of physical addresses */
-	ctx_ptr = kcalloc(mpidr_hash_size(), sizeof(phys_addr_t), GFP_KERNEL);
+	sleep_save_stash = kcalloc(mpidr_hash_size(), sizeof(*sleep_save_stash),
+				   GFP_KERNEL);
 
-	if (WARN_ON(!ctx_ptr))
+	if (WARN_ON(!sleep_save_stash))
 		return -ENOMEM;
 
-	sleep_save_sp.save_ptr_stash = ctx_ptr;
-	sleep_save_sp.save_ptr_stash_phys = virt_to_phys(ctx_ptr);
-	__flush_dcache_area(&sleep_save_sp, sizeof(struct sleep_save_sp));
-
 	return 0;
 }
 early_initcall(cpu_suspend_init);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 456c1c5f8ecd..b3afb6123c81 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -59,20 +59,17 @@ ENTRY(cpu_do_suspend)
 	mrs	x2, tpidr_el0
 	mrs	x3, tpidrro_el0
 	mrs	x4, contextidr_el1
-	mrs	x5, mair_el1
 	mrs	x6, cpacr_el1
-	mrs	x7, ttbr1_el1
 	mrs	x8, tcr_el1
 	mrs	x9, vbar_el1
 	mrs	x10, mdscr_el1
 	mrs	x11, oslsr_el1
 	mrs	x12, sctlr_el1
 	stp	x2, x3, [x0]
-	stp	x4, x5, [x0, #16]
-	stp	x6, x7, [x0, #32]
-	stp	x8, x9, [x0, #48]
-	stp	x10, x11, [x0, #64]
-	str	x12, [x0, #80]
+	stp	x4, xzr, [x0, #16]
+	stp	x6, x8, [x0, #32]
+	stp	x9, x10, [x0, #48]
+	stp	x11, x12, [x0, #64]
 	ret
 ENDPROC(cpu_do_suspend)
 
@@ -80,29 +77,20 @@ ENDPROC(cpu_do_suspend)
  * cpu_do_resume - restore CPU register context
  *
  * x0: Physical address of context pointer
- * x1: ttbr0_el1 to be restored
  *
  * Returns:
  *	sctlr_el1 value in x0
  */
 ENTRY(cpu_do_resume)
-	/*
-	 * Invalidate local tlb entries before turning on MMU
-	 */
-	tlbi	vmalle1
 	ldp	x2, x3, [x0]
 	ldp	x4, x5, [x0, #16]
-	ldp	x6, x7, [x0, #32]
-	ldp	x8, x9, [x0, #48]
-	ldp	x10, x11, [x0, #64]
-	ldr	x12, [x0, #80]
+	ldp	x6, x8, [x0, #32]
+	ldp	x9, x10, [x0, #48]
+	ldp	x11, x12, [x0, #64]
 	msr	tpidr_el0, x2
 	msr	tpidrro_el0, x3
 	msr	contextidr_el1, x4
-	msr	mair_el1, x5
 	msr	cpacr_el1, x6
-	msr	ttbr0_el1, x1
-	msr	ttbr1_el1, x7
 	tcr_set_idmap_t0sz x8, x7
 	msr	tcr_el1, x8
 	msr	vbar_el1, x9
@@ -113,7 +101,6 @@ ENTRY(cpu_do_resume)
 	ubfx	x11, x11, #1, #1
 	msr	oslar_el1, x11
 	mov	x0, x12
-	dsb	nsh		// Make sure local tlb invalidation completed
 	isb
 	ret
 ENDPROC(cpu_do_resume)
-- 
2.1.4


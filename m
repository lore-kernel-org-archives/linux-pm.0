From: James Morse <james.morse@arm.com>
Subject: [PATCH v5 06/15] arm64: kernel: Rework finisher callback out of __cpu_suspend_enter().
Date: Tue, 16 Feb 2016 15:49:18 +0000
Message-ID: <1455637767-31561-7-git-send-email-james.morse@arm.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54480 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755289AbcBPPvj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Feb 2016 10:51:39 -0500
In-Reply-To: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

Hibernate could make use of the cpu_suspend() code to save/restore cpu
state, however it needs to be able to return '0' from the 'finisher'.

Rework cpu_suspend() so that the finisher is called from C code,
independently from the save/restore of cpu state. Space to save the context
in is allocated in the caller's stack frame, and passed into
__cpu_suspend_enter().

Hibernate's use of this API will look like a copy of the cpu_suspend()
function.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/suspend.h | 20 +++++++++
 arch/arm64/kernel/asm-offsets.c  |  2 +
 arch/arm64/kernel/sleep.S        | 93 ++++++++++++++--------------------------
 arch/arm64/kernel/suspend.c      | 66 +++++++++++++++++-----------
 4 files changed, 97 insertions(+), 84 deletions(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 59a5b0f1e81c..365d8cdd0073 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -2,6 +2,7 @@
 #define __ASM_SUSPEND_H
 
 #define NR_CTX_REGS 11
+#define NR_CALLEE_SAVED_REGS 12
 
 /*
  * struct cpu_suspend_ctx must be 16-byte aligned since it is allocated on
@@ -21,6 +22,25 @@ struct sleep_save_sp {
 	phys_addr_t save_ptr_stash_phys;
 };
 
+/*
+ * Memory to save the cpu state is allocated on the stack by
+ * __cpu_suspend_enter()'s caller, and populated by __cpu_suspend_enter().
+ * This data must survive until cpu_resume() is called.
+ *
+ * This struct desribes the size and the layout of the saved cpu state.
+ * The layout of the callee_saved_regs is defined by the implementation
+ * of __cpu_suspend_enter(), and cpu_resume(). This struct must be passed
+ * in by the caller as __cpu_suspend_enter()'s stack-frame is gone once it
+ * returns, and the data would be subsequently corrupted by the call to the
+ * finisher.
+ */
+struct sleep_stack_data {
+	struct cpu_suspend_ctx	system_regs;
+	unsigned long		callee_saved_regs[NR_CALLEE_SAVED_REGS];
+};
+
 extern int cpu_suspend(unsigned long arg, int (*fn)(unsigned long));
 extern void cpu_resume(void);
+int __cpu_suspend_enter(struct sleep_stack_data *state);
+void __cpu_suspend_exit(void);
 #endif
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index fffa4ac6c25a..7d7994774e82 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -123,6 +123,8 @@ int main(void)
   DEFINE(SLEEP_SAVE_SP_SZ,	sizeof(struct sleep_save_sp));
   DEFINE(SLEEP_SAVE_SP_PHYS,	offsetof(struct sleep_save_sp, save_ptr_stash_phys));
   DEFINE(SLEEP_SAVE_SP_VIRT,	offsetof(struct sleep_save_sp, save_ptr_stash));
+  DEFINE(SLEEP_STACK_DATA_SYSTEM_REGS,	offsetof(struct sleep_stack_data, system_regs));
+  DEFINE(SLEEP_STACK_DATA_CALLEE_REGS,	offsetof(struct sleep_stack_data, callee_saved_regs));
 #endif
   DEFINE(ARM_SMCCC_RES_X0_OFFS,	offsetof(struct arm_smccc_res, a0));
   DEFINE(ARM_SMCCC_RES_X2_OFFS,	offsetof(struct arm_smccc_res, a2));
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index e33fe33876ab..dca81612fe90 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -49,37 +49,30 @@
 	orr	\dst, \dst, \mask		// dst|=(aff3>>rs3)
 	.endm
 /*
- * Save CPU state for a suspend and execute the suspend finisher.
- * On success it will return 0 through cpu_resume - ie through a CPU
- * soft/hard reboot from the reset vector.
- * On failure it returns the suspend finisher return value or force
- * -EOPNOTSUPP if the finisher erroneously returns 0 (the suspend finisher
- * is not allowed to return, if it does this must be considered failure).
- * It saves callee registers, and allocates space on the kernel stack
- * to save the CPU specific registers + some other data for resume.
+ * Save CPU state in the provided sleep_stack_data area, and publish its
+ * location for cpu_resume()'s use in sleep_save_stash.
  *
- *  x0 = suspend finisher argument
- *  x1 = suspend finisher function pointer
+ * cpu_resume() will restore this saved state, and return. Because the
+ * link-register is saved and restored, it will appear to return from this
+ * function. So that the caller can tell the suspend/resume paths apart,
+ * __cpu_suspend_enter() will always return a non-zero value, whereas the
+ * path through cpu_resume() will return 0.
+ *
+ *  x0 = struct sleep_stack_data area
  */
 ENTRY(__cpu_suspend_enter)
-	stp	x29, lr, [sp, #-96]!
-	stp	x19, x20, [sp,#16]
-	stp	x21, x22, [sp,#32]
-	stp	x23, x24, [sp,#48]
-	stp	x25, x26, [sp,#64]
-	stp	x27, x28, [sp,#80]
-	/*
-	 * Stash suspend finisher and its argument in x20 and x19
-	 */
-	mov	x19, x0
-	mov	x20, x1
+	stp	x29, lr, [x0, #SLEEP_STACK_DATA_CALLEE_REGS]
+	stp	x19, x20, [x0,#SLEEP_STACK_DATA_CALLEE_REGS+16]
+	stp	x21, x22, [x0,#SLEEP_STACK_DATA_CALLEE_REGS+32]
+	stp	x23, x24, [x0,#SLEEP_STACK_DATA_CALLEE_REGS+48]
+	stp	x25, x26, [x0,#SLEEP_STACK_DATA_CALLEE_REGS+64]
+	stp	x27, x28, [x0,#SLEEP_STACK_DATA_CALLEE_REGS+80]
+
+	/* save the sp in cpu_suspend_ctx */
 	mov	x2, sp
-	sub	sp, sp, #CPU_SUSPEND_SZ	// allocate cpu_suspend_ctx
-	mov	x0, sp
-	/*
-	 * x0 now points to struct cpu_suspend_ctx allocated on the stack
-	 */
-	str	x2, [x0, #CPU_CTX_SP]
+	str	x2, [x0, #SLEEP_STACK_DATA_SYSTEM_REGS + CPU_CTX_SP]
+
+	/* find the mpidr_hash */
 	ldr	x1, =sleep_save_sp
 	ldr	x1, [x1, #SLEEP_SAVE_SP_VIRT]
 	mrs	x7, mpidr_el1
@@ -93,34 +86,11 @@ ENTRY(__cpu_suspend_enter)
 	ldp	w5, w6, [x9, #(MPIDR_HASH_SHIFTS + 8)]
 	compute_mpidr_hash x8, x3, x4, x5, x6, x7, x10
 	add	x1, x1, x8, lsl #3
+
+	push	x29, lr
 	bl	__cpu_suspend_save
-	/*
-	 * Grab suspend finisher in x20 and its argument in x19
-	 */
-	mov	x0, x19
-	mov	x1, x20
-	/*
-	 * We are ready for power down, fire off the suspend finisher
-	 * in x1, with argument in x0
-	 */
-	blr	x1
-        /*
-	 * Never gets here, unless suspend finisher fails.
-	 * Successful cpu_suspend should return from cpu_resume, returning
-	 * through this code path is considered an error
-	 * If the return value is set to 0 force x0 = -EOPNOTSUPP
-	 * to make sure a proper error condition is propagated
-	 */
-	cmp	x0, #0
-	mov	x3, #-EOPNOTSUPP
-	csel	x0, x3, x0, eq
-	add	sp, sp, #CPU_SUSPEND_SZ	// rewind stack pointer
-	ldp	x19, x20, [sp, #16]
-	ldp	x21, x22, [sp, #32]
-	ldp	x23, x24, [sp, #48]
-	ldp	x25, x26, [sp, #64]
-	ldp	x27, x28, [sp, #80]
-	ldp	x29, lr, [sp], #96
+	pop	x29, lr
+	mov	x0, #1
 	ret
 ENDPROC(__cpu_suspend_enter)
 	.ltorg
@@ -146,12 +116,6 @@ ENDPROC(cpu_resume_mmu)
 	.popsection
 cpu_resume_after_mmu:
 	mov	x0, #0			// return zero on success
-	ldp	x19, x20, [sp, #16]
-	ldp	x21, x22, [sp, #32]
-	ldp	x23, x24, [sp, #48]
-	ldp	x25, x26, [sp, #64]
-	ldp	x27, x28, [sp, #80]
-	ldp	x29, lr, [sp], #96
 	ret
 ENDPROC(cpu_resume_after_mmu)
 
@@ -168,6 +132,8 @@ ENTRY(cpu_resume)
         /* x7 contains hash index, let's use it to grab context pointer */
 	ldr_l	x0, sleep_save_sp + SLEEP_SAVE_SP_PHYS
 	ldr	x0, [x0, x7, lsl #3]
+	add	x29, x0, #SLEEP_STACK_DATA_CALLEE_REGS
+	add	x0, x0, #SLEEP_STACK_DATA_SYSTEM_REGS
 	/* load sp from context */
 	ldr	x2, [x0, #CPU_CTX_SP]
 	/* load physical address of identity map page table in x1 */
@@ -181,5 +147,12 @@ ENTRY(cpu_resume)
 	 * pointer and x1 to contain physical address of 1:1 page tables
 	 */
 	bl	cpu_do_resume		// PC relative jump, MMU off
+	/* Can't access these by physical address once the MMU is on */
+	ldp	x19, x20, [x29, #16]
+	ldp	x21, x22, [x29, #32]
+	ldp	x23, x24, [x29, #48]
+	ldp	x25, x26, [x29, #64]
+	ldp	x27, x28, [x29, #80]
+	ldp	x29, lr, [x29]
 	b	cpu_resume_mmu		// Resume MMU, never returns
 ENDPROC(cpu_resume)
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 66055392f445..6fe46100685a 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -10,22 +10,22 @@
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
 
-extern int __cpu_suspend_enter(unsigned long arg, int (*fn)(unsigned long));
+
 /*
  * This is called by __cpu_suspend_enter() to save the state, and do whatever
  * flushing is required to ensure that when the CPU goes to sleep we have
  * the necessary data available when the caches are not searched.
  *
- * ptr: CPU context virtual address
+ * ptr: sleep_stack_data containing cpu state virtual address.
  * save_ptr: address of the location where the context physical address
  *           must be saved
  */
-void notrace __cpu_suspend_save(struct cpu_suspend_ctx *ptr,
+void notrace __cpu_suspend_save(struct sleep_stack_data *ptr,
 				phys_addr_t *save_ptr)
 {
 	*save_ptr = virt_to_phys(ptr);
 
-	cpu_do_suspend(ptr);
+	cpu_do_suspend(&ptr->system_regs);
 	/*
 	 * Only flush the context that must be retrieved with the MMU
 	 * off. VA primitives ensure the flush is applied to all
@@ -51,6 +51,30 @@ void __init cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *))
 	hw_breakpoint_restore = hw_bp_restore;
 }
 
+void notrace __cpu_suspend_exit(void)
+{
+	/*
+	 * We are resuming from reset with the idmap active in TTBR0_EL1.
+	 * We must uninstall the idmap and restore the expected MMU
+	 * state before we can possibly return to userspace.
+	 */
+	cpu_uninstall_idmap();
+
+	/*
+	 * Restore per-cpu offset before any kernel
+	 * subsystem relying on it has a chance to run.
+	 */
+	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
+
+	/*
+	 * Restore HW breakpoint registers to sane values
+	 * before debug exceptions are possibly reenabled
+	 * through local_dbg_restore.
+	 */
+	if (hw_breakpoint_restore)
+		hw_breakpoint_restore(NULL);
+}
+
 /*
  * cpu_suspend
  *
@@ -60,8 +84,9 @@ void __init cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *))
  */
 int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 {
-	int ret;
+	int ret = 0;
 	unsigned long flags;
+	struct sleep_stack_data state;
 
 	/*
 	 * From this point debug exceptions are disabled to prevent
@@ -83,28 +108,21 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	 * page tables, so that the thread address space is properly
 	 * set-up on function return.
 	 */
-	ret = __cpu_suspend_enter(arg, fn);
-	if (ret == 0) {
-		/*
-		 * We are resuming from reset with the idmap active in TTBR0_EL1.
-		 * We must uninstall the idmap and restore the expected MMU
-		 * state before we can possibly return to userspace.
-		 */
-		cpu_uninstall_idmap();
-
-		/*
-		 * Restore per-cpu offset before any kernel
-		 * subsystem relying on it has a chance to run.
-		 */
-		set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
+	if (__cpu_suspend_enter(&state)) {
+		/* Call the suspend finisher */
+		ret = fn(arg);
 
 		/*
-		 * Restore HW breakpoint registers to sane values
-		 * before debug exceptions are possibly reenabled
-		 * through local_dbg_restore.
+		 * Never gets here, unless the suspend finisher fails.
+		 * Successful cpu_suspend() should return from cpu_resume(),
+		 * returning through this code path is considered an error
+		 * If the return value is set to 0 force ret = -EOPNOTSUPP
+		 * to make sure a proper error condition is propagated
 		 */
-		if (hw_breakpoint_restore)
-			hw_breakpoint_restore(NULL);
+		if (!ret)
+			ret = -EOPNOTSUPP;
+	} else {
+		__cpu_suspend_exit();
 	}
 
 	unpause_graph_tracing();
-- 
2.6.2


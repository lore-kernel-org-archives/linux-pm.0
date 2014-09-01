From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v8 1/8] arm64: kernel: refactor the CPU suspend API for retention states
Date: Mon,  1 Sep 2014 16:28:37 +0100
Message-ID: <1409585324-3678-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58654 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbaIAP2q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Sep 2014 11:28:46 -0400
In-Reply-To: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <k.chander@samsung.com>, Geoff

CPU suspend is the standard kernel interface to be used to enter
low-power states on ARM64 systems. Current cpu_suspend implementation
by default assumes that all low power states are losing the CPU context,
so the CPU registers must be saved and cleaned to DRAM upon state
entry. Furthermore, the current cpu_suspend() implementation assumes
that if the CPU suspend back-end method returns when called, this has
to be considered an error regardless of the return code (which can be
successful) since the CPU was not expected to return from a code path that
is different from cpu_resume code path - eg returning from the reset vector=
.

All in all this means that the current API does not cope well with low-powe=
r
states that preserve the CPU context when entered (ie retention states),
since first of all the context is saved for nothing on state entry for
those states and a successful state entry can return as a normal function
return, which is considered an error by the current CPU suspend
implementation.

This patch refactors the cpu_suspend() API so that it can be split in
two separate functionalities. The arm64 cpu_suspend API just provides
a wrapper around CPU suspend operation hook. A new function is
introduced (for architecture code use only) for states that require
context saving upon entry:

__cpu_suspend(unsigned long arg, int (*fn)(unsigned long))

__cpu_suspend() saves the context on function entry and calls the
so called suspend finisher (ie fn) to complete the suspend operation.
The finisher is not expected to return, unless it fails in which case
the error is propagated back to the __cpu_suspend caller.

The API refactoring results in the following pseudo code call sequence for =
a
suspending CPU, when triggered from a kernel subsystem:

/*
 * int cpu_suspend(unsigned long idx)
 * @idx: idle state index
 */
{
-> cpu_suspend(idx)
=09|---> CPU operations suspend hook called, if present
=09=09|--> if (retention_state)
=09=09=09|--> direct suspend back-end call (eg PSCI suspend)
=09=09     else
=09=09=09|--> __cpu_suspend(idx, &back_end_finisher);
}

By refactoring the cpu_suspend API this way, the CPU operations back-end
has a chance to detect whether idle states require state saving or not
and can call the required suspend operations accordingly either through
simple function call or indirectly through __cpu_suspend() which carries ou=
t
state saving and suspend finisher dispatching to complete idle state entry.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/suspend.h |  1 +
 arch/arm64/kernel/sleep.S        | 47 ++++++++++++++++++++++++++++--------=
---
 arch/arm64/kernel/suspend.c      | 48 ++++++++++++++++++++++++------------=
----
 3 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/susp=
end.h
index e9c149c..456d67c 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -21,6 +21,7 @@ struct sleep_save_sp {
 =09phys_addr_t save_ptr_stash_phys;
 };
=20
+extern int __cpu_suspend(unsigned long arg, int (*fn)(unsigned long));
 extern void cpu_resume(void);
 extern int cpu_suspend(unsigned long);
=20
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index b192572..a564b44 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -49,28 +49,39 @@
 =09orr=09\dst, \dst, \mask=09=09// dst|=3D(aff3>>rs3)
 =09.endm
 /*
- * Save CPU state for a suspend.  This saves callee registers, and allocat=
es
- * space on the kernel stack to save the CPU specific registers + some
- * other data for resume.
+ * Save CPU state for a suspend and execute the suspend finisher.
+ * On success it will return 0 through cpu_resume - ie through a CPU
+ * soft/hard reboot from the reset vector.
+ * On failure it returns the suspend finisher return value or force
+ * -EOPNOTSUPP if the finisher erroneously returns 0 (the suspend finisher
+ * is not allowed to return, if it does this must be considered failure).
+ * It saves callee registers, and allocates space on the kernel stack
+ * to save the CPU specific registers + some other data for resume.
  *
  *  x0 =3D suspend finisher argument
+ *  x1 =3D suspend finisher function pointer
  */
-ENTRY(__cpu_suspend)
+ENTRY(__cpu_suspend_enter)
 =09stp=09x29, lr, [sp, #-96]!
 =09stp=09x19, x20, [sp,#16]
 =09stp=09x21, x22, [sp,#32]
 =09stp=09x23, x24, [sp,#48]
 =09stp=09x25, x26, [sp,#64]
 =09stp=09x27, x28, [sp,#80]
+=09/*
+=09 * Stash suspend finisher and its argument in x20 and x19
+=09 */
+=09mov=09x19, x0
+=09mov=09x20, x1
 =09mov=09x2, sp
 =09sub=09sp, sp, #CPU_SUSPEND_SZ=09// allocate cpu_suspend_ctx
-=09mov=09x1, sp
+=09mov=09x0, sp
 =09/*
-=09 * x1 now points to struct cpu_suspend_ctx allocated on the stack
+=09 * x0 now points to struct cpu_suspend_ctx allocated on the stack
 =09 */
-=09str=09x2, [x1, #CPU_CTX_SP]
-=09ldr=09x2, =3Dsleep_save_sp
-=09ldr=09x2, [x2, #SLEEP_SAVE_SP_VIRT]
+=09str=09x2, [x0, #CPU_CTX_SP]
+=09ldr=09x1, =3Dsleep_save_sp
+=09ldr=09x1, [x1, #SLEEP_SAVE_SP_VIRT]
 #ifdef CONFIG_SMP
 =09mrs=09x7, mpidr_el1
 =09ldr=09x9, =3Dmpidr_hash
@@ -82,11 +93,21 @@ ENTRY(__cpu_suspend)
 =09ldp=09w3, w4, [x9, #MPIDR_HASH_SHIFTS]
 =09ldp=09w5, w6, [x9, #(MPIDR_HASH_SHIFTS + 8)]
 =09compute_mpidr_hash x8, x3, x4, x5, x6, x7, x10
-=09add=09x2, x2, x8, lsl #3
+=09add=09x1, x1, x8, lsl #3
 #endif
-=09bl=09__cpu_suspend_finisher
+=09bl=09__cpu_suspend_save
+=09/*
+=09 * Grab suspend finisher in x20 and its argument in x19
+=09 */
+=09mov=09x0, x19
+=09mov=09x1, x20
+=09/*
+=09 * We are ready for power down, fire off the suspend finisher
+=09 * in x1, with argument in x0
+=09 */
+=09blr=09x1
         /*
-=09 * Never gets here, unless suspend fails.
+=09 * Never gets here, unless suspend finisher fails.
 =09 * Successful cpu_suspend should return from cpu_resume, returning
 =09 * through this code path is considered an error
 =09 * If the return value is set to 0 force x0 =3D -EOPNOTSUPP
@@ -103,7 +124,7 @@ ENTRY(__cpu_suspend)
 =09ldp=09x27, x28, [sp, #80]
 =09ldp=09x29, lr, [sp], #96
 =09ret
-ENDPROC(__cpu_suspend)
+ENDPROC(__cpu_suspend_enter)
 =09.ltorg
=20
 /*
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 55a99b9..13ad4db 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -9,22 +9,19 @@
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
=20
-extern int __cpu_suspend(unsigned long);
+extern int __cpu_suspend_enter(unsigned long arg, int (*fn)(unsigned long)=
);
 /*
- * This is called by __cpu_suspend() to save the state, and do whatever
+ * This is called by __cpu_suspend_enter() to save the state, and do whate=
ver
  * flushing is required to ensure that when the CPU goes to sleep we have
  * the necessary data available when the caches are not searched.
  *
- * @arg: Argument to pass to suspend operations
- * @ptr: CPU context virtual address
- * @save_ptr: address of the location where the context physical address
- *            must be saved
+ * ptr: CPU context virtual address
+ * save_ptr: address of the location where the context physical address
+ *           must be saved
  */
-int __cpu_suspend_finisher(unsigned long arg, struct cpu_suspend_ctx *ptr,
-=09=09=09   phys_addr_t *save_ptr)
+void notrace __cpu_suspend_save(struct cpu_suspend_ctx *ptr,
+=09=09=09=09phys_addr_t *save_ptr)
 {
-=09int cpu =3D smp_processor_id();
-
 =09*save_ptr =3D virt_to_phys(ptr);
=20
 =09cpu_do_suspend(ptr);
@@ -35,8 +32,6 @@ int __cpu_suspend_finisher(unsigned long arg, struct cpu_=
suspend_ctx *ptr,
 =09 */
 =09__flush_dcache_area(ptr, sizeof(*ptr));
 =09__flush_dcache_area(save_ptr, sizeof(*save_ptr));
-
-=09return cpu_ops[cpu]->cpu_suspend(arg);
 }
=20
 /*
@@ -56,15 +51,15 @@ void __init cpu_suspend_set_dbg_restorer(void (*hw_bp_r=
estore)(void *))
 }
=20
 /**
- * cpu_suspend
+ * cpu_suspend() - function to enter a low-power state
+ * @arg: argument to pass to CPU suspend operations
  *
- * @arg: argument to pass to the finisher function
+ * Return: 0 on success, -EOPNOTSUPP if CPU suspend hook not initialized, =
CPU
+ * operations back-end error code otherwise.
  */
 int cpu_suspend(unsigned long arg)
 {
-=09struct mm_struct *mm =3D current->active_mm;
-=09int ret, cpu =3D smp_processor_id();
-=09unsigned long flags;
+=09int cpu =3D smp_processor_id();
=20
 =09/*
 =09 * If cpu_ops have not been registered or suspend
@@ -72,6 +67,21 @@ int cpu_suspend(unsigned long arg)
 =09 */
 =09if (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_suspend)
 =09=09return -EOPNOTSUPP;
+=09return cpu_ops[cpu]->cpu_suspend(arg);
+}
+
+/*
+ * __cpu_suspend
+ *
+ * arg: argument to pass to the finisher function
+ * fn: finisher function pointer
+ *
+ */
+int __cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
+{
+=09struct mm_struct *mm =3D current->active_mm;
+=09int ret;
+=09unsigned long flags;
=20
 =09/*
 =09 * From this point debug exceptions are disabled to prevent
@@ -86,7 +96,7 @@ int cpu_suspend(unsigned long arg)
 =09 * page tables, so that the thread address space is properly
 =09 * set-up on function return.
 =09 */
-=09ret =3D __cpu_suspend(arg);
+=09ret =3D __cpu_suspend_enter(arg, fn);
 =09if (ret =3D=3D 0) {
 =09=09cpu_switch_mm(mm->pgd, mm);
 =09=09flush_tlb_all();
@@ -95,7 +105,7 @@ int cpu_suspend(unsigned long arg)
 =09=09 * Restore per-cpu offset before any kernel
 =09=09 * subsystem relying on it has a chance to run.
 =09=09 */
-=09=09set_my_cpu_offset(per_cpu_offset(cpu));
+=09=09set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
=20
 =09=09/*
 =09=09 * Restore HW breakpoint registers to sane values
--=20
1.9.1



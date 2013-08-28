From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 05/14] arm64: kernel: cpu_{suspend/resume} implementation
Date: Wed, 28 Aug 2013 12:35:57 +0100
Message-ID: <1377689766-17642-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38617 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895Ab3H1LgG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 07:36:06 -0400
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

Kernel subsystems like CPU idle and suspend to RAM require a generic
mechanism to suspend a processor, save its context and put it into
a quiescent state. The cpu_{suspend}/{resume} implementation provides
such a framework through a kernel interface allowing to save/restore
registers, flush the context to DRAM and suspend/resume to/from
low-power states where processor context may be lost.

Different SoCs might require different operations to be carried out
before a power down request is committed. For this reason the kernel
allows the caller of cpu_suspend to provide a function pointer (fn in
the cpu_suspend prototype below),

int cpu_suspend(unsigned long arg, int (*fn)(unsigned long));

called suspend finisher, that is executed after the context is saved and
flushed to DRAM, so that SoC/platform specific operations can be carried ou=
t
before issuing power down commands.

Context memory is allocated on the stack, whose address is stashed in a
per-cpu variable to keep track of it and passed to core functions that
save/restore the registers required by the architecture.

Even though, upon successful execution, the cpu_suspend function shuts
down the suspending processor, the warm boot resume mechanism, based
on the cpu_resume function, makes the resume path operate as a
cpu_suspend function return, so that cpu_suspend can be treated as a C
function by the caller, which simplifies coding the PM drivers that rely
on the cpu_suspend API.

Upon context save, the minimal amount of memory is flushed to DRAM so
that it can be retrieved when the MMU is off and caches are not searched.

The suspend finisher, depending on the required operations (eg CPU vs
Cluster shutdown) is in charge of flushing the cache hierarchy either
implicitly (by calling firmware implementations like PSCI) or explicitly
by executing the required cache maintainance functions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/suspend.h |  12 +++
 arch/arm64/kernel/asm-offsets.c  |   4 +
 arch/arm64/kernel/sleep.S        | 181 +++++++++++++++++++++++++++++++++++=
++++
 arch/arm64/kernel/suspend.c      |  76 ++++++++++++++++
 4 files changed, 273 insertions(+)
 create mode 100644 arch/arm64/include/asm/suspend.h
 create mode 100644 arch/arm64/kernel/sleep.S
 create mode 100644 arch/arm64/kernel/suspend.c

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/susp=
end.h
new file mode 100644
index 0000000..aa47f51
--- /dev/null
+++ b/arch/arm64/include/asm/suspend.h
@@ -0,0 +1,12 @@
+#ifndef __ASM_ARM_SUSPEND_H
+#define __ASM_ARM_SUSPEND_H
+
+struct sleep_save_sp {
+=09u64 *save_ptr_stash;
+=09phys_addr_t save_ptr_stash_phys;
+};
+
+extern void cpu_resume(void);
+extern int cpu_suspend(unsigned long, int (*)(unsigned long));
+
+#endif
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offset=
s.c
index 77b12d1..0dd1f51 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -26,6 +26,7 @@
 #include <asm/memory.h>
 #include <asm/cputable.h>
 #include <asm/smp_plat.h>
+#include <asm/suspend.h>
 #include <asm/vdso_datapage.h>
 #include <linux/kbuild.h>
=20
@@ -152,6 +153,9 @@ int main(void)
   DEFINE(CPU_CTX_VBAR_EL1,=09offsetof(struct cpu_suspend_ctx, vbar_el1));
   DEFINE(CPU_CTX_SCTLR_EL1,=09offsetof(struct cpu_suspend_ctx, sctlr_el1))=
;
   DEFINE(CPU_CTX_SP,=09=09offsetof(struct cpu_suspend_ctx, sp));
+  DEFINE(SLEEP_SAVE_SP_SZ,=09sizeof(struct sleep_save_sp));
+  DEFINE(SLEEP_SAVE_SP_PHYS,=09offsetof(struct sleep_save_sp, save_ptr_sta=
sh_phys));
+  DEFINE(SLEEP_SAVE_SP_VIRT,=09offsetof(struct sleep_save_sp, save_ptr_sta=
sh));
   DEFINE(MPIDR_HASH_MASK,=09offsetof(struct mpidr_hash, mask));
   DEFINE(MPIDR_HASH_SHIFTS,=09offsetof(struct mpidr_hash, shift_aff));
 #endif
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
new file mode 100644
index 0000000..7924220
--- /dev/null
+++ b/arch/arm64/kernel/sleep.S
@@ -0,0 +1,181 @@
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/assembler.h>
+
+=09.text
+/*
+ * Implementation of MPIDR_EL1 hash algorithm through shifting
+ * and OR'ing.
+ *
+ * @dst: register containing hash result
+ * @rs0: register containing affinity level 0 bit shift
+ * @rs1: register containing affinity level 1 bit shift
+ * @rs2: register containing affinity level 2 bit shift
+ * @rs3: register containing affinity level 3 bit shift
+ * @mpidr: register containing MPIDR_EL1 value
+ * @mask: register containing MPIDR mask
+ *
+ * Pseudo C-code:
+ *
+ *u32 dst;
+ *
+ *compute_mpidr_hash(u32 rs0, u32 rs1, u32 rs2, u32 rs3, u64 mpidr, u64 ma=
sk) {
+ *=09u32 aff0, aff1, aff2, aff3;
+ *=09u64 mpidr_masked =3D mpidr & mask;
+ *=09aff0 =3D mpidr_masked & 0xff;
+ *=09aff1 =3D mpidr_masked & 0xff00;
+ *=09aff2 =3D mpidr_masked & 0xff0000;
+ *=09aff2 =3D mpidr_masked & 0xff00000000;
+ *=09dst =3D (aff0 >> rs0 | aff1 >> rs1 | aff2 >> rs2 | aff3 >> rs3);
+ *}
+ * Input registers: rs0, rs1, rs2, rs3, mpidr, mask
+ * Output register: dst
+ * Note: input and output registers must be disjoint register sets
+         (eg: a macro instance with mpidr =3D r1 and dst =3D r1 is invalid=
)
+ */
+=09.macro compute_mpidr_hash dst, rs0, rs1, rs2, rs3, mpidr, mask
+=09and=09\mpidr, \mpidr, \mask=09=09// mask out MPIDR bits
+=09and=09\dst, \mpidr, #0xff=09=09// mask=3Daff0
+=09lsr=09\dst ,\dst, \rs0=09=09// dst=3Daff0>>rs0
+=09and=09\mask, \mpidr, #0xff00=09=09// mask =3D aff1
+=09lsr=09\mask ,\mask, \rs1
+=09orr=09\dst, \dst, \mask=09=09// dst|=3D(aff1>>rs1)
+=09and=09\mask, \mpidr, #0xff0000=09// mask =3D aff2
+=09lsr=09\mask ,\mask, \rs2
+=09orr=09\dst, \dst, \mask=09=09// dst|=3D(aff2>>rs2)
+=09and=09\mask, \mpidr, #0xff00000000=09// mask =3D aff3
+=09lsr=09\mask ,\mask, \rs3
+=09orr=09\dst, \dst, \mask=09=09// dst|=3D(aff3>>rs3)
+=09.endm
+/*
+ * Save CPU state for a suspend.  This saves the CPU general purpose
+ * registers, and allocates space on the kernel stack to save the CPU
+ * specific registers and some other data for resume.
+ *
+ *  x0 =3D suspend function arg0
+ *  x1 =3D suspend function
+ */
+ENTRY(__cpu_suspend)
+=09stp=09x29, lr, [sp, #-96]!
+=09stp=09x19, x20, [sp,#16]
+=09stp=09x21, x22, [sp,#32]
+=09stp=09x23, x24, [sp,#48]
+=09stp=09x25, x26, [sp,#64]
+=09stp=09x27, x28, [sp,#80]
+=09mov=09x2, sp
+=09sub=09sp, sp, #CPU_SUSPEND_SZ=09// allocate cpu_suspend_ctx
+=09mov=09x19, x0
+=09mov=09x20, x1
+=09mov=09x0, sp
+=09/*
+=09 * x0 now points to struct cpu_suspend_ctx allocated on the stack
+=09 */
+=09str=09x2, [x0, #CPU_CTX_SP]
+=09ldr=09x1, =3Dsleep_save_sp
+=09ldr=09x1, [x1, #SLEEP_SAVE_SP_VIRT]
+#ifdef CONFIG_SMP
+=09mrs=09x7, mpidr_el1
+=09ldr=09x9, =3Dmpidr_hash
+=09ldr=09x2, [x9, #MPIDR_HASH_MASK]
+=09ldp=09w3, w4, [x9, #MPIDR_HASH_SHIFTS]
+=09ldp=09w5, w6, [x9, #(MPIDR_HASH_SHIFTS + 8)]
+=09compute_mpidr_hash x8, x3, x4, x5, x6, x7, x2
+=09add=09x1, x1, x8, lsl #3
+#endif
+=09bl=09__cpu_suspend_save
+=09adr=09lr, cpu_suspend_abort=09// set lr, in case suspend fails
+=09mov=09x0, x19
+=09br=09x20=09=09=09// jump to suspend finisher, x0 =3D arg
+ENDPROC(__cpu_suspend)
+=09.ltorg
+
+cpu_suspend_abort:
+=09pop =09x1, x2
+=09cmp=09x0, #0
+=09mov=09x3, #1
+=09csel=09x0, x3, x0, ne=09=09// force x0 =3D 1 (error) in case x0 =3D=3D =
0
+=09mov=09sp, x2=09=09=09// restore sp and return
+=09ldp=09x19, x20, [sp, #16]
+=09ldp=09x21, x22, [sp, #32]
+=09ldp=09x23, x24, [sp, #48]
+=09ldp=09x25, x26, [sp, #64]
+=09ldp=09x27, x28, [sp, #80]
+=09ldp=09x29, lr, [sp], #96
+=09ret
+ENDPROC(cpu_suspend_abort)
+/*
+ * x0 must contain the sctlr value retrieved from restored context
+ */
+ENTRY(cpu_resume_mmu)
+=09ldr=09x3, =3Dcpu_resume_after_mmu
+=09msr=09sctlr_el1, x0=09=09// restore sctlr_el1
+=09isb
+=09br=09x3=09=09=09// global jump to virtual address
+ENDPROC(cpu_resume_mmu)
+cpu_resume_after_mmu:
+=09mov=09x0, #0=09=09=09// return zero on success
+=09ldp=09x19, x20, [sp, #16]
+=09ldp=09x21, x22, [sp, #32]
+=09ldp=09x23, x24, [sp, #48]
+=09ldp=09x25, x26, [sp, #64]
+=09ldp=09x27, x28, [sp, #80]
+=09ldp=09x29, lr, [sp], #96
+=09ret
+ENDPROC(cpu_resume_after_mmu)
+
+=09.data
+ENTRY(cpu_resume)
+=09adr=09x4, sleep_save_sp
+=09ldr=09x5, =3Dsleep_save_sp
+=09sub=09x28, x4, x5=09=09// x28 =3D PHYS_OFFSET - PAGE_OFFSET
+        /*
+=09 * make sure el2 is sane, el2_setup expects:
+=09 * x28 =3D PHYS_OFFSET - PAGE_OFFSET
+=09 */
+=09bl=09el2_setup=09=09// if in EL2 drop to EL1 cleanly
+#ifdef CONFIG_SMP
+=09mrs=09x1, mpidr_el1
+=09adr=09x4, mpidr_hash_ptr
+=09ldr=09x5, [x4]
+=09add=09x8, x4, x5=09=09// x8 =3D struct mpidr_hash phys address
+        /* retrieve mpidr_hash members to compute the hash */
+=09ldr=09x2, [x8, #MPIDR_HASH_MASK]
+=09ldp=09w3, w4, [x8, #MPIDR_HASH_SHIFTS]
+=09ldp=09w5, w6, [x8, #(MPIDR_HASH_SHIFTS + 8)]
+=09compute_mpidr_hash x7, x3, x4, x5, x6, x1, x2
+        /* x7 contains hash index, let's use it to grab context pointer */
+#else
+=09mov=09x7, xzr
+#endif
+=09adr=09x0, _sleep_save_sp
+=09ldr=09x0, [x0, #SLEEP_SAVE_SP_PHYS]
+=09ldr=09x0, [x0, x7, lsl #3]
+=09/* load phys identity pgd and sp */
+=09ldr=09x2, [x0, #CPU_CTX_SP]
+=09ldr=09x1, [x0, #CPU_CTX_TTBR0_EL1]
+=09mov=09sp, x2
+=09/*
+=09 * cpu_do_resume expects x1 to contain physical address of 1:1
+=09 * page tables
+=09 */
+=09bl=09cpu_do_resume=09=09// PC relative jump, MMU off
+=09b=09cpu_resume_mmu=09=09// Resume MMU, never returns
+ENDPROC(cpu_resume)
+
+=09.align 3
+mpidr_hash_ptr:
+=09/*
+=09 * offset of mpidr_hash symbol from current location
+=09 * used to obtain run-time mpidr_hash address with MMU off
+         */
+=09.quad=09mpidr_hash - .
+/*
+ * struct sleep_save_sp {
+ *=09u64 *save_ptr_stash;
+ *=09phys_addr_t save_ptr_stash_phys;
+ * };
+ */
+=09.type=09sleep_save_sp, #object
+ENTRY(sleep_save_sp)
+_sleep_save_sp:
+=09.space=09SLEEP_SAVE_SP_SZ=09// struct sleep_save_sp
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
new file mode 100644
index 0000000..491aceb
--- /dev/null
+++ b/arch/arm64/kernel/suspend.c
@@ -0,0 +1,76 @@
+#include <linux/slab.h>
+#include <asm/cacheflush.h>
+#include <asm/pgtable.h>
+#include <asm/memory.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
+#include <asm/tlbflush.h>
+
+extern int __cpu_suspend(unsigned long, int (*)(unsigned long));
+/*
+ * This is called by __cpu_suspend() to save the state, and do whatever
+ * flushing is required to ensure that when the CPU goes to sleep we have
+ * the necessary data available when the caches are not searched.
+ *
+ * @ptr: CPU context virtual address
+ * @save_ptr: address of the location where the context physical address
+ *            must be saved
+ */
+void __cpu_suspend_save(struct cpu_suspend_ctx *ptr, u64 *save_ptr)
+{
+=09*save_ptr =3D virt_to_phys(ptr);
+
+=09ptr->ttbr0_el1 =3D virt_to_phys(idmap_pg_dir);
+
+=09cpu_do_suspend(ptr);
+=09/*
+=09 * Only flush the context that must be retrieved with the MMU
+=09 * off. VA primitives ensure the flush is applied to all
+=09 * cache levels so context is pushed to DRAM.
+=09 */
+=09__flush_dcache_area(ptr, sizeof(*ptr));
+=09__flush_dcache_area(save_ptr, sizeof(*save_ptr));
+}
+
+/**
+ * cpu_suspend
+ *
+ * @arg: argument to pass to the finisher function
+ * @fn: suspend finisher function, the function that executes last
+ *=09operations required to suspend a processor
+ */
+int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
+{
+=09struct mm_struct *mm =3D current->active_mm;
+=09int ret;
+=09/*
+=09 * Save the mm context on the stack, it will be restored when
+=09 * the cpu comes out of reset through the identity mapped
+=09 * page tables, so that the thread address space is properly
+=09 * set-up on function return.
+=09 */
+=09ret =3D __cpu_suspend(arg, fn);
+=09if (ret =3D=3D 0) {
+=09=09cpu_switch_mm(mm->pgd, mm);
+=09=09flush_tlb_all();
+=09}
+
+=09return ret;
+}
+
+extern struct sleep_save_sp sleep_save_sp;
+
+static int cpu_suspend_alloc_sp(void)
+{
+=09void *ctx_ptr;
+=09/* ctx_ptr is an array of physical addresses */
+=09ctx_ptr =3D kcalloc(mpidr_hash_size(), sizeof(phys_addr_t), GFP_KERNEL)=
;
+
+=09if (WARN_ON(!ctx_ptr))
+=09=09return -ENOMEM;
+=09sleep_save_sp.save_ptr_stash =3D ctx_ptr;
+=09sleep_save_sp.save_ptr_stash_phys =3D virt_to_phys(ctx_ptr);
+=09__flush_dcache_area(&sleep_save_sp, sizeof(struct sleep_save_sp));
+=09return 0;
+}
+early_initcall(cpu_suspend_alloc_sp);
--=20
1.8.3.4



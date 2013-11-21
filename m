From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v3 03/12] arm64: kernel: suspend/resume registers save/restore
Date: Thu, 21 Nov 2013 11:24:10 +0000
Message-ID: <1385033059-25896-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:32829 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab3KULYx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2013 06:24:53 -0500
In-Reply-To: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>

Power management software requires the kernel to save and restore
CPU registers while going through suspend and resume operations
triggered by kernel subsystems like CPU idle and suspend to RAM.

This patch implements code that provides save and restore mechanism
for the arm v8 implementation. Memory for the context is passed as
parameter to both cpu_do_suspend and cpu_do_resume functions, and allows
the callers to implement context allocation as they deem fit.

The registers that are saved and restored correspond to the registers set
actually required by the kernel to be up and running which represents a
subset of v8 ISA.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/proc-fns.h |  3 ++
 arch/arm64/include/asm/suspend.h  | 18 ++++++++++
 arch/arm64/mm/proc.S              | 69 +++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 90 insertions(+)
 create mode 100644 arch/arm64/include/asm/suspend.h

diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/pro=
c-fns.h
index 7cdf466..0c657bb 100644
--- a/arch/arm64/include/asm/proc-fns.h
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -26,11 +26,14 @@
 #include <asm/page.h>
=20
 struct mm_struct;
+struct cpu_suspend_ctx;
=20
 extern void cpu_cache_off(void);
 extern void cpu_do_idle(void);
 extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm)=
;
 extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
+extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
+extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
=20
 #include <asm/memory.h>
=20
diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/susp=
end.h
new file mode 100644
index 0000000..a88558e
--- /dev/null
+++ b/arch/arm64/include/asm/suspend.h
@@ -0,0 +1,18 @@
+#ifndef __ASM_SUSPEND_H
+#define __ASM_SUSPEND_H
+
+#define NR_CTX_REGS 11
+
+/*
+ * struct cpu_suspend_ctx must be 16-byte aligned since it is allocated on
+ * the stack, which must be 16-byte aligned on v8
+ */
+struct cpu_suspend_ctx {
+=09/*
+=09 * This struct must be kept in sync with
+=09 * cpu_do_{suspend/resume} in mm/proc.S
+=09 */
+=09u64 ctx_regs[NR_CTX_REGS];
+=09u64 sp;
+} __aligned(16);
+#endif
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 421b99f..ef91046 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -80,6 +80,75 @@ ENTRY(cpu_do_idle)
 =09ret
 ENDPROC(cpu_do_idle)
=20
+#ifdef CONFIG_ARM64_CPU_SUSPEND
+/**
+ * cpu_do_suspend - save CPU registers context
+ *
+ * x0: virtual address of context pointer
+ */
+ENTRY(cpu_do_suspend)
+=09mrs=09x2, tpidr_el0
+=09mrs=09x3, tpidrro_el0
+=09mrs=09x4, contextidr_el1
+=09mrs=09x5, mair_el1
+=09mrs=09x6, cpacr_el1
+=09mrs=09x7, ttbr1_el1
+=09mrs=09x8, tcr_el1
+=09mrs=09x9, vbar_el1
+=09mrs=09x10, mdscr_el1
+=09mrs=09x11, oslsr_el1
+=09mrs=09x12, sctlr_el1
+=09stp=09x2, x3, [x0]
+=09stp=09x4, x5, [x0, #16]
+=09stp=09x6, x7, [x0, #32]
+=09stp=09x8, x9, [x0, #48]
+=09stp=09x10, x11, [x0, #64]
+=09str=09x12, [x0, #80]
+=09ret
+ENDPROC(cpu_do_suspend)
+
+/**
+ * cpu_do_resume - restore CPU register context
+ *
+ * x0: Physical address of context pointer
+ * x1: ttbr0_el1 to be restored
+ *
+ * Returns:
+ *=09sctlr_el1 value in x0
+ */
+ENTRY(cpu_do_resume)
+=09/*
+=09 * Invalidate local tlb entries before turning on MMU
+=09 */
+=09tlbi=09vmalle1
+=09ldp=09x2, x3, [x0]
+=09ldp=09x4, x5, [x0, #16]
+=09ldp=09x6, x7, [x0, #32]
+=09ldp=09x8, x9, [x0, #48]
+=09ldp=09x10, x11, [x0, #64]
+=09ldr=09x12, [x0, #80]
+=09msr=09tpidr_el0, x2
+=09msr=09tpidrro_el0, x3
+=09msr=09contextidr_el1, x4
+=09msr=09mair_el1, x5
+=09msr=09cpacr_el1, x6
+=09msr=09ttbr0_el1, x1
+=09msr=09ttbr1_el1, x7
+=09msr=09tcr_el1, x8
+=09msr=09vbar_el1, x9
+=09msr=09mdscr_el1, x10
+=09/*
+=09 * Restore oslsr_el1 by writing oslar_el1
+=09 */
+=09ubfx=09x11, x11, #1, #1
+=09msr=09oslar_el1, x11
+=09mov=09x0, x12
+=09dsb=09nsh=09=09// Make sure local tlb invalidation completed
+=09isb
+=09ret
+ENDPROC(cpu_do_resume)
+#endif
+
 /*
  *=09cpu_switch_mm(pgd_phys, tsk)
  *
--=20
1.8.4



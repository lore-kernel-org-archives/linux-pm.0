From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2 03/13] arm64: kernel: suspend/resume registers save/restore
Date: Mon, 14 Oct 2013 12:03:00 +0100
Message-ID: <1381748590-14279-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:56873 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab3JNLCc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 07:02:32 -0400
In-Reply-To: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

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
 arch/arm64/include/asm/proc-fns.h      |  3 ++
 arch/arm64/include/asm/suspend.h       | 27 ++++++++++++
 arch/arm64/include/asm/suspendmacros.h | 75 ++++++++++++++++++++++++++++++=
++++
 arch/arm64/mm/proc.S                   | 30 ++++++++++++++
 4 files changed, 135 insertions(+)
 create mode 100644 arch/arm64/include/asm/suspend.h
 create mode 100644 arch/arm64/include/asm/suspendmacros.h

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
index 0000000..2b9f1a9
--- /dev/null
+++ b/arch/arm64/include/asm/suspend.h
@@ -0,0 +1,27 @@
+#ifndef __ASM_SUSPEND_H
+#define __ASM_SUSPEND_H
+
+/*
+ * struct cpu_suspend_ctx must be 16-byte aligned since it is allocated on
+ * the stack, which must be 16-byte aligned on v8
+ */
+struct cpu_suspend_ctx {
+=09/*
+=09 * This struct must be kept in sync with
+=09 * suspend_save_ctx/suspend_restore_ctx
+=09 * macros in asm/suspendmacros.h
+=09 */
+=09struct {
+=09=09u64 tpidr_el0;
+=09=09u64 tpidrro_el0;
+=09=09u64 contextidr_el1;
+=09=09u64 mair_el1;
+=09=09u64 cpacr_el1;
+=09=09u64 ttbr1_el1;
+=09=09u64 tcr_el1;
+=09=09u64 vbar_el1;
+=09=09u64 sctlr_el1;
+=09} ctx_regs;
+=09u64 sp;
+} __aligned(16);
+#endif
diff --git a/arch/arm64/include/asm/suspendmacros.h b/arch/arm64/include/as=
m/suspendmacros.h
new file mode 100644
index 0000000..9203e76
--- /dev/null
+++ b/arch/arm64/include/asm/suspendmacros.h
@@ -0,0 +1,75 @@
+/*
+ * suspend state saving and restoring macros
+ *
+ * Copyright (C) 2013 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * suspend_save_ctx - save registers required to suspend a cpu
+ *
+ * x0: register where context base address is stored
+ * macro clobbers {x2 - x10}
+ *
+ * Registers to be saved must be kept consistent with
+ * struct cpu_suspend_ctx
+ */
+.macro suspend_save_ctx
+=09mrs=09x2, tpidr_el0
+=09mrs=09x3, tpidrro_el0
+=09mrs=09x4, contextidr_el1
+=09mrs=09x5, mair_el1
+=09mrs=09x6, cpacr_el1
+=09mrs=09x7, ttbr1_el1
+=09mrs=09x8, tcr_el1
+=09mrs=09x9, vbar_el1
+=09mrs=09x10, sctlr_el1
+=09stp=09x2, x3, [x0]
+=09stp=09x4, x5, [x0, #16]
+=09stp=09x6, x7, [x0, #32]
+=09stp=09x8, x9, [x0, #48]
+=09str=09x10, [x0, #64]
+.endm
+
+/*
+ * suspend_restore_ctx - restore registers required to suspend a cpu
+ *
+ * x0: register where context base address is stored
+ * x1: ttbr0_el1 value to be restored
+ *
+ * Upon completion x0 contains saved sctlr_el1
+ *
+ * macro clobbers {x2 - x10}
+ *
+ * Registers to be restored must be kept consistent with
+ * struct cpu_suspend_ctx
+ */
+.macro suspend_restore_ctx
+=09ldp=09x2, x3, [x0]
+=09ldp=09x4, x5, [x0, #16]
+=09ldp=09x6, x7, [x0, #32]
+=09ldp=09x8, x9, [x0, #48]
+=09ldr=09x10, [x0, #64]
+=09msr=09tpidr_el0, x2
+=09msr=09tpidrro_el0, x3
+=09msr=09contextidr_el1, x4
+=09msr=09mair_el1, x5
+=09msr=09cpacr_el1, x6
+=09msr=09ttbr0_el1, x1
+=09msr=09ttbr1_el1, x7
+=09msr=09tcr_el1, x8
+=09msr=09vbar_el1, x9
+=09mov=09x0, x10
+.endm
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index b1b31bb..6ee3b99 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -25,6 +25,7 @@
 #include <asm/hwcap.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
+#include <asm/suspendmacros.h>
=20
 #include "proc-macros.S"
=20
@@ -80,6 +81,35 @@ ENTRY(cpu_do_idle)
 =09ret
 ENDPROC(cpu_do_idle)
=20
+#ifdef CONFIG_ARM64_CPU_SUSPEND
+/**
+ * cpu_do_suspend - save CPU registers context
+ * x0: virtual address of context pointer
+ */
+ENTRY(cpu_do_suspend)
+=09suspend_save_ctx
+=09ret
+ENDPROC(cpu_do_suspend)
+
+/**
+ * cpu_do_resume - restore CPU register context
+ *
+ *
+ * x0: Physical address of context pointer
+ * x1: ttbr0_el1 to be restored
+ *
+ * Returns:
+ *=09sctlr_el1 value in x0
+ */
+ENTRY(cpu_do_resume)
+=09tlbi=09vmalle1is=09// make sure tlb entries are invalidated
+=09suspend_restore_ctx
+=09isb
+=09dsb=09sy
+=09ret
+ENDPROC(cpu_do_resume)
+#endif
+
 /*
  *=09cpu_switch_mm(pgd_phys, tsk)
  *
--=20
1.8.4



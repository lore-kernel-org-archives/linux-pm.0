From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 04/14] arm64: kernel: suspend/resume registers save/restore
Date: Wed, 28 Aug 2013 12:35:56 +0100
Message-ID: <1377689766-17642-5-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38486 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030Ab3H1LgF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 07:36:05 -0400
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

Power management software requires the kernel to save and restore
CPU registers while going through suspend and resume operations
triggered by kernel subsystems like CPU idle and suspend to RAM.

This patch implements code that provides save and restore mechanism
for the arm v8 implementation. Memory for the context is passed as
parameter to both cpu_do_suspend and cpu_do_resume functions, and allows
the callers to implement context allocation as they deem fit.

The registers that are saved and restored correspond to the registers
actually required by the kernel to be up and running and is by no means
a complete save and restore of the entire v8 register set.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/proc-fns.h |  3 ++
 arch/arm64/mm/proc.S              | 64 +++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 67 insertions(+)

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
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index a82ae88..193bf98 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -80,6 +80,70 @@ ENTRY(cpu_do_idle)
 =09ret
 ENDPROC(cpu_do_idle)
=20
+#ifdef CONFIG_ARM_CPU_SUSPEND
+/**
+ * cpu_do_suspend - save CPU registers context
+ * x0: virtual address of context pointer
+ */
+ENTRY(cpu_do_suspend)
+=09mrs=09x1, tpidr_el0
+=09str=09x1, [x0, #CPU_CTX_TPIDR_EL0]
+=09mrs=09x2, tpidrro_el0
+=09str=09x2, [x0, #CPU_CTX_TPIDRRO_EL0]
+=09mrs=09x3, contextidr_el1
+=09str=09x3, [x0, #CPU_CTX_CTXIDR_EL1]
+=09mrs=09x4, mair_el1
+=09str=09x4, [x0, #CPU_CTX_MAIR_EL1]
+=09mrs=09x5, cpacr_el1
+=09str=09x5, [x0, #CPU_CTX_CPACR_EL1]
+=09mrs=09x6, ttbr1_el1
+=09str=09x6, [x0, #CPU_CTX_TTBR1_EL1]
+=09mrs=09x7, tcr_el1
+=09str=09x7, [x0, #CPU_CTX_TCR_EL1]
+=09mrs=09x8, vbar_el1
+=09str=09x8, [x0, #CPU_CTX_VBAR_EL1]
+=09mrs=09x9, sctlr_el1
+=09str=09x9, [x0, #CPU_CTX_SCTLR_EL1]
+=09ret
+ENDPROC(cpu_do_suspend)
+
+/**
+ * cpu_do_resume - registers layout should match the corresponding
+ *                 cpu_do_suspend call
+ *
+ * x0: Physical address of context pointer
+ * x1: Should contain the physical address of identity map page tables
+ *     used to turn on the MMU and complete context restore
+ *
+ * Returns:
+ *=09sctlr value in x0
+ */
+ENTRY(cpu_do_resume)
+=09tlbi=09vmalle1is=09// make sure tlb entries are invalid
+=09ldr=09x2, [x0, #CPU_CTX_TPIDR_EL0]
+=09msr=09tpidr_el0, x2
+=09ldr=09x3, [x0, #CPU_CTX_TPIDRRO_EL0]
+=09msr=09tpidrro_el0, x3
+=09ldr=09x4, [x0, #CPU_CTX_CTXIDR_EL1]
+=09msr=09contextidr_el1, x4
+=09ldr=09x5, [x0, #CPU_CTX_MAIR_EL1]
+=09msr=09mair_el1, x5
+=09ldr=09x6, [x0, #CPU_CTX_CPACR_EL1]
+=09msr=09cpacr_el1, x6
+=09msr=09ttbr0_el1, x1
+=09ldr=09x7, [x0, #CPU_CTX_TTBR1_EL1]
+=09msr=09ttbr1_el1, x7
+=09ldr=09x8, [x0, #CPU_CTX_TCR_EL1]
+=09msr=09tcr_el1, x8
+=09ldr=09x9, [x0, #CPU_CTX_VBAR_EL1]
+=09msr=09vbar_el1, x9
+=09ldr=09x0, [x0, #CPU_CTX_SCTLR_EL1]
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
1.8.3.4



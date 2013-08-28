From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 03/14] arm64: kernel: add structure to define cpu context layout
Date: Wed, 28 Aug 2013 12:35:55 +0100
Message-ID: <1377689766-17642-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38561 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab3H1LgG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 07:36:06 -0400
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

In order to define registers that have to be saved and restored on
cpu suspend, this patch adds to the kernel a structure declaration
that defines registers that needs saving and restoring across power
cycles.
asm offsets for size and members of the struct are generated so that
assembly code can make use of them in the cpu_{suspend}/{resume} code
path.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/processor.h | 18 ++++++++++++++++++
 arch/arm64/kernel/asm-offsets.c    | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/pr=
ocessor.h
index ab239b2..2b5f694 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -74,6 +74,24 @@ struct cpu_context {
 =09unsigned long pc;
 };
=20
+/*
+ * struct cpu_suspend_ctx must be 16-byte aligned since it is allocated on
+ * the stack, which must be 16-byte aligned on v8
+ */
+struct cpu_suspend_ctx {
+=09unsigned long tpidr_el0;
+=09unsigned long tpidrro_el0;
+=09unsigned long contextidr_el1;
+=09unsigned long mair_el1;
+=09unsigned long cpacr_el1;
+=09unsigned long ttbr0_el1;
+=09unsigned long ttbr1_el1;
+=09unsigned long tcr_el1;
+=09unsigned long vbar_el1;
+=09unsigned long sctlr_el1;
+=09unsigned long sp;
+} __aligned(16);
+
 struct thread_struct {
 =09struct cpu_context=09cpu_context;=09/* cpu context */
 =09unsigned long=09=09tp_value;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offset=
s.c
index f300a13..77b12d1 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -140,6 +140,18 @@ int main(void)
   DEFINE(KVM_VGIC_VCTRL,=09offsetof(struct kvm, arch.vgic.vctrl_base));
 #endif
 #ifdef CONFIG_ARM_CPU_SUSPEND
+  DEFINE(CPU_SUSPEND_SZ,=09sizeof(struct cpu_suspend_ctx));
+  DEFINE(CPU_CTX_TPIDR_EL0,=09offsetof(struct cpu_suspend_ctx, tpidr_el0))=
;
+  DEFINE(CPU_CTX_TPIDRRO_EL0,=09offsetof(struct cpu_suspend_ctx, tpidrro_e=
l0));
+  DEFINE(CPU_CTX_CTXIDR_EL1,=09offsetof(struct cpu_suspend_ctx, contextidr=
_el1));
+  DEFINE(CPU_CTX_MAIR_EL1,=09offsetof(struct cpu_suspend_ctx, mair_el1));
+  DEFINE(CPU_CTX_CPACR_EL1,=09offsetof(struct cpu_suspend_ctx, cpacr_el1))=
;
+  DEFINE(CPU_CTX_TTBR0_EL1,=09offsetof(struct cpu_suspend_ctx, ttbr0_el1))=
;
+  DEFINE(CPU_CTX_TTBR1_EL1,=09offsetof(struct cpu_suspend_ctx, ttbr1_el1))=
;
+  DEFINE(CPU_CTX_TCR_EL1,=09offsetof(struct cpu_suspend_ctx, tcr_el1));
+  DEFINE(CPU_CTX_VBAR_EL1,=09offsetof(struct cpu_suspend_ctx, vbar_el1));
+  DEFINE(CPU_CTX_SCTLR_EL1,=09offsetof(struct cpu_suspend_ctx, sctlr_el1))=
;
+  DEFINE(CPU_CTX_SP,=09=09offsetof(struct cpu_suspend_ctx, sp));
   DEFINE(MPIDR_HASH_MASK,=09offsetof(struct mpidr_hash, mask));
   DEFINE(MPIDR_HASH_SHIFTS,=09offsetof(struct mpidr_hash, shift_aff));
 #endif
--=20
1.8.3.4



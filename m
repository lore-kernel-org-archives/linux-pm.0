From: James Morse <james.morse@arm.com>
Subject: [PATCH v5 01/15] arm64: Fold proc-macros.S into assembler.h
Date: Tue, 16 Feb 2016 15:49:13 +0000
Message-ID: <1455637767-31561-2-git-send-email-james.morse@arm.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54438 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755420AbcBPPvW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Feb 2016 10:51:22 -0500
In-Reply-To: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

From: Geoff Levand <geoff@infradead.org>

To allow the assembler macros defined in arch/arm64/mm/proc-macros.S to
be used outside the mm code move the contents of proc-macros.S to
asm/assembler.h.  Also, delete proc-macros.S, and fix up all references
to proc-macros.S.

Signed-off-by: Geoff Levand <geoff@infradead.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
[rebased, included dcache_by_line_op]
Signed-off-by: James Morse <james.morse@arm.com>
---
This patch comes from v13 of kexec

 arch/arm64/include/asm/assembler.h | 82 ++++++++++++++++++++++++++++++-
 arch/arm64/mm/cache.S              |  2 -
 arch/arm64/mm/proc-macros.S        | 98 --------------------------------------
 arch/arm64/mm/proc.S               |  3 --
 4 files changed, 81 insertions(+), 104 deletions(-)
 delete mode 100644 arch/arm64/mm/proc-macros.S

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index bb7b72734c24..ec4e37cb3b41 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -1,5 +1,5 @@
 /*
- * Based on arch/arm/include/asm/assembler.h
+ * Based on arch/arm/include/asm/assembler.h, arch/arm/mm/proc-macros.S
  *
  * Copyright (C) 1996-2000 Russell King
  * Copyright (C) 2012 ARM Ltd.
@@ -23,6 +23,8 @@
 #ifndef __ASM_ASSEMBLER_H
 #define __ASM_ASSEMBLER_H
 
+#include <asm/asm-offsets.h>
+#include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 
@@ -205,6 +207,84 @@ lr	.req	x30		// link register
 	.endm
 
 /*
+ * vma_vm_mm - get mm pointer from vma pointer (vma->vm_mm)
+ */
+	.macro	vma_vm_mm, rd, rn
+	ldr	\rd, [\rn, #VMA_VM_MM]
+	.endm
+
+/*
+ * mmid - get context id from mm pointer (mm->context.id)
+ */
+	.macro	mmid, rd, rn
+	ldr	\rd, [\rn, #MM_CONTEXT_ID]
+	.endm
+
+/*
+ * dcache_line_size - get the minimum D-cache line size from the CTR register.
+ */
+	.macro	dcache_line_size, reg, tmp
+	mrs	\tmp, ctr_el0			// read CTR
+	ubfm	\tmp, \tmp, #16, #19		// cache line size encoding
+	mov	\reg, #4			// bytes per word
+	lsl	\reg, \reg, \tmp		// actual cache line size
+	.endm
+
+/*
+ * icache_line_size - get the minimum I-cache line size from the CTR register.
+ */
+	.macro	icache_line_size, reg, tmp
+	mrs	\tmp, ctr_el0			// read CTR
+	and	\tmp, \tmp, #0xf		// cache line size encoding
+	mov	\reg, #4			// bytes per word
+	lsl	\reg, \reg, \tmp		// actual cache line size
+	.endm
+
+/*
+ * tcr_set_idmap_t0sz - update TCR.T0SZ so that we can load the ID map
+ */
+	.macro	tcr_set_idmap_t0sz, valreg, tmpreg
+#ifndef CONFIG_ARM64_VA_BITS_48
+	ldr_l	\tmpreg, idmap_t0sz
+	bfi	\valreg, \tmpreg, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
+#endif
+	.endm
+
+/*
+ * Macro to perform a data cache maintenance for the interval
+ * [kaddr, kaddr + size)
+ *
+ * 	op:		operation passed to dc instruction
+ * 	domain:		domain used in dsb instruciton
+ * 	kaddr:		starting virtual address of the region
+ * 	size:		size of the region
+ * 	Corrupts:	kaddr, size, tmp1, tmp2
+ */
+	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
+	dcache_line_size \tmp1, \tmp2
+	add	\size, \kaddr, \size
+	sub	\tmp2, \tmp1, #1
+	bic	\kaddr, \kaddr, \tmp2
+9998:	dc	\op, \kaddr
+	add	\kaddr, \kaddr, \tmp1
+	cmp	\kaddr, \size
+	b.lo	9998b
+	dsb	\domain
+	.endm
+
+/*
+ * reset_pmuserenr_el0 - reset PMUSERENR_EL0 if PMUv3 present
+ */
+	.macro	reset_pmuserenr_el0, tmpreg
+	mrs	\tmpreg, id_aa64dfr0_el1	// Check ID_AA64DFR0_EL1 PMUVer
+	sbfx	\tmpreg, \tmpreg, #8, #4
+	cmp	\tmpreg, #1			// Skip if no PMU present
+	b.lt	9000f
+	msr	pmuserenr_el0, xzr		// Disable PMU access from EL0
+9000:
+	.endm
+
+/*
  * Annotate a function as position independent, i.e., safe to be called before
  * the kernel virtual mapping is activated.
  */
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 6df07069a025..50ff9ba3a236 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -24,8 +24,6 @@
 #include <asm/cpufeature.h>
 #include <asm/alternative.h>
 
-#include "proc-macros.S"
-
 /*
  *	flush_icache_range(start,end)
  *
diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
deleted file mode 100644
index e6a30e1268a8..000000000000
--- a/arch/arm64/mm/proc-macros.S
+++ /dev/null
@@ -1,98 +0,0 @@
-/*
- * Based on arch/arm/mm/proc-macros.S
- *
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <asm/asm-offsets.h>
-#include <asm/thread_info.h>
-
-/*
- * vma_vm_mm - get mm pointer from vma pointer (vma->vm_mm)
- */
-	.macro	vma_vm_mm, rd, rn
-	ldr	\rd, [\rn, #VMA_VM_MM]
-	.endm
-
-/*
- * mmid - get context id from mm pointer (mm->context.id)
- */
-	.macro	mmid, rd, rn
-	ldr	\rd, [\rn, #MM_CONTEXT_ID]
-	.endm
-
-/*
- * dcache_line_size - get the minimum D-cache line size from the CTR register.
- */
-	.macro	dcache_line_size, reg, tmp
-	mrs	\tmp, ctr_el0			// read CTR
-	ubfm	\tmp, \tmp, #16, #19		// cache line size encoding
-	mov	\reg, #4			// bytes per word
-	lsl	\reg, \reg, \tmp		// actual cache line size
-	.endm
-
-/*
- * icache_line_size - get the minimum I-cache line size from the CTR register.
- */
-	.macro	icache_line_size, reg, tmp
-	mrs	\tmp, ctr_el0			// read CTR
-	and	\tmp, \tmp, #0xf		// cache line size encoding
-	mov	\reg, #4			// bytes per word
-	lsl	\reg, \reg, \tmp		// actual cache line size
-	.endm
-
-/*
- * tcr_set_idmap_t0sz - update TCR.T0SZ so that we can load the ID map
- */
-	.macro	tcr_set_idmap_t0sz, valreg, tmpreg
-#ifndef CONFIG_ARM64_VA_BITS_48
-	ldr_l	\tmpreg, idmap_t0sz
-	bfi	\valreg, \tmpreg, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
-#endif
-	.endm
-
-/*
- * Macro to perform a data cache maintenance for the interval
- * [kaddr, kaddr + size)
- *
- * 	op:		operation passed to dc instruction
- * 	domain:		domain used in dsb instruciton
- * 	kaddr:		starting virtual address of the region
- * 	size:		size of the region
- * 	Corrupts: 	kaddr, size, tmp1, tmp2
- */
-	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
-	dcache_line_size \tmp1, \tmp2
-	add	\size, \kaddr, \size
-	sub	\tmp2, \tmp1, #1
-	bic	\kaddr, \kaddr, \tmp2
-9998:	dc	\op, \kaddr
-	add	\kaddr, \kaddr, \tmp1
-	cmp	\kaddr, \size
-	b.lo	9998b
-	dsb	\domain
-	.endm
-
-/*
- * reset_pmuserenr_el0 - reset PMUSERENR_EL0 if PMUv3 present
- */
-	.macro	reset_pmuserenr_el0, tmpreg
-	mrs	\tmpreg, id_aa64dfr0_el1	// Check ID_AA64DFR0_EL1 PMUVer
-	sbfx	\tmpreg, \tmpreg, #8, #4
-	cmp	\tmpreg, #1			// Skip if no PMU present
-	b.lt	9000f
-	msr	pmuserenr_el0, xzr		// Disable PMU access from EL0
-9000:
-	.endm
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 0c19534a901e..db832c42ae30 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -23,11 +23,8 @@
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/hwcap.h>
-#include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
 
-#include "proc-macros.S"
-
 #ifdef CONFIG_ARM64_64K_PAGES
 #define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
 #elif defined(CONFIG_ARM64_16K_PAGES)
-- 
2.6.2


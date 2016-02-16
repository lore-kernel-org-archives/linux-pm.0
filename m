From: James Morse <james.morse@arm.com>
Subject: [PATCH v5 11/15] arm64: head.S: Change the register el2_setup() returns its result in x0
Date: Tue, 16 Feb 2016 15:49:23 +0000
Message-ID: <1455637767-31561-12-git-send-email-james.morse@arm.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54521 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755273AbcBPPv5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Feb 2016 10:51:57 -0500
In-Reply-To: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

Today el2_setup() returns its result in w20. This means we can't call it
like any normal function. Change this to w0.

All three callers of el2_setup() call set_cpu_boot_mode_flag() immediately
afterwards, and don't rely on x0 in later code. Boot cpu code calls
preserve_boot_args() before el2_setup(), so we don't clobber the DT pointer.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/processor.h |  2 ++
 arch/arm64/kernel/head.S           | 18 +++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 4acb7ca94fcd..07ac4351538e 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -188,4 +188,6 @@ static inline void spin_lock_prefetch(const void *x)
 
 void cpu_enable_pan(void *__unused);
 
+int el2_setup(void);
+
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 410a2dc04775..5894c7e91e6b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -206,7 +206,7 @@ section_table:
 
 ENTRY(stext)
 	bl	preserve_boot_args
-	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
+	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
 	adrp	x24, __PHYS_OFFSET
 	bl	set_cpu_boot_mode_flag
 	bl	__create_page_tables		// x25=TTBR0, x26=TTBR1
@@ -446,8 +446,8 @@ ENDPROC(__mmap_switched)
  * If we're fortunate enough to boot at EL2, ensure that the world is
  * sane before dropping to EL1.
  *
- * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in x20 if
- * booted in EL1 or EL2 respectively.
+ * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 if booted in
+ * EL1 or EL2 respectively.
  */
 ENTRY(el2_setup)
 	mrs	x0, CurrentEL
@@ -462,7 +462,7 @@ CPU_LE(	bic	x0, x0, #(1 << 25)	)	// Clear the EE bit for EL2
 CPU_BE(	orr	x0, x0, #(3 << 24)	)	// Set the EE and E0E bits for EL1
 CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 	msr	sctlr_el1, x0
-	mov	w20, #BOOT_CPU_MODE_EL1		// This cpu booted in EL1
+	mov	w0, #BOOT_CPU_MODE_EL1		// This cpu booted in EL1
 	isb
 	ret
 
@@ -538,20 +538,20 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 		      PSR_MODE_EL1h)
 	msr	spsr_el2, x0
 	msr	elr_el2, lr
-	mov	w20, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
+	mov	w0, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
 	eret
 ENDPROC(el2_setup)
 
 /*
  * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
- * in x20. See arch/arm64/include/asm/virt.h for more info.
+ * in w0. See arch/arm64/include/asm/virt.h for more info.
  */
 ENTRY(set_cpu_boot_mode_flag)
 	adr_l	x1, __boot_cpu_mode
-	cmp	w20, #BOOT_CPU_MODE_EL2
+	cmp	w0, #BOOT_CPU_MODE_EL2
 	b.ne	1f
 	add	x1, x1, #4
-1:	str	w20, [x1]			// This CPU has booted in EL1
+1:	str	w0, [x1]			// This CPU has booted in EL1
 	dmb	sy
 	dc	ivac, x1			// Invalidate potentially stale cache line
 	ret
@@ -576,7 +576,7 @@ ENTRY(__boot_cpu_mode)
 	 * cores are held until we're ready for them to initialise.
 	 */
 ENTRY(secondary_holding_pen)
-	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
+	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
 	bl	set_cpu_boot_mode_flag
 	mrs	x0, mpidr_el1
 	ldr     x1, =MPIDR_HWID_BITMASK
-- 
2.6.2


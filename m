From: James Morse <james.morse@arm.com>
Subject: [PATCH v5 12/15] arm64: head.S: el2_setup() to accept sctlr_el1 as an argument
Date: Tue, 16 Feb 2016 15:49:24 +0000
Message-ID: <1455637767-31561-13-git-send-email-james.morse@arm.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54534 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932444AbcBPPwG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Feb 2016 10:52:06 -0500
In-Reply-To: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

el2_setup() doesn't just configure el2, it configures el1 too. This
means we can't use it to re-configure el2 after resume from hibernate,
as we will be returned to el1 with the MMU turned off.

Split the sctlr_el1 setting code up, so that el2_setup() accepts an
initial value as an argument. This value will be ignored if el2_setup()
is called at el1: the running value will be preserved with endian
correction.

Hibernate can now call el2_setup() to re-configure el2, passing the
current sctlr_el1 as an argument.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/assembler.h |  9 +++++++++
 arch/arm64/include/asm/processor.h |  2 +-
 arch/arm64/kernel/head.S           | 19 ++++++++++++-------
 arch/arm64/kernel/sleep.S          |  1 +
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index f3854d9b5e31..9a4746302d8d 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -304,6 +304,15 @@ lr	.req	x30		// link register
 	.endm
 
 /*
+ * Generate the initial sctlr_el1 value for el2_setup to set if we boot at EL2.
+ */
+	.macro init_sctlr_el1 reg
+		mov	\reg, #0x0800		// Set/clear RES{1,0} bits
+CPU_BE(		movk	\reg, #0x33d0, lsl #16)	// Set EE and E0E on BE systems
+CPU_LE(		movk	\reg, #0x30d0, lsl #16)	// Clear EE and E0E on LE systems
+	.endm
+
+/*
  * Annotate a function as position independent, i.e., safe to be called before
  * the kernel virtual mapping is activated.
  */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 07ac4351538e..8973715e582e 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -188,6 +188,6 @@ static inline void spin_lock_prefetch(const void *x)
 
 void cpu_enable_pan(void *__unused);
 
-int el2_setup(void);
+int el2_setup(unsigned long init_sctlr_el1);
 
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 5894c7e91e6b..4926093461e9 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -206,6 +206,7 @@ section_table:
 
 ENTRY(stext)
 	bl	preserve_boot_args
+	init_sctlr_el1	x0
 	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
 	adrp	x24, __PHYS_OFFSET
 	bl	set_cpu_boot_mode_flag
@@ -448,8 +449,12 @@ ENDPROC(__mmap_switched)
  *
  * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 if booted in
  * EL1 or EL2 respectively.
+ *
+ * If booted in EL2, SCTLR_EL1 will be initialised with the value in x0
+ * (otherwise the existing value will be preserved, with endian correction).
  */
 ENTRY(el2_setup)
+	mov	x1, x0				// preserve passed-in sctlr_el1
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
 	b.ne	1f
@@ -458,7 +463,7 @@ CPU_BE(	orr	x0, x0, #(1 << 25)	)	// Set the EE bit for EL2
 CPU_LE(	bic	x0, x0, #(1 << 25)	)	// Clear the EE bit for EL2
 	msr	sctlr_el2, x0
 	b	2f
-1:	mrs	x0, sctlr_el1
+1:	mrs	x0, sctlr_el1			// ignore passed-in sctlr_el1
 CPU_BE(	orr	x0, x0, #(3 << 24)	)	// Set the EE and E0E bits for EL1
 CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 	msr	sctlr_el1, x0
@@ -494,6 +499,10 @@ CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 
 3:
 #endif
+	/* use sctlr_el1 value we were provided with */
+CPU_BE(	orr	x1, x1, #(3 << 24)	)	// Set the EE and E0E bits for EL1
+CPU_LE(	bic	x1, x1, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
+	msr	sctlr_el1, x1
 
 	/* Populate ID registers. */
 	mrs	x0, midr_el1
@@ -501,12 +510,6 @@ CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 	msr	vpidr_el2, x0
 	msr	vmpidr_el2, x1
 
-	/* sctlr_el1 */
-	mov	x0, #0x0800			// Set/clear RES{1,0} bits
-CPU_BE(	movk	x0, #0x33d0, lsl #16	)	// Set EE and E0E on BE systems
-CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
-	msr	sctlr_el1, x0
-
 	/* Coprocessor traps. */
 	mov	x0, #0x33ff
 	msr	cptr_el2, x0			// Disable copro. traps to EL2
@@ -576,6 +579,7 @@ ENTRY(__boot_cpu_mode)
 	 * cores are held until we're ready for them to initialise.
 	 */
 ENTRY(secondary_holding_pen)
+	init_sctlr_el1	x0
 	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
 	bl	set_cpu_boot_mode_flag
 	mrs	x0, mpidr_el1
@@ -594,6 +598,7 @@ ENDPROC(secondary_holding_pen)
 	 * be used where CPUs are brought online dynamically by the kernel.
 	 */
 ENTRY(secondary_entry)
+	init_sctlr_el1	x0
 	bl	el2_setup			// Drop to EL1
 	bl	set_cpu_boot_mode_flag
 	b	secondary_startup
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 0e2b36f1fb44..5c66252d2b9f 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -98,6 +98,7 @@ ENDPROC(__cpu_suspend_enter)
 	.ltorg
 
 ENTRY(cpu_resume)
+	init_sctlr_el1	x0
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	/* enable the MMU early - so we can access sleep_save_stash by va */
 	adr_l	lr, __enable_mmu	/* __cpu_setup will return here */
-- 
2.6.2


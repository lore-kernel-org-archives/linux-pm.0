From: James Morse <james.morse@arm.com>
Subject: [PATCH v2 2/6] arm64: Add .mmuoff.text section
Date: Wed, 15 Jun 2016 18:35:44 +0100
Message-ID: <1466012148-7674-3-git-send-email-james.morse@arm.com>
References: <1466012148-7674-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39175 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbcFORjB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 13:39:01 -0400
In-Reply-To: <1466012148-7674-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>

Resume from hibernate needs to clean any text executed by the kernel with
the MMU off to the PoC. Collect these functions together into a new
.mmuoff.text section.

This covers booting of secondary cores and the cpu_suspend() path used
by cpu-idle and suspend-to-ram.

The bulk of head.S is not included, as the primary boot code is only ever
executed once, the kernel never needs to ensure it is cleaned to a
particular point in the cache.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
This patch is new since v1.

 arch/arm64/include/asm/sections.h | 1 +
 arch/arm64/kernel/head.S          | 6 ++++--
 arch/arm64/kernel/sleep.S         | 2 ++
 arch/arm64/kernel/vmlinux.lds.S   | 3 +++
 arch/arm64/mm/proc.S              | 4 ++++
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index cb68eb348566..6f27c3f86a09 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -24,5 +24,6 @@ extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
 extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 extern char __hyp_text_start[], __hyp_text_end[];
 extern char __idmap_text_start[], __idmap_text_end[];
+extern char __mmuoff_text_start[], __mmuoff_text_end[];
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2c6e598a94dc..ff37231e2054 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -477,6 +477,7 @@ ENTRY(kimage_vaddr)
  * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in x20 if
  * booted in EL1 or EL2 respectively.
  */
+	.pushsection ".mmuoff.text", "ax"
 ENTRY(el2_setup)
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
@@ -604,7 +605,7 @@ install_el2_stub:
 	mov	w20, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
 	eret
 ENDPROC(el2_setup)
-
+	.popsection
 /*
  * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
  * in x20. See arch/arm64/include/asm/virt.h for more info.
@@ -656,6 +657,7 @@ ENDPROC(secondary_holding_pen)
 	 * Secondary entry point that jumps straight into the kernel. Only to
 	 * be used where CPUs are brought online dynamically by the kernel.
 	 */
+	.pushsection ".mmuoff.text", "ax"
 ENTRY(secondary_entry)
 	bl	el2_setup			// Drop to EL1
 	bl	set_cpu_boot_mode_flag
@@ -687,7 +689,7 @@ __secondary_switched:
 	mov	x29, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
-
+	.popsection
 /*
  * The booting CPU updates the failed status @__early_cpu_boot_status,
  * with MMU turned off.
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 9a3aec97ac09..e66ce9b7bbde 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -97,6 +97,7 @@ ENTRY(__cpu_suspend_enter)
 ENDPROC(__cpu_suspend_enter)
 	.ltorg
 
+	.pushsection ".mmuoff.text", "ax"
 ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	/* enable the MMU early - so we can access sleep_save_stash by va */
@@ -106,6 +107,7 @@ ENTRY(cpu_resume)
 	adrp	x26, swapper_pg_dir
 	b	__cpu_setup
 ENDPROC(cpu_resume)
+	.popsection
 
 ENTRY(_cpu_resume)
 	mrs	x1, mpidr_el1
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 435e820e898d..64fe907bcc5f 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -118,6 +118,9 @@ SECTIONS
 			__exception_text_end = .;
 			IRQENTRY_TEXT
 			SOFTIRQENTRY_TEXT
+			__mmuoff_text_start = .;
+			*(.mmuoff.text)
+			__mmuoff_text_end = .;
 			TEXT_TEXT
 			SCHED_TEXT
 			LOCK_TEXT
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index c4317879b938..655ff3ec90f2 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -83,6 +83,7 @@ ENDPROC(cpu_do_suspend)
  *
  * x0: Address of context pointer
  */
+	.pushsection ".mmuoff.text", "ax"
 ENTRY(cpu_do_resume)
 	ldp	x2, x3, [x0]
 	ldp	x4, x5, [x0, #16]
@@ -111,6 +112,7 @@ ENTRY(cpu_do_resume)
 	isb
 	ret
 ENDPROC(cpu_do_resume)
+	.popsection
 #endif
 
 /*
@@ -172,6 +174,7 @@ ENDPROC(idmap_cpu_replace_ttbr1)
  *	Initialise the processor for turning the MMU on.  Return in x0 the
  *	value of the SCTLR_EL1 register.
  */
+	.pushsection ".mmuoff.text", "ax"
 ENTRY(__cpu_setup)
 	tlbi	vmalle1				// Invalidate local TLB
 	dsb	nsh
@@ -255,3 +258,4 @@ ENDPROC(__cpu_setup)
 crval:
 	.word	0xfcffffff			// clear
 	.word	0x34d5d91d			// set
+	.popsection
-- 
2.8.0.rc3


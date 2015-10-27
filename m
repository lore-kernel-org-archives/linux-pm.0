From: James Morse <james.morse@arm.com>
Subject: [PATCH v2 03/11] arm64: Convert hcalls to use HVC immediate value
Date: Tue, 27 Oct 2015 17:29:12 +0000
Message-ID: <1445966960-31724-4-git-send-email-james.morse@arm.com>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57866 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754441AbbJ0RaV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 27 Oct 2015 13:30:21 -0400
In-Reply-To: <1445966960-31724-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

From: Geoff Levand <geoff@infradead.org>

The existing arm64 hcall implementations are limited in that they only allow
for two distinct hcalls; with the x0 register either zero or not zero.  Also,
the API of the hyp-stub exception vector routines and the KVM exception vector
routines differ; hyp-stub uses a non-zero value in x0 to implement
__hyp_set_vectors, whereas KVM uses it to implement kvm_call_hyp.

To allow for additional hcalls to be defined and to make the arm64 hcall API
more consistent across exception vector routines, change the hcall
implementations to use the 16 bit immediate value of the HVC instruction to
specify the hcall type.

Define three new preprocessor macros HVC_CALL_HYP, HVC_GET_VECTORS, and
HVC_SET_VECTORS to be used as hcall type specifiers and convert the
existing __hyp_get_vectors(), __hyp_set_vectors() and kvm_call_hyp() routines
to use these new macros when executing an HVC call.  Also, change the
corresponding hyp-stub and KVM el1_sync exception vector routines to use these
new macros.

Signed-off-by: Geoff Levand <geoff@infradead.org>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/virt.h | 27 +++++++++++++++++++++++++++
 arch/arm64/kernel/hyp-stub.S  | 32 +++++++++++++++++++++-----------
 arch/arm64/kvm/hyp.S          | 16 +++++++++-------
 3 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 7a5df5252dd7..eb10368c329e 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -18,6 +18,33 @@
 #ifndef __ASM__VIRT_H
 #define __ASM__VIRT_H
 
+/*
+ * The arm64 hcall implementation uses the ISS field of the ESR_EL2 register to
+ * specify the hcall type.  The exception handlers are allowed to use registers
+ * x17 and x18 in their implementation.  Any routine issuing an hcall must not
+ * expect these registers to be preserved.
+ */
+
+/*
+ * HVC_CALL_HYP - Execute a hyp routine.
+ */
+
+#define HVC_CALL_HYP 0
+
+/*
+ * HVC_GET_VECTORS - Return the value of the vbar_el2 register.
+ */
+
+#define HVC_GET_VECTORS 1
+
+/*
+ * HVC_SET_VECTORS - Set the value of the vbar_el2 register.
+ *
+ * @x0: Physical address of the new vector table.
+ */
+
+#define HVC_SET_VECTORS 2
+
 #define BOOT_CPU_MODE_EL1	(0xe11)
 #define BOOT_CPU_MODE_EL2	(0xe12)
 
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index a272f335c289..017ab519aaf1 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -22,6 +22,7 @@
 #include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/assembler.h>
+#include <asm/kvm_arm.h>
 #include <asm/ptrace.h>
 #include <asm/virt.h>
 
@@ -53,14 +54,22 @@ ENDPROC(__hyp_stub_vectors)
 	.align 11
 
 el1_sync:
-	mrs	x1, esr_el2
-	lsr	x1, x1, #26
-	cmp	x1, #0x16
+	mrs	x18, esr_el2
+	lsr	x17, x18, #ESR_ELx_EC_SHIFT
+	and	x18, x18, #ESR_ELx_ISS_MASK
+
+	cmp	x17, #ESR_ELx_EC_HVC64
 	b.ne	2f				// Not an HVC trap
-	cbz	x0, 1f
-	msr	vbar_el2, x0			// Set vbar_el2
+
+	cmp	x18, #HVC_GET_VECTORS
+	b.ne	1f
+	mrs	x0, vbar_el2
 	b	2f
-1:	mrs	x0, vbar_el2			// Return vbar_el2
+
+1:	cmp	x18, #HVC_SET_VECTORS
+	b.ne	2f
+	msr	vbar_el2, x0
+
 2:	eret
 ENDPROC(el1_sync)
 
@@ -100,11 +109,12 @@ ENDPROC(\label)
  * initialisation entry point.
  */
 
-ENTRY(__hyp_get_vectors)
-	mov	x0, xzr
-	// fall through
 ENTRY(__hyp_set_vectors)
-	hvc	#0
+	hvc	#HVC_SET_VECTORS
 	ret
-ENDPROC(__hyp_get_vectors)
 ENDPROC(__hyp_set_vectors)
+
+ENTRY(__hyp_get_vectors)
+	hvc	#HVC_GET_VECTORS
+	ret
+ENDPROC(__hyp_get_vectors)
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index e5836138ec42..073b8bf3daf7 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -29,6 +29,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/memory.h>
+#include <asm/virt.h>
 
 #define CPU_GP_REG_OFFSET(x)	(CPU_GP_REGS + x)
 #define CPU_XREG_OFFSET(x)	CPU_GP_REG_OFFSET(CPU_USER_PT_REGS + 8*x)
@@ -924,12 +925,9 @@ __hyp_panic_str:
  * in Hyp mode (see init_hyp_mode in arch/arm/kvm/arm.c).  Return values are
  * passed in r0 and r1.
  *
- * A function pointer with a value of 0 has a special meaning, and is
- * used to implement __hyp_get_vectors in the same way as in
- * arch/arm64/kernel/hyp_stub.S.
  */
 ENTRY(kvm_call_hyp)
-	hvc	#0
+	hvc	#HVC_CALL_HYP
 	ret
 ENDPROC(kvm_call_hyp)
 
@@ -960,6 +958,7 @@ el1_sync:					// Guest trapped into EL2
 
 	mrs	x1, esr_el2
 	lsr	x2, x1, #ESR_ELx_EC_SHIFT
+	and	x0, x1, #ESR_ELx_ISS_MASK
 
 	cmp	x2, #ESR_ELx_EC_HVC64
 	b.ne	el1_trap
@@ -968,15 +967,18 @@ el1_sync:					// Guest trapped into EL2
 	cbnz	x3, el1_trap			// called HVC
 
 	/* Here, we're pretty sure the host called HVC. */
+	mov	x18, x0
 	pop	x2, x3
 	pop	x0, x1
 
-	/* Check for __hyp_get_vectors */
-	cbnz	x0, 1f
+	cmp	x18, #HVC_GET_VECTORS
+	b.ne	1f
 	mrs	x0, vbar_el2
 	b	2f
 
-1:	push	lr, xzr
+1:	/* Default to HVC_CALL_HYP. */
+
+	push	lr, xzr
 
 	/*
 	 * Compute the function address in EL2, and shuffle the parameters.
-- 
2.1.4


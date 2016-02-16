From: James Morse <james.morse@arm.com>
Subject: [PATCH v5 02/15] arm64: Cleanup SCTLR flags
Date: Tue, 16 Feb 2016 15:49:14 +0000
Message-ID: <1455637767-31561-3-git-send-email-james.morse@arm.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54446 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755422AbcBPPvZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Feb 2016 10:51:25 -0500
In-Reply-To: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

From: Geoff Levand <geoff@infradead.org>

We currently have macros defining flags for the arm64 sctlr registers in
both kvm_arm.h and sysreg.h.  To clean things up and simplify move the
definitions of the SCTLR_EL2 flags from kvm_arm.h to sysreg.h, rename any
SCTLR_EL1 or SCTLR_EL2 flags that are common to both registers to be
SCTLR_ELx, with 'x' indicating a common flag, and fixup all files to
include the proper header or to use the new macro names.

Signed-off-by: Geoff Levand <geoff@infradead.org>
[Restored pgtable-hwdef.h include]
Signed-off-by: James Morse <james.morse@arm.com>
---
This patch comes from v13 of kexec

 arch/arm64/include/asm/kvm_arm.h | 11 -----------
 arch/arm64/include/asm/sysreg.h  | 19 +++++++++++++++----
 arch/arm64/kvm/hyp-init.S        |  5 +++--
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index bef6e9243c63..9e1c0e7b0b73 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -83,17 +83,6 @@
 #define HCR_INT_OVERRIDE   (HCR_FMO | HCR_IMO)
 
 
-/* Hyp System Control Register (SCTLR_EL2) bits */
-#define SCTLR_EL2_EE	(1 << 25)
-#define SCTLR_EL2_WXN	(1 << 19)
-#define SCTLR_EL2_I	(1 << 12)
-#define SCTLR_EL2_SA	(1 << 3)
-#define SCTLR_EL2_C	(1 << 2)
-#define SCTLR_EL2_A	(1 << 1)
-#define SCTLR_EL2_M	1
-#define SCTLR_EL2_FLAGS	(SCTLR_EL2_M | SCTLR_EL2_A | SCTLR_EL2_C |	\
-			 SCTLR_EL2_SA | SCTLR_EL2_I)
-
 /* TCR_EL2 Registers bits */
 #define TCR_EL2_RES1	((1 << 31) | (1 << 23))
 #define TCR_EL2_TBI	(1 << 20)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4aeebec3d882..99dac2f9f21a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -82,10 +82,21 @@
 #define SET_PSTATE_PAN(x) __inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
 				     (!!x)<<8 | 0x1f)
 
-/* SCTLR_EL1 */
-#define SCTLR_EL1_CP15BEN	(0x1 << 5)
-#define SCTLR_EL1_SED		(0x1 << 8)
-#define SCTLR_EL1_SPAN		(0x1 << 23)
+/* Common SCTLR_ELx flags. */
+#define SCTLR_ELx_EE    (1 << 25)
+#define SCTLR_ELx_I	(1 << 12)
+#define SCTLR_ELx_SA	(1 << 3)
+#define SCTLR_ELx_C	(1 << 2)
+#define SCTLR_ELx_A	(1 << 1)
+#define SCTLR_ELx_M	1
+
+#define SCTLR_ELx_FLAGS	(SCTLR_ELx_M | SCTLR_ELx_A | SCTLR_ELx_C | \
+			 SCTLR_ELx_SA | SCTLR_ELx_I)
+
+/* SCTLR_EL1 specific flags. */
+#define SCTLR_EL1_SPAN		(1 << 23)
+#define SCTLR_EL1_SED		(1 << 8)
+#define SCTLR_EL1_CP15BEN	(1 << 5)
 
 
 /* id_aa64isar0 */
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 3e568dcd907b..dc6335a7353e 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -21,6 +21,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/pgtable-hwdef.h>
+#include <asm/sysreg.h>
 
 	.text
 	.pushsection	.hyp.idmap.text, "ax"
@@ -114,8 +115,8 @@ __do_hyp_init:
 	dsb	sy
 
 	mrs	x4, sctlr_el2
-	and	x4, x4, #SCTLR_EL2_EE	// preserve endianness of EL2
-	ldr	x5, =SCTLR_EL2_FLAGS
+	and	x4, x4, #SCTLR_ELx_EE	// preserve endianness of EL2
+	ldr	x5, =SCTLR_ELx_FLAGS
 	orr	x4, x4, x5
 	msr	sctlr_el2, x4
 	isb
-- 
2.6.2


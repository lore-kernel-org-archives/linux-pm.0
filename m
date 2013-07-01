From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RFC/PATCH 1/2] ARM: feroceon: Add suspend/resume operation
Date: Mon,  1 Jul 2013 19:47:28 -0300
Message-ID: <1372718849-2912-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1372718849-2912-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:43517 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601Ab3GAWrk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2013 18:47:40 -0400
In-Reply-To: <1372718849-2912-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Simon Guinot <sguinot@lacie.com>, Russell King <linux@arm.linux.org.uk>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Assaf Hoffman <hoffman@marvell.com>

Add support for suspend/resume operations. The implemented procedures
are identical to the ones for ARM926.

Cc: Assaf Hoffman <hoffman@marvell.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/Kconfig            |  2 +-
 arch/arm/mm/proc-feroceon.S | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2651b1d..a35287b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2207,7 +2207,7 @@ source "kernel/power/Kconfig"
 
 config ARCH_SUSPEND_POSSIBLE
 	depends on !ARCH_S5PC100
-	depends on CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || \
+	depends on CPU_ARM920T || CPU_ARM926T || CPU_FEROCEON || CPU_SA1100 || \
 		CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE || CPU_MOHAWK
 	def_bool y
 
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index 4106b09..ac9201c 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -514,6 +514,32 @@ ENTRY(cpu_feroceon_set_pte_ext)
 #endif
 	mov	pc, lr
 
+/* Suspend/resume support: taken from arch/arm/mm/proc-arm926.S */
+.globl	cpu_feroceon_suspend_size
+.equ	cpu_feroceon_suspend_size, 4 * 3
+#ifdef CONFIG_ARM_CPU_SUSPEND
+ENTRY(cpu_feroceon_do_suspend)
+	stmfd	sp!, {r4 - r6, lr}
+	mrc	p15, 0, r4, c13, c0, 0	@ PID
+	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
+	mrc	p15, 0, r6, c1, c0, 0	@ Control register
+	stmia	r0, {r4 - r6}
+	ldmfd	sp!, {r4 - r6, pc}
+ENDPROC(cpu_feroceon_do_suspend)
+
+ENTRY(cpu_feroceon_do_resume)
+	mov	ip, #0
+	mcr	p15, 0, ip, c8, c7, 0	@ invalidate I+D TLBs
+	mcr	p15, 0, ip, c7, c7, 0	@ invalidate I+D caches
+	ldmia	r0, {r4 - r6}
+	mcr	p15, 0, r4, c13, c0, 0	@ PID
+	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
+	mcr	p15, 0, r1, c2, c0, 0	@ TTB address
+	mov	r0, r6			@ control register
+	b	cpu_resume_mmu
+ENDPROC(cpu_feroceon_do_resume)
+#endif
+
 	__CPUINIT
 
 	.type	__feroceon_setup, #function
-- 
1.8.1.5


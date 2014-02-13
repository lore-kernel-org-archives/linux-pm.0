From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 04/13] ARM: mvebu: Remove the unused argument of set_cpu_coherent()
Date: Thu, 13 Feb 2014 18:33:27 +0100
Message-ID: <1392312816-17657-5-git-send-email-gregory.clement@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51885 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752640AbaBMReD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2014 12:34:03 -0500
In-Reply-To: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

set_cpu_coherent() took the SMP group ID as parameter. But this
parameter was never used, and the CPU always use the SMP group 0. So
we can remove this parameter.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c    |  8 ++---
 arch/arm/mach-mvebu/coherency.h    |  2 +-
 arch/arm/mach-mvebu/coherency_ll.S | 61 ++++++++++++++++++++++++--------------
 arch/arm/mach-mvebu/headsmp.S      |  4 +--
 arch/arm/mach-mvebu/platsmp.c      |  2 +-
 5 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 51010dbbf7e4..931c62be2bce 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -44,9 +44,9 @@ static struct of_device_id of_coherency_table[] = {
 };
 
 /* Function defined in coherency_ll.S */
-int ll_set_cpu_coherent(void);
+int ll_set_cpu_coherent_and_smp(void);
 
-int set_cpu_coherent(int smp_group_id)
+int set_cpu_coherent(void)
 {
 	if (!coherency_base) {
 		pr_warn("Can't make current CPU cache coherent.\n");
@@ -54,7 +54,7 @@ int set_cpu_coherent(int smp_group_id)
 		return 1;
 	}
 
-	return ll_set_cpu_coherent();
+	return ll_set_cpu_coherent_and_smp();
 }
 
 static inline void mvebu_hwcc_sync_io_barrier(void)
@@ -140,7 +140,7 @@ int __init coherency_init(void)
 		sync_cache_w(&coherency_phys_base);
 		coherency_base = of_iomap(np, 0);
 		coherency_cpu_base = of_iomap(np, 1);
-		set_cpu_coherent(0);
+		set_cpu_coherent();
 		of_node_put(np);
 	}
 
diff --git a/arch/arm/mach-mvebu/coherency.h b/arch/arm/mach-mvebu/coherency.h
index c7e5df368d98..dff16612dd93 100644
--- a/arch/arm/mach-mvebu/coherency.h
+++ b/arch/arm/mach-mvebu/coherency.h
@@ -15,8 +15,8 @@
 #define __MACH_370_XP_COHERENCY_H
 
 extern unsigned long coherency_phys_base;
+int set_cpu_coherent(void);
 
-int set_cpu_coherent(int smp_group_id);
 int coherency_init(void);
 
 #endif	/* __MACH_370_XP_COHERENCY_H */
diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index 6cb26b919787..7b42b4b08a80 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -25,52 +25,67 @@
 
 	.text
 
-ENTRY(ll_set_cpu_coherent)
+	.macro modify_coherent_reg join_smp
 	mrc	p15, 0, r1, c1, c0, 0
 	tst	r1, #CR_M @ Check MMU bit enabled
 	bne	1f
 
-	/* use physical address of the coherency register*/
-	adr	r0, 3f
-	ldr	r3, [r0]
-	ldr	r0, [r0, r3]
+	/* use physical address of the coherency register */
+	adr	r1, 3f
+	ldr	r3, [r1]
+	ldr	r1, [r1, r3]
 	b	2f
 1:
-	/* use virtual address of the coherency register*/
-	ldr	r0, =coherency_base
-	ldr	r0, [r0]
+	/* use virtual address of the coherency register */
+	ldr	r1, =coherency_base
+	ldr	r1, [r1]
 2:
 	/* Create bit by cpu index */
-	mrc	15, 0, r1, cr0, cr0, 5
-	and	r1, r1, #15
+	mrc	15, 0, r3, cr0, cr0, 5
+	and	r3, r3, #15
 	mov	r2, #(1 << 24)
-	lsl	r1, r2, r1
-	ARM_BE8(rev	r1, r1)
+	lsl	r3, r2, r3
+	ARM_BE8(rev	r3, r3)
 
-	/* Add CPU to SMP group - Atomic */
-	add	r3, r0, #ARMADA_XP_CFB_CTL_REG_OFFSET
+	.if \join_smp == 1
+	/* Add CPU to SMP group - Atomic (only if the flag is set) */
+	add	r0, r1, #ARMADA_XP_CFB_CFG_REG_OFFSET
 1:
-	ldrex	r2, [r3]
-	orr	r2, r2, r1
-	strex 	r0, r2, [r3]
-	cmp	r0, #0
+	ldrex	r2, [r0]
+	orr	r2, r2, r3
+	strex 	r1, r2, [r0]
+	cmp	r1, #0
 	bne 1b
 
+	/* get back to the base register */
+	sub	r1, r0, #ARMADA_XP_CFB_CFG_REG_OFFSET
+	.endif
+
 	/* Enable coherency on CPU - Atomic */
-	add	r3, r3, #ARMADA_XP_CFB_CFG_REG_OFFSET
+	add	r0, r1, #ARMADA_XP_CFB_CTL_REG_OFFSET
 1:
-	ldrex	r2, [r3]
-	orr	r2, r2, r1
-	strex	r0, r2, [r3]
-	cmp	r0, #0
+	ldrex	r2, [r0]
+	orr	r2, r2, r3
+	strex	r1, r2, [r0]
+	cmp	r1, #0
 	bne 1b
 
 	dsb
 
 	mov	r0, #0
 	mov	pc, lr
+	.endm
+
+/*  Enable coherency on CPU */
+ENTRY(ll_set_cpu_coherent)
+	modify_coherent_reg join_smp = 0
 ENDPROC(ll_set_cpu_coherent)
 
+/* Add CPU to SMP group */
+ENTRY(ll_set_cpu_coherent_and_smp)
+	modify_coherent_reg join_smp = 1
+ENDPROC(ll_set_cpu_coherent_and_smp)
+
 	.align 2
 3:
 	.long	coherency_phys_base - .
diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
index cf7abe6554f7..924fb96775c5 100644
--- a/arch/arm/mach-mvebu/headsmp.S
+++ b/arch/arm/mach-mvebu/headsmp.S
@@ -31,8 +31,8 @@
 ENTRY(armada_xp_secondary_startup)
  ARM_BE8(setend	be )			@ go BE8 if entered LE
 
-	/* Add CPU to coherency fabric */
-	bl	ll_set_cpu_coherent
+	bl	ll_set_cpu_coherent_and_smp
+
 	b	secondary_startup
 
 ENDPROC(armada_xp_secondary_startup)
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index a99d71a747f0..f2f1830063c8 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -102,7 +102,7 @@ static void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
 
 	set_secondary_cpus_clock();
 	flush_cache_all();
-	set_cpu_coherent(0);
+	set_cpu_coherent();
 
 	/*
 	 * In order to boot the secondary CPUs we need to ensure
-- 
1.8.1.2


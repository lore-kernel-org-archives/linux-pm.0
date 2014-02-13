From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 05/13] ARM: mvebu: Low level function to disable HW coherency support
Date: Thu, 13 Feb 2014 18:33:28 +0100
Message-ID: <1392312816-17657-6-git-send-email-gregory.clement@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51889 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752638AbaBMReE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2014 12:34:04 -0500
In-Reply-To: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

When going to deep idle we need to disable the SoC snooping (aka
hardware coherency support). Playing with the coherency fabric
requires to use assembly code to be sure that the compiler doesn't
reorder the instructions nor do wrong optimization.

This commit extends the modify_coherent_reg macro in order to manage
enabling (setting a bit) and disabling (clearing the same bit) the
hardware coherency support.

This function will be called by the low level (in assembly) part of
the CPU idle functions.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency_ll.S | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index 7b42b4b08a80..686aba2adfc7 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -25,7 +25,7 @@
 
 	.text
 
-	.macro modify_coherent_reg join_smp
+	.macro modify_coherent_reg join_smp clear_coherency
 	mrc	p15, 0, r1, c1, c0, 0
 	tst	r1, #CR_M @ Check MMU bit enabled
 	bne	1f
@@ -61,11 +61,19 @@
 	sub	r1, r0, #ARMADA_XP_CFB_CFG_REG_OFFSET
 	.endif
 
-	/* Enable coherency on CPU - Atomic */
+	/*
+	 * Enable coherency on CPU - Atomic (or disable depending of
+	 * the clear_coherency flag)
+	 */
 	add	r0, r1, #ARMADA_XP_CFB_CTL_REG_OFFSET
+
 1:
 	ldrex	r2, [r0]
+	.if \clear_coherency == 1
+	bic	r2, r2, r3
+	.else
 	orr	r2, r2, r3
+	.endif
 	strex	r1, r2, [r0]
 	cmp	r1, #0
 	bne 1b
@@ -78,12 +86,17 @@
 
 /*  Enable coherency on CPU */
 ENTRY(ll_set_cpu_coherent)
-	modify_coherent_reg join_smp = 0
+	modify_coherent_reg join_smp = 0, clear_coherency = 0
 ENDPROC(ll_set_cpu_coherent)
 
+/*  Disable coherency on CPU */
+ENTRY(ll_clear_cpu_coherent)
+	modify_coherent_reg join_smp = 0, clear_coherency = 1
+ENDPROC(ll_clear_cpu_coherent)
+
 /* Add CPU to SMP group */
 ENTRY(ll_set_cpu_coherent_and_smp)
-	modify_coherent_reg join_smp = 1
+	modify_coherent_reg join_smp = 1, clear_coherency = 0
 ENDPROC(ll_set_cpu_coherent_and_smp)
 
 	.align 2
-- 
1.8.1.2


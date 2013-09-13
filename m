From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 01/12] ARM: PJ4B: Add cpu_suspend/cpu_resume hooks for PJ4B
Date: Fri, 13 Sep 2013 12:06:30 +0200
Message-ID: <1379066801-16276-2-git-send-email-gregory.clement@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44122 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755160Ab3IMKGv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 06:06:51 -0400
In-Reply-To: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Chris Van Hoof <vanhoof@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Atsushi Yamagata <yamagata@plathome.co.jp>, Hironobu Shibata <h-shibata@plathome.co.jp>, Tomonori Kimura <kimura@plathome.co.jp>

PJ4B needs extra instructions for suspend and resume, so instead of
using the armv7 version, this commit introduces specific versions for
PJ4B.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mm/proc-v7.S | 64 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index c63d9bd..b14801b 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -162,9 +162,67 @@ ENDPROC(cpu_pj4b_do_idle)
 	globl_equ	cpu_pj4b_do_idle,  	cpu_v7_do_idle
 #endif
 	globl_equ	cpu_pj4b_dcache_clean_area,	cpu_v7_dcache_clean_area
-	globl_equ	cpu_pj4b_do_suspend,	cpu_v7_do_suspend
-	globl_equ	cpu_pj4b_do_resume,	cpu_v7_do_resume
-	globl_equ	cpu_pj4b_suspend_size,	cpu_v7_suspend_size
+#ifdef CONFIG_ARM_CPU_SUSPEND
+ENTRY(cpu_pj4b_do_suspend)
+	stmfd	sp!, {r4 - r10, lr}
+	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
+	mrc	p15, 0, r5, c13, c0, 3	@ User r/o thread ID
+	stmia	r0!, {r4 - r5}
+	mrc	p15, 1, r6, c15, c1, 0  @ save CP15 - extra features
+	mrc	p15, 1, r7, c15, c2, 0	@ save CP15 - Aux Func Modes Ctrl 0
+	mrc	p15, 1, r8, c15, c1, 2	@ save CP15 - Aux Debug Modes Ctrl 2
+	mrc	p15, 1, r9, c15, c1, 1  @ save CP15 - Aux Debug Modes Ctrl 1
+	mrc	p15, 0, r10, c9, c14, 0  @ save CP15 - PMC
+	stmia	r0!, {r6 - r10}
+	mrc	p15, 0, r6, c3, c0, 0	@ Domain ID
+	mrc	p15, 0, r7, c2, c0, 1	@ TTB 1
+	mrc	p15, 0, r11, c2, c0, 2	@ TTB control register
+	mrc	p15, 0, r8, c1, c0, 0	@ Control register
+	mrc	p15, 0, r9, c1, c0, 1	@ Auxiliary control register
+	mrc	p15, 0, r10, c1, c0, 2	@ Co-processor access control
+	stmia	r0, {r6 - r11}
+	ldmfd	sp!, {r4 - r10, pc}
+ENDPROC(cpu_pj4b_do_suspend)
+
+ENTRY(cpu_pj4b_do_resume)
+	mov	ip, #0
+	mcr	p15, 0, ip, c7, c5, 0	@ invalidate I cache
+	mcr	p15, 0, ip, c13, c0, 1	@ set reserved context ID
+	ldmia	r0!, {r4 - r5}
+	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
+	mcr	p15, 0, r5, c13, c0, 3	@ User r/o thread ID
+	ldmia	r0!, {r6 - r10}
+	mcr	p15, 1, r6, c15, c1, 0  @ save CP15 - extra features
+	mcr	p15, 1, r7, c15, c2, 0	@ save CP15 - Aux Func Modes Ctrl 0
+	mcr	p15, 1, r8, c15, c1, 2	@ save CP15 - Aux Debug Modes Ctrl 2
+	mcr	p15, 1, r9, c15, c1, 1  @ save CP15 - Aux Debug Modes Ctrl 1
+	mcr	p15, 0, r10, c9, c14, 0  @ save CP15 - PMC
+	ldmia	r0, {r6 - r11}
+	mcr	p15, 0, ip, c8, c7, 0	@ invalidate TLBs
+	mcr	p15, 0, r6, c3, c0, 0	@ Domain ID
+#ifndef CONFIG_ARM_LPAE
+	ALT_SMP(orr	r1, r1, #TTB_FLAGS_SMP)
+	ALT_UP(orr	r1, r1, #TTB_FLAGS_UP)
+#endif
+	mcr	p15, 0, r1, c2, c0, 0	@ TTB 0
+	mcr	p15, 0, r7, c2, c0, 1	@ TTB 1
+	mcr	p15, 0, r11, c2, c0, 2	@ TTB control register
+	ldr	r4, =PRRR		@ PRRR
+	ldr	r5, =NMRR		@ NMRR
+	mcr	p15, 0, r4, c10, c2, 0	@ write PRRR
+	mcr	p15, 0, r5, c10, c2, 1	@ write NMRR
+	mrc	p15, 0, r4, c1, c0, 1	@ Read Auxiliary control register
+	teq	r4, r9			@ Is it already set?
+	mcrne	p15, 0, r9, c1, c0, 1	@ No, so write it
+	mcr	p15, 0, r10, c1, c0, 2	@ Co-processor access control
+	isb
+	dsb
+	mov	r0, r8			@ control register
+	b	cpu_resume_mmu
+ENDPROC(cpu_pj4b_do_resume)
+#endif
+.globl	cpu_pj4b_suspend_size
+.equ	cpu_pj4b_suspend_size, 4 * 13
 
 #endif
 
-- 
1.8.1.2


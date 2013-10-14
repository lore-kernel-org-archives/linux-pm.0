From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 11/14] ARM: mvebu: Add CPU idle low level support for Marvell Armada XP
Date: Mon, 14 Oct 2013 15:58:23 +0200
Message-ID: <1381759106-15004-12-git-send-email-gregory.clement@free-electrons.com>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60851 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756642Ab3JNN66 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 09:58:58 -0400
In-Reply-To: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>

This commit adds the low level implementation of CPU Idle.
Currently only Armada XP is supported, but the support
will be extended for Armada 370.

Based on the work of Nadav Haklai.

Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/Makefile                |  1 +
 arch/arm/mach-mvebu/suspend-armada-370-xp.S | 90 +++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 arch/arm/mach-mvebu/suspend-armada-370-xp.S

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 2d04f0e..9cd2705 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
 obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
+obj-$(CONFIG_ARM_ARMADA_370_XP_CPUIDLE) += suspend-armada-370-xp.o
diff --git a/arch/arm/mach-mvebu/suspend-armada-370-xp.S b/arch/arm/mach-mvebu/suspend-armada-370-xp.S
new file mode 100644
index 0000000..5f01a68
--- /dev/null
+++ b/arch/arm/mach-mvebu/suspend-armada-370-xp.S
@@ -0,0 +1,90 @@
+/*
+ * CPU idle low level implementation for Marvell Armada 370 and Armada XP SoCs
+ *
+ * Copyright (C) 2013 Marvell
+ *
+ * Nadav Haklai <nadavh@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ */
+#include <linux/linkage.h>
+
+/*
+* armadaxp_cpu_suspend: enter cpu deepIdle state
+* input:
+*/
+ENTRY(armada_370_xp_cpu_suspend)
+/* Save ARM registers */
+	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
+
+	bl armada_370_xp_pmsu_idle_prepare
+	/*
+	 * Invalidate L1 data cache. Even though only invalidate is
+	 * necessary exported flush API is used here. Doing clean
+	 * on already clean cache would be almost NOP.
+	 */
+	bl v7_flush_dcache_all
+
+	/*
+	 * Clear the SCTLR.C bit to prevent further data cache
+	 * allocation. Clearing SCTLR.C would make all the data accesses
+	 * strongly ordered and would not hit the cache.
+	 */
+	mrc	p15, 0, r0, c1, c0, 0
+	bic	r0, r0, #(1 << 2)	@ Disable the C bit
+	mcr	p15, 0, r0, c1, c0, 0
+	isb
+
+	bl v7_flush_dcache_all
+
+	/* Data memory barrier and Data sync barrier */
+	dsb
+	dmb
+
+	bl armada_370_xp_disable_snoop_ena
+
+	dsb				@ Data Synchronization Barrier
+
+/*
+ * ===================================
+ * == WFI instruction => Enter idle ==
+ * ===================================
+ */
+
+	wfi				@ wait for interrupt
+/*
+ * ===================================
+ * == Resume path for non-OFF modes ==
+ * ===================================
+ */
+
+/* Enable SnoopEna - Exclusive */
+	mov	r0, #1			@ r0!=0 means use virtual address
+	mov	r1, #0			@ Do not add CPU to SMP group
+	bl ll_set_cpu_coherent
+
+/* Re-enable C-bit if needed */
+	mrc	p15, 0, r0, c1, c0, 0
+	tst	r0, #(1 << 2)		@ Check C bit enabled?
+	orreq	r0, r0, #(1 << 2)	@ Enable the C bit if cleared
+	mcreq	p15, 0, r0, c1, c0, 0
+	isb
+
+	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
+ENDPROC(armada_370_xp_cpu_suspend)
+
+/*
+* armada_370_xp_cpu_resume: exit cpu deepIdle state
+*/
+ENTRY(armada_370_xp_cpu_resume)
+	mov	r0, #0			@ r0==0 means use physical address
+	mov	r1, #1			@ Add CPU to SMP group
+	bl ll_set_cpu_coherent
+
+	/* Now branch to the common CPU resume function */
+	b	cpu_resume
+
+ENDPROC(armada_370_xp_cpu_resume)
-- 
1.8.1.2


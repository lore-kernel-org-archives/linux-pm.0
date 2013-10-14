From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 05/14] ARM: mvebu: Make ll_set_cpu_coherent() more configurable
Date: Mon, 14 Oct 2013 15:58:17 +0200
Message-ID: <1381759106-15004-6-git-send-email-gregory.clement@free-electrons.com>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60790 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756684Ab3JNN6s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 09:58:48 -0400
In-Reply-To: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>

ll_set_cpu_coherent does two things to set the coherency for a CPU:

- Adding the CPU to the SMP group 0
- Enabling the snooping on the CPU

Only the second part is needed when coming back from a CPU Idle. This
commit allows to choose to do the first part or not.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c    |  4 ++--
 arch/arm/mach-mvebu/coherency_ll.S | 30 ++++++++++++++++++------------
 arch/arm/mach-mvebu/headsmp.S      |  3 +++
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 8c9e84d..e09bdfd 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -43,7 +43,7 @@ static struct of_device_id of_coherency_table[] = {
 };
 
 /* Function defined in coherency_ll.S */
-int ll_set_cpu_coherent(bool use_virt_addr);
+int ll_set_cpu_coherent(bool use_virt_addr, bool use_smp_group);
 
 int set_cpu_coherent(void)
 {
@@ -53,7 +53,7 @@ int set_cpu_coherent(void)
 		return 1;
 	}
 
-	return ll_set_cpu_coherent(true);
+	return ll_set_cpu_coherent(true, true);
 }
 
 static inline void mvebu_hwcc_sync_io_barrier(void)
diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index fc2e6f7..1526b94 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -22,7 +22,8 @@
 
 	.text
 /*
- * r0: if r0==0 => physical addres, else virtual address
+ * r0: Use virtual address if r0 != 0, else physical address
+ * r1: Add CPU to the SMP group if r1 != 0
  */
 ENTRY(ll_set_cpu_coherent)
 	cmp	r0, #0
@@ -38,26 +39,31 @@ ENTRY(ll_set_cpu_coherent)
 	ldr	r0, [r0]
 2:
 	/* Create bit by cpu index */
-	mrc	15, 0, r1, cr0, cr0, 5
-	and	r1, r1, #15
+	mrc	15, 0, r3, cr0, cr0, 5
+	and	r3, r3, #15
 	mov	r2, #(1 << 24)
-	lsl	r1, r2, r1
+	lsl	r3, r2, r3
+
+	/* If r1=!0 then just enable the snooping */
+	cmp	r1, #0
+	beq	2f
 
 	/* Add CPU to SMP group - Atomic */
-	add	r3, r0, #ARMADA_XP_CFB_CTL_REG_OFFSET
+	add	r1, r0, #ARMADA_XP_CFB_CTL_REG_OFFSET
 1:
-	ldrex	r2, [r3]
-	orr	r2, r2, r1
-	strex 	r0, r2, [r3]
+	ldrex	r2, [r1]
+	orr	r2, r2, r3
+	strex 	r0, r2, [r1]
 	cmp	r0, #0
 	bne 1b
 
+2:
 	/* Enable coherency on CPU - Atomic */
-	add	r3, r3, #ARMADA_XP_CFB_CFG_REG_OFFSET
+	add	r1, r1, #ARMADA_XP_CFB_CFG_REG_OFFSET
 1:
-	ldrex	r2, [r3]
-	orr	r2, r2, r1
-	strex	r0, r2, [r3]
+	ldrex	r2, [r1]
+	orr	r2, r2, r3
+	strex	r0, r2, [r1]
 	cmp	r0, #0
 	bne 1b
 
diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
index b2c6e95..f2732c8 100644
--- a/arch/arm/mach-mvebu/headsmp.S
+++ b/arch/arm/mach-mvebu/headsmp.S
@@ -30,6 +30,9 @@ ENTRY(armada_xp_secondary_startup)
 	/* Use physical addrss */
 	mov	r0, #0
 
+	/* Add CPU to the SMP group*/
+	mov	r1, #1
+
 	/* Add CPU to coherency fabric */
 	bl	ll_set_cpu_coherent
 	b	secondary_startup
-- 
1.8.1.2


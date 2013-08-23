From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 06/12] ARM: mvebu: Low level functions to disbale cache snooping
Date: Fri, 23 Aug 2013 08:53:11 +0200
Message-ID: <1377240797-4047-7-git-send-email-gregory.clement@free-electrons.com>
References: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47872 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754869Ab3HWGxk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2013 02:53:40 -0400
In-Reply-To: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Chris Van Hoof <vanhoof@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Atsushi Yamagata <yamagata@plathome.co.jp>, Hironobu Shibata <h-shibata@plathome.co.jp>, Tomonori Kimura <kimura@plathome.co.jp>

When going to deep idle we need to disable the SoC snooping by
"hand". Playing with the coherency fabric requires to use assembly
code to be sure that the compiler doesn't reorder the instructions nor
do wrong optimization.

This function will be called by the low level (in assembly) part of
the CPU idle functions.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency_ll.S | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index 1526b94..3fb426e 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -73,6 +73,28 @@ ENTRY(ll_set_cpu_coherent)
 	mov	pc, lr
 ENDPROC(ll_set_cpu_coherent)
 
+/*
+ * r0: if r0==0 => physical addres, else virtual address
+ */
+ENTRY(armada_370_xp_disable_snoop_ena)
+	ldr	r0, =(coherency_base)
+	ldr	r0, [r0]
+	/* Enable SnoopEna - Exclusive */
+	mrc	15, 0, r1, cr0, cr0, 5
+	and	r1, r1, #15
+	mov	r2, #(1 << 24)
+	lsl	r2, r2, r1
+
+1:
+	ldrex	r1, [r0]
+	bic	r1, r1, r2
+	strex	r3, r1, [r0]
+	cmp	r3, #0
+	bne 1b
+
+	mov pc, lr
+ENDPROC(armada_370_xp_disable_snoop_ena)
+
 	.align 2
 3:
-	.long	coherency_phys_base - .
+		.long	coherency_phys_base - .
-- 
1.8.1.2


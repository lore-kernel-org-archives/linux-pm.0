From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 3/4] ARM: mvebu: Allow using the GIC for wakeup in standby mode
Date: Tue, 30 Jun 2015 19:18:59 +0200
Message-ID: <1435684740-24912-4-git-send-email-gregory.clement@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:50951 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752159AbbF3RUe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 13:20:34 -0400
In-Reply-To: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On the Armada 375/38x/39x SoCs, in standby mode the SoCs stay powered
and it is possible to wake-up from any interrupt sources. This patch
adds flag to the GIC irqchip driver to let linux know this.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index e5911defccac..f446230e7416 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
+#include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
 #include <linux/dma-mapping.h>
@@ -26,6 +27,7 @@
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -129,6 +131,11 @@ static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
 
 static void __init mvebu_init_irq(void)
 {
+	if (of_machine_is_compatible("marvell,armada375") ||
+	    of_machine_is_compatible("marvell,armada380") ||
+	    of_machine_is_compatible("marvell,armada390"))
+		gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE |
+				      IRQCHIP_MASK_ON_SUSPEND);
 	irqchip_init();
 	mvebu_scu_enable();
 	coherency_init();
-- 
2.1.0


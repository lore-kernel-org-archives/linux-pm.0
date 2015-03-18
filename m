From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/7] irqchip: renesas-irqc: Add more register documentation
Date: Wed, 18 Mar 2015 19:55:55 +0100
Message-ID: <1426704961-27322-2-git-send-email-geert+renesas@glider.be>
References: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:35559 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933161AbbCRS4E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 14:56:04 -0400
In-Reply-To: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-irqc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 2ea3412fdf8cc668..2ce2edf8ec8ec182 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -30,14 +30,24 @@
 #include <linux/module.h>
 #include <linux/platform_data/irq-renesas-irqc.h>
 
-#define IRQC_IRQ_MAX 32 /* maximum 32 interrupts per driver instance */
+#define IRQC_IRQ_MAX	32	/* maximum 32 interrupts per driver instance */
 
-#define IRQC_REQ_STS 0x00
-#define IRQC_EN_STS 0x04
-#define IRQC_EN_SET 0x08
+#define IRQC_REQ_STS	0x00	/* Interrupt Request Status Register */
+#define IRQC_EN_STS	0x04	/* Interrupt Enable Status Register */
+#define IRQC_EN_SET	0x08	/* Interrupt Enable Set Register */
 #define IRQC_INT_CPU_BASE(n) (0x000 + ((n) * 0x10))
-#define DETECT_STATUS 0x100
+				/* SYS-CPU vs. RT-CPU */
+#define DETECT_STATUS	0x100	/* IRQn Detect Status Register */
+#define MONITOR		0x104	/* IRQn Signal Level Monitor Register */
+#define HLVL_STS	0x108	/* IRQn High Level Detect Status Register */
+#define LLVL_STS	0x10c	/* IRQn Low Level Detect Status Register */
+#define S_R_EDGE_STS	0x110	/* IRQn Sync Rising Edge Detect Status Reg. */
+#define S_F_EDGE_STS	0x114	/* IRQn Sync Falling Edge Detect Status Reg. */
+#define A_R_EDGE_STS	0x118	/* IRQn Async Rising Edge Detect Status Reg. */
+#define A_F_EDGE_STS	0x11c	/* IRQn Async Falling Edge Detect Status Reg. */
+#define CHTEN_STS	0x120	/* Chattering Reduction Status Register */
 #define IRQC_CONFIG(n) (0x180 + ((n) * 0x04))
+				/* IRQn Configuration Register */
 
 struct irqc_irq {
 	int hw_irq;
-- 
1.9.1


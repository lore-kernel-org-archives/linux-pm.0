From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFT] irqchip: mxs: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
Date: Fri, 11 Nov 2016 17:26:48 +0000
Message-ID: <1478885208-18821-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:54031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934509AbcKKR2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2016 12:28:41 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Oleksij Rempel <linux@rempel-privat.de>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Marek Vasut <marex@denx.de>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <lw@karo-electronics.de>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

The ICOLL controller doesn't provide any facility to configure the
wakeup sources. That's the reason why this implementation lacks
the irq_set_wake implementation. But this prevent us from properly
entering power management states like "suspend to idle".

So enable the flags IRQCHIP_SKIP_SET_WAKE and IRQCHIP_MASK_ON_SUSPEND
to let the irqchip core allows and handles the power management.

This patch has been tested with a MX23 and a MX28 board. Any further
tests especially with ASM9260 would be appreciated.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/irqchip/irq-mxs.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index 1730470..05fa9f7 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -131,12 +131,16 @@ static void asm9260_unmask_irq(struct irq_data *d)
 	.irq_ack = icoll_ack_irq,
 	.irq_mask = icoll_mask_irq,
 	.irq_unmask = icoll_unmask_irq,
+	.flags = IRQCHIP_MASK_ON_SUSPEND |
+		 IRQCHIP_SKIP_SET_WAKE,
 };
 
 static struct irq_chip asm9260_icoll_chip = {
 	.irq_ack = icoll_ack_irq,
 	.irq_mask = asm9260_mask_irq,
 	.irq_unmask = asm9260_unmask_irq,
+	.flags = IRQCHIP_MASK_ON_SUSPEND |
+		 IRQCHIP_SKIP_SET_WAKE,
 };
 
 asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
-- 
1.7.9.5


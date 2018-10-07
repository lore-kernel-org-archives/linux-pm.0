From: Jonas Danielsson <jonas@orbital-systems.com>
Subject: [PATCH] power: reset: at91-reset: enable I-cache for at91sam9260_reset
Date: Sun,  7 Oct 2018 14:57:45 +0200
Message-ID: <20181007125815.8392-1-jonas@threetimestwo.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jonas Danielsson <jonas@orbital-systems.com>, Sebastian Reichel <sre@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Jonas Danielsson <jonas@orbital-systems.com>

This fixes a bug where our embedded system (AT91SAM9260 based) would
hang at reboot. At the most we managed 16 boot loops without a hang.

With this patch applied the problem has not been observed and the board
has managed above 250 boot loops.

The AT91SAM9260 datasheet tells us that with the instruction cache
disabled all instructions are fetched from SDRAM. And we have an errata
telling us we must power down the SDRAM before issuing cpu reset.

This means we need the instruction cache enabled in at91sam9260_reset()
At the moment it is being disabled in cpu_proc_fin() which is called from
arch/arm/kernel/reboot.c.

Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
---
 drivers/power/reset/at91-reset.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index f44a9ffcc2ab..78972bba64df 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -50,14 +50,24 @@ static void __iomem *at91_ramc_base[2], *at91_rstc_base;
 static struct clk *sclk;
 
 /*
-* unless the SDRAM is cleanly shutdown before we hit the
+* Errata 43.1.7.1 RSTC: Reset during SDRAM Accesses
+*
+* Unless the SDRAM is cleanly shutdown before we hit the
 * reset register it can be left driving the data bus and
 * killing the chance of a subsequent boot from NAND
+*
+* Since we are disabling SDRAM need to make sure that the
+* instruction cache is enabled.
 */
 static int at91sam9260_restart(struct notifier_block *this, unsigned long mode,
 			       void *cmd)
 {
 	asm volatile(
+		/* Enable I-cache */
+		"mrc	p15, 0, r0, c1, c0, 0\n\t"
+		"orr	r0, r0, #4096\n\t" /* CR_I (bit 12) */
+		"mcr	p15, 0, r0, c1, c0, 0\n\t"
+
 		/* Align to cache lines */
 		".balign 32\n\t"
 
-- 
2.14.4

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 4/4] irqchip/gic: remove big.LITTLE switcher support
Date: Mon, 27 Jun 2016 13:26:10 +0200
Message-ID: <1467026770-5699-5-git-send-email-b.zolnierkie@samsung.com>
References: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49818 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbcF0L1Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 07:27:24 -0400
In-reply-to: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nico@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Dave Martin <dave.martin@linaro.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Remove no longer needed big.LITTLE switcher support.

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/irqchip/irq-gic.c | 137 ----------------------------------------------
 1 file changed, 137 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 1de07eb..9237dd2 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -788,144 +788,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 }
 #endif
 
-#ifdef CONFIG_BL_SWITCHER
-/*
- * gic_send_sgi - send a SGI directly to given CPU interface number
- *
- * cpu_id: the ID for the destination CPU interface
- * irq: the IPI number to send a SGI for
- */
-void gic_send_sgi(unsigned int cpu_id, unsigned int irq)
-{
-	BUG_ON(cpu_id >= NR_GIC_CPU_IF);
-	cpu_id = 1 << cpu_id;
-	/* this always happens on GIC0 */
-	writel_relaxed((cpu_id << 16) | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
-}
-
-/*
- * gic_get_cpu_id - get the CPU interface ID for the specified CPU
- *
- * @cpu: the logical CPU number to get the GIC ID for.
- *
- * Return the CPU interface ID for the given logical CPU number,
- * or -1 if the CPU number is too large or the interface ID is
- * unknown (more than one bit set).
- */
-int gic_get_cpu_id(unsigned int cpu)
-{
-	unsigned int cpu_bit;
-
-	if (cpu >= NR_GIC_CPU_IF)
-		return -1;
-	cpu_bit = gic_cpu_map[cpu];
-	if (cpu_bit & (cpu_bit - 1))
-		return -1;
-	return __ffs(cpu_bit);
-}
-
-/*
- * gic_migrate_target - migrate IRQs to another CPU interface
- *
- * @new_cpu_id: the CPU target ID to migrate IRQs to
- *
- * Migrate all peripheral interrupts with a target matching the current CPU
- * to the interface corresponding to @new_cpu_id.  The CPU interface mapping
- * is also updated.  Targets to other CPU interfaces are unchanged.
- * This must be called with IRQs locally disabled.
- */
-void gic_migrate_target(unsigned int new_cpu_id)
-{
-	unsigned int cur_cpu_id, gic_irqs, gic_nr = 0;
-	void __iomem *dist_base;
-	int i, ror_val, cpu = smp_processor_id();
-	u32 val, cur_target_mask, active_mask;
-
-	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
-
-	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
-	if (!dist_base)
-		return;
-	gic_irqs = gic_data[gic_nr].gic_irqs;
-
-	cur_cpu_id = __ffs(gic_cpu_map[cpu]);
-	cur_target_mask = 0x01010101 << cur_cpu_id;
-	ror_val = (cur_cpu_id - new_cpu_id) & 31;
-
-	raw_spin_lock(&irq_controller_lock);
-
-	/* Update the target interface for this logical CPU */
-	gic_cpu_map[cpu] = 1 << new_cpu_id;
-
-	/*
-	 * Find all the peripheral interrupts targetting the current
-	 * CPU interface and migrate them to the new CPU interface.
-	 * We skip DIST_TARGET 0 to 7 as they are read-only.
-	 */
-	for (i = 8; i < DIV_ROUND_UP(gic_irqs, 4); i++) {
-		val = readl_relaxed(dist_base + GIC_DIST_TARGET + i * 4);
-		active_mask = val & cur_target_mask;
-		if (active_mask) {
-			val &= ~active_mask;
-			val |= ror32(active_mask, ror_val);
-			writel_relaxed(val, dist_base + GIC_DIST_TARGET + i*4);
-		}
-	}
-
-	raw_spin_unlock(&irq_controller_lock);
-
-	/*
-	 * Now let's migrate and clear any potential SGIs that might be
-	 * pending for us (cur_cpu_id).  Since GIC_DIST_SGI_PENDING_SET
-	 * is a banked register, we can only forward the SGI using
-	 * GIC_DIST_SOFTINT.  The original SGI source is lost but Linux
-	 * doesn't use that information anyway.
-	 *
-	 * For the same reason we do not adjust SGI source information
-	 * for previously sent SGIs by us to other CPUs either.
-	 */
-	for (i = 0; i < 16; i += 4) {
-		int j;
-		val = readl_relaxed(dist_base + GIC_DIST_SGI_PENDING_SET + i);
-		if (!val)
-			continue;
-		writel_relaxed(val, dist_base + GIC_DIST_SGI_PENDING_CLEAR + i);
-		for (j = i; j < i + 4; j++) {
-			if (val & 0xff)
-				writel_relaxed((1 << (new_cpu_id + 16)) | j,
-						dist_base + GIC_DIST_SOFTINT);
-			val >>= 8;
-		}
-	}
-}
-
-/*
- * gic_get_sgir_physaddr - get the physical address for the SGI register
- *
- * REturn the physical address of the SGI register to be used
- * by some early assembly code when the kernel is not yet available.
- */
-static unsigned long gic_dist_physaddr;
-
-unsigned long gic_get_sgir_physaddr(void)
-{
-	if (!gic_dist_physaddr)
-		return 0;
-	return gic_dist_physaddr + GIC_DIST_SOFTINT;
-}
-
-void __init gic_init_physaddr(struct device_node *node)
-{
-	struct resource res;
-	if (of_address_to_resource(node, 0, &res) == 0) {
-		gic_dist_physaddr = res.start;
-		pr_info("GIC physical location is %#lx\n", gic_dist_physaddr);
-	}
-}
-
-#else
 #define gic_init_physaddr(node)  do { } while (0)
-#endif
 
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
-- 
1.9.1


From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 3/5] ARM: dove: create a proper PMU driver for power domains,
 PMU IRQs and resets
Date: Sun, 27 Apr 2014 14:29:01 +0100
Message-ID: <E1WeP8f-0000Uo-1q@rmk-PC.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:53690 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752252AbaD0N3G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Apr 2014 09:29:06 -0400
In-Reply-To: <20140427132312.GC26756@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>

The PMU device contains an interrupt controller, power control and
resets.  The interrupt controller is a little sub-standard in that
there is no race free way to clear down pending interrupts, so we try
to avoid problems by reducing the window as much as possible, and
clearing as infrequently as possible.

The interrupt support is implemented using an IRQ domain, and the
parent interrupt referenced in the standard DT way.

The power domains and reset support is closely related - there is a
defined sequence for powering down a domain which is tightly coupled
with asserting the reset.  Hence, it makes sense to group these two
together.

This patch adds the core PMU driver: power domains must be defined in
the DT file in order to make use of them.  The reset controller can
be referenced in the standard way for reset controllers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                     |   1 +
 arch/arm/mach-dove/Makefile          |   1 +
 arch/arm/mach-dove/common.c          |   2 +
 arch/arm/mach-dove/common.h          |   1 +
 arch/arm/mach-dove/include/mach/pm.h |  17 --
 arch/arm/mach-dove/irq.c             |  87 -------
 arch/arm/mach-dove/pmu.c             | 457 +++++++++++++++++++++++++++++++++++
 7 files changed, 462 insertions(+), 104 deletions(-)
 create mode 100644 arch/arm/mach-dove/pmu.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 15949459611f..cec3ff2dfad4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -534,6 +534,7 @@ config ARCH_DOVE
 	select PINCTRL
 	select PINCTRL_DOVE
 	select PLAT_ORION_LEGACY
+	select PM_GENERIC_DOMAINS if PM
 	select USB_ARCH_HAS_EHCI
 	help
 	  Support for the Marvell Dove SoC 88AP510
diff --git a/arch/arm/mach-dove/Makefile b/arch/arm/mach-dove/Makefile
index cbc5c0618788..8e59c57dfa3c 100644
--- a/arch/arm/mach-dove/Makefile
+++ b/arch/arm/mach-dove/Makefile
@@ -1,4 +1,5 @@
 obj-y				+= common.o
+obj-$(CONFIG_PM_GENERIC_DOMAINS)+= pmu.o
 obj-$(CONFIG_DOVE_LEGACY)	+= irq.o mpp.o
 obj-$(CONFIG_PCI)		+= pcie.o
 obj-$(CONFIG_MACH_DOVE_DB)	+= dove-db-setup.o
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 0d1a89298ece..195871c87819 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -377,6 +377,8 @@ void __init dove_setup_cpu_wins(void)
 
 void __init dove_init(void)
 {
+	dove_init_pmu();
+
 	pr_info("Dove 88AP510 SoC, TCLK = %d MHz.\n",
 		(dove_tclk + 499999) / 1000000);
 
diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-dove/common.h
index 1d725224d146..261e0e995daa 100644
--- a/arch/arm/mach-dove/common.h
+++ b/arch/arm/mach-dove/common.h
@@ -45,5 +45,6 @@ void dove_i2c_init(void);
 void dove_sdio0_init(void);
 void dove_sdio1_init(void);
 void dove_restart(enum reboot_mode, const char *);
+int dove_init_pmu(void);
 
 #endif
diff --git a/arch/arm/mach-dove/include/mach/pm.h b/arch/arm/mach-dove/include/mach/pm.h
index b47f75038686..625a89c15c1f 100644
--- a/arch/arm/mach-dove/include/mach/pm.h
+++ b/arch/arm/mach-dove/include/mach/pm.h
@@ -51,22 +51,5 @@
 #define  CLOCK_GATING_GIGA_PHY_MASK	(1 << CLOCK_GATING_BIT_GIGA_PHY)
 
 #define PMU_INTERRUPT_CAUSE	(DOVE_PMU_VIRT_BASE + 0x50)
-#define PMU_INTERRUPT_MASK	(DOVE_PMU_VIRT_BASE + 0x54)
-
-static inline int pmu_to_irq(int pin)
-{
-	if (pin < NR_PMU_IRQS)
-		return pin + IRQ_DOVE_PMU_START;
-
-	return -EINVAL;
-}
-
-static inline int irq_to_pmu(int irq)
-{
-	if (IRQ_DOVE_PMU_START <= irq && irq < NR_IRQS)
-		return irq - IRQ_DOVE_PMU_START;
-
-	return -EINVAL;
-}
 
 #endif
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index bc4344aa1009..ca14d45a699b 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -7,86 +7,14 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/io.h>
-#include <asm/mach/arch.h>
 #include <plat/irq.h>
-#include <asm/mach/irq.h>
-#include <mach/pm.h>
 #include <mach/bridge-regs.h>
 #include <plat/orion-gpio.h>
 #include "common.h"
 
-static void pmu_irq_mask(struct irq_data *d)
-{
-	int pin = irq_to_pmu(d->irq);
-	u32 u;
-
-	u = readl(PMU_INTERRUPT_MASK);
-	u &= ~(1 << (pin & 31));
-	writel(u, PMU_INTERRUPT_MASK);
-}
-
-static void pmu_irq_unmask(struct irq_data *d)
-{
-	int pin = irq_to_pmu(d->irq);
-	u32 u;
-
-	u = readl(PMU_INTERRUPT_MASK);
-	u |= 1 << (pin & 31);
-	writel(u, PMU_INTERRUPT_MASK);
-}
-
-static void pmu_irq_ack(struct irq_data *d)
-{
-	int pin = irq_to_pmu(d->irq);
-	u32 u;
-
-	/*
-	 * The PMU mask register is not RW0C: it is RW.  This means that
-	 * the bits take whatever value is written to them; if you write
-	 * a '1', you will set the interrupt.
-	 *
-	 * Unfortunately this means there is NO race free way to clear
-	 * these interrupts.
-	 *
-	 * So, let's structure the code so that the window is as small as
-	 * possible.
-	 */
-	u = ~(1 << (pin & 31));
-	u &= readl_relaxed(PMU_INTERRUPT_CAUSE);
-	writel_relaxed(u, PMU_INTERRUPT_CAUSE);
-}
-
-static struct irq_chip pmu_irq_chip = {
-	.name		= "pmu_irq",
-	.irq_mask	= pmu_irq_mask,
-	.irq_unmask	= pmu_irq_unmask,
-	.irq_ack	= pmu_irq_ack,
-};
-
-static void pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned long cause = readl(PMU_INTERRUPT_CAUSE);
-
-	cause &= readl(PMU_INTERRUPT_MASK);
-	if (cause == 0) {
-		do_bad_IRQ(irq, desc);
-		return;
-	}
-
-	for (irq = 0; irq < NR_PMU_IRQS; irq++) {
-		if (!(cause & (1 << irq)))
-			continue;
-		irq = pmu_to_irq(irq);
-		generic_handle_irq(irq);
-	}
-}
-
 static int __initdata gpio0_irqs[4] = {
 	IRQ_DOVE_GPIO_0_7,
 	IRQ_DOVE_GPIO_8_15,
@@ -110,8 +38,6 @@ static int __initdata gpio2_irqs[4] = {
 
 void __init dove_init_irq(void)
 {
-	int i;
-
 	orion_irq_init(0, IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF);
 	orion_irq_init(32, IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF);
 
@@ -126,17 +52,4 @@ void __init dove_init_irq(void)
 
 	orion_gpio_init(NULL, 64, 8, DOVE_GPIO2_VIRT_BASE, 0,
 			IRQ_DOVE_GPIO_START + 64, gpio2_irqs);
-
-	/*
-	 * Mask and clear PMU interrupts
-	 */
-	writel(0, PMU_INTERRUPT_MASK);
-	writel(0, PMU_INTERRUPT_CAUSE);
-
-	for (i = IRQ_DOVE_PMU_START; i < NR_IRQS; i++) {
-		irq_set_chip_and_handler(i, &pmu_irq_chip, handle_level_irq);
-		irq_set_status_flags(i, IRQ_LEVEL);
-		set_irq_flags(i, IRQF_VALID);
-	}
-	irq_set_chained_handler(IRQ_DOVE_PMU, pmu_irq_handler);
 }
diff --git a/arch/arm/mach-dove/pmu.c b/arch/arm/mach-dove/pmu.c
new file mode 100644
index 000000000000..0b3201fa2d5c
--- /dev/null
+++ b/arch/arm/mach-dove/pmu.c
@@ -0,0 +1,457 @@
+/*
+ * Marvell Dove PMU support
+ */
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/reset.h>
+#include <linux/reset-controller.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <asm/mach/irq.h>
+
+#include <mach/hardware.h>
+#include <mach/pm.h>
+
+#define PMC_SW_RST		0x30
+#define PMC_IRQ_CAUSE		0x50
+#define PMC_IRQ_MASK		0x54
+
+#define PMU_PWR			0x10
+#define  PMU_PWR_DOWN_GPU	BIT(2)
+#define  PMU_PWR_DOWN_VPU	BIT(3)
+#define PMU_ISO			0x58
+#define  PMU_ISO_VPU		BIT(0)
+#define  PMU_ISO_GPU		BIT(1)
+#define  PMU_ISO_CPU		BIT(2)
+#define  PMU_ISO_CORE		BIT(3)
+
+struct pmu_data {
+	spinlock_t lock;
+	struct device_node *of_node;
+	void __iomem *pmc_base;
+	void __iomem *pmu_base;
+	struct irq_chip_generic *irq_gc;
+	struct irq_domain *irq_domain;
+#ifdef CONFIG_RESET_CONTROLLER
+	struct reset_controller_dev reset;
+#endif
+};
+
+/*
+ * The PMU contains a register to reset various subsystems within the
+ * SoC.  Export this as a reset controller.
+ */
+#ifdef CONFIG_RESET_CONTROLLER
+#define rcdev_to_pmu(rcdev) container_of(rcdev, struct pmu_data, reset)
+
+static int pmu_reset_reset(struct reset_controller_dev *rc, unsigned long id)
+{
+	struct pmu_data *pmu = rcdev_to_pmu(rc);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&pmu->lock, flags);
+	val = readl_relaxed(pmu->pmc_base + PMC_SW_RST);
+	writel_relaxed(val & ~BIT(id), pmu->pmc_base + PMC_SW_RST);
+	writel_relaxed(val | BIT(id), pmu->pmc_base + PMC_SW_RST);
+	spin_unlock_irqrestore(&pmu->lock, flags);
+
+	return 0;
+}
+
+static int pmu_reset_assert(struct reset_controller_dev *rc, unsigned long id)
+{
+	struct pmu_data *pmu = rcdev_to_pmu(rc);
+	unsigned long flags;
+	u32 val = ~BIT(id);
+
+	spin_lock_irqsave(&pmu->lock, flags);
+	val &= readl_relaxed(pmu->pmc_base + PMC_SW_RST);
+	writel_relaxed(val, pmu->pmc_base + PMC_SW_RST);
+	spin_unlock_irqrestore(&pmu->lock, flags);
+
+	return 0;
+}
+
+static int pmu_reset_deassert(struct reset_controller_dev *rc, unsigned long id)
+{
+	struct pmu_data *pmu = rcdev_to_pmu(rc);
+	unsigned long flags;
+	u32 val = BIT(id);
+
+	spin_lock_irqsave(&pmu->lock, flags);
+	val |= readl_relaxed(pmu->pmc_base + PMC_SW_RST);
+	writel_relaxed(val, pmu->pmc_base + PMC_SW_RST);
+	spin_unlock_irqrestore(&pmu->lock, flags);
+
+	return 0;
+}
+
+static struct reset_control_ops pmu_reset_ops = {
+	.reset = pmu_reset_reset,
+	.assert = pmu_reset_assert,
+	.deassert = pmu_reset_deassert,
+};
+
+static struct reset_controller_dev pmu_reset __initdata = {
+	.ops = &pmu_reset_ops,
+	.owner = THIS_MODULE,
+	.nr_resets = 32,
+};
+
+static void __init pmu_reset_init(struct pmu_data *pmu)
+{
+	int ret;
+
+	pmu->reset = pmu_reset;
+	pmu->reset.of_node = pmu->of_node;
+
+	ret = reset_controller_register(&pmu->reset);
+	if (ret)
+		pr_err("pmu: %s failed: %d\n", "reset_controller_register", ret);
+}
+#else
+static void __init pmu_reset_init(struct pmu_data *pmu)
+{
+}
+#endif
+
+struct pmu_domain {
+	struct pmu_data *pmu;
+	u32 pwr_mask;
+	u32 rst_mask;
+	u32 iso_mask;
+	struct generic_pm_domain base;
+};
+
+#define to_pmu_domain(dom) container_of(dom, struct pmu_domain, base)
+
+/*
+ * This deals with the "old" Marvell sequence of bringing a power domain
+ * down/up, which is: apply power, release reset, disable isolators.
+ *
+ * Later devices apparantly use a different sequence: power up, disable
+ * isolators, assert repair signal, enable SRMA clock, enable AXI clock,
+ * enable module clock, deassert reset.
+ *
+ * Note: reading the assembly, it seems that the IO accessors have an
+ * unfortunate side-effect - they cause memory already read into registers
+ * for the if () to be re-read for the bit-set or bit-clear operation.
+ * The code is written to avoid this.
+ */
+static int pmu_domain_power_off(struct generic_pm_domain *domain)
+{
+	struct pmu_domain *pmu_dom = to_pmu_domain(domain);
+	struct pmu_data *pmu = pmu_dom->pmu;
+	unsigned long flags;
+	unsigned int val;
+	void __iomem *pmu_base = pmu->pmu_base;
+	void __iomem *pmc_base = pmu->pmc_base;
+
+	spin_lock_irqsave(&pmu->lock, flags);
+
+	/* Enable isolators */
+	if (pmu_dom->iso_mask) {
+		val = ~pmu_dom->iso_mask;
+		val &= readl_relaxed(pmu_base + PMU_ISO);
+		writel_relaxed(val, pmu_base + PMU_ISO);
+	}
+
+	/* Reset unit */
+	if (pmu_dom->rst_mask) {
+		val = ~pmu_dom->rst_mask;
+		val &= readl_relaxed(pmc_base + PMC_SW_RST);
+		writel_relaxed(val, pmc_base + PMC_SW_RST);
+	}
+
+	/* Power down */
+	val = readl_relaxed(pmu_base + PMU_PWR) | pmu_dom->pwr_mask;
+	writel_relaxed(val, pmu_base + PMU_PWR);
+
+	spin_unlock_irqrestore(&pmu->lock, flags);
+
+	return 0;
+}
+
+static int pmu_domain_power_on(struct generic_pm_domain *domain)
+{
+	struct pmu_domain *pmu_dom = to_pmu_domain(domain);
+	struct pmu_data *pmu = pmu_dom->pmu;
+	unsigned long flags;
+	unsigned int val;
+	void __iomem *pmu_base = pmu->pmu_base;
+	void __iomem *pmc_base = pmu->pmc_base;
+
+	spin_lock_irqsave(&pmu->lock, flags);
+
+	/* Power on */
+	val = ~pmu_dom->pwr_mask & readl_relaxed(pmu_base + PMU_PWR);
+	writel_relaxed(val, pmu_base + PMU_PWR);
+
+	/* Release reset */
+	if (pmu_dom->rst_mask) {
+		val = pmu_dom->rst_mask;
+		val |= readl_relaxed(pmc_base + PMC_SW_RST);
+		writel_relaxed(val, pmc_base + PMC_SW_RST);
+	}
+
+	/* Disable isolators */
+	if (pmu_dom->iso_mask) {
+		val = pmu_dom->iso_mask;
+		val |= readl_relaxed(pmu_base + PMU_ISO);
+		writel_relaxed(val, pmu_base + PMU_ISO);
+	}
+
+	spin_unlock_irqrestore(&pmu->lock, flags);
+
+	return 0;
+}
+
+static void __pmu_domain_register(struct pmu_domain *domain)
+{
+	unsigned int val = readl_relaxed(domain->pmu->pmu_base + PMU_PWR);
+
+	domain->base.dev_irq_safe = true;
+	domain->base.power_off = pmu_domain_power_off;
+	domain->base.power_on = pmu_domain_power_on;
+
+	pm_genpd_init(&domain->base, NULL, !(val & domain->pwr_mask));
+}
+
+static void pmu_add_genpd_of(struct device *dev)
+{
+	struct device_node *node;
+
+	node = of_parse_phandle(dev->of_node, "marvell,power-domain", 0);
+	if (!node)
+		return;
+
+	while (1) {
+		if (pm_genpd_of_add_device(node, dev) != -EAGAIN)
+			break;
+		cond_resched();
+	}
+}
+
+static void pmu_remove_genpd(struct device *dev)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+
+	while (1) {
+		if (pm_genpd_remove_device(genpd, dev) != -EAGAIN)
+			break;
+		cond_resched();
+	}
+}
+
+static int pmu_platform_call(struct notifier_block *nb,
+	unsigned long event, void *data)
+{
+	struct device *dev = data;
+
+	switch (event) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		if (dev->of_node)
+			pmu_add_genpd_of(dev);
+		break;
+
+	case BUS_NOTIFY_DEL_DEVICE:
+		pmu_remove_genpd(dev);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block platform_nb = {
+	.notifier_call = pmu_platform_call,
+};
+
+/* PMU IRQ controller */
+static void pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct pmu_data *pmu = irq_get_handler_data(irq);
+	struct irq_chip_generic *gc = pmu->irq_gc;
+	struct irq_domain *domain = pmu->irq_domain;
+	void __iomem *base = gc->reg_base;
+	u32 stat = readl_relaxed(base + PMC_IRQ_CAUSE) & gc->mask_cache;
+	u32 done = ~0;
+
+	if (stat == 0) {
+		do_bad_IRQ(irq, desc);
+		return;
+	}
+
+	while (stat) {
+		u32 hwirq = fls(stat) - 1;
+
+		stat &= ~(1 << hwirq);
+		done &= ~(1 << hwirq);
+
+		generic_handle_irq(irq_find_mapping(domain, hwirq));
+	}
+
+	/*
+	 * The PMU mask register is not RW0C: it is RW.  This means that
+	 * the bits take whatever value is written to them; if you write
+	 * a '1', you will set the interrupt.
+	 *
+	 * Unfortunately this means there is NO race free way to clear
+	 * these interrupts.
+	 *
+	 * So, let's structure the code so that the window is as small as
+	 * possible.
+	 */
+	irq_gc_lock(gc);
+	done &= readl_relaxed(base + PMC_IRQ_CAUSE);
+	writel_relaxed(done, base + PMC_IRQ_CAUSE);
+	irq_gc_unlock(gc);
+}
+
+static int __init dove_init_pmu_irq(struct pmu_data *pmu, int irq)
+{
+	const char *name = "pmu_irq";
+	struct irq_chip_generic *gc;
+	struct irq_domain *domain;
+	int ret;
+
+	/* mask and clear all interrupts */
+	writel(0, pmu->pmc_base + PMC_IRQ_MASK);
+	writel(0, pmu->pmc_base + PMC_IRQ_CAUSE);
+
+	domain = irq_domain_add_linear(pmu->of_node, NR_PMU_IRQS,
+				       &irq_generic_chip_ops, NULL);
+	if (!domain) {
+		pr_err("%s: unable to add irq domain\n", name);
+		return -ENOMEM;
+	}
+
+	ret = irq_alloc_domain_generic_chips(domain, NR_PMU_IRQS, 1, name,
+					     handle_level_irq,
+					     IRQ_NOREQUEST | IRQ_NOPROBE, 0,
+					     IRQ_GC_INIT_MASK_CACHE);
+	if (ret) {
+		pr_err("%s: unable to alloc irq domain gc: %d\n", name, ret);
+		irq_domain_remove(domain);
+		return ret;
+	}
+
+	gc = irq_get_domain_generic_chip(domain, 0);
+	gc->reg_base = pmu->pmc_base;
+	gc->chip_types[0].regs.mask = PMC_IRQ_MASK;
+	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
+	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
+
+	pmu->irq_domain = domain;
+	pmu->irq_gc = gc;
+
+	/* If no of_node, populate the domain */
+	if (!pmu->of_node)
+		irq_domain_associate_many(pmu->irq_domain, IRQ_DOVE_PMU_START,
+					  0, NR_PMU_IRQS);
+
+	irq_set_handler_data(irq, pmu);
+	irq_set_chained_handler(irq, pmu_irq_handler);
+
+	return 0;
+}
+
+/*
+ * pmu {
+ *	compatible = "marvell,pmu";
+ *	reg = <0xd0000 0x8000> <0xd8000 0x8000>;
+ *	interrupts = <33>;
+ *	#reset-cells = 1;
+ *	vpu_domain: vpu-domain {
+ *		marvell,pmu_pwr_mask = <0x00000008>;
+ *		marvell,pmu_iso_mask = <0x00000001>;
+ *		resets = <&pmu 16>;
+ *	};
+ *	gpu_domain: gpu-domain {
+ *		marvell,pmu_pwr_mask = <0x00000004>;
+ *		marvell,pmu_iso_mask = <0x00000002>;
+ *		resets = <&pmu 18>;
+ *	};
+ * };
+ */
+int __init dove_init_pmu(void)
+{
+	struct device_node *np_pmu, *np;
+	struct pmu_data *pmu;
+	int ret, parent_irq;
+
+	/* Lookup the PMU node */
+	np_pmu = of_find_compatible_node(NULL, NULL, "marvell,pmu");
+	if (!np_pmu)
+		return 0;
+
+	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	spin_lock_init(&pmu->lock);
+	pmu->of_node = np_pmu;
+	pmu->pmc_base = of_iomap(pmu->of_node, 0);
+	pmu->pmu_base = of_iomap(pmu->of_node, 1);
+	if (!pmu->pmc_base || !pmu->pmu_base) {
+		pr_err("%s: failed to map PMU\n", np_pmu->name);
+		iounmap(pmu->pmu_base);
+		iounmap(pmu->pmc_base);
+		kfree(pmu);
+		return -ENOMEM;
+	}
+
+	parent_irq = irq_of_parse_and_map(pmu->of_node, 0);
+	if (!parent_irq)
+		pr_err("%s: no interrupt specified\n", np_pmu->name);
+
+	pmu_reset_init(pmu);
+
+	for_each_available_child_of_node(pmu->of_node, np) {
+		struct of_phandle_args args;
+		struct pmu_domain *domain;
+
+		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+		if (!domain)
+			break;
+
+		domain->pmu = pmu;
+		domain->base.of_node = np;
+		domain->base.name = kstrdup(np->name, GFP_KERNEL);
+		if (!domain->base.name) {
+			kfree(domain);
+			break;
+		}
+
+		of_property_read_u32(np, "marvell,pmu_pwr_mask",
+				     &domain->pwr_mask);
+		of_property_read_u32(np, "marvell,pmu_iso_mask",
+				     &domain->iso_mask);
+
+		ret = of_parse_phandle_with_args(np, "resets", "#reset-cells",
+						 0, &args);
+		if (ret == 0) {
+			if (args.np == pmu->of_node)
+				domain->rst_mask = BIT(args.args[0]);
+			of_node_put(args.np);
+		}
+
+		__pmu_domain_register(domain);
+	}
+	pm_genpd_poweroff_unused();
+
+	ret = dove_init_pmu_irq(pmu, parent_irq);
+	if (ret)
+		pr_err("dove_init_pmu_irq() failed: %d\n", ret);
+
+	bus_register_notifier(&platform_bus_type, &platform_nb);
+
+	return 0;
+}
-- 
1.8.3.1


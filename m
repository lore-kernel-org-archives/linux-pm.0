From: Andrew Lunn <andrew@lunn.ch>
Subject: [RFC PATCH v5 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Tue, 17 Dec 2013 22:41:10 +0100
Message-ID: <1387316473-3250-2-git-send-email-andrew@lunn.ch>
References: <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
 <1387316473-3250-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:34986 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942Ab3LQVl5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Dec 2013 16:41:57 -0500
In-Reply-To: <1387316473-3250-1-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mark.rutland@arm.com
Cc: rjw@rjwysocki.net, Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Andrew Lunn <andrew@lunn.ch>

The Marvell Dove SoC can run the CPU at two frequencies. The high
frequencey is from a PLL, while the lower is the same as the DDR
clock. Add a cpufreq driver to swap between these frequences.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Sort header files
Remove unneeded header files
Notify only on change
Use get_cpu_device(0), devm_clk_get()
Use platform_get_resource_byname()
Error check clk_prepare_enable()
Comment the interrupt handler

rebase onto 3.13-rc2 linux-next
use target_index
---
 .../devicetree/bindings/cpufreq/cpufreq-dove.txt   |  23 ++
 drivers/cpufreq/Kconfig.arm                        |   5 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/dove-cpufreq.c                     | 265 +++++++++++++++++++++
 4 files changed, 294 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-dove.txt
 create mode 100644 drivers/cpufreq/dove-cpufreq.c

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-dove.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-dove.txt
new file mode 100644
index 000000000000..f95cc2234fc1
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-dove.txt
@@ -0,0 +1,23 @@
+Dove cpufreq driver
+-------------------
+
+The Dove cpufreq driver makes use of the pmu node in the device tree.
+
+Required properties:
+- compatibility: Must be "marvell,dove-pmu"
+- interrupts:	 Interrupt to know the completion of cpu frequency change.
+- clocks:	 phandles and clock specifiers pairs for CPU and DDR clock
+- clock-names: 	 "cpu" and "ddr"
+- reg: 		 Address ranges of the PMU. Two ranges are expected.
+
+Example:
+
+	pmu: pmu@d0000 {
+		compatible = "marvell,dove-pmu";
+		reg = <0xd0000 0x0700>,
+		      <0xd8000 0x0140>;
+		clocks = <&core_clk 1>, <&core_clk 3>;
+		clock-names = "cpu", "ddr";
+		interrupt-parent = <&pmu_intc>;
+		interrupts = <0>;
+	};
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index ce52ed949249..af7c4947f218 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -8,6 +8,11 @@ config ARM_BIG_LITTLE_CPUFREQ
 	help
 	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
 
+config ARM_DOVE_CPUFREQ
+	def_bool ARCH_DOVE && OF
+	help
+	  This adds the CPUFreq driver for Marvell Dove SoCs.
+
 config ARM_DT_BL_CPUFREQ
 	tristate "Generic probing via DT for ARM big LITTLE CPUfreq driver"
 	depends on ARM_BIG_LITTLE_CPUFREQ && OF
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 74945652dd7a..cd72c2bbfd44 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
+obj-$(CONFIG_ARM_DOVE_CPUFREQ)		+= dove-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
diff --git a/drivers/cpufreq/dove-cpufreq.c b/drivers/cpufreq/dove-cpufreq.c
new file mode 100644
index 000000000000..158dcf27f79f
--- /dev/null
+++ b/drivers/cpufreq/dove-cpufreq.c
@@ -0,0 +1,265 @@
+/*
+ *	dove_freq.c: cpufreq driver for the Marvell dove
+ *
+ *	Copyright (C) 2013 Andrew Lunn <andrew@lunn.ch>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <asm/proc-fns.h>
+
+#define DFS_CR			0x0000 /* Relative to core */
+#define  DFS_EN			BIT(0)
+#define  CPU_SLOW_EN		BIT(1)
+#define  L2_RATIO_OFFS		9
+#define  L2_RATIO_MASK		(0x3F << L2_RATIO_OFFS)
+
+#define DFS_SR			0x0004 /* Relative to core */
+#define  CPU_SLOW_MODE_STTS	BIT(1)
+
+#define PMU_CLK_DIV		0x0044 /* Relative to core */
+#define  DPRATIO_OFFS		24
+#define  DPRATIO_MASK		(0x3F << DPRATIO_OFFS)
+#define  XPRATIO_OFFS		16
+#define  XPRATIO_MASK		(0x3F << XPRATIO_OFFS)
+
+#define PMU_CR			0x8000
+#define  MASK_FIQ		BIT(28)
+#define  MASK_IRQ		BIT(24)	/* PMU_CR */
+
+static struct priv
+{
+	struct clk *cpu_clk;
+	struct clk *ddr_clk;
+	struct device *dev;
+	unsigned long dpratio;
+	unsigned long xpratio;
+	void __iomem *base;
+	void __iomem *pmu_cr;
+	void __iomem *pmu_clk_div;
+} priv;
+
+#define STATE_CPU_FREQ 0x01
+#define STATE_DDR_FREQ 0x02
+
+/*
+ * Dove can swap the clock to the CPU between two clocks:
+ *
+ * - cpu clk
+ * - ddr clk
+ *
+ * The frequencies are set at runtime before registering this
+ * table.
+ */
+static struct cpufreq_frequency_table dove_freq_table[] = {
+	{STATE_CPU_FREQ,	0}, /* CPU uses cpuclk */
+	{STATE_DDR_FREQ,	0}, /* CPU uses ddrclk */
+	{0,			CPUFREQ_TABLE_END},
+};
+
+static unsigned int dove_cpufreq_get_cpu_frequency(unsigned int cpu)
+{
+	unsigned long reg = readl_relaxed(priv.base + DFS_SR);
+
+	if (reg & CPU_SLOW_MODE_STTS)
+		return dove_freq_table[1].frequency;
+	return dove_freq_table[0].frequency;
+}
+
+static int dove_cpufreq_target(struct cpufreq_policy *policy,
+			       unsigned int index)
+{
+	unsigned int state = dove_freq_table[index].driver_data;
+	unsigned long reg, cr;
+
+	local_irq_disable();
+
+	/* Mask IRQ and FIQ to CPU */
+	cr = readl(priv.base + PMU_CR);
+	cr |= MASK_IRQ | MASK_FIQ;
+	writel(cr, priv.base + PMU_CR);
+
+	/* Set/Clear the CPU_SLOW_EN bit */
+	reg = readl_relaxed(priv.base + DFS_CR);
+	reg &= ~L2_RATIO_MASK;
+
+	switch (state) {
+	case STATE_CPU_FREQ:
+		reg |= priv.xpratio;
+		reg &= ~CPU_SLOW_EN;
+		break;
+	case STATE_DDR_FREQ:
+		reg |= (priv.dpratio | CPU_SLOW_EN);
+		break;
+	}
+
+	/* Start the DFS process */
+	reg |= DFS_EN;
+
+	writel(reg, priv.base + DFS_CR);
+
+	/*
+	 * Wait-for-Interrupt, while the hardware changes frequency.
+	 * IRQ and FIQ will be automagically unmasked on
+	 * completion
+	 */
+	cpu_do_idle();
+
+	local_irq_enable();
+
+	return 0;
+}
+
+static int dove_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	return cpufreq_generic_init(policy, dove_freq_table, 5000);
+}
+
+/*
+ * Handle the interrupt raised when the frequency change is
+ * complete. Without having an interrupt handler, the WFI will
+ * exit on the next timer tick, reducing performance.
+ */
+static irqreturn_t dove_cpufreq_irq(int irq, void *dev)
+{
+	return IRQ_HANDLED;
+}
+
+static struct cpufreq_driver dove_cpufreq_driver = {
+	.get	= dove_cpufreq_get_cpu_frequency,
+	.verify	= cpufreq_generic_frequency_table_verify,
+	.target_index = dove_cpufreq_target,
+	.init	= dove_cpufreq_cpu_init,
+	.exit	= cpufreq_generic_exit,
+	.name	= "dove-cpufreq",
+	.attr	= cpufreq_generic_attr,
+};
+
+static const struct of_device_id dove_cpufreq_match[] = {
+	{
+		.compatible = "marvell,dove-pmu",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, dove_cpufreq_match);
+
+
+static int dove_cpufreq_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int err, irq;
+
+	if (!np)
+		return -ENODEV;
+
+	memset(&priv, 0, sizeof(priv));
+	priv.dev = &pdev->dev;
+
+	priv.base = of_iomap(np, 0);
+	if (IS_ERR(priv.base)) {
+		err = PTR_ERR(priv.base);
+		goto out;
+	}
+
+	priv.cpu_clk = devm_clk_get(&pdev->dev, "cpu");
+	if (IS_ERR(priv.cpu_clk)) {
+		err = PTR_ERR(priv.cpu_clk);
+		goto out;
+	}
+
+	err = clk_prepare_enable(priv.cpu_clk);
+	if (err)
+		goto out;
+
+	dove_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
+
+	priv.ddr_clk = devm_clk_get(&pdev->dev, "ddr");
+	if (IS_ERR(priv.ddr_clk)) {
+		err = PTR_ERR(priv.ddr_clk);
+		goto out;
+	}
+
+	err = clk_prepare_enable(priv.ddr_clk);
+	if (err)
+		goto out;
+
+	dove_freq_table[1].frequency = clk_get_rate(priv.ddr_clk) / 1000;
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		err = -ENXIO;
+		goto out;
+	}
+
+	err = devm_request_irq(&pdev->dev, irq, dove_cpufreq_irq,
+			       0, "dove-cpufreq", NULL);
+	if (err) {
+		dev_err(&pdev->dev, "cannot assign irq %d, %d\n", irq, err);
+		goto out;
+	}
+
+	/* Read the target ratio which should be the DDR ratio */
+	priv.dpratio = readl_relaxed(priv.base + PMU_CLK_DIV);
+	priv.dpratio = (priv.dpratio & DPRATIO_MASK) >> DPRATIO_OFFS;
+	priv.dpratio = priv.dpratio << L2_RATIO_OFFS;
+
+	/* Save L2 ratio at reset */
+	priv.xpratio = readl(priv.base + PMU_CLK_DIV);
+	priv.xpratio = (priv.xpratio & XPRATIO_MASK) >> XPRATIO_OFFS;
+	priv.xpratio = priv.xpratio << L2_RATIO_OFFS;
+
+	err = cpufreq_register_driver(&dove_cpufreq_driver);
+	if (!err)
+		return 0;
+
+	dev_err(priv.dev, "Failed to register cpufreq driver");
+
+out:
+	if (!IS_ERR(priv.ddr_clk))
+		clk_disable_unprepare(priv.ddr_clk);
+	if (!IS_ERR(priv.cpu_clk))
+		clk_disable_unprepare(priv.cpu_clk);
+
+	return err;
+}
+
+static int dove_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&dove_cpufreq_driver);
+
+	clk_disable_unprepare(priv.ddr_clk);
+	clk_disable_unprepare(priv.cpu_clk);
+
+	return 0;
+}
+
+static struct platform_driver dove_cpufreq_platform_driver = {
+	.probe = dove_cpufreq_probe,
+	.remove = dove_cpufreq_remove,
+	.driver = {
+		.name = "dove-cpufreq",
+		.owner = THIS_MODULE,
+		.of_match_table = dove_cpufreq_match,
+	},
+};
+
+module_platform_driver(dove_cpufreq_platform_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch");
+MODULE_DESCRIPTION("cpufreq driver for Marvell's dove CPU");
+MODULE_ALIAS("platform:dove-cpufreq");
-- 
1.8.5.1


From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 7/7] cpufreq: add imx7ulp cpufreq driver
Date: Thu, 24 Aug 2017 00:10:10 +0800
Message-ID: <1503504610-12880-8-git-send-email-aisheng.dong@nxp.com>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org, vireshk@kernel.org, nm@ti.com, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, ping.bai@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>
List-Id: linux-pm@vger.kernel.org

MX7ULP supports HSRUN mode (528 Mhz), RUN mode (413 Mhz) and VLPR mode
(restricted to FIRC clock, usually 48 Mhz). This patch adds the cpufreq
driver support for HSRUN and RUN mode.
When in different modes, the A7 core is using different clocks:
RUN:	clk run_divcore
HSRUN:	clk hsrun_divcore

Thus, this driver replies on the newly added features in OPP core framework
in former patches:
"PM / OPP: use OPP node clock to set CPU frequency"

And since IMX7ULP CPU clock setting is different from the generic
set OPP clock, we also implemented a private set_clk function.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/cpufreq/Kconfig.arm       |   8 ++
 drivers/cpufreq/Makefile          |   1 +
 drivers/cpufreq/imx7ulp-cpufreq.c | 234 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/cpufreq/imx7ulp-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 2011fec..53664b5 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -90,6 +90,14 @@ config ARM_IMX6Q_CPUFREQ
 
 	  If in doubt, say N.
 
+config ARM_IMX7ULP_CPUFREQ
+	tristate "NXP i.MX7ULP cpufreq support"
+	depends on ARCH_MXC
+	help
+	  This adds cpufreq driver support for NXP i.MX7ULP series SoCs.
+
+	  If in doubt, say N.
+
 config ARM_KIRKWOOD_CPUFREQ
 	def_bool MACH_KIRKWOOD
 	help
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index ab3a42c..25a1ebd 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_ARM_DB8500_CPUFREQ)	+= dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
+obj-$(CONFIG_ARM_IMX7ULP_CPUFREQ)	+= imx7ulp-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_MT8173_CPUFREQ)	+= mt8173-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
diff --git a/drivers/cpufreq/imx7ulp-cpufreq.c b/drivers/cpufreq/imx7ulp-cpufreq.c
new file mode 100644
index 0000000..92374c6
--- /dev/null
+++ b/drivers/cpufreq/imx7ulp-cpufreq.c
@@ -0,0 +1,234 @@
+/*
+ * Copyright 2017 NXP.
+ *
+ * Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pm_opp.h>
+#include <linux/pm_qos.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/suspend.h>
+
+#define HSRUN_FREQ	528000000
+#define SMC_PMPROT	0x8
+#define SMC_PMCTRL	0x10
+
+static void __iomem *smc_base;
+
+static struct device *cpu_dev;
+static struct opp_table *opp_table;
+static struct cpufreq_frequency_table *freq_table;
+
+enum IMX7ULP_CPUFREQ_CLKS {
+	RUN_DIVCORE,
+	RUN_SCS_SEL,
+	HSRUN_DIVCORE,
+	HSRUN_SCS_SEL,
+	SPLL_PFD0,
+	SPLL_SEL,
+	FIRC,
+};
+
+static struct clk_bulk_data clks[] = {
+	{ .id = "run_divcore" },
+	{ .id = "run_scs_sel" },
+	{ .id = "hsrun_divcore" },
+	{ .id = "hsrun_scs_sel" },
+	{ .id = "spll_pfd0" },
+	{ .id = "spll_sel" },
+	{ .id = "firc" },
+};
+
+static int imx7ulp_set_clk(struct device *dev, struct clk *clk,
+			   unsigned long old_freq, unsigned long new_freq)
+{
+	u32 val;
+
+	/*
+	 * Before changing the ARM core PLL, change the ARM clock soure
+	 * to FIRC first.
+	 */
+	if (new_freq >= HSRUN_FREQ) {
+		clk_set_parent(clks[RUN_SCS_SEL].clk, clks[FIRC].clk);
+
+		/* switch to HSRUN mode */
+		val = readl_relaxed(smc_base + SMC_PMCTRL);
+		val |= (0x3 << 8);
+		writel_relaxed(val, smc_base + SMC_PMCTRL);
+
+		/* change the clock rate in HSRUN */
+		clk_set_rate(clks[SPLL_PFD0].clk, new_freq);
+		clk_set_parent(clks[HSRUN_SCS_SEL].clk, clks[SPLL_SEL].clk);
+	} else {
+		/* change the HSRUN clock to firc */
+		clk_set_parent(clks[HSRUN_SCS_SEL].clk, clks[FIRC].clk);
+
+		/* switch to RUN mode */
+		val = readl_relaxed(smc_base + SMC_PMCTRL);
+		val &= ~(0x3 << 8);
+		writel_relaxed(val, smc_base + SMC_PMCTRL);
+
+		clk_set_rate(clks[SPLL_PFD0].clk, new_freq);
+		clk_set_parent(clks[RUN_SCS_SEL].clk, clks[SPLL_SEL].clk);
+	}
+
+	return 0;
+}
+
+static int imx7ulp_set_target(struct cpufreq_policy *policy, unsigned int index)
+{
+	int ret;
+
+	ret = dev_pm_opp_set_rate(cpu_dev,
+				  policy->freq_table[index].frequency * 1000);
+	if (ret)
+		return ret;
+
+	policy->clk = dev_pm_opp_get_cur_clk(cpu_dev);
+	if (IS_ERR(policy->clk))
+		ret = PTR_ERR(policy->clk);
+
+	return ret;
+}
+
+static int imx7ulp_cpufreq_init(struct cpufreq_policy *policy)
+{
+	unsigned int transition_latency;
+	int ret;
+
+	policy->clk = clks[RUN_DIVCORE].clk;
+	policy->suspend_freq = dev_pm_opp_get_suspend_opp_freq(cpu_dev) / 1000;
+	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
+	if (!transition_latency)
+		transition_latency = CPUFREQ_ETERNAL;
+
+	ret = cpufreq_generic_init(policy, freq_table, transition_latency);
+	if (ret) {
+		dev_err(cpu_dev, "imx7ulp cpufreq init failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct cpufreq_driver imx7ulp_cpufreq_driver = {
+	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.verify = cpufreq_generic_frequency_table_verify,
+	.target_index = imx7ulp_set_target,
+	.get = cpufreq_generic_get,
+	.init = imx7ulp_cpufreq_init,
+	.name = "imx7ulp-cpufreq",
+	.attr = cpufreq_generic_attr,
+	.suspend = cpufreq_generic_suspend,
+};
+
+static int imx7ulp_cpufreq_probe(struct platform_device *pdev)
+{
+	const char *name = "cpu";
+	struct device_node *np;
+	int ret;
+
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu0 device\n");
+		return -ENOENT;
+	}
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-smc1");
+	smc_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!smc_base)
+		return -ENOMEM;
+
+	ret = clk_bulk_get(cpu_dev, ARRAY_SIZE(clks), clks);
+	if (ret)
+		return ret;
+
+	opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		dev_err(cpu_dev, "failed to set regulator %d\n", ret);
+		goto put_clk;
+	}
+
+	opp_table = dev_pm_opp_register_set_clk_helper(cpu_dev,
+						       imx7ulp_set_clk);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		dev_err(cpu_dev, "failed to set opp clk %d\n", ret);
+		goto put_reg;
+	}
+
+	ret = dev_pm_opp_of_add_table(cpu_dev);
+	if (ret < 0) {
+		dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
+		goto put_clk_helper;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
+	if (ret) {
+		dev_err(cpu_dev, "failed to init cpufreq table\n");
+		goto free_opp_table;
+	}
+
+	ret = cpufreq_register_driver(&imx7ulp_cpufreq_driver);
+	if (ret) {
+		dev_err(cpu_dev, "failed to register cpufreq driver\n");
+		goto free_freq_table;
+	}
+
+	return 0;
+
+free_freq_table:
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+free_opp_table:
+	dev_pm_opp_of_remove_table(cpu_dev);
+put_clk_helper:
+	dev_pm_opp_register_put_clk_helper(opp_table);
+put_reg:
+	dev_pm_opp_put_regulators(opp_table);
+put_clk:
+	clk_bulk_put(ARRAY_SIZE(clks), clks);
+
+	return ret;
+}
+
+static int imx7ulp_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&imx7ulp_cpufreq_driver);
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+	dev_pm_opp_of_remove_table(cpu_dev);
+	dev_pm_opp_register_put_clk_helper(opp_table);
+	dev_pm_opp_put_regulators(opp_table);
+	clk_bulk_put(ARRAY_SIZE(clks), clks);
+
+	return 0;
+}
+
+static struct platform_driver imx7ulp_cpufreq_platdrv = {
+	.driver = {
+		.name	= "imx7ulp-cpufreq",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= imx7ulp_cpufreq_probe,
+	.remove		= imx7ulp_cpufreq_remove,
+};
+
+module_platform_driver(imx7ulp_cpufreq_platdrv);
+
+MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.org>");
+MODULE_DESCRIPTION("NXP i.MX7ULP cpufreq driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

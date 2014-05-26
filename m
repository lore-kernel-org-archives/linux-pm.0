From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 2/4] cpufreq: add i.MX5 cpufreq driver
Date: Mon, 26 May 2014 12:15:06 +0200
Message-ID: <1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46455 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbaEZKPi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 06:15:38 -0400
In-Reply-To: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@freescale.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de

SoC specific driver to be able to handle PLL reprogramming
for exact OPP frequencies and additional power saving.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 .../devicetree/bindings/cpufreq/cpufreq-imx5.txt   |  43 +++
 drivers/cpufreq/Kconfig.arm                        |   8 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/imx5-cpufreq.c                     | 302 +++++++++++++++++++++
 4 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-imx5.txt
 create mode 100644 drivers/cpufreq/imx5-cpufreq.c

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-imx5.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-imx5.txt
new file mode 100644
index 000000000000..03b14bd2ca59
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-imx5.txt
@@ -0,0 +1,43 @@
+Freescale i.MX5 cpufreq driver
+------------------------------
+
+The imx5-cpufreq driver supports scaling the CPU core clock on Freescale i.MX5
+SoCs by directly changing the CPU PLL frequency. This allows for accurate
+matching of the documented operating points and potentially some additional
+power saving compared to a cpufreq driver using just the CPU frequency
+pre-divider.
+
+Required properties:
+ - operating-points: Refer to Documentation/devicetree/bindings/power/opp.txt
+ - clocks: Must contain an entry for each entry in the clock-names property.
+ - clock-names:
+   - "cpu": the final CPU clock
+   - "pll1": raw, undivided PLL1 output clock
+   - "step": the step clock used as the PLL1 bypass
+   - "lp_apm": the low power clock used as input to the step clock
+ - vddgp-supply: Power supply connected to VddGP aka the CPU core voltage
+ - vddgp-supply-max-microvolt: maximum allowed voltage for the VddGP rail
+ 
+All properties listed above must be defined under node /cpus/cpu@0.
+
+Example:
+--------
+
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cpu0: cpu@0 {
+		clocks = <&clks 24>, <&clks 112>, <&clks 187>, <&clks 89>;
+		clock-names = "cpu", "pll1", "step", "lp_apm";
+		vddgp-supply = <&sw1_reg>;
+		vddgp-supply-max-microvolt = <1400000>;
+		operating-points-range = <
+			/* kHz    uV */
+			 166666  850000
+			 400000  900000
+			 800000 1050000
+			1000000 1200000
+			1200000 1300000
+		>;
+	};
+};
\ No newline at end of file
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0e9cce82844b..636008e15a51 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -104,6 +104,14 @@ config ARM_HIGHBANK_CPUFREQ
 
 	  If in doubt, say N.
 
+config ARM_IMX5_CPUFREQ
+	tristate "Freescale i.MX5 cpufreq support"
+	depends on SOC_IMX5
+	help
+	  This adds cpufreq driver support for Freescale i.MX5 SOC.
+
+	  If in doubt, say N.
+
 config ARM_IMX6Q_CPUFREQ
 	tristate "Freescale i.MX6 cpufreq support"
 	depends on ARCH_MXC
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 0dbb963c1aef..16d2094fa106 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
+obj-$(CONFIG_ARM_IMX5_CPUFREQ)		+= imx5-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
 obj-$(CONFIG_ARM_INTEGRATOR)		+= integrator-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
diff --git a/drivers/cpufreq/imx5-cpufreq.c b/drivers/cpufreq/imx5-cpufreq.c
new file mode 100644
index 000000000000..668b395ce2bc
--- /dev/null
+++ b/drivers/cpufreq/imx5-cpufreq.c
@@ -0,0 +1,302 @@
+/*
+ * Copyright (c) 2014 Lucas Stach <l.stach@pengutronix.de>, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/regulator/consumer.h>
+
+struct imx5_cpufreq_private {
+	struct device *dev, *cpu_dev;
+	struct clk *cpu_clk, *pll1_clk, *step_clk, *lp_apm_clk;
+	struct regulator *vddgp_reg;
+	unsigned int max_volt;
+	struct cpufreq_frequency_table *freq_table;
+	unsigned int latency;
+};
+
+/* this should really go away, when the cpufreq driver interface gets sane */
+static struct imx5_cpufreq_private *global_private;
+
+static int imx5_set_target(struct cpufreq_policy *policy, unsigned int index)
+{
+	struct imx5_cpufreq_private *priv = global_private;
+	struct clk *cpu_clk_sel = clk_get_parent(priv->cpu_clk);
+	struct dev_pm_opp *opp;
+	unsigned long freq_hz, volt, volt_old;
+	unsigned int old_freq, new_freq;
+	int ret;
+
+	new_freq = priv->freq_table[index].frequency;
+	freq_hz = new_freq * 1000;
+	old_freq = clk_get_rate(priv->cpu_clk) / 1000;
+
+	rcu_read_lock();
+	opp = dev_pm_opp_find_freq_ceil(priv->cpu_dev, &freq_hz);
+	if (IS_ERR(opp)) {
+		rcu_read_unlock();
+		dev_err(priv->dev, "failed to find OPP for %ld\n", freq_hz);
+		return PTR_ERR(opp);
+	}
+
+	volt = dev_pm_opp_get_voltage(opp);
+	rcu_read_unlock();
+	volt_old = regulator_get_voltage(priv->vddgp_reg);
+
+	dev_dbg(priv->dev, "%4u MHz, %4ld mV --> %4u MHz, %4ld mV\n",
+		old_freq / 1000, volt_old / 1000,
+		new_freq / 1000, volt / 1000);
+
+	/* scaling up? scale voltage before frequency */
+	if (new_freq > old_freq) {
+		ret = regulator_set_voltage(priv->vddgp_reg,
+					    volt, priv->max_volt);
+		if (ret) {
+			dev_err(priv->dev,
+				"failed to scale vddgp up: %d\n", ret);
+			return ret;
+		}
+	}
+
+	/* switch CPU to lp_apm clock */
+	ret = clk_set_parent(priv->step_clk, priv->lp_apm_clk);
+	if (ret)
+		goto out_revert_regulator;
+	ret = clk_set_parent(cpu_clk_sel, priv->step_clk);
+	if (ret)
+		goto out_revert_regulator;
+
+	/* reprogram PLL */
+	ret = clk_set_rate(priv->pll1_clk, new_freq * 1000);
+	if (ret)
+		goto out_revert_pll;
+
+	/* switch back CPU to PLL clock */
+	clk_set_parent(cpu_clk_sel, priv->pll1_clk);
+
+	/* Ensure the arm clock divider is what we expect */
+	clk_set_rate(priv->cpu_clk, new_freq * 1000);
+
+	/* scaling down? scale voltage after frequency */
+	if (new_freq < old_freq) {
+		ret = regulator_set_voltage(priv->vddgp_reg,
+					    volt, priv->max_volt);
+		if (ret) {
+			dev_warn(priv->dev,
+				 "failed to scale vddgp down: %d\n", ret);
+			ret = 0;
+		}
+	}
+
+	return 0;
+
+out_revert_pll:
+	clk_set_rate(priv->pll1_clk, old_freq);
+	clk_set_parent(cpu_clk_sel, priv->pll1_clk);
+out_revert_regulator:
+	regulator_set_voltage_tol(priv->vddgp_reg, volt_old, 0);
+
+	return ret;
+}
+
+static unsigned int imx5_get_speed(unsigned int cpu)
+{
+	struct imx5_cpufreq_private *priv = global_private;
+
+	return clk_get_rate(priv->cpu_clk) / 1000;
+}
+
+static int imx5_cpufreq_init(struct cpufreq_policy *policy)
+{
+	struct imx5_cpufreq_private *priv = global_private;
+
+	return cpufreq_generic_init(policy, priv->freq_table, priv->latency);
+}
+
+static struct cpufreq_driver imx5_cpufreq_driver = {
+	.verify = cpufreq_generic_frequency_table_verify,
+	.target_index = imx5_set_target,
+	.get = imx5_get_speed,
+	.init = imx5_cpufreq_init,
+	.exit = cpufreq_generic_exit,
+	.name = "imx5-cpufreq",
+	.attr = cpufreq_generic_attr,
+};
+
+static int imx5_cpufreq_probe(struct platform_device *pdev)
+{
+	struct device_node *np;
+	struct dev_pm_opp *opp;
+	struct imx5_cpufreq_private *priv;
+	unsigned long opp_freq = 0;
+	unsigned int opp_volt, min_volt = ~0, max_volt = 0;
+	int num_opp, ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	priv->cpu_dev = get_cpu_device(0);
+	if (!priv->cpu_dev) {
+		pr_err("failed to get cpu0 device\n");
+		return -ENODEV;
+	}
+
+	np = of_node_get(priv->cpu_dev->of_node);
+	if (!np) {
+		dev_err(priv->dev, "failed to find cpu0 node\n");
+		return -ENOENT;
+	}
+
+	priv->cpu_clk = clk_get(priv->cpu_dev, "cpu");
+	priv->pll1_clk = clk_get(priv->cpu_dev, "pll1");
+	priv->step_clk = clk_get(priv->cpu_dev, "step");
+	priv->lp_apm_clk = clk_get(priv->cpu_dev, "lp_apm");
+	if (IS_ERR(priv->cpu_clk) || IS_ERR(priv->step_clk) ||
+	    IS_ERR(priv->lp_apm_clk)) {
+		dev_err(priv->dev, "failed to get clocks\n");
+		ret = -ENOENT;
+		goto out_clk_put;
+	}
+
+	priv->vddgp_reg = regulator_get(priv->cpu_dev, "vddgp");
+	if (IS_ERR(priv->vddgp_reg)) {
+		dev_err(priv->dev, "failed to get regulators\n");
+		ret = PTR_ERR(priv->vddgp_reg);
+		goto out_clk_put;
+	}
+
+	ret = of_init_opp_table(priv->cpu_dev);
+	if (ret) {
+		dev_err(priv->dev, "failed to init OPP table: %d\n", ret);
+		goto out_regulator_put;
+	}
+
+	ret = of_property_read_u32(np, "vddgp-supply-max-microvolt",
+				   &priv->max_volt);
+	if (ret) {
+		dev_err(priv->dev, "no max-voltage found\n");
+		goto out_regulator_put;
+	}
+
+	/*
+	 * Disable any OPPs where the connected regulator isn't able to provide
+	 * the specified voltage.
+	 */
+	while (1){
+		rcu_read_lock();
+		opp = dev_pm_opp_find_freq_ceil(priv->cpu_dev, &opp_freq);
+		if (IS_ERR(opp)) {
+			rcu_read_unlock();
+			break;
+		}
+		opp_volt = (unsigned int)dev_pm_opp_get_voltage(opp);
+		rcu_read_unlock();
+
+		if (regulator_is_supported_voltage(priv->vddgp_reg,
+						   opp_volt, priv->max_volt)) {
+			if (opp_volt < min_volt)
+				min_volt = opp_volt;
+			if (opp_volt > max_volt)
+				max_volt = opp_volt;
+		} else {
+			dev_pm_opp_disable(priv->cpu_dev, opp_freq);
+		}
+
+		opp_freq++;
+	}
+
+	/*
+	 * If the number of enabled OPPs has changed, we need to adjust the
+	 * frequency table. Also if there isn't any usable OPP this driver is of
+	 * no use, so just bail in this case.
+	 */
+	num_opp = dev_pm_opp_get_opp_count(priv->cpu_dev);
+	if (!num_opp) {
+		dev_err(priv->dev, "regulator does not support any OPP mandated voltage\n");
+		goto out_regulator_put;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(priv->cpu_dev, &priv->freq_table);
+	if (ret) {
+		dev_err(priv->dev, "failed to init cpufreq table: %d\n", ret);
+		goto out_regulator_put;
+	}
+
+	priv->latency = 61036; /* two CLK32 periods to relock PLL */
+	ret = regulator_set_voltage_time(priv->vddgp_reg, min_volt, max_volt);
+	if (ret > 0)
+		priv->latency += ret * 1000;
+
+	platform_set_drvdata(pdev, priv);
+	global_private = priv;
+
+	ret = cpufreq_register_driver(&imx5_cpufreq_driver);
+	if (ret) {
+		dev_err(priv->dev, "failed register driver: %d\n", ret);
+		goto out_free_freq_table;
+	}
+
+	of_node_put(np);
+
+	return 0;
+
+out_free_freq_table:
+	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &priv->freq_table);
+out_regulator_put:
+	regulator_put(priv->vddgp_reg);
+out_clk_put:
+	if (!IS_ERR(priv->cpu_clk))
+		clk_put(priv->cpu_clk);
+	if (!IS_ERR(priv->pll1_clk))
+		clk_put(priv->pll1_clk);
+	if (!IS_ERR(priv->step_clk))
+		clk_put(priv->step_clk);
+	if (!IS_ERR(priv->lp_apm_clk))
+		clk_put(priv->lp_apm_clk);
+
+	of_node_put(np);
+
+	return ret;
+}
+
+static int imx5_cpufreq_remove(struct platform_device *pdev)
+{
+	struct imx5_cpufreq_private *priv = platform_get_drvdata(pdev);
+
+	cpufreq_unregister_driver(&imx5_cpufreq_driver);
+	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &priv->freq_table);
+	regulator_put(priv->vddgp_reg);
+	clk_put(priv->cpu_clk);
+	clk_put(priv->pll1_clk);
+	clk_put(priv->step_clk);
+	clk_put(priv->lp_apm_clk);
+
+	return 0;
+}
+
+static struct platform_driver imx5_cpufreq_drv = {
+	.driver = {
+		.name	= "imx5-cpufreq",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= imx5_cpufreq_probe,
+	.remove		= imx5_cpufreq_remove,
+};
+module_platform_driver(imx5_cpufreq_drv);
+
+MODULE_AUTHOR("Lucas Stach <l.stach@pengutronix.de>");
+MODULE_DESCRIPTION("Freescale i.MX5 cpufreq driver");
+MODULE_LICENSE("GPL v2");
-- 
2.0.0.rc2


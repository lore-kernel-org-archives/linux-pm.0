From: Penny Chiu <pchiu@nvidia.com>
Subject: [PATCH 05/11] pwm: tegra-dfll: Add driver for Tegra DFLL PWM controller
Date: Fri, 22 Apr 2016 18:31:05 +0800
Message-ID: <1461321071-6431-6-git-send-email-pchiu@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Penny Chiu <pchiu@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Tegra DFLL IP block controls off-chip PMIC via I2C bus or PWM
signals. This driver exposes DFLL as a PWM controller to generate
PWM signals to PWM regulator.

Tegra DFLL HW changes regulator voltage by adjusting PWM signals
duty cycle automatically based on required DVCO frequency, so PWM
regulator client doesn't need to change voltage by SW.

In this driver, it only configs proper PWM rate in the driver
initialization, and provides two APIs for clients to determine when
to enable and disable generating PWM signals by setting related
pinmux tristate.

Signed-off-by: Penny Chiu <pchiu@nvidia.com>
---
 .../bindings/pwm/nvidia,tegra-dfll-pwm.txt         |  48 +++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-tegra-dfll.c                       | 322 +++++++++++++++++++++
 include/soc/tegra/pwm-tegra-dfll.h                 |  27 ++
 5 files changed, 408 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.txt
 create mode 100644 drivers/pwm/pwm-tegra-dfll.c
 create mode 100644 include/soc/tegra/pwm-tegra-dfll.h

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.txt
new file mode 100644
index 0000000..bd0d247
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.txt
@@ -0,0 +1,48 @@
+Tegra SoC DFLL PWM controller
+
+Required properties:
+- compatible: For Tegra210, must contain "nvidia,tegra210-dfll-pwm".
+- reg: physical base address and length of the controller's registers
+- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+  the cells format.
+- clock-names: Must include the "ref" entry.
+- clocks: Must contain one entry, for the DFLL closed loop reference clock.
+  See ../clocks/clock-bindings.txt for details.
+- pwm-regulator: phandle to PWM regulator for using this PWM controller.
+- pinctrl-names: Must contain two entries to enable and disable PWM signals
+  output pinmux states.
+- pinctrl-0: pinmux state to enable PWM signals output
+- pinctrl-1: pinmux state to disable PWM signals output
+
+Example:
+
+	pinmux: pinmux@700008d4 {
+		dvfs_pwm_active_state: dvfs_pwm_active {
+			dvfs_pwm_pbb1 {
+				nvidia,pins = "dvfs_pwm_pbb1";
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+		};
+
+		dvfs_pwm_inactive_state: dvfs_pwm_inactive {
+			dvfs_pwm_pbb1 {
+				nvidia,pins = "dvfs_pwm_pbb1";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+		};
+	};
+
+	pwm_dfll: pwm@70110000 {
+		compatible = "nvidia,tegra210-dfll-pwm";
+		reg = <0x0 0x70110000 0x0 0x400>;
+		clocks = <&tegra_car TEGRA210_CLK_DFLL_REF>;
+		clock-names = "ref";
+		#pwm-cells = <2>;
+		pwm-regulator = <&cpu_ovr_reg>;
+
+		pinctrl-names = "dvfs_pwm_enable", "dvfs_pwm_disable";
+		pinctrl-0 = <&dvfs_pwm_active_state>;
+		pinctrl-1 = <&dvfs_pwm_inactive_state>;
+
+		status = "okay";
+	};
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c182efc..dd67cad 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -382,6 +382,16 @@ config PWM_TEGRA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tegra.
 
+config PWM_TEGRA_DFLL
+	tristate "NVIDIA Tegra DFLL PWM support"
+	depends on ARCH_TEGRA
+	help
+	  PWM driver support for the Tegra DFLL module found on NVIDIA
+	  Tegra SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-tegra-dfll.
+
 config  PWM_TIECAP
 	tristate "ECAP PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index dd35bc1..22414cb 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
+obj-$(CONFIG_PWM_TEGRA_DFLL)	+= pwm-tegra-dfll.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
 obj-$(CONFIG_PWM_TIPWMSS)	+= pwm-tipwmss.o
diff --git a/drivers/pwm/pwm-tegra-dfll.c b/drivers/pwm/pwm-tegra-dfll.c
new file mode 100644
index 0000000..74d6b97
--- /dev/null
+++ b/drivers/pwm/pwm-tegra-dfll.c
@@ -0,0 +1,322 @@
+/*
+ * drivers/pwm/pwm-tegra-dfll.c
+ *
+ * Tegra DFLL PWM controller driver
+ *
+ * Copyright (c) 2016, NVIDIA Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pwm.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/pinctrl/consumer.h>
+#include <soc/tegra/pwm-tegra-dfll.h>
+
+/* DFLL_CTRL: DFLL control register */
+#define DFLL_CTRL			0x00
+
+/* DFLL_OUTPUT_CFG: closed loop mode control registers */
+#define DFLL_OUTPUT_CFG			0x20
+#define OUT_MASK			0x3f
+#define DFLL_OUTPUT_CFG_PWM_DELTA	(0x1 << 7)
+#define DFLL_OUTPUT_CFG_PWM_ENABLE	(0x1 << 6)
+#define DFLL_OUTPUT_CFG_PWM_DIV_SHIFT	0
+#define DFLL_OUTPUT_CFG_PWM_DIV_MASK	\
+		(OUT_MASK << DFLL_OUTPUT_CFG_PWM_DIV_SHIFT)
+
+/* MAX_DFLL_VOLTAGES: number of LUT entries in the DFLL IP block */
+#define DFLL_MAX_VOLTAGES		33
+
+#define DFLL_OF_PWM_PERIOD_CELL		1
+
+/**
+ * struct tegra_dfll_pwm_chip - DFLL PWM controller data
+ * @pwm_pin: pinmux for PWM signals output
+ * @pwm_enable_state: enabled states of pinmux for PWM signals output
+ * @pwm_disable_state: disabled states of pinmux for PWM signals output
+ * @mmio_base: mmio base for access DFLL registers
+ * @ref_clk: referenced source clock
+ * @pwm_rate: PWM rate for DFLL PWM output config register
+ */
+struct tegra_dfll_pwm_chip {
+	struct pwm_chip		chip;
+	struct device		*dev;
+
+	struct pinctrl		*pwm_pin;
+	struct pinctrl_state	*pwm_enable_state;
+	struct pinctrl_state	*pwm_disable_state;
+
+	void __iomem		*mmio_base;
+	struct clk		*ref_clk;
+
+	unsigned long		ref_rate;
+	unsigned long		pwm_rate;
+};
+
+static struct tegra_dfll_pwm_chip *tdpc;
+
+/*
+ * Register accessors
+ */
+static inline u32 pwm_readl(u32 offs)
+{
+	return __raw_readl(tdpc->mmio_base + offs);
+}
+
+static inline void pwm_writel(u32 val, u32 offs)
+{
+	__raw_writel(val, tdpc->mmio_base + offs);
+	pwm_readl(DFLL_CTRL);
+}
+
+static int tegra_dfll_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+				int duty_ns, int period_ns)
+{
+	return 0;
+}
+
+static int tegra_dfll_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	u32 val;
+
+	val = pwm_readl(DFLL_OUTPUT_CFG);
+	val |= DFLL_OUTPUT_CFG_PWM_ENABLE;
+	pwm_writel(val, DFLL_OUTPUT_CFG);
+
+	dev_info(tdpc->dev, "DFLL_PWM is enabled\n");
+
+	return 0;
+}
+
+static void tegra_dfll_pwm_disable(struct pwm_chip *chip,
+				   struct pwm_device *pwm)
+{
+	u32 val;
+
+	val = pwm_readl(DFLL_OUTPUT_CFG);
+	val &= ~DFLL_OUTPUT_CFG_PWM_ENABLE;
+	pwm_writel(val, DFLL_OUTPUT_CFG);
+
+	dev_info(tdpc->dev, "DFLL_PWM is disabled\n");
+
+	return 0;
+}
+
+/**
+ * tegra_dfll_pwm_output_enable - enable DFLL PWM signals output
+ *
+ * Enable DFLL PWM signals output by changing related pinmux state
+ */
+int tegra_dfll_pwm_output_enable(void)
+{
+	int ret;
+
+	ret = pinctrl_select_state(tdpc->pwm_pin, tdpc->pwm_enable_state);
+	if (ret < 0) {
+		dev_err(tdpc->dev, "setting enable state failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_dfll_pwm_output_enable);
+
+/**
+ * tegra_dfll_pwm_output_disable - disable DFLL PWM signals output
+ *
+ * Disable DFLL PWM signals output by changing related pinmux state
+ */
+int tegra_dfll_pwm_output_disable(void)
+{
+	int ret;
+
+	ret = pinctrl_select_state(tdpc->pwm_pin, tdpc->pwm_disable_state);
+	if (ret < 0) {
+		dev_err(tdpc->dev, "setting enable state failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_dfll_pwm_output_disable);
+
+static const struct pwm_ops tegra_dfll_pwm_ops = {
+	.config = tegra_dfll_pwm_config,
+	.enable = tegra_dfll_pwm_enable,
+	.disable = tegra_dfll_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+/**
+ * dt_parse_pwm_regulator - parse PWM regulator from device-tree
+ *
+ * Parse DFLL PWM controller client to get and calcluate initialized
+ * DFLL PWM rate.
+ */
+static int dt_parse_pwm_regulator(void)
+{
+	struct device_node *r_dn =
+		of_parse_phandle(tdpc->dev->of_node, "pwm-regulator", 0);
+	struct of_phandle_args args;
+	unsigned long val;
+	int ret;
+
+	/* pwm regulator device */
+	if (!r_dn) {
+		dev_err(tdpc->dev, "DT: missing pwm-regulator property\n");
+		return -EINVAL;
+	}
+
+	ret = of_parse_phandle_with_args(r_dn, "pwms", "#pwm-cells", 0, &args);
+	if (ret) {
+		dev_err(tdpc->dev, "DT: failed to parse pwms property\n");
+		return -EINVAL;
+	}
+	of_node_put(args.np);
+
+	if (args.args_count <= DFLL_OF_PWM_PERIOD_CELL) {
+		dev_err(tdpc->dev, "DT: low #pwm-cells %d\n", args.args_count);
+		return -EINVAL;
+	}
+
+	/* convert pwm period in ns to DFLL pwm rate in Hz */
+	val = args.args[DFLL_OF_PWM_PERIOD_CELL];
+	val = (NSEC_PER_SEC / val) * (DFLL_MAX_VOLTAGES - 1);
+	tdpc->pwm_rate = val;
+	dev_info(tdpc->dev, "DFLL pwm-rate: %lu\n", val);
+
+	return 0;
+}
+
+/**
+ * tegra_dfll_pwm_init - init Tegra DFLL PWM controller
+ *
+ * Calculate the DIV value and write into DFLL register
+ */
+static int tegra_dfll_pwm_init(void)
+{
+	u32 div, val;
+
+	pwm_writel(0, DFLL_OUTPUT_CFG);
+
+	div = DIV_ROUND_UP(tdpc->ref_rate, tdpc->pwm_rate);
+	val = (div << DFLL_OUTPUT_CFG_PWM_DIV_SHIFT) &
+	      DFLL_OUTPUT_CFG_PWM_DIV_MASK;
+	pwm_writel(val, DFLL_OUTPUT_CFG);
+
+	return 0;
+}
+
+static int tegra_dfll_pwm_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret;
+
+	tdpc = devm_kzalloc(&pdev->dev, sizeof(*tdpc), GFP_KERNEL);
+	if (!tdpc)
+		return -ENOMEM;
+
+	tdpc->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	tdpc->mmio_base = devm_ioremap_resource(tdpc->dev, res);
+	if (IS_ERR(tdpc->mmio_base))
+		return PTR_ERR(tdpc->mmio_base);
+
+	platform_set_drvdata(pdev, tdpc);
+
+	tdpc->chip.dev = tdpc->dev;
+	tdpc->chip.ops = &tegra_dfll_pwm_ops;
+	tdpc->chip.base = -1;
+	tdpc->chip.npwm = 1;
+
+	ret = pwmchip_add(&tdpc->chip);
+	if (ret < 0) {
+		dev_err(tdpc->dev, "pwmchip_add() failed: %d\n", ret);
+		return ret;
+	}
+
+	tdpc->ref_clk = devm_clk_get(tdpc->dev, "ref");
+	if (IS_ERR(tdpc->ref_clk)) {
+		dev_err(tdpc->dev, "DT: missing ref clock\n");
+		return PTR_ERR(tdpc->ref_clk);
+	}
+
+	tdpc->ref_rate = clk_get_rate(tdpc->ref_clk);
+
+	tdpc->pwm_pin = devm_pinctrl_get(tdpc->dev);
+	if (IS_ERR(tdpc->pwm_pin)) {
+		dev_err(tdpc->dev, "DT: missing pinctrl device\n");
+		return PTR_ERR(tdpc->pwm_pin);
+	}
+
+	tdpc->pwm_enable_state = pinctrl_lookup_state(tdpc->pwm_pin,
+						"dvfs_pwm_enable");
+	if (IS_ERR(tdpc->pwm_enable_state)) {
+		dev_err(tdpc->dev, "DT: missing pwm enabled state\n");
+		return PTR_ERR(tdpc->pwm_enable_state);
+	}
+
+	tdpc->pwm_disable_state = pinctrl_lookup_state(tdpc->pwm_pin,
+						"dvfs_pwm_disable");
+	if (IS_ERR(tdpc->pwm_disable_state)) {
+		dev_err(tdpc->dev, "DT: missing pwm disabled state\n");
+		return PTR_ERR(tdpc->pwm_disable_state);
+	}
+
+	ret = dt_parse_pwm_regulator();
+	if (ret < 0) {
+		dev_err(tdpc->dev, "failed to parse pwm regulator\n");
+		return ret;
+	}
+
+	ret = tegra_dfll_pwm_init();
+	if (ret < 0) {
+		dev_err(tdpc->dev, "failed to init DFLL pwm\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tegra_dfll_pwm_remove(struct platform_device *pdev)
+{
+	return pwmchip_remove(&tdpc->chip);
+}
+
+static const struct of_device_id tegra_dfll_pwm_of_match[] = {
+	{ .compatible = "nvidia,tegra210-dfll-pwm" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, tegra_dfll_pwm_of_match);
+
+static struct platform_driver tegra_dfll_pwm_driver = {
+	.driver = {
+		.name = "tegra-dfll-pwm",
+		.of_match_table = tegra_dfll_pwm_of_match,
+	},
+	.probe = tegra_dfll_pwm_probe,
+	.remove = tegra_dfll_pwm_remove,
+};
+
+module_platform_driver(tegra_dfll_pwm_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("NVIDIA Corporation");
+MODULE_ALIAS("platform:tegra-dfll-pwm");
diff --git a/include/soc/tegra/pwm-tegra-dfll.h b/include/soc/tegra/pwm-tegra-dfll.h
new file mode 100644
index 0000000..d34c6e8
--- /dev/null
+++ b/include/soc/tegra/pwm-tegra-dfll.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2016 NVIDIA Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __SOC_TEGRA_PWM_TEGRA_DFLL_H__
+#define __SOC_TEGRA_PWM_TEGRA_DFLL_H__
+
+#ifdef CONFIG_PWM_TEGRA_DFLL
+int tegra_dfll_pwm_output_enable(void);
+int tegra_dfll_pwm_output_disable(void);
+#else
+static inline int tegra_dfll_pwm_output_enable(void)
+{
+	return -ENOTSUPP;
+}
+
+static inline int tegra_dfll_pwm_output_disable(void)
+{
+	return -ENOTSUPP;
+}
+#endif
+
+#endif /* __SOC_TEGRA_PWM_TEGRA_DFLL_H__ */
-- 
2.8.1

From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH v5 04/15] clk: qcom: Add HFPLL driver
Date: Tue, 19 Dec 2017 21:24:49 +0530
Message-ID: <1513698900-10638-5-git-send-email-sricharan@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbdLSP4c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Dec 2017 10:56:32 -0500
In-Reply-To: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: sricharan@codeaurora.org

From: Stephen Boyd <sboyd@codeaurora.org>

On some devices (MSM8974 for example), the HFPLLs are
instantiated within the Krait processor subsystem as separate
register regions. Add a driver for these PLLs so that we can
provide HFPLL clocks for use by the system.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/Kconfig  |  8 ++++
 drivers/clk/qcom/Makefile |  1 +
 drivers/clk/qcom/hfpll.c  | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 drivers/clk/qcom/hfpll.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 20b5d6f..6c811bd 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -205,3 +205,11 @@ config SPMI_PMIC_CLKDIV
 	  Technologies, Inc. SPMI PMIC. It configures the frequency of
 	  clkdiv outputs of the PMIC. These clocks are typically wired
 	  through alternate functions on GPIO pins.
+
+config QCOM_HFPLL
+	tristate "High-Frequency PLL (HFPLL) Clock Controller"
+	depends on COMMON_CLK_QCOM
+	help
+	  Support for the high-frequency PLLs present on Qualcomm devices.
+	  Say Y if you want to support CPU frequency scaling on devices
+	  such as MSM8974, APQ8084, etc.
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 4795e21..4a4bf38 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_MSM_MMCC_8996) += mmcc-msm8996.o
 obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
 obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
+obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
new file mode 100644
index 0000000..7443239
--- /dev/null
+++ b/drivers/clk/qcom/hfpll.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017, The Linux Foundation. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+
+#include "clk-regmap.h"
+#include "clk-hfpll.h"
+
+static const struct hfpll_data hdata = {
+	.mode_reg = 0x00,
+	.l_reg = 0x04,
+	.m_reg = 0x08,
+	.n_reg = 0x0c,
+	.user_reg = 0x10,
+	.config_reg = 0x14,
+	.config_val = 0x430405d,
+	.status_reg = 0x1c,
+	.lock_bit = 16,
+
+	.user_val = 0x8,
+	.user_vco_mask = 0x100000,
+	.low_vco_max_rate = 1248000000,
+	.min_rate = 537600000UL,
+	.max_rate = 2900000000UL,
+};
+
+static const struct of_device_id qcom_hfpll_match_table[] = {
+	{ .compatible = "qcom,hfpll" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qcom_hfpll_match_table);
+
+static const struct regmap_config hfpll_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x30,
+	.fast_io	= true,
+};
+
+static int qcom_hfpll_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	struct regmap *regmap;
+	struct clk_hfpll *h;
+	struct clk_init_data init = {
+		.parent_names = (const char *[]){ "xo" },
+		.num_parents = 1,
+		.ops = &clk_ops_hfpll,
+	};
+
+	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
+	if (!h)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, base, &hfpll_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	if (of_property_read_string_index(dev->of_node, "clock-output-names",
+					  0, &init.name))
+		return -ENODEV;
+
+	h->d = &hdata;
+	h->clkr.hw.init = &init;
+	spin_lock_init(&h->lock);
+
+	return devm_clk_register_regmap(&pdev->dev, &h->clkr);
+}
+
+static struct platform_driver qcom_hfpll_driver = {
+	.probe		= qcom_hfpll_probe,
+	.driver		= {
+		.name	= "qcom-hfpll",
+		.of_match_table = qcom_hfpll_match_table,
+	},
+};
+module_platform_driver(qcom_hfpll_driver);
+
+MODULE_DESCRIPTION("QCOM HFPLL Clock Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:qcom-hfpll");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v4 3/8] clk: add support for clocks provided by SCP(System Control Processor)
Date: Mon,  8 Jun 2015 11:39:57 +0100
Message-ID: <1433760002-24120-4-git-send-email-sudeep.holla@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On some ARM based systems, a separate Cortex-M based System Control
Processor(SCP) provides the overall power, clock, reset and system
control. System Control and Power Interface(SCPI) Message Protocol
is defined for the communication between the Application Cores(AP)
and the SCP.

This patch adds support for the clocks provided by SCP using SCPI
protocol.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/Kconfig    |  10 ++
 drivers/clk/Makefile   |   1 +
 drivers/clk/clk-scpi.c | 286 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 297 insertions(+)
 create mode 100644 drivers/clk/clk-scpi.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 9897f353bf1a..0fe8daefc105 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -59,6 +59,16 @@ config COMMON_CLK_RK808
 	  clocked at 32KHz each. Clkout1 is always on, Clkout2 can off
 	  by control register.
 
+config COMMON_CLK_SCPI
+        tristate "Clock driver controlled via SCPI interface"
+        depends on ARM_SCPI_PROTOCOL || COMPILE_TEST
+        ---help---
+          This driver provides support for clocks that are controlled
+          by firmware that implements the SCPI interface.
+
+	  This driver uses SCPI Message Protocol to interact with the
+	  firmware providing all the clock controls.
+
 config COMMON_CLK_SI5351
 	tristate "Clock driver for SiLabs 5351A/B/C"
 	depends on I2C
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 3d00c25382c5..442ab6ebd5b1 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
 obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
 obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
 obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
+obj-$(CONFIG_COMMON_CLK_SCPI)           += clk-scpi.o
 obj-$(CONFIG_COMMON_CLK_SI5351)		+= clk-si5351.o
 obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
 obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
new file mode 100644
index 000000000000..707b3430c55f
--- /dev/null
+++ b/drivers/clk/clk-scpi.c
@@ -0,0 +1,286 @@
+/*
+ * System Control and Power Interface (SCPI) Protocol based clock driver
+ *
+ * Copyright (C) 2015 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/scpi_protocol.h>
+
+struct scpi_clk {
+	u32 id;
+	const char *name;
+	struct clk_hw hw;
+	struct scpi_dvfs_info *info;
+	struct scpi_ops *scpi_ops;
+};
+
+#define to_scpi_clk(clk) container_of(clk, struct scpi_clk, hw)
+
+static unsigned long scpi_clk_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct scpi_clk *clk = to_scpi_clk(hw);
+
+	return clk->scpi_ops->clk_get_val(clk->id);
+}
+
+static long scpi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	return rate;
+}
+
+static int scpi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct scpi_clk *clk = to_scpi_clk(hw);
+
+	return clk->scpi_ops->clk_set_val(clk->id, rate);
+}
+
+static void scpi_clk_disable(struct clk_hw *hw)
+{
+	scpi_clk_set_rate(hw, 0, 0);
+}
+
+static const struct clk_ops scpi_clk_ops = {
+	.recalc_rate = scpi_clk_recalc_rate,
+	.round_rate = scpi_clk_round_rate,
+	.set_rate = scpi_clk_set_rate,
+	.disable = scpi_clk_disable,
+};
+
+/* find closest match to given frequency in OPP table */
+static int __scpi_dvfs_round_rate(struct scpi_clk *clk, unsigned long rate)
+{
+	int idx;
+	u32 fmin = 0, fmax = ~0, ftmp;
+	struct scpi_opp *opp = clk->info->opps;
+
+	for (idx = 0; idx < clk->info->count; idx++, opp++) {
+		ftmp = opp->freq;
+		if (ftmp >= (u32)rate) {
+			if (ftmp <= fmax)
+				fmax = ftmp;
+			break;
+		} else if (ftmp >= fmin) {
+			fmin = ftmp;
+		}
+	}
+	return fmax != ~0 ? fmax : fmin;
+}
+
+static unsigned long scpi_dvfs_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct scpi_clk *clk = to_scpi_clk(hw);
+	int idx = clk->scpi_ops->dvfs_get_idx(clk->id);
+	struct scpi_opp *opp;
+
+	if (idx < 0)
+		return 0;
+
+	opp = clk->info->opps + idx;
+	return opp->freq;
+}
+
+static long scpi_dvfs_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *parent_rate)
+{
+	struct scpi_clk *clk = to_scpi_clk(hw);
+
+	return __scpi_dvfs_round_rate(clk, rate);
+}
+
+static int __scpi_find_dvfs_index(struct scpi_clk *clk, unsigned long rate)
+{
+	int idx, max_opp = clk->info->count;
+	struct scpi_opp *opp = clk->info->opps;
+
+	for (idx = 0; idx < max_opp; idx++, opp++)
+		if (opp->freq == rate)
+			return idx;
+	return -EINVAL;
+}
+
+static int scpi_dvfs_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct scpi_clk *clk = to_scpi_clk(hw);
+	int ret = __scpi_find_dvfs_index(clk, rate);
+
+	if (ret < 0)
+		return ret;
+	return clk->scpi_ops->dvfs_set_idx(clk->id, (u8)ret);
+}
+
+static const struct clk_ops scpi_dvfs_ops = {
+	.recalc_rate = scpi_dvfs_recalc_rate,
+	.round_rate = scpi_dvfs_round_rate,
+	.set_rate = scpi_dvfs_set_rate,
+};
+
+static const struct of_device_id scpi_clk_match[] = {
+	{ .compatible = "arm,scpi-dvfs-clocks", .data = &scpi_dvfs_ops, },
+	{ .compatible = "arm,scpi-variable-clocks", .data = &scpi_clk_ops, },
+	{}
+};
+
+static struct clk *
+scpi_clk_ops_init(struct device *dev, const struct of_device_id *match,
+		  struct scpi_clk *sclk)
+{
+	struct clk_init_data init;
+	struct clk *clk;
+	unsigned long min = 0, max = 0;
+
+	init.name = sclk->name;
+	init.flags = CLK_IS_ROOT;
+	init.num_parents = 0;
+	init.ops = match->data;
+	sclk->hw.init = &init;
+	sclk->scpi_ops = get_scpi_ops();
+
+	if (init.ops == &scpi_dvfs_ops) {
+		sclk->info = sclk->scpi_ops->dvfs_get_info(sclk->id);
+		if (IS_ERR(sclk->info))
+			return NULL;
+	} else if (init.ops == &scpi_clk_ops) {
+		if (sclk->scpi_ops->clk_get_range(sclk->id, &min, &max) || !max)
+			return NULL;
+	} else {
+		return NULL;
+	}
+
+	clk = devm_clk_register(dev, &sclk->hw);
+	if (!IS_ERR(clk) && max)
+		clk_set_rate_range(clk, min, max);
+	return clk;
+}
+
+static int scpi_clk_add(struct device *dev, struct device_node *np,
+			const struct of_device_id *match)
+{
+	struct clk **clks;
+	int idx, count;
+	struct clk_onecell_data *clk_data;
+
+	count = of_property_count_strings(np, "clock-output-names");
+	if (count < 0) {
+		dev_err(dev, "%s: invalid clock output count\n", np->name);
+		return -EINVAL;
+	}
+
+	clk_data = devm_kmalloc(dev, sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clks = devm_kcalloc(dev, count, sizeof(*clks), GFP_KERNEL);
+	if (!clks)
+		return -ENOMEM;
+
+	for (idx = 0; idx < count; idx++) {
+		struct scpi_clk *sclk;
+		u32 val;
+
+		sclk = devm_kzalloc(dev, sizeof(*sclk), GFP_KERNEL);
+		if (!sclk)
+			return -ENOMEM;
+
+		if (of_property_read_string_index(np, "clock-output-names",
+						  idx, &sclk->name)) {
+			dev_err(dev, "invalid clock name @ %s\n", np->name);
+			return -EINVAL;
+		}
+
+		if (of_property_read_u32_index(np, "clock-indices",
+					       idx, &val)) {
+			dev_err(dev, "invalid clock index @ %s\n", np->name);
+			return -EINVAL;
+		}
+
+		sclk->id = val;
+
+		clks[idx] = scpi_clk_ops_init(dev, match, sclk);
+		if (IS_ERR_OR_NULL(clks[idx]))
+			dev_err(dev, "failed to register clock '%s'\n",
+				sclk->name);
+		else
+			dev_dbg(dev, "Registered clock '%s'\n", sclk->name);
+	}
+
+	clk_data->clks = clks;
+	clk_data->clk_num = idx;
+
+	return of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
+}
+
+static int scpi_clocks_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *child, *np = dev->of_node;
+
+	for_each_available_child_of_node(np, child)
+		of_clk_del_provider(np);
+	return 0;
+}
+
+static int scpi_clocks_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct device_node *child, *np = dev->of_node;
+	const struct of_device_id *match;
+
+	if (!get_scpi_ops())
+		return -ENXIO;
+
+	for_each_available_child_of_node(np, child) {
+		match = of_match_node(scpi_clk_match, child);
+		if (!match)
+			continue;
+		ret = scpi_clk_add(dev, child, match);
+		if (ret) {
+			scpi_clocks_remove(pdev);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static const struct of_device_id scpi_clocks_ids[] = {
+	{ .compatible = "arm,scpi-clocks", },
+	{}
+};
+
+static struct platform_driver scpi_clocks_driver = {
+	.driver	= {
+		.name = "scpi_clocks",
+		.of_match_table = scpi_clocks_ids,
+	},
+	.probe = scpi_clocks_probe,
+	.remove = scpi_clocks_remove,
+};
+module_platform_driver(scpi_clocks_driver);
+
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("ARM SCPI clock driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

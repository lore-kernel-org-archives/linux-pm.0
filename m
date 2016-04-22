From: Penny Chiu <pchiu@nvidia.com>
Subject: [PATCH 03/11] clk: tegra: Add DFLL DVCO reset control for Tegra210
Date: Fri, 22 Apr 2016 18:31:03 +0800
Message-ID: <1461321071-6431-4-git-send-email-pchiu@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Penny Chiu <pchiu@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The DVCO present in the DFLL IP block has a separate reset line,
exposed via the CAR IP block.  This reset line is asserted upon SoC
reset.  Unless something (such as the DFLL driver) deasserts this
line, the DVCO will not oscillate, although reads and writes to the
DFLL IP block will complete.

Signed-off-by: Penny Chiu <pchiu@nvidia.com>
---
 drivers/clk/tegra/clk-tegra210.c         | 68 ++++++++++++++++++++++++++++++++
 include/dt-bindings/reset/tegra210-car.h | 12 ++++++
 2 files changed, 80 insertions(+)
 create mode 100644 include/dt-bindings/reset/tegra210-car.h

diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index d3709b1..3d70b38 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -24,6 +24,7 @@
 #include <linux/export.h>
 #include <linux/clk/tegra.h>
 #include <dt-bindings/clock/tegra210-car.h>
+#include <dt-bindings/reset/tegra210-car.h>
 
 #include "clk.h"
 #include "clk-id.h"
@@ -39,6 +40,9 @@
 #define CLK_SOURCE_CSITE 0x1d4
 #define CLK_SOURCE_EMC 0x19c
 
+#define RST_DFLL_DVCO 0x2f4
+#define DVFS_DFLL_RESET_SHIFT 0
+
 #define PLLC_BASE 0x80
 #define PLLC_OUT 0x84
 #define PLLC_MISC0 0x88
@@ -2781,6 +2785,68 @@ static void __init tegra210_clock_apply_init_table(void)
 }
 
 /**
+ * tegra210_car_barrier - wait for pending writes to the CAR to complete
+ *
+ * Wait for any outstanding writes to the CAR MMIO space from this CPU
+ * to complete before continuing execution.  No return value.
+ */
+static void tegra210_car_barrier(void)
+{
+	readl_relaxed(clk_base + RST_DFLL_DVCO);
+}
+
+/**
+ * tegra210_clock_assert_dfll_dvco_reset - assert the DFLL's DVCO reset
+ *
+ * Assert the reset line of the DFLL's DVCO.  No return value.
+ */
+static void tegra210_clock_assert_dfll_dvco_reset(void)
+{
+	u32 v;
+
+	v = readl_relaxed(clk_base + RST_DFLL_DVCO);
+	v |= (1 << DVFS_DFLL_RESET_SHIFT);
+	writel_relaxed(v, clk_base + RST_DFLL_DVCO);
+	tegra210_car_barrier();
+}
+
+/**
+ * tegra210_clock_deassert_dfll_dvco_reset - deassert the DFLL's DVCO reset
+ *
+ * Deassert the reset line of the DFLL's DVCO, allowing the DVCO to
+ * operate.  No return value.
+ */
+static void tegra210_clock_deassert_dfll_dvco_reset(void)
+{
+	u32 v;
+
+	v = readl_relaxed(clk_base + RST_DFLL_DVCO);
+	v &= ~(1 << DVFS_DFLL_RESET_SHIFT);
+	writel_relaxed(v, clk_base + RST_DFLL_DVCO);
+	tegra210_car_barrier();
+}
+
+static int tegra210_reset_assert(unsigned long id)
+{
+	if (id == TEGRA210_RST_DFLL_DVCO)
+		tegra210_clock_assert_dfll_dvco_reset();
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int tegra210_reset_deassert(unsigned long id)
+{
+	if (id == TEGRA210_RST_DFLL_DVCO)
+		tegra210_clock_deassert_dfll_dvco_reset();
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
  * tegra210_clock_init - Tegra210-specific clock initialization
  * @np: struct device_node * of the DT node for the SoC CAR IP block
  *
@@ -2844,6 +2910,8 @@ static void __init tegra210_clock_init(struct device_node *np)
 
 	tegra_super_clk_gen5_init(clk_base, pmc_base, tegra210_clks,
 				  &pll_x_params);
+	tegra_init_special_resets(1, tegra210_reset_assert,
+				tegra210_reset_deassert);
 	tegra_add_of_provider(np);
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
diff --git a/include/dt-bindings/reset/tegra210-car.h b/include/dt-bindings/reset/tegra210-car.h
new file mode 100644
index 0000000..a8632af
--- /dev/null
+++ b/include/dt-bindings/reset/tegra210-car.h
@@ -0,0 +1,12 @@
+/*
+ * This header provides Tegra210-specific constants for binding
+ * nvidia,tegra210-car.
+ */
+
+#ifndef _DT_BINDINGS_RESET_TEGRA210_CAR_H
+#define _DT_BINDINGS_RESET_TEGRA210_CAR_H
+
+#define TEGRA210_RESET(x)		(7 * 32 + (x))
+#define TEGRA210_RST_DFLL_DVCO		TEGRA210_RESET(0)
+
+#endif	/* _DT_BINDINGS_RESET_TEGRA210_CAR_H */
-- 
2.8.1

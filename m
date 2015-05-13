From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH v9 05/17] clk: tegra: Introduce ability for SoC-specific reset control callbacks
Date: Wed, 13 May 2015 17:58:39 +0300
Message-ID: <1431529131-16710-6-git-send-email-mikko.perttunen@kapsi.fi>
References: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Mikko Perttunen <mikko.perttunen@kapsi.fi>
List-Id: linux-pm@vger.kernel.org

This patch allows SoC-specific CAR initialization routines to register
their own reset_assert and reset_deassert callbacks with the common Tegra
CAR code. If defined, the common code will call these callbacks when a
reset control with number >= 0x40000000 is attempted to be asserted or
deasserted respectively. The callback should return -EINVAL if the number
of the reset control is invalid. Numbers greater than or equal to 0x40000000
are used to avoid clashes with low numbers that are automatically mapped to
standard CAR reset lines. Furthermore, numbers with the most significant bit
set should not be used, as some functions interpret these as negative error
codes.

Each SoC with these special resets should specify the defined reset control
numbers in a device tree header file.

Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Acked-by: Michael Turquette <mturquette@linaro.org>
---
 drivers/clk/tegra/clk.c | 36 ++++++++++++++++++++++++++++--------
 drivers/clk/tegra/clk.h |  3 +++
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index 41cd87c..d4e4c31 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -49,7 +49,6 @@
 #define RST_DEVICES_L			0x004
 #define RST_DEVICES_H			0x008
 #define RST_DEVICES_U			0x00C
-#define RST_DFLL_DVCO			0x2F4
 #define RST_DEVICES_V			0x358
 #define RST_DEVICES_W			0x35C
 #define RST_DEVICES_X			0x28C
@@ -79,6 +78,10 @@ static struct clk **clks;
 static int clk_num;
 static struct clk_onecell_data clk_data;
 
+/* Handlers for SoC-specific reset lines */
+static int (*reset_assert)(unsigned long);
+static int (*reset_deassert)(unsigned long);
+
 static struct tegra_clk_periph_regs periph_regs[] = {
 	[0] = {
 		.enb_reg = CLK_OUT_ENB_L,
@@ -152,19 +155,29 @@ static int tegra_clk_rst_assert(struct reset_controller_dev *rcdev,
 	 */
 	tegra_read_chipid();
 
-	writel_relaxed(BIT(id % 32),
-			clk_base + periph_regs[id / 32].rst_set_reg);
+	if (id >= 0x40000000 && reset_assert) {
+		return reset_assert(id);
+	} else if (id < clk_num * 32) {
+		writel_relaxed(BIT(id % 32),
+			       clk_base + periph_regs[id / 32].rst_set_reg);
+		return 0;
+	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static int tegra_clk_rst_deassert(struct reset_controller_dev *rcdev,
 		unsigned long id)
 {
-	writel_relaxed(BIT(id % 32),
-			clk_base + periph_regs[id / 32].rst_clr_reg);
+	if (id >= 0x40000000 && reset_deassert) {
+		return reset_deassert(id);
+	} else if (id < clk_num * 32) {
+		writel_relaxed(BIT(id % 32),
+			       clk_base + periph_regs[id / 32].rst_clr_reg);
+		return 0;
+	}
 
-	return 0;
+	return -EINVAL;
 }
 
 struct tegra_clk_periph_regs *get_reg_bank(int clkid)
@@ -286,10 +299,17 @@ void __init tegra_add_of_provider(struct device_node *np)
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
 	rst_ctlr.of_node = np;
-	rst_ctlr.nr_resets = periph_banks * 32;
+	rst_ctlr.nr_resets = 0x80000000;
 	reset_controller_register(&rst_ctlr);
 }
 
+void __init tegra_init_special_resets(int (*assert)(unsigned long),
+				      int (*deassert)(unsigned long))
+{
+	reset_assert = assert;
+	reset_deassert = deassert;
+}
+
 void __init tegra_register_devclks(struct tegra_devclk *dev_clks, int num)
 {
 	int i;
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 75ddc8ff..5f88c9d 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -591,6 +591,9 @@ struct tegra_devclk {
 	char		*con_id;
 };
 
+void tegra_init_special_resets(int (*assert)(unsigned long),
+			       int (*deassert)(unsigned long));
+
 void tegra_init_from_table(struct tegra_clk_init_table *tbl,
 		struct clk *clks[], int clk_max);
 
-- 
2.3.0

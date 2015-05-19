From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH v10 05/17] clk: tegra: Introduce ability for SoC-specific reset control callbacks
Date: Tue, 19 May 2015 14:39:27 +0300
Message-ID: <1432035567-19008-1-git-send-email-mikko.perttunen@kapsi.fi>
References: <1431529131-16710-6-git-send-email-mikko.perttunen@kapsi.fi>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:32994 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbbESLmz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 May 2015 07:42:55 -0400
In-Reply-To: <1431529131-16710-6-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com
Cc: mturquette@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Mikko Perttunen <mikko.perttunen@kapsi.fi>

This patch allows SoC-specific CAR initialization routines to register
their own reset_assert and reset_deassert callbacks with the common Tegra
CAR code. If defined, the common code will call these callbacks when a
reset control with number >= num_periph_banks * 32 is attempted to be asserted 
or deasserted respectively. Numbers greater than or equal to num_periph_banks * 32
are used to avoid clashes with low numbers that are automatically mapped to
standard CAR reset lines.

Each SoC with these special resets should specify the defined reset control
numbers in a device tree header file.

Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Acked-by: Michael Turquette <mturquette@linaro.org>
---
 drivers/clk/tegra/clk.c | 39 +++++++++++++++++++++++++++++++--------
 drivers/clk/tegra/clk.h |  3 +++
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index 41cd87c..c093ed9 100644
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
@@ -79,6 +78,11 @@ static struct clk **clks;
 static int clk_num;
 static struct clk_onecell_data clk_data;
 
+/* Handlers for SoC-specific reset lines */
+static int (*special_reset_assert)(unsigned long);
+static int (*special_reset_deassert)(unsigned long);
+static int special_reset_num;
+
 static struct tegra_clk_periph_regs periph_regs[] = {
 	[0] = {
 		.enb_reg = CLK_OUT_ENB_L,
@@ -152,19 +156,29 @@ static int tegra_clk_rst_assert(struct reset_controller_dev *rcdev,
 	 */
 	tegra_read_chipid();
 
-	writel_relaxed(BIT(id % 32),
-			clk_base + periph_regs[id / 32].rst_set_reg);
+	if (id < periph_banks * 32) {
+		writel_relaxed(BIT(id % 32),
+			       clk_base + periph_regs[id / 32].rst_set_reg);
+		return 0;
+	} else if (id < periph_banks * 32 + special_reset_num) {
+		return special_reset_assert(id);
+	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static int tegra_clk_rst_deassert(struct reset_controller_dev *rcdev,
 		unsigned long id)
 {
-	writel_relaxed(BIT(id % 32),
-			clk_base + periph_regs[id / 32].rst_clr_reg);
+	if (id < periph_banks * 32) {
+		writel_relaxed(BIT(id % 32),
+			       clk_base + periph_regs[id / 32].rst_clr_reg);
+		return 0;
+	} else if (id < periph_banks * 32 + special_reset_num) {
+		return special_reset_deassert(id);
+	}
 
-	return 0;
+	return -EINVAL;
 }
 
 struct tegra_clk_periph_regs *get_reg_bank(int clkid)
@@ -286,10 +300,19 @@ void __init tegra_add_of_provider(struct device_node *np)
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
 	rst_ctlr.of_node = np;
-	rst_ctlr.nr_resets = periph_banks * 32;
+	rst_ctlr.nr_resets = periph_banks * 32 + special_reset_num;
 	reset_controller_register(&rst_ctlr);
 }
 
+void __init tegra_init_special_resets(int num,
+				      int (*assert)(unsigned long),
+				      int (*deassert)(unsigned long))
+{
+	special_reset_num = num;
+	special_reset_assert = assert;
+	special_reset_deassert = deassert;
+}
+
 void __init tegra_register_devclks(struct tegra_devclk *dev_clks, int num)
 {
 	int i;
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 75ddc8ff..f42cbbe 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -591,6 +591,9 @@ struct tegra_devclk {
 	char		*con_id;
 };
 
+void tegra_init_special_resets(int num, int (*assert)(unsigned long),
+			       int (*deassert)(unsigned long));
+
 void tegra_init_from_table(struct tegra_clk_init_table *tbl,
 		struct clk *clks[], int clk_max);
 
-- 
2.3.0


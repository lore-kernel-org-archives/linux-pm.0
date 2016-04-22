From: Penny Chiu <pchiu@nvidia.com>
Subject: [PATCH 02/11] clk: tegra: dfll: Move SoC specific data into of_device_id
Date: Fri, 22 Apr 2016 18:31:02 +0800
Message-ID: <1461321071-6431-3-git-send-email-pchiu@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Penny Chiu <pchiu@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Move all SoC specific fcpu data into of_device_id structure, and
move SoC fcpu data assignments from init function to probe
function.

Signed-off-by: Penny Chiu <pchiu@nvidia.com>
---
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 51 ++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index 5e5958e..b577bc6 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <soc/tegra/fuse.h>
 
@@ -28,8 +29,15 @@
 #include "clk-dfll.h"
 #include "cvb.h"
 
+struct dfll_fcpu_data {
+	const unsigned long *cpu_max_freq_table;
+	unsigned int cpu_max_freq_table_size;
+	const struct cvb_table *cpu_cvb_tables;
+	unsigned int cpu_cvb_tables_size;
+};
+
 /* Maximum CPU frequency, indexed by CPU speedo id */
-static const unsigned long cpu_max_freq_table[] = {
+static const unsigned long tegra124_cpu_max_freq_table[] = {
 	[0] = 2014500000UL,
 	[1] = 2320500000UL,
 	[2] = 2116500000UL,
@@ -79,18 +87,39 @@ static const struct cvb_table tegra124_cpu_cvb_tables[] = {
 	},
 };
 
+static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
+	.cpu_max_freq_table = tegra124_cpu_max_freq_table,
+	.cpu_max_freq_table_size = ARRAY_SIZE(tegra124_cpu_max_freq_table),
+	.cpu_cvb_tables = tegra124_cpu_cvb_tables,
+	.cpu_cvb_tables_size = ARRAY_SIZE(tegra124_cpu_cvb_tables)
+};
+
+static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
+	{
+		.compatible = "nvidia,tegra124-dfll",
+		.data = &tegra124_dfll_fcpu_data
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tegra124_dfll_fcpu_of_match);
+
 static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 {
 	int process_id, speedo_id, speedo_value, ret;
 	struct rail_alignment align;
 	struct tegra_dfll_soc_data *soc;
 	const struct cvb_table *cvb;
+	const struct of_device_id *of_id;
+	const struct dfll_fcpu_data *fcpu_data;
+
+	of_id = of_match_device(tegra124_dfll_fcpu_of_match, &pdev->dev);
+	fcpu_data = of_id->data;
 
 	process_id = tegra_sku_info.cpu_process_id;
 	speedo_id = tegra_sku_info.cpu_speedo_id;
 	speedo_value = tegra_sku_info.cpu_speedo_value;
 
-	if (speedo_id >= ARRAY_SIZE(cpu_max_freq_table)) {
+	if (speedo_id >= fcpu_data->cpu_max_freq_table_size) {
 		dev_err(&pdev->dev, "unknown max CPU freq for speedo_id=%d\n",
 			speedo_id);
 		return -ENODEV;
@@ -121,12 +150,12 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	cvb = tegra_cvb_build_opp_table(tegra124_cpu_cvb_tables,
-					ARRAY_SIZE(tegra124_cpu_cvb_tables),
-					&align,
-					process_id, speedo_id, speedo_value,
-					cpu_max_freq_table[speedo_id],
-					soc->dev);
+	cvb = tegra_cvb_build_opp_table(fcpu_data->cpu_cvb_tables,
+				fcpu_data->cpu_cvb_tables_size,
+				&align,
+				process_id, speedo_id, speedo_value,
+				fcpu_data->cpu_max_freq_table[speedo_id],
+				soc->dev);
 	if (IS_ERR(cvb)) {
 		dev_err(&pdev->dev, "couldn't build OPP table: %ld\n",
 			PTR_ERR(cvb));
@@ -142,12 +171,6 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 	return tegra_dfll_register(pdev, soc);
 }
 
-static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
-	{ .compatible = "nvidia,tegra124-dfll", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, tegra124_dfll_fcpu_of_match);
-
 static const struct dev_pm_ops tegra124_dfll_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_dfll_runtime_suspend,
 			   tegra_dfll_runtime_resume, NULL)
-- 
2.8.1

From: Penny Chiu <pchiu@nvidia.com>
Subject: [PATCH 01/11] clk: tegra: dfll: Fix voltage comparison
Date: Fri, 22 Apr 2016 18:31:01 +0800
Message-ID: <1461321071-6431-2-git-send-email-pchiu@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Penny Chiu <pchiu@nvidia.com>
List-Id: linux-pm@vger.kernel.org

When generating opp table, the voltage is round down based on the
alignment in cvb table. This alignment should be also applied on all
voltage comparison. By the way, the alignment voltage values should
depend on regulator device specification, so these values should not
be hard code in cvb table. To Move these values into devicetree will
be more independent for different platforms using the same SoC.

Signed-off-by: Penny Chiu <pchiu@nvidia.com>
---
 .../bindings/clock/nvidia,tegra124-dfll.txt        |  9 ++++++++
 drivers/clk/tegra/clk-dfll.c                       | 27 +++++++++++++---------
 drivers/clk/tegra/clk-dfll.h                       |  1 +
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         | 23 ++++++++++++++----
 drivers/clk/tegra/cvb.c                            | 12 ++++++----
 drivers/clk/tegra/cvb.h                            |  8 ++++---
 6 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
index ee7e5fd..84080a8 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
@@ -34,6 +34,14 @@ Required properties:
   hardware will start controlling. The regulator will be queried for
   the I2C register, control values and supported voltages.
 
+Reguired properties for build voltage table:
+- nvidia,align-step-uv: Step uV of regulator for CPU voltage rail. This
+  value will be applied when building frequency-voltage table to ensure
+  all calculated voltages will be aligned to voltages regulator supplied.
+
+Optional properties for build voltage table:
+- nvidia,align-offset-uv: Offset uV for calculating DFLL output voltage.
+
 Required properties for the control loop parameters:
 - nvidia,sample-rate: Sample rate of the DFLL control loop.
 - nvidia,droop-ctrl: See the register CL_DVFS_DROOP_CTRL in the TRM.
@@ -68,6 +76,7 @@ clock@0,70110000 {
         vdd-cpu-supply = <&vdd_cpu>;
         status = "okay";
 
+        nvidia,align-step-uv = <10000>; /* 10mv */
         nvidia,sample-rate = <12500>;
         nvidia,droop-ctrl = <0x00000f00>;
         nvidia,force-mode = <1>;
diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index 19bfa07..a279467 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -630,7 +630,7 @@ static void dfll_init_out_if(struct tegra_dfll *td)
 static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
 {
 	struct dev_pm_opp *opp;
-	int i, uv;
+	int i, align_volt;
 
 	rcu_read_lock();
 
@@ -639,12 +639,13 @@ static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
 		rcu_read_unlock();
 		return PTR_ERR(opp);
 	}
-	uv = dev_pm_opp_get_voltage(opp);
+	align_volt = dev_pm_opp_get_voltage(opp) / td->soc->alignment;
 
 	rcu_read_unlock();
 
 	for (i = 0; i < td->i2c_lut_size; i++) {
-		if (regulator_list_voltage(td->vdd_reg, td->i2c_lut[i]) == uv)
+		if ((regulator_list_voltage(td->vdd_reg, td->i2c_lut[i]) /
+				td->soc->alignment) == align_volt)
 			return i;
 	}
 
@@ -1380,15 +1381,17 @@ di_err1:
  */
 static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
 {
-	int i, n_voltages, reg_uV;
+	int i, n_voltages, reg_volt, align_volt;
 
+	align_volt = uV / td->soc->alignment;
 	n_voltages = regulator_count_voltages(td->vdd_reg);
 	for (i = 0; i < n_voltages; i++) {
-		reg_uV = regulator_list_voltage(td->vdd_reg, i);
-		if (reg_uV < 0)
+		reg_volt = regulator_list_voltage(td->vdd_reg, i) /
+					td->soc->alignment;
+		if (reg_volt < 0)
 			break;
 
-		if (uV == reg_uV)
+		if (align_volt == reg_volt)
 			return i;
 	}
 
@@ -1402,15 +1405,17 @@ static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
  * */
 static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
 {
-	int i, n_voltages, reg_uV;
+	int i, n_voltages, reg_volt, align_volt;
 
+	align_volt = uV / td->soc->alignment;
 	n_voltages = regulator_count_voltages(td->vdd_reg);
 	for (i = 0; i < n_voltages; i++) {
-		reg_uV = regulator_list_voltage(td->vdd_reg, i);
-		if (reg_uV < 0)
+		reg_volt = regulator_list_voltage(td->vdd_reg, i) /
+					td->soc->alignment;
+		if (reg_volt < 0)
 			break;
 
-		if (uV <= reg_uV)
+		if (align_volt <= reg_volt)
 			return i;
 	}
 
diff --git a/drivers/clk/tegra/clk-dfll.h b/drivers/clk/tegra/clk-dfll.h
index 2e4c077..5714691 100644
--- a/drivers/clk/tegra/clk-dfll.h
+++ b/drivers/clk/tegra/clk-dfll.h
@@ -37,6 +37,7 @@
 struct tegra_dfll_soc_data {
 	struct device *dev;
 	unsigned int min_millivolts;
+	unsigned int alignment;
 	u32 tune0_low;
 	u32 tune0_high;
 	u32 tune1;
diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index 6125333..5e5958e 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -42,9 +42,6 @@ static const struct cvb_table tegra124_cpu_cvb_tables[] = {
 		.process_id = -1,
 		.min_millivolts = 900,
 		.max_millivolts = 1260,
-		.alignment = {
-			.step_uv = 10000, /* 10mV */
-		},
 		.speedo_scale = 100,
 		.voltage_scale = 1000,
 		.cvb_table = {
@@ -84,7 +81,8 @@ static const struct cvb_table tegra124_cpu_cvb_tables[] = {
 
 static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 {
-	int process_id, speedo_id, speedo_value;
+	int process_id, speedo_id, speedo_value, ret;
+	struct rail_alignment align;
 	struct tegra_dfll_soc_data *soc;
 	const struct cvb_table *cvb;
 
@@ -108,8 +106,24 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ret = of_property_read_u32(pdev->dev.of_node, "nvidia,align-offset-uv",
+					&align.offset_uv);
+	if (ret < 0) {
+		dev_dbg(&pdev->dev,
+			"offset uv not found, the default value will be 0\n");
+		align.offset_uv = 0;
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node, "nvidia,align-step-uv",
+					&align.step_uv);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "missing step uv\n");
+		return -EINVAL;
+	}
+
 	cvb = tegra_cvb_build_opp_table(tegra124_cpu_cvb_tables,
 					ARRAY_SIZE(tegra124_cpu_cvb_tables),
+					&align,
 					process_id, speedo_id, speedo_value,
 					cpu_max_freq_table[speedo_id],
 					soc->dev);
@@ -120,6 +134,7 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 	}
 
 	soc->min_millivolts = cvb->min_millivolts;
+	soc->alignment = align.step_uv;
 	soc->tune0_low = cvb->cpu_dfll_data.tune0_low;
 	soc->tune0_high = cvb->cpu_dfll_data.tune0_high;
 	soc->tune1 = cvb->cpu_dfll_data.tune1;
diff --git a/drivers/clk/tegra/cvb.c b/drivers/clk/tegra/cvb.c
index 69c74ee..a3be166 100644
--- a/drivers/clk/tegra/cvb.c
+++ b/drivers/clk/tegra/cvb.c
@@ -62,13 +62,13 @@ static int round_voltage(int mv, const struct rail_alignment *align, int up)
 }
 
 static int build_opp_table(const struct cvb_table *d,
+			   const struct rail_alignment *align,
 			   int speedo_value,
 			   unsigned long max_freq,
 			   struct device *opp_dev)
 {
 	int i, ret, dfll_mv, min_mv, max_mv;
 	const struct cvb_table_freq_entry *table = NULL;
-	const struct rail_alignment *align = &d->alignment;
 
 	min_mv = round_voltage(d->min_millivolts, align, UP);
 	max_mv = round_voltage(d->max_millivolts, align, DOWN);
@@ -110,8 +110,11 @@ static int build_opp_table(const struct cvb_table *d,
  */
 const struct cvb_table *tegra_cvb_build_opp_table(
 		const struct cvb_table *cvb_tables,
-		size_t sz, int process_id,
-		int speedo_id, int speedo_value,
+		size_t sz,
+		const struct rail_alignment *align,
+		int process_id,
+		int speedo_id,
+		int speedo_value,
 		unsigned long max_rate,
 		struct device *opp_dev)
 {
@@ -125,7 +128,8 @@ const struct cvb_table *tegra_cvb_build_opp_table(
 		if (d->process_id != -1 && d->process_id != process_id)
 			continue;
 
-		ret = build_opp_table(d, speedo_value, max_rate, opp_dev);
+		ret = build_opp_table(
+			d, align, speedo_value, max_rate, opp_dev);
 		return ret ? ERR_PTR(ret) : d;
 	}
 
diff --git a/drivers/clk/tegra/cvb.h b/drivers/clk/tegra/cvb.h
index f62cdc4..4964c49 100644
--- a/drivers/clk/tegra/cvb.h
+++ b/drivers/clk/tegra/cvb.h
@@ -49,7 +49,6 @@ struct cvb_table {
 
 	int min_millivolts;
 	int max_millivolts;
-	struct rail_alignment alignment;
 
 	int speedo_scale;
 	int voltage_scale;
@@ -59,8 +58,11 @@ struct cvb_table {
 
 const struct cvb_table *tegra_cvb_build_opp_table(
 		const struct cvb_table *cvb_tables,
-		size_t sz, int process_id,
-		int speedo_id, int speedo_value,
+		size_t sz,
+		const struct rail_alignment *align,
+		int process_id,
+		int speedo_id,
+		int speedo_value,
 		unsigned long max_rate,
 		struct device *opp_dev);
 
-- 
2.8.1

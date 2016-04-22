From: Penny Chiu <pchiu@nvidia.com>
Subject: [PATCH 06/11] clk: tegra: dfll: Add PWM inferface
Date: Fri, 22 Apr 2016 18:31:06 +0800
Message-ID: <1461321071-6431-7-git-send-email-pchiu@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, Penny Chiu <pchiu@nvidia.com>, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The DFLL module can autonomously change the supply voltage by
communicating with an off-chip PMIC via either I2C or PWM signals.

Original driver only supports I2C interface, this patch adds PWM
interface support.

Signed-off-by: Penny Chiu <pchiu@nvidia.com>
---
 .../bindings/clock/nvidia,tegra124-dfll.txt        |   8 +-
 drivers/clk/tegra/clk-dfll.c                       | 399 +++++++++++++++------
 2 files changed, 299 insertions(+), 108 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
index 42a1fe6..a3e350e 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
@@ -8,7 +8,6 @@ the fast CPU cluster. It consists of a free-running voltage controlled
 oscillator connected to the CPU voltage rail (VDD_CPU), and a closed loop
 control module that will automatically adjust the VDD_CPU voltage by
 communicating with an off-chip PMIC either via an I2C bus or via PWM signals.
-Currently only the I2C mode is supported by these bindings.
 
 Required properties:
 - compatible : should be one of following:
@@ -36,6 +35,10 @@ Required properties:
   hardware will start controlling. The regulator will be queried for
   the I2C register, control values and supported voltages.
 
+Optional properties:
+- nvidia,pwm-to-pmic: Specify DFLL PMU interface as PWM. If the property
+  is not defined, default PMU interface is I2C.
+
 Reguired properties for build voltage table:
 - nvidia,align-step-uv: Step uV of regulator for CPU voltage rail. This
   value will be applied when building frequency-voltage table to ensure
@@ -58,6 +61,9 @@ Optional properties for the control loop parameters:
 Required properties for I2C mode:
 - nvidia,i2c-fs-rate: I2C transfer rate, if using full speed mode.
 
+Required properties for PWM mode:
+- nvidia,init-uv: Initialized CPU voltage before DFLL is not ready yet.
+
 Example:
 
 clock@0,70110000 {
diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index a279467..56829c6 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -53,6 +53,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/seq_file.h>
+#include <soc/tegra/pwm-tegra-dfll.h>
 
 #include "clk-dfll.h"
 
@@ -242,6 +243,11 @@ enum dfll_tune_range {
 	DFLL_TUNE_LOW = 1,
 };
 
+enum tegra_dfll_pmu_if {
+	TEGRA_DFLL_PMU_I2C = 0,
+	TEGRA_DFLL_PMU_PWM = 1,
+};
+
 /**
  * struct dfll_rate_req - target DFLL rate request data
  * @rate: target frequency, after the postscaling
@@ -293,6 +299,7 @@ struct tegra_dfll {
 	u32				ci;
 	u32				cg;
 	bool				cg_scale;
+	u32				reg_init_uV;
 
 	/* I2C interface parameters */
 	u32				i2c_fs_rate;
@@ -300,9 +307,12 @@ struct tegra_dfll {
 	u32				i2c_slave_addr;
 
 	/* i2c_lut array entries are regulator framework selectors */
-	unsigned			i2c_lut[MAX_DFLL_VOLTAGES];
-	int				i2c_lut_size;
+	unsigned			lut[MAX_DFLL_VOLTAGES];
+	int				lut_size;
 	u8				lut_min, lut_max, lut_safe;
+
+	/* PWM interface */
+	enum tegra_dfll_pmu_if		pmu_if;
 };
 
 #define clk_hw_to_dfll(_hw) container_of(_hw, struct tegra_dfll, dfll_clk_hw)
@@ -326,7 +336,6 @@ static inline u32 dfll_readl(struct tegra_dfll *td, u32 offs)
 
 static inline void dfll_writel(struct tegra_dfll *td, u32 val, u32 offs)
 {
-	WARN_ON(offs >= DFLL_I2C_CFG);
 	__raw_writel(val, td->base + offs);
 }
 
@@ -538,7 +547,7 @@ static void dfll_load_i2c_lut(struct tegra_dfll *td)
 			lut_index = i;
 
 		val = regulator_list_hardware_vsel(td->vdd_reg,
-						     td->i2c_lut[lut_index]);
+						     td->lut[lut_index]);
 		__raw_writel(val, td->lut_base + i * 4);
 	}
 
@@ -581,36 +590,135 @@ static void dfll_init_i2c_if(struct tegra_dfll *td)
 	dfll_i2c_wmb(td);
 }
 
+/*
+ * DFLL-to-PWM controller interface
+ */
+
 /**
- * dfll_init_out_if - prepare DFLL-to-PMIC interface
+ * dfll_set_force_output_value - set fixed value for force output
  * @td: DFLL instance
+ * @out_val: value to force output
  *
- * During DFLL driver initialization or resume from context loss,
- * disable the I2C command output to the PMIC, set safe voltage and
- * output limits, and disable and clear limit interrupts.
+ * Set the fixec value for force output, DFLL will output this value when
+ * force output is enabled.
  */
-static void dfll_init_out_if(struct tegra_dfll *td)
+static u32 dfll_set_force_output_value(struct tegra_dfll *td, u8 out_val)
+{
+	u32 val = dfll_readl(td, DFLL_OUTPUT_FORCE);
+
+	val |= (val & DFLL_OUTPUT_FORCE_ENABLE) | (out_val & OUT_MASK);
+	dfll_writel(td, val, DFLL_OUTPUT_FORCE);
+	dfll_wmb(td);
+
+	return dfll_readl(td, DFLL_OUTPUT_FORCE);
+}
+
+/**
+ * dfll_set_force_output_enabled - enable/disable force output
+ * @td: DFLL instance
+ * @enable: whether to enable or disable the force output
+ *
+ * Set the enable control for fouce output with fixed value.
+ */
+static void dfll_set_force_output_enabled(struct tegra_dfll *td, bool enable)
+{
+	u32 val = dfll_readl(td, DFLL_OUTPUT_FORCE);
+
+	if (enable)
+		val |= DFLL_OUTPUT_FORCE_ENABLE;
+	else
+		val &= ~DFLL_OUTPUT_FORCE_ENABLE;
+
+	dfll_writel(td, val, DFLL_OUTPUT_FORCE);
+	dfll_wmb(td);
+}
+
+/**
+ * dfll_i2c_set_output_enabled - enable/disable I2C PMIC voltage requests
+ * @td: DFLL instance
+ * @enable: whether to enable or disable the I2C voltage requests
+ *
+ * Set the master enable control for I2C control value updates. If disabled,
+ * then I2C control messages are inhibited, regardless of the DFLL mode.
+ */
+static int dfll_force_output(struct tegra_dfll *td, unsigned int out_sel)
 {
 	u32 val;
 
-	td->lut_min = 0;
-	td->lut_max = td->i2c_lut_size - 1;
-	td->lut_safe = td->lut_min + 1;
+	if (out_sel > OUT_MASK)
+		return -EINVAL;
 
-	dfll_i2c_writel(td, 0, DFLL_OUTPUT_CFG);
-	val = (td->lut_safe << DFLL_OUTPUT_CFG_SAFE_SHIFT) |
-		(td->lut_max << DFLL_OUTPUT_CFG_MAX_SHIFT) |
-		(td->lut_min << DFLL_OUTPUT_CFG_MIN_SHIFT);
-	dfll_i2c_writel(td, val, DFLL_OUTPUT_CFG);
-	dfll_i2c_wmb(td);
+	val = dfll_set_force_output_value(td, out_sel);
+	if ((td->mode < DFLL_CLOSED_LOOP) &&
+	    !(val & DFLL_OUTPUT_FORCE_ENABLE)) {
+		dfll_set_force_output_enabled(td, true);
+	}
 
-	dfll_writel(td, 0, DFLL_OUTPUT_FORCE);
-	dfll_i2c_writel(td, 0, DFLL_INTR_EN);
-	dfll_i2c_writel(td, DFLL_INTR_MAX_MASK | DFLL_INTR_MIN_MASK,
-			DFLL_INTR_STS);
+	return 0;
+}
+
+/**
+ * dfll_init_out_if - prepare DFLL-to-PMIC interface
+ * @td: DFLL instance
+ *
+ * During DFLL driver initialization or resume from context loss,
+ * it needs to set safe voltage and output limits, and disable and
+ * clear limit interrupts. For PWM interface, it needs to set
+ * initial voltage for force output to avoid CPU voltage glitch
+ * during DFLL is from open to closed loop transition.
+ */
+static void dfll_init_out_if(struct tegra_dfll *td)
+{
+	u32 val = 0;
 
-	dfll_load_i2c_lut(td);
-	dfll_init_i2c_if(td);
+	if (td->pmu_if == TEGRA_DFLL_PMU_PWM) {
+		int vinit = td->reg_init_uV;
+		int vstep = td->soc->alignment;
+		int vmin = regulator_list_voltage(td->vdd_reg, 0);
+
+		td->lut_min = td->lut[0];
+		td->lut_max = td->lut[td->lut_size - 1];
+		td->lut_safe = td->lut_min + 1;
+
+		val = dfll_readl(td, DFLL_OUTPUT_CFG);
+		val |= (td->lut_safe << DFLL_OUTPUT_CFG_SAFE_SHIFT) |
+		       (td->lut_max << DFLL_OUTPUT_CFG_MAX_SHIFT) |
+		       (td->lut_min << DFLL_OUTPUT_CFG_MIN_SHIFT);
+		dfll_writel(td, val, DFLL_OUTPUT_CFG);
+		dfll_wmb(td);
+
+		dfll_writel(td, 0, DFLL_OUTPUT_FORCE);
+		dfll_writel(td, 0, DFLL_INTR_EN);
+		dfll_writel(td, DFLL_INTR_MAX_MASK | DFLL_INTR_MIN_MASK,
+				DFLL_INTR_STS);
+
+		/* set initial voltage */
+		if ((vinit >= vmin) && vstep) {
+			unsigned int vsel;
+
+			vsel = DIV_ROUND_UP((vinit - vmin), vstep);
+			dfll_force_output(td, vsel);
+		}
+	} else {
+		td->lut_min = 0;
+		td->lut_max = td->lut_size - 1;
+		td->lut_safe = td->lut_min + 1;
+
+		dfll_i2c_writel(td, 0, DFLL_OUTPUT_CFG);
+		val |= (td->lut_safe << DFLL_OUTPUT_CFG_SAFE_SHIFT) |
+		       (td->lut_max << DFLL_OUTPUT_CFG_MAX_SHIFT) |
+		       (td->lut_min << DFLL_OUTPUT_CFG_MIN_SHIFT);
+		dfll_i2c_writel(td, val, DFLL_OUTPUT_CFG);
+		dfll_i2c_wmb(td);
+
+		dfll_i2c_writel(td, 0, DFLL_OUTPUT_FORCE);
+		dfll_i2c_writel(td, 0, DFLL_INTR_EN);
+		dfll_i2c_writel(td, DFLL_INTR_MAX_MASK | DFLL_INTR_MIN_MASK,
+				DFLL_INTR_STS);
+
+		dfll_load_i2c_lut(td);
+		dfll_init_i2c_if(td);
+	}
 }
 
 /*
@@ -643,9 +751,9 @@ static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
 
 	rcu_read_unlock();
 
-	for (i = 0; i < td->i2c_lut_size; i++) {
-		if ((regulator_list_voltage(td->vdd_reg, td->i2c_lut[i]) /
-				td->soc->alignment) == align_volt)
+	for (i = 0; i < td->lut_size; i++) {
+		if ((regulator_list_voltage(td->vdd_reg, td->lut[i]) /
+					td->soc->alignment) == align_volt)
 			return i;
 	}
 
@@ -723,7 +831,12 @@ static void dfll_set_frequency_request(struct tegra_dfll *td,
 	int force_val;
 	int coef = 128; /* FIXME: td->cg_scale? */;
 
-	force_val = (req->lut_index - td->lut_safe) * coef / td->cg;
+	if (td->pmu_if == TEGRA_DFLL_PMU_PWM)
+		force_val = td->lut[req->lut_index] - td->lut[td->lut_safe];
+	else
+		force_val = req->lut_index - td->lut_safe;
+
+	force_val = force_val * coef / td->cg;
 	force_val = clamp(force_val, FORCE_MIN, FORCE_MAX);
 
 	val |= req->mult_bits << DFLL_FREQ_REQ_MULT_SHIFT;
@@ -867,9 +980,14 @@ static int dfll_lock(struct tegra_dfll *td)
 			return -EINVAL;
 		}
 
-		dfll_i2c_set_output_enabled(td, true);
+		if (td->pmu_if == TEGRA_DFLL_PMU_PWM)
+			tegra_dfll_pwm_output_enable();
+		else
+			dfll_i2c_set_output_enabled(td, true);
+
 		dfll_set_mode(td, DFLL_CLOSED_LOOP);
 		dfll_set_frequency_request(td, req);
+		dfll_set_force_output_enabled(td, false);
 		return 0;
 
 	default:
@@ -889,11 +1007,17 @@ static int dfll_lock(struct tegra_dfll *td)
  */
 static int dfll_unlock(struct tegra_dfll *td)
 {
+
 	switch (td->mode) {
 	case DFLL_CLOSED_LOOP:
 		dfll_set_open_loop_config(td);
 		dfll_set_mode(td, DFLL_OPEN_LOOP);
-		dfll_i2c_set_output_enabled(td, false);
+
+		if (td->pmu_if == TEGRA_DFLL_PMU_PWM)
+			tegra_dfll_pwm_output_disable();
+		else
+			dfll_i2c_set_output_enabled(td, false);
+
 		return 0;
 
 	case DFLL_OPEN_LOOP:
@@ -1160,7 +1284,8 @@ static int attr_registers_show(struct seq_file *s, void *data)
 
 	seq_puts(s, "CONTROL REGISTERS:\n");
 	for (offs = 0; offs <= DFLL_MONITOR_DATA; offs += 4) {
-		if (offs == DFLL_OUTPUT_CFG)
+		if (td->pmu_if == TEGRA_DFLL_PMU_I2C &&
+		    offs == DFLL_OUTPUT_CFG)
 			val = dfll_i2c_readl(td, offs);
 		else
 			val = dfll_readl(td, offs);
@@ -1168,22 +1293,33 @@ static int attr_registers_show(struct seq_file *s, void *data)
 	}
 
 	seq_puts(s, "\nI2C and INTR REGISTERS:\n");
-	for (offs = DFLL_I2C_CFG; offs <= DFLL_I2C_STS; offs += 4)
-		seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
-			   dfll_i2c_readl(td, offs));
-	for (offs = DFLL_INTR_STS; offs <= DFLL_INTR_EN; offs += 4)
-		seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
-			   dfll_i2c_readl(td, offs));
+	for (offs = DFLL_I2C_CFG; offs <= DFLL_I2C_STS; offs += 4) {
+		if (td->pmu_if == TEGRA_DFLL_PMU_I2C)
+			val = dfll_i2c_readl(td, offs);
+		else
+			val = dfll_readl(td, offs);
 
-	seq_puts(s, "\nINTEGRATED I2C CONTROLLER REGISTERS:\n");
-	offs = DFLL_I2C_CLK_DIVISOR;
-	seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
-		   __raw_readl(td->i2c_controller_base + offs));
+		seq_printf(s, "[0x%02x] = 0x%08x\n", offs, val);
+	}
+	for (offs = DFLL_INTR_STS; offs <= DFLL_INTR_EN; offs += 4) {
+		if (td->pmu_if == TEGRA_DFLL_PMU_I2C)
+			val = dfll_i2c_readl(td, offs);
+		else
+			val = dfll_readl(td, offs);
+		seq_printf(s, "[0x%02x] = 0x%08x\n", offs, val);
+	}
 
-	seq_puts(s, "\nLUT:\n");
-	for (offs = 0; offs <  4 * MAX_DFLL_VOLTAGES; offs += 4)
+	if (td->pmu_if == TEGRA_DFLL_PMU_I2C) {
+		seq_puts(s, "\nINTEGRATED I2C CONTROLLER REGISTERS:\n");
+		offs = DFLL_I2C_CLK_DIVISOR;
 		seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
-			   __raw_readl(td->lut_base + offs));
+			   __raw_readl(td->i2c_controller_base + offs));
+
+		seq_puts(s, "\nLUT:\n");
+		for (offs = 0; offs <  4 * MAX_DFLL_VOLTAGES; offs += 4)
+			seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
+				   __raw_readl(td->lut_base + offs));
+	}
 
 	return 0;
 }
@@ -1385,9 +1521,11 @@ static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
 
 	align_volt = uV / td->soc->alignment;
 	n_voltages = regulator_count_voltages(td->vdd_reg);
+
 	for (i = 0; i < n_voltages; i++) {
 		reg_volt = regulator_list_voltage(td->vdd_reg, i) /
 					td->soc->alignment;
+
 		if (reg_volt < 0)
 			break;
 
@@ -1409,9 +1547,11 @@ static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
 
 	align_volt = uV / td->soc->alignment;
 	n_voltages = regulator_count_voltages(td->vdd_reg);
+
 	for (i = 0; i < n_voltages; i++) {
 		reg_volt = regulator_list_voltage(td->vdd_reg, i) /
 					td->soc->alignment;
+
 		if (reg_volt < 0)
 			break;
 
@@ -1424,7 +1564,7 @@ static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
 }
 
 /**
- * dfll_build_i2c_lut - build the I2C voltage register lookup table
+ * dfll_build_lut - build the I2C and PWM voltage register lookup table
  * @td: DFLL instance
  *
  * The DFLL hardware has 33 bytes of look-up table RAM that must be filled with
@@ -1433,12 +1573,12 @@ static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
  * the soc-specific platform driver (td->soc->opp_dev) and the PMIC
  * register-to-voltage mapping queried from the regulator framework.
  *
- * On success, fills in td->i2c_lut and returns 0, or -err on failure.
+ * On success, fills in td->lut and returns 0, or -err on failure.
  */
-static int dfll_build_i2c_lut(struct tegra_dfll *td)
+static int dfll_build_lut(struct tegra_dfll *td)
 {
 	int ret = -EINVAL;
-	int j, v, v_max, v_opp;
+	int j, v, v_max, v_opp, v_min_align;
 	int selector;
 	unsigned long rate;
 	struct dev_pm_opp *opp;
@@ -1454,19 +1594,21 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
 	}
 	v_max = dev_pm_opp_get_voltage(opp);
 
+	v_min_align = DIV_ROUND_UP(td->soc->min_millivolts * 1000,
+			td->soc->alignment) * td->soc->alignment;
+
 	v = td->soc->min_millivolts * 1000;
 	lut = find_vdd_map_entry_exact(td, v);
 	if (lut < 0)
 		goto out;
-	td->i2c_lut[0] = lut;
+	td->lut[0] = lut;
 
 	for (j = 1, rate = 0; ; rate++) {
 		opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
 		if (IS_ERR(opp))
 			break;
 		v_opp = dev_pm_opp_get_voltage(opp);
-
-		if (v_opp <= td->soc->min_millivolts * 1000)
+		if (v_opp <= v_min_align)
 			td->dvco_rate_min = dev_pm_opp_get_freq(opp);
 
 		for (;;) {
@@ -1477,21 +1619,21 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
 			selector = find_vdd_map_entry_min(td, v);
 			if (selector < 0)
 				goto out;
-			if (selector != td->i2c_lut[j - 1])
-				td->i2c_lut[j++] = selector;
+			if (selector != td->lut[j - 1])
+				td->lut[j++] = selector;
 		}
 
 		v = (j == MAX_DFLL_VOLTAGES - 1) ? v_max : v_opp;
 		selector = find_vdd_map_entry_exact(td, v);
 		if (selector < 0)
 			goto out;
-		if (selector != td->i2c_lut[j - 1])
-			td->i2c_lut[j++] = selector;
+		if (selector != td->lut[j - 1])
+			td->lut[j++] = selector;
 
 		if (v >= v_max)
 			break;
 	}
-	td->i2c_lut_size = j;
+	td->lut_size = j;
 
 	if (!td->dvco_rate_min)
 		dev_err(td->dev, "no opp above DFLL minimum voltage %d mV\n",
@@ -1563,12 +1705,6 @@ static int dfll_fetch_i2c_params(struct tegra_dfll *td)
 	}
 	td->i2c_reg = vsel_reg;
 
-	ret = dfll_build_i2c_lut(td);
-	if (ret) {
-		dev_err(td->dev, "couldn't build I2C LUT\n");
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -1601,6 +1737,61 @@ static int dfll_fetch_common_params(struct tegra_dfll *td)
 	return ok ? 0 : -EINVAL;
 }
 
+/**
+ * dfll_dt_parse - read necessary parameters from the device tree
+ * @td: DFLL instance
+ *
+ * Read necessary DT parameters based on I2C or PWM operation.
+ * Returns 0 on success or -EINVAL on any failure.
+ */
+static int dfll_dt_parse(struct tegra_dfll *td)
+{
+	int ret;
+	struct device_node *dn = td->dev->of_node;
+
+	ret = dfll_fetch_common_params(td);
+	if (ret) {
+		dev_err(td->dev, "couldn't parse device tree parameters\n");
+		return ret;
+	}
+
+	td->vdd_reg = devm_regulator_get(td->dev, "vdd-cpu");
+	if (IS_ERR(td->vdd_reg)) {
+		dev_err(td->dev, "couldn't get vdd_cpu regulator\n");
+		return PTR_ERR(td->vdd_reg);
+	}
+
+	/* I2C or PWM interface */
+	if (of_property_read_bool(dn, "nvidia,pwm-to-pmic")) {
+		td->pmu_if = TEGRA_DFLL_PMU_PWM;
+		dev_info(td->dev, "config PMU interface as PWM\n");
+
+		ret = of_property_read_u32(dn, "nvidia,init-uv",
+					&td->reg_init_uV);
+		if (ret) {
+			dev_err(td->dev, "couldn't get initialized voltage\n");
+			return ret;
+		}
+	} else {
+		td->pmu_if = TEGRA_DFLL_PMU_I2C;
+		dev_info(td->dev, "config PMU interface as I2C\n");
+
+		ret = dfll_fetch_i2c_params(td);
+		if (ret) {
+			dev_err(td->dev, "couldn't get I2C parameters\n");
+			return ret;
+		}
+	}
+
+	ret = dfll_build_lut(td);
+	if (ret) {
+		dev_err(td->dev, "couldn't build LUT\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * API exported to per-SoC platform drivers
  */
@@ -1634,10 +1825,10 @@ int tegra_dfll_register(struct platform_device *pdev,
 
 	td->soc = soc;
 
-	td->vdd_reg = devm_regulator_get(td->dev, "vdd-cpu");
-	if (IS_ERR(td->vdd_reg)) {
-		dev_err(td->dev, "couldn't get vdd_cpu regulator\n");
-		return PTR_ERR(td->vdd_reg);
+	ret = dfll_dt_parse(td);
+	if (ret) {
+		dev_err(td->dev, "parse device-tree failed\n");
+		return ret;
 	}
 
 	td->dvco_rst = devm_reset_control_get(td->dev, "dvco");
@@ -1646,16 +1837,6 @@ int tegra_dfll_register(struct platform_device *pdev,
 		return PTR_ERR(td->dvco_rst);
 	}
 
-	ret = dfll_fetch_common_params(td);
-	if (ret) {
-		dev_err(td->dev, "couldn't parse device tree parameters\n");
-		return ret;
-	}
-
-	ret = dfll_fetch_i2c_params(td);
-	if (ret)
-		return ret;
-
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(td->dev, "no control register resource\n");
@@ -1668,43 +1849,47 @@ int tegra_dfll_register(struct platform_device *pdev,
 		return -ENODEV;
 	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!mem) {
-		dev_err(td->dev, "no i2c_base resource\n");
-		return -ENODEV;
-	}
+	if (td->pmu_if == TEGRA_DFLL_PMU_I2C) {
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!mem) {
+			dev_err(td->dev, "no i2c_base resource\n");
+			return -ENODEV;
+		}
 
-	td->i2c_base = devm_ioremap(td->dev, mem->start, resource_size(mem));
-	if (!td->i2c_base) {
-		dev_err(td->dev, "couldn't ioremap i2c_base resource\n");
-		return -ENODEV;
-	}
+		td->i2c_base = devm_ioremap(td->dev, mem->start,
+					resource_size(mem));
+		if (!td->i2c_base) {
+			dev_err(td->dev, "couldn't ioremap i2c_base resource\n");
+			return -ENODEV;
+		}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	if (!mem) {
-		dev_err(td->dev, "no i2c_controller_base resource\n");
-		return -ENODEV;
-	}
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		if (!mem) {
+			dev_err(td->dev, "no i2c_controller_base resource\n");
+			return -ENODEV;
+		}
 
-	td->i2c_controller_base = devm_ioremap(td->dev, mem->start,
+		td->i2c_controller_base = devm_ioremap(td->dev, mem->start,
 					       resource_size(mem));
-	if (!td->i2c_controller_base) {
-		dev_err(td->dev,
-			"couldn't ioremap i2c_controller_base resource\n");
-		return -ENODEV;
-	}
+		if (!td->i2c_controller_base) {
+			dev_err(td->dev,
+				"couldn't ioremap i2c_controller_base resource\n");
+			return -ENODEV;
+		}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-	if (!mem) {
-		dev_err(td->dev, "no lut_base resource\n");
-		return -ENODEV;
-	}
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+		if (!mem) {
+			dev_err(td->dev, "no lut_base resource\n");
+			return -ENODEV;
+		}
 
-	td->lut_base = devm_ioremap(td->dev, mem->start, resource_size(mem));
-	if (!td->lut_base) {
-		dev_err(td->dev,
-			"couldn't ioremap lut_base resource\n");
-		return -ENODEV;
+		td->lut_base = devm_ioremap(td->dev, mem->start,
+					resource_size(mem));
+		if (!td->lut_base) {
+			dev_err(td->dev,
+				"couldn't ioremap lut_base resource\n");
+			return -ENODEV;
+		}
 	}
 
 	ret = dfll_init_clks(td);
-- 
2.8.1

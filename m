From: Anson Huang <b20788@freescale.com>
Subject: [PATCH V3 2/2] cpufreq: imx6q: correct VDDSOC/PU voltage scaling when cpufreq is changed
Date: Wed, 18 Dec 2013 16:26:50 -0500
Message-ID: <1387402010-31749-2-git-send-email-b20788@freescale.com>
References: <1387402010-31749-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1387402010-31749-1-git-send-email-b20788@freescale.com>
Sender: cpufreq-owner@vger.kernel.org
To: shawn.guo@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

on i.MX6Q, cpu freq change need to follow below flows:

1. each setpoint has different VDDARM, VDDSOC/PU voltage, get the setpoint
   table from dts;
2. when cpu freq is scaling up, need to increase VDDSOC/PU voltage before
   VDDARM, if VDDPU is off, no need to change it;
3. when cpu freq is scaling down, need to decrease VDDARM voltage before
   VDDSOC/PU, if VDDPU is off, no need to change it;

normally dts will pass vddsoc/pu freq/volt info to kernel, if not, will
use fixed value for vddsoc/pu voltage setting.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 drivers/cpufreq/imx6q-cpufreq.c |  106 ++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 29 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 4b3f18e..c29198f 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -35,6 +35,9 @@ static struct device *cpu_dev;
 static struct cpufreq_frequency_table *freq_table;
 static unsigned int transition_latency;
 
+static u32 *imx6_soc_volt;
+static u32 soc_opp_count;
+
 static unsigned int imx6q_get_speed(unsigned int cpu)
 {
 	return clk_get_rate(arm_clk) / 1000;
@@ -69,23 +72,22 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 
 	/* scaling up?  scale voltage before frequency */
 	if (new_freq > old_freq) {
+		ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
+		if (ret) {
+			dev_err(cpu_dev, "failed to scale vddpu up: %d\n", ret);
+			return ret;
+		}
+		ret = regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
+		if (ret) {
+			dev_err(cpu_dev, "failed to scale vddsoc up: %d\n", ret);
+			return ret;
+		}
 		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
 		if (ret) {
 			dev_err(cpu_dev,
 				"failed to scale vddarm up: %d\n", ret);
 			return ret;
 		}
-
-		/*
-		 * Need to increase vddpu and vddsoc for safety
-		 * if we are about to run at 1.2 GHz.
-		 */
-		if (new_freq == FREQ_1P2_GHZ / 1000) {
-			regulator_set_voltage_tol(pu_reg,
-					PU_SOC_VOLTAGE_HIGH, 0);
-			regulator_set_voltage_tol(soc_reg,
-					PU_SOC_VOLTAGE_HIGH, 0);
-		}
 	}
 
 	/*
@@ -120,12 +122,15 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 				 "failed to scale vddarm down: %d\n", ret);
 			ret = 0;
 		}
-
-		if (old_freq == FREQ_1P2_GHZ / 1000) {
-			regulator_set_voltage_tol(pu_reg,
-					PU_SOC_VOLTAGE_NORMAL, 0);
-			regulator_set_voltage_tol(soc_reg,
-					PU_SOC_VOLTAGE_NORMAL, 0);
+		ret = regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
+		if (ret) {
+			dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
+			ret = 0;
+		}
+		ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
+		if (ret) {
+			dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
+			ret = 0;
 		}
 	}
 
@@ -153,6 +158,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	struct dev_pm_opp *opp;
 	unsigned long min_volt, max_volt;
 	int num, ret;
+	const struct property *prop;
+	const __be32 *val;
+	u32 nr, i, j;
 
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev) {
@@ -201,10 +209,62 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		goto put_node;
 	}
 
+	/* Make imx6_soc_volt array's size same as arm opp number */
+	imx6_soc_volt = devm_kzalloc(cpu_dev, sizeof(*imx6_soc_volt) * num, GFP_KERNEL);
+	if (imx6_soc_volt == NULL) {
+		ret = -ENOMEM;
+		goto free_freq_table;
+	}
+
+	prop = of_find_property(np, "fsl,soc-operating-points", NULL);
+	if (!prop || !prop->value)
+		goto soc_opp_out;
+
+	/*
+	 * Each OPP is a set of tuples consisting of frequency and
+	 * voltage like <freq-kHz vol-uV>.
+	 */
+	nr = prop->length / sizeof(u32);
+	if (nr % 2 || (nr / 2) < num)
+		goto soc_opp_out;
+
+	for (j = 0; j < num; j++) {
+		val = prop->value;
+		for (i = 0; i < nr / 2; i++) {
+			unsigned long freq = be32_to_cpup(val++);
+			unsigned long volt = be32_to_cpup(val++);
+			if (freq_table[j].frequency == freq) {
+				imx6_soc_volt[soc_opp_count++] = volt;
+				break;
+			}
+		}
+	}
+
+soc_opp_out:
+	/* use fixed soc opp volt if no valid soc opp info found in dtb */
+	if (soc_opp_count != num) {
+		dev_warn(cpu_dev, "can NOT find valid fsl,soc-operating-points property in dtb, use default value!\n");
+		for (j = 0; j < num; j++)
+			imx6_soc_volt[j] = PU_SOC_VOLTAGE_NORMAL;
+		if (freq_table[num - 1].frequency * 1000 == FREQ_1P2_GHZ)
+			imx6_soc_volt[num - 1] = PU_SOC_VOLTAGE_HIGH;
+	}
+
 	if (of_property_read_u32(np, "clock-latency", &transition_latency))
 		transition_latency = CPUFREQ_ETERNAL;
 
 	/*
+	 * Calculate the ramp time for max voltage change in the
+	 * VDDSOC and VDDPU regulators.
+	 */
+	ret = regulator_set_voltage_time(soc_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
+	if (ret > 0)
+		transition_latency += ret * 1000;
+	ret = regulator_set_voltage_time(pu_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
+	if (ret > 0)
+		transition_latency += ret * 1000;
+
+	/*
 	 * OPP is maintained in order of increasing frequency, and
 	 * freq_table initialised from OPP is therefore sorted in the
 	 * same order.
@@ -221,18 +281,6 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	if (ret > 0)
 		transition_latency += ret * 1000;
 
-	/* Count vddpu and vddsoc latency in for 1.2 GHz support */
-	if (freq_table[num].frequency == FREQ_1P2_GHZ / 1000) {
-		ret = regulator_set_voltage_time(pu_reg, PU_SOC_VOLTAGE_NORMAL,
-						 PU_SOC_VOLTAGE_HIGH);
-		if (ret > 0)
-			transition_latency += ret * 1000;
-		ret = regulator_set_voltage_time(soc_reg, PU_SOC_VOLTAGE_NORMAL,
-						 PU_SOC_VOLTAGE_HIGH);
-		if (ret > 0)
-			transition_latency += ret * 1000;
-	}
-
 	ret = cpufreq_register_driver(&imx6q_cpufreq_driver);
 	if (ret) {
 		dev_err(cpu_dev, "failed register driver: %d\n", ret);
-- 
1.7.9.5



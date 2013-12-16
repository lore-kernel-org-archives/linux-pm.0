From: Anson Huang <b20788@freescale.com>
Subject: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling when cpufreq is changed
Date: Mon, 16 Dec 2013 16:14:10 -0500
Message-ID: <1387228450-641-2-git-send-email-b20788@freescale.com>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1387228450-641-1-git-send-email-b20788@freescale.com>
Sender: cpufreq-owner@vger.kernel.org
To: shawn.guo@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

on i.MX6Q, cpu freq change need to follow below flows:

1. each setpoint has different VDDARM, VDDSOC/PU voltage, get the setpoint
table from dts;
2. when cpu freq is scaling up, need to increase VDDSOC/PU voltage before
VDDARM, if VDDPU is off, no need to change it;
3. when cpu freq is scaling down, need to decrease VDDARM voltage before
VDDSOC/PU, if VDDPU is off, no need to change it;

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 drivers/cpufreq/imx6q-cpufreq.c |  161 ++++++++++++++++++++++++++++++---------
 1 file changed, 126 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 4b3f18e..5fb302e 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -17,10 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-#define PU_SOC_VOLTAGE_NORMAL	1250000
-#define PU_SOC_VOLTAGE_HIGH	1275000
-#define FREQ_1P2_GHZ		1200000000
-
 static struct regulator *arm_reg;
 static struct regulator *pu_reg;
 static struct regulator *soc_reg;
@@ -35,6 +31,14 @@ static struct device *cpu_dev;
 static struct cpufreq_frequency_table *freq_table;
 static unsigned int transition_latency;
 
+struct soc_opp {
+	u32 arm_freq;
+	u32 soc_volt;
+};
+
+static struct soc_opp *imx6_soc_opp;
+static u32 soc_opp_count;
+
 static unsigned int imx6q_get_speed(unsigned int cpu)
 {
 	return clk_get_rate(arm_clk) / 1000;
@@ -45,6 +49,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	struct dev_pm_opp *opp;
 	unsigned long freq_hz, volt, volt_old;
 	unsigned int old_freq, new_freq;
+	unsigned int soc_opp_index = 0;
 	int ret;
 
 	new_freq = freq_table[index].frequency;
@@ -63,29 +68,48 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	rcu_read_unlock();
 	volt_old = regulator_get_voltage(arm_reg);
 
-	dev_dbg(cpu_dev, "%u MHz, %ld mV --> %u MHz, %ld mV\n",
+	/* Find the matching VDDSOC/VDDPU operating voltage */
+	while (soc_opp_index < soc_opp_count) {
+		if (new_freq == imx6_soc_opp[soc_opp_index].arm_freq)
+			break;
+		soc_opp_index++;
+	}
+	if (soc_opp_index >= soc_opp_count) {
+		dev_err(cpu_dev,
+			"Can NOT find matching imx6_soc_opp voltage!\n");
+			return -EINVAL;
+	}
+
+	dev_dbg(cpu_dev, "%u MHz, arm %ld mV, soc-pu %d mV --> %u MHz, arm %ld mV, soc-pu %d mV\n",
 		old_freq / 1000, volt_old / 1000,
-		new_freq / 1000, volt / 1000);
+		imx6_soc_opp[soc_opp_index].soc_volt / 1000,
+		new_freq / 1000, volt / 1000,
+		imx6_soc_opp[soc_opp_index].soc_volt / 1000);
 
 	/* scaling up?  scale voltage before frequency */
 	if (new_freq > old_freq) {
+		if (regulator_is_enabled(pu_reg)) {
+			ret = regulator_set_voltage_tol(pu_reg,
+				imx6_soc_opp[soc_opp_index].soc_volt, 0);
+			if (ret) {
+				dev_err(cpu_dev,
+					"failed to scale vddpu up: %d\n", ret);
+				return ret;
+			}
+		}
+		ret = regulator_set_voltage_tol(soc_reg,
+				imx6_soc_opp[soc_opp_index].soc_volt, 0);
+		if (ret) {
+			dev_err(cpu_dev,
+				"failed to scale vddsoc up: %d\n", ret);
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
@@ -120,12 +144,22 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 				 "failed to scale vddarm down: %d\n", ret);
 			ret = 0;
 		}
-
-		if (old_freq == FREQ_1P2_GHZ / 1000) {
-			regulator_set_voltage_tol(pu_reg,
-					PU_SOC_VOLTAGE_NORMAL, 0);
-			regulator_set_voltage_tol(soc_reg,
-					PU_SOC_VOLTAGE_NORMAL, 0);
+		ret = regulator_set_voltage_tol(soc_reg,
+				imx6_soc_opp[soc_opp_index].soc_volt, 0);
+		if (ret) {
+			dev_warn(cpu_dev,
+				"failed to scale vddsoc down: %d\n", ret);
+			ret = 0;
+		}
+		if (regulator_is_enabled(pu_reg)) {
+			ret = regulator_set_voltage_tol(pu_reg,
+				imx6_soc_opp[soc_opp_index].soc_volt, 0);
+			if (ret) {
+				dev_warn(cpu_dev,
+					"failed to scale vddpu down: %d\n",
+					ret);
+				ret = 0;
+			}
 		}
 	}
 
@@ -153,6 +187,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	struct dev_pm_opp *opp;
 	unsigned long min_volt, max_volt;
 	int num, ret;
+	const struct property *prop;
+	const __be32 *val;
+	u32 nr, i;
 
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev) {
@@ -201,9 +238,75 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		goto put_node;
 	}
 
+	prop = of_find_property(np, "fsl,soc-operating-points", NULL);
+	if (!prop) {
+		dev_err(cpu_dev,
+			"fsl,soc-operating-points node not found!\n");
+		goto free_freq_table;
+	}
+	if (!prop->value) {
+		dev_err(cpu_dev,
+			"No entries in fsl-soc-operating-points node!\n");
+		goto free_freq_table;
+	}
+
+	/*
+	 * Each OPP is a set of tuples consisting of frequency and
+	 * voltage like <freq-kHz vol-uV>.
+	 */
+	nr = prop->length / sizeof(u32);
+	if (nr % 2) {
+		dev_err(cpu_dev, "Invalid fsl-soc-operating-points list!\n");
+		goto free_freq_table;
+	}
+
+	/* Get the VDDSOC/VDDPU voltages that need to track the CPU voltages. */
+	imx6_soc_opp = devm_kzalloc(cpu_dev,
+		sizeof(struct soc_opp) * (nr / 2), GFP_KERNEL);
+
+	if (imx6_soc_opp == NULL) {
+		dev_err(cpu_dev, "No Memory for VDDSOC/PU table!\n");
+		goto free_freq_table;
+	}
+
+	rcu_read_lock();
+	val = prop->value;
+
+	min_volt = max_volt = 0;
+	for (i = 0; i < nr / 2; i++) {
+		unsigned long freq = be32_to_cpup(val++);
+		unsigned long volt = be32_to_cpup(val++);
+
+		if (i == 0)
+			min_volt = max_volt = volt;
+		if (volt < min_volt)
+			min_volt = volt;
+		if (volt > max_volt)
+			max_volt = volt;
+		opp = dev_pm_opp_find_freq_exact(cpu_dev, freq * 1000, true);
+		imx6_soc_opp[i].arm_freq = freq;
+		imx6_soc_opp[i].soc_volt = volt;
+		soc_opp_count++;
+	}
+	rcu_read_unlock();
+
 	if (of_property_read_u32(np, "clock-latency", &transition_latency))
 		transition_latency = CPUFREQ_ETERNAL;
 
+	if (min_volt * max_volt != 0) {
+		/*
+		 * Calculate the ramp time for max voltage change in the
+		 * VDDSOC and VDDPU regulators.
+		 */
+		ret = regulator_set_voltage_time(soc_reg, min_volt, max_volt);
+		if (ret > 0)
+			transition_latency += ret * 1000;
+
+		ret = regulator_set_voltage_time(pu_reg, min_volt, max_volt);
+		if (ret > 0)
+			transition_latency += ret * 1000;
+	}
+
 	/*
 	 * OPP is maintained in order of increasing frequency, and
 	 * freq_table initialised from OPP is therefore sorted in the
@@ -221,18 +324,6 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
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



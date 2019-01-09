From: Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2] cpufreq: qcom: Read voltage LUT and populate OPP
Date: Wed,  9 Jan 2019 13:37:28 +0530
Message-ID: <1547021248-27258-1-git-send-email-tdas@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, Matthias Kaehlcke <mka@chromium.org>, evgreen@google.com, Taniya Das <tdas@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add support to read the voltage look up table and populate OPP for all
corresponding CPUS for consumers like the energy model could use the
frequency and voltage from the OPP tables.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d83939a..18f90bb 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -10,18 +10,21 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/pm_opp.h>
 #include <linux/slab.h>

 #define LUT_MAX_ENTRIES			40U
 #define LUT_SRC				GENMASK(31, 30)
 #define LUT_L_VAL			GENMASK(7, 0)
 #define LUT_CORE_COUNT			GENMASK(18, 16)
+#define LUT_VOLT			GENMASK(11, 0)
 #define LUT_ROW_SIZE			32
 #define CLK_HW_DIV			2

 /* Register offsets */
 #define REG_ENABLE			0x0
-#define REG_LUT_TABLE			0x110
+#define REG_FREQ_LUT			0x110
+#define REG_VOLT_LUT			0x114
 #define REG_PERF_STATE			0x920

 static unsigned long cpu_hw_rate, xo_rate;
@@ -75,6 +78,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
 				    void __iomem *base)
 {
 	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
+	u32 volt;
 	unsigned int max_cores = cpumask_weight(policy->cpus);
 	struct cpufreq_frequency_table	*table;

@@ -83,11 +87,16 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
 		return -ENOMEM;

 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
-		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
+		data = readl_relaxed(base + REG_FREQ_LUT +
+				      i * LUT_ROW_SIZE);
 		src = FIELD_GET(LUT_SRC, data);
 		lval = FIELD_GET(LUT_L_VAL, data);
 		core_count = FIELD_GET(LUT_CORE_COUNT, data);

+		data = readl_relaxed(base + REG_VOLT_LUT +
+				      i * LUT_ROW_SIZE);
+		volt = FIELD_GET(LUT_VOLT, data) * 1000;
+
 		if (src)
 			freq = xo_rate * lval / 1000;
 		else
@@ -98,6 +107,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
 			table[i].frequency = CPUFREQ_ENTRY_INVALID;
 		} else {
 			table[i].frequency = freq;
+			dev_pm_opp_add(get_cpu_device(policy->cpu),
+					freq * 1000, volt);
 			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
 				freq, core_count);
 		}
@@ -116,6 +127,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
 			if (prev_cc != max_cores) {
 				prev->frequency = prev_freq;
 				prev->flags = CPUFREQ_BOOST_FREQ;
+				dev_pm_opp_add(get_cpu_device(policy->cpu),
+						prev_freq * 1000, volt);
 			}

 			break;
@@ -127,6 +140,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,

 	table[i].frequency = CPUFREQ_TABLE_END;
 	policy->freq_table = table;
+	dev_pm_opp_set_sharing_cpus(get_cpu_device(policy->cpu), policy->cpus);

 	return 0;
 }
@@ -159,10 +173,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	struct device *dev = &global_pdev->dev;
 	struct of_phandle_args args;
 	struct device_node *cpu_np;
+	struct device *cpu_dev;
 	struct resource *res;
 	void __iomem *base;
 	int ret, index;

+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("%s: failed to get cpu%d device\n", __func__,
+		       policy->cpu);
+		return -ENODEV;
+	}
+
 	cpu_np = of_cpu_device_node_get(policy->cpu);
 	if (!cpu_np)
 		return -EINVAL;
@@ -205,6 +227,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto error;
 	}

+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret <= 0) {
+		dev_err(cpu_dev, "OPP table is not ready\n");
+		goto error;
+	}
+
 	policy->fast_switch_possible = true;

 	return 0;
@@ -217,6 +245,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 {
 	void __iomem *base = policy->driver_data - REG_PERF_STATE;

+	dev_pm_opp_remove_all_dynamic(&global_pdev->dev);
 	kfree(policy->freq_table);
 	devm_iounmap(&global_pdev->dev, base);

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

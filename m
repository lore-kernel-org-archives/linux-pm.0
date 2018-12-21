From: Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1] cpufreq: qcom: Read voltage LUT and populate OPP
Date: Fri, 21 Dec 2018 23:36:48 +0530
Message-ID: <1545415608-15163-1-git-send-email-tdas@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, Matthias Kaehlcke <mka@chromium.org>, evgreen@google.com, Taniya Das <tdas@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add support to read the voltage look up table and populate OPP for all
corresponding CPUS.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d83939a..7559b87 100644
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
+#define REG_FREQ_LUT_TABLE		0x110
+#define REG_VOLT_LUT_TABLE		0x114
 #define REG_PERF_STATE			0x920

 static unsigned long cpu_hw_rate, xo_rate;
@@ -75,19 +78,26 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
 				    void __iomem *base)
 {
 	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
+	u32 volt;
 	unsigned int max_cores = cpumask_weight(policy->cpus);
 	struct cpufreq_frequency_table	*table;
+	unsigned long cpu_r;

 	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;

 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
-		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
+		data = readl_relaxed(base + REG_FREQ_LUT_TABLE +
+				      i * LUT_ROW_SIZE);
 		src = FIELD_GET(LUT_SRC, data);
 		lval = FIELD_GET(LUT_L_VAL, data);
 		core_count = FIELD_GET(LUT_CORE_COUNT, data);

+		data = readl_relaxed(base + REG_VOLT_LUT_TABLE +
+				      i * LUT_ROW_SIZE);
+		volt = FIELD_GET(LUT_VOLT, data) * 1000;
+
 		if (src)
 			freq = xo_rate * lval / 1000;
 		else
@@ -123,6 +133,10 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,

 		prev_cc = core_count;
 		prev_freq = freq;
+
+		freq *= 1000;
+		for_each_cpu(cpu_r, policy->cpus)
+			dev_pm_opp_add(get_cpu_device(cpu_r), freq, volt);
 	}

 	table[i].frequency = CPUFREQ_TABLE_END;
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
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

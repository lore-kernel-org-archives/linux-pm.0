From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V9 5/7] soc: qcom: rpmpd: Add support for get/set performance state
Date: Wed,  2 Aug 2017 15:42:36 +0530
Message-ID: <2cc3c8fecf9bc135b136b176ae4ce73221ee4fb6.1501668354.git.viresh.kumar@linaro.org>
References: <cover.1501668354.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501668354.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1501668354.git.viresh.kumar@linaro.org>
References: <cover.1501668354.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

THIS IS TEST CODE, SHOULDN'T BE MERGED.

With genpd now expecting powerdomain drivers supporting performance
state to support get/set performance state callbacks, add support for it
in the rpmpd driver.

NOT-signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
NOT-signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index d34d9c363815..4e4f5cda9ce2 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -101,6 +101,20 @@ struct rpmpd_desc {
 	size_t num_pds;
 };
 
+enum rpmpd_levels {
+	NONE,
+	LOWER,          /* SVS2 */
+	LOW,            /* SVS */
+	NOMINAL,        /* NOMINAL */
+	HIGH,           /* Turbo */
+	MAX_LEVEL,
+};
+
+struct rpmpd_freq_map {
+	struct rpmpd *pd;
+	unsigned long freq[MAX_LEVEL];
+};
+
 static DEFINE_MUTEX(rpmpd_lock);
 
 /* msm8996 RPM powerdomains */
@@ -126,6 +140,47 @@ static const struct rpmpd_desc msm8996_desc = {
 	.num_pds = ARRAY_SIZE(msm8996_rpmpds),
 };
 
+enum msm8996_devices {
+	SDHCI,
+	UFS,
+	PCIE,
+	USB3,
+};
+
+static struct rpmpd_freq_map msm8996_rpmpd_freq_map[] = {
+	[SDHCI] = {
+		.pd = &msm8996_vddcx,
+		.freq[LOWER] = 19200000,
+		.freq[LOW] = 200000000,
+		.freq[NOMINAL] = 400000000,
+	},
+	[UFS] = {
+		.pd = &msm8996_vddcx,
+		.freq[LOWER] = 19200000,
+		.freq[LOW] = 100000000,
+		.freq[NOMINAL] = 200000000,
+		.freq[HIGH] = 240000000,
+	},
+	[PCIE] = {
+		.pd = &msm8996_vddcx,
+		.freq[LOWER] = 1011000,
+	},
+	[USB3] = {
+		.pd = &msm8996_vddcx,
+		.freq[LOWER] = 60000000,
+		.freq[LOW] = 120000000,
+		.freq[NOMINAL] = 150000000,
+	},
+};
+
+static const struct of_device_id rpmpd_performance_table[] = {
+	{ .compatible = "qcom,sdhci-msm-v4", .data = (void *)SDHCI },
+	{ .compatible = "qcom,ufshc", .data = (void *)UFS },
+	{ .compatible = "qcom,pcie-msm8996", .data = (void *)PCIE },
+	{ .compatible = "qcom,dwc3", .data = (void *)USB3 },
+	{ }
+};
+
 static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,rpmpd-msm8996", .data = &msm8996_desc },
 	{ }
@@ -230,6 +285,49 @@ static int rpmpd_power_off(struct generic_pm_domain *domain)
 	return ret;
 }
 
+static int rpmpd_set_performance(struct generic_pm_domain *domain,
+			     unsigned int state)
+{
+	int ret = 0;
+	struct rpmpd *pd = domain_to_rpmpd(domain);
+
+	mutex_lock(&rpmpd_lock);
+
+	pd->corner = state;
+
+	if (!pd->enabled && (pd->key != KEY_FLOOR_CORNER))
+		goto out;
+
+	ret = rpmpd_aggregate_corner(pd);
+
+out:
+	mutex_unlock(&rpmpd_lock);
+
+	return ret;
+}
+
+
+static int rpmpd_get_performance(struct device *dev, unsigned long rate)
+{
+	int i;
+	unsigned long index;
+	const struct of_device_id *id;
+
+	if (!rate)
+		return 0;
+
+	id = of_match_device(rpmpd_performance_table, dev);
+	if (!id)
+		return -EINVAL;
+
+	index = (unsigned long)id->data;
+	for (i = 0; i < MAX_LEVEL; i++)
+		if (msm8996_rpmpd_freq_map[index].freq[i] >= rate)
+			return i;
+
+	return MAX_LEVEL;
+}
+
 static int rpmpd_probe(struct platform_device *pdev)
 {
 	int i;
@@ -267,6 +365,8 @@ static int rpmpd_probe(struct platform_device *pdev)
 		rpmpds[i]->rpm = rpm;
 		rpmpds[i]->pd.power_off = rpmpd_power_off;
 		rpmpds[i]->pd.power_on = rpmpd_power_on;
+		rpmpds[i]->pd.genpd_set_performance_state = rpmpd_set_performance;
+		rpmpds[i]->pd.dev_get_performance_state = rpmpd_get_performance;
 		pm_genpd_init(&rpmpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmpds[i]->pd;
-- 
2.13.0.71.gd7076ec9c9cb

From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH RFC v2 5/7] PM / devfreq: exynos5250: migrate to common-clock
Date: Thu, 22 May 2014 22:52:00 +0530
Message-ID: <1400779322-4410-6-git-send-email-a.kesavan@samsung.com>
References: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:54341 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbaEVRWi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 13:22:38 -0400
In-Reply-To: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, t.figa@samsung.com, myungjoo.ham@samsung.com, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: kesavan.abhilash@gmail.com

From: Andrew Bresticker <abrestic@chromium.org>

Use the common-clock framework to scale frequencies for the various
peripheral clocks on the Exynos5250.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/devfreq/exynos/exynos5_bus.c |  131 ++++++++++++++++++++++++++++++----
 1 file changed, 119 insertions(+), 12 deletions(-)

diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
index 6cd0392..1196653 100644
--- a/drivers/devfreq/exynos/exynos5_bus.c
+++ b/drivers/devfreq/exynos/exynos5_bus.c
@@ -57,7 +57,6 @@ struct busfreq_data_int {
 	struct notifier_block pm_notifier;
 	struct mutex lock;
 	struct pm_qos_request int_req;
-	struct clk *int_clk;
 };
 
 struct int_bus_opp_table {
@@ -66,6 +65,17 @@ struct int_bus_opp_table {
 	unsigned long volt;
 };
 
+struct int_clk_table {
+	unsigned int idx;
+	unsigned long freq;
+};
+
+struct int_clk {
+	const char *clk_name;
+	struct clk *clk;
+	struct int_clk_table *freq_table;
+};
+
 static struct int_bus_opp_table exynos5_int_opp_table[] = {
 	{LV_0, 266000, 1025000},
 	{LV_1, 200000, 1025000},
@@ -75,6 +85,98 @@ static struct int_bus_opp_table exynos5_int_opp_table[] = {
 	{0, 0, 0},
 };
 
+static struct int_clk_table aclk_166[] = {
+	{LV_0, 167000},
+	{LV_1, 111000},
+	{LV_2,  84000},
+	{LV_3,  84000},
+	{LV_4,  42000},
+};
+
+static struct int_clk_table aclk_200[] = {
+	{LV_0, 200000},
+	{LV_1, 160000},
+	{LV_2, 160000},
+	{LV_3, 134000},
+	{LV_4, 100000},
+};
+
+static struct int_clk_table aclk_266[] = {
+	{LV_0, 267000},
+	{LV_1, 200000},
+	{LV_2, 160000},
+	{LV_3, 134000},
+	{LV_4, 100000},
+};
+
+static struct int_clk_table aclk_333[] = {
+	{LV_0, 333000},
+	{LV_1, 167000},
+	{LV_2, 111000},
+	{LV_3, 111000},
+	{LV_4,  42000},
+};
+
+static struct int_clk_table aclk_300_disp1[] = {
+	{LV_0, 267000},
+	{LV_1, 267000},
+	{LV_2, 267000},
+	{LV_3, 267000},
+	{LV_4, 200000},
+};
+
+static struct int_clk_table aclk_300_gscl[] = {
+	{LV_0, 267000},
+	{LV_1, 267000},
+	{LV_2, 267000},
+	{LV_3, 200000},
+	{LV_4, 100000},
+};
+
+#define EXYNOS5_INT_CLK(name, tbl) {		\
+	.clk_name = name,			\
+	.freq_table = tbl,			\
+}
+
+static struct int_clk exynos5_int_clks[] = {
+	EXYNOS5_INT_CLK("aclk166_d", aclk_166),
+	EXYNOS5_INT_CLK("aclk200_d", aclk_200),
+	EXYNOS5_INT_CLK("aclk266_d", aclk_266),
+	EXYNOS5_INT_CLK("aclk333_d", aclk_333),
+	EXYNOS5_INT_CLK("aclk300_disp1_d", aclk_300_disp1),
+	EXYNOS5_INT_CLK("aclk300_gscl_d", aclk_300_gscl),
+};
+
+static int exynos5_int_set_rate(struct busfreq_data_int *data,
+				unsigned long rate)
+{
+	int index, i;
+
+	for (index = 0; index < ARRAY_SIZE(exynos5_int_opp_table); index++) {
+		if (exynos5_int_opp_table[index].clk == rate)
+			break;
+	}
+
+	if (index >= _LV_END)
+		return -EINVAL;
+
+	/* Change the system clock divider values */
+	for (i = 0; i < ARRAY_SIZE(exynos5_int_clks); i++) {
+		struct int_clk *clk_info = &exynos5_int_clks[i];
+		int ret;
+
+		ret = clk_set_rate(clk_info->clk,
+				clk_info->freq_table[index].freq * 1000);
+		if (ret) {
+			dev_err(data->dev, "Failed to set %s rate: %d\n",
+				clk_info->clk_name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int exynos5_int_setvolt(struct busfreq_data_int *data,
 				unsigned long volt)
 {
@@ -126,7 +228,7 @@ static int exynos5_busfreq_int_target(struct device *dev, unsigned long *_freq,
 	if (err)
 		goto out;
 
-	err = clk_set_rate(data->int_clk, freq * 1000);
+	err = exynos5_int_set_rate(data, freq);
 
 	if (err)
 		goto out;
@@ -220,7 +322,7 @@ static int exynos5_busfreq_int_pm_notifier_event(struct notifier_block *this,
 		if (err)
 			goto unlock;
 
-		err = clk_set_rate(data->int_clk, freq * 1000);
+		err = exynos5_int_set_rate(data, freq);
 
 		if (err)
 			goto unlock;
@@ -300,10 +402,15 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 		return PTR_ERR(data->vdd_int);
 	}
 
-	data->int_clk = devm_clk_get(dev, "int_clk");
-	if (IS_ERR(data->int_clk)) {
-		dev_err(dev, "Cannot get clock \"int_clk\"\n");
-		return PTR_ERR(data->int_clk);
+	for (i = 0; i < ARRAY_SIZE(exynos5_int_clks); i++) {
+		struct int_clk *clk_info = &exynos5_int_clks[i];
+
+		clk_info->clk = devm_clk_get(dev, clk_info->clk_name);
+		if (IS_ERR(clk_info->clk)) {
+			dev_err(dev, "Failed to get clock %s\n",
+				clk_info->clk_name);
+			return PTR_ERR(clk_info->clk);
+		}
 	}
 
 	rcu_read_lock();
@@ -320,16 +427,16 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 	rcu_read_unlock();
 	data->curr_freq = initial_freq;
 
-	err = clk_set_rate(data->int_clk, initial_freq * 1000);
+	err = exynos5_int_setvolt(data, initial_volt);
+	if (err)
+		return err;
+
+	err = exynos5_int_set_rate(data, initial_freq);
 	if (err) {
 		dev_err(dev, "Failed to set initial frequency\n");
 		return err;
 	}
 
-	err = exynos5_int_setvolt(data, initial_volt);
-	if (err)
-		return err;
-
 	platform_set_drvdata(pdev, data);
 
 	busfreq_mon_reset(ppmu_data);
-- 
1.7.9.5


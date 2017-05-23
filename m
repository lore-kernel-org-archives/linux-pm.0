From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/4] PM / OPP: Reorganize _generic_set_opp_regulator()
Date: Tue, 23 May 2017 09:32:10 +0530
Message-ID: <b9f67b2be37d5e9740a5e1ed85b0e8b4e5c0eb91.1495511998.git.viresh.kumar@linaro.org>
References: <cover.1495511998.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33066 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbdEWECT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 00:02:19 -0400
Received: by mail-pf0-f177.google.com with SMTP id e193so101321934pfh.0
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2017 21:02:18 -0700 (PDT)
In-Reply-To: <cover.1495511998.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

The code was overly complicated here because of the limitations that we
had with RCUs (Couldn't use opp-table and OPPs outside RCU protected
section and can't call sleep-able routines from within that). But that
is long gone now.

Reorganize _generic_set_opp_regulator() in order to avoid using "struct
dev_pm_set_opp_data" and copying data into it for the case where
opp_table->set_opp is not set.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 73 ++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index dae61720b314..c4590fc017ba 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -543,17 +543,18 @@ _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 	return ret;
 }
 
-static int _generic_set_opp(struct dev_pm_set_opp_data *data)
+static int _generic_set_opp_regulator(const struct opp_table *opp_table,
+				      struct device *dev,
+				      unsigned long old_freq,
+				      unsigned long freq,
+				      struct dev_pm_opp_supply *old_supply,
+				      struct dev_pm_opp_supply *new_supply)
 {
-	struct dev_pm_opp_supply *old_supply = data->old_opp.supplies;
-	struct dev_pm_opp_supply *new_supply = data->new_opp.supplies;
-	unsigned long old_freq = data->old_opp.rate, freq = data->new_opp.rate;
-	struct regulator *reg = data->regulators[0];
-	struct device *dev= data->dev;
+	struct regulator *reg = opp_table->regulators[0];
 	int ret;
 
 	/* This function only supports single regulator per device */
-	if (WARN_ON(data->regulator_count > 1)) {
+	if (WARN_ON(opp_table->regulator_count > 1)) {
 		dev_err(dev, "multiple regulators are not supported\n");
 		return -EINVAL;
 	}
@@ -566,7 +567,7 @@ static int _generic_set_opp(struct dev_pm_set_opp_data *data)
 	}
 
 	/* Change frequency */
-	ret = _generic_set_opp_clk_only(dev, data->clk, old_freq, freq);
+	ret = _generic_set_opp_clk_only(dev, opp_table->clk, old_freq, freq);
 	if (ret)
 		goto restore_voltage;
 
@@ -580,12 +581,12 @@ static int _generic_set_opp(struct dev_pm_set_opp_data *data)
 	return 0;
 
 restore_freq:
-	if (_generic_set_opp_clk_only(dev, data->clk, freq, old_freq))
+	if (_generic_set_opp_clk_only(dev, opp_table->clk, freq, old_freq))
 		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
 			__func__, old_freq);
 restore_voltage:
 	/* This shouldn't harm even if the voltages weren't updated earlier */
-	if (old_supply->u_volt)
+	if (old_supply)
 		_set_opp_voltage(dev, reg, old_supply);
 
 	return ret;
@@ -603,10 +604,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	struct opp_table *opp_table;
 	unsigned long freq, old_freq;
-	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_opp *old_opp, *opp;
-	struct regulator **regulators;
-	struct dev_pm_set_opp_data *data;
 	struct clk *clk;
 	int ret, size;
 
@@ -661,38 +659,35 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
 		old_freq, freq);
 
-	regulators = opp_table->regulators;
-
 	/* Only frequency scaling */
-	if (!regulators) {
+	if (!opp_table->regulators) {
 		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
-		goto put_opps;
-	}
+	} else if (!opp_table->set_opp) {
+		ret = _generic_set_opp_regulator(opp_table, dev, old_freq, freq,
+						 IS_ERR(old_opp) ? NULL : old_opp->supplies,
+						 opp->supplies);
+	} else {
+		struct dev_pm_set_opp_data *data;
 
-	if (opp_table->set_opp)
-		set_opp = opp_table->set_opp;
-	else
-		set_opp = _generic_set_opp;
-
-	data = opp_table->set_opp_data;
-	data->regulators = regulators;
-	data->regulator_count = opp_table->regulator_count;
-	data->clk = clk;
-	data->dev = dev;
-
-	data->old_opp.rate = old_freq;
-	size = sizeof(*opp->supplies) * opp_table->regulator_count;
-	if (IS_ERR(old_opp))
-		memset(data->old_opp.supplies, 0, size);
-	else
-		memcpy(data->old_opp.supplies, old_opp->supplies, size);
+		data = opp_table->set_opp_data;
+		data->regulators = opp_table->regulators;
+		data->regulator_count = opp_table->regulator_count;
+		data->clk = clk;
+		data->dev = dev;
 
-	data->new_opp.rate = freq;
-	memcpy(data->new_opp.supplies, opp->supplies, size);
+		data->old_opp.rate = old_freq;
+		size = sizeof(*opp->supplies) * opp_table->regulator_count;
+		if (IS_ERR(old_opp))
+			memset(data->old_opp.supplies, 0, size);
+		else
+			memcpy(data->old_opp.supplies, old_opp->supplies, size);
 
-	ret = set_opp(data);
+		data->new_opp.rate = freq;
+		memcpy(data->new_opp.supplies, opp->supplies, size);
+
+		ret = opp_table->set_opp(data);
+	}
 
-put_opps:
 	dev_pm_opp_put(opp);
 put_old_opp:
 	if (!IS_ERR(old_opp))
-- 
2.13.0.70.g6367777092d9

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/8] PM / OPP: Pass struct dev_pm_opp_supply to _set_opp_voltage()
Date: Thu, 20 Oct 2016 14:14:58 +0530
Message-ID: <5f5f81da4b9773854fba72359cb911d2660e2957.1476952750.git.viresh.kumar@linaro.org>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1476952750.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1476952750.git.viresh.kumar@linaro.org>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Pass the entire supply structure instead of all of its fields.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 44 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 8d6006151c9a..37fad2eb0f47 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -542,8 +542,7 @@ static struct clk *_get_opp_clk(struct device *dev)
 }
 
 static int _set_opp_voltage(struct device *dev, struct regulator *reg,
-			    unsigned long u_volt, unsigned long u_volt_min,
-			    unsigned long u_volt_max)
+			    struct dev_pm_opp_supply *supply)
 {
 	int ret;
 
@@ -554,14 +553,15 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 		return 0;
 	}
 
-	dev_dbg(dev, "%s: voltages (mV): %lu %lu %lu\n", __func__, u_volt_min,
-		u_volt, u_volt_max);
+	dev_dbg(dev, "%s: voltages (mV): %lu %lu %lu\n", __func__,
+		supply->u_volt_min, supply->u_volt, supply->u_volt_max);
 
-	ret = regulator_set_voltage_triplet(reg, u_volt_min, u_volt,
-					    u_volt_max);
+	ret = regulator_set_voltage_triplet(reg, supply->u_volt_min,
+					    supply->u_volt, supply->u_volt_max);
 	if (ret)
 		dev_err(dev, "%s: failed to set voltage (%lu %lu %lu mV): %d\n",
-			__func__, u_volt_min, u_volt, u_volt_max, ret);
+			__func__, supply->u_volt_min, supply->u_volt,
+			supply->u_volt_max, ret);
 
 	return ret;
 }
@@ -583,8 +583,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	struct regulator *reg;
 	struct clk *clk;
 	unsigned long freq, old_freq;
-	unsigned long u_volt, u_volt_min, u_volt_max;
-	unsigned long old_u_volt, old_u_volt_min, old_u_volt_max;
+	struct dev_pm_opp_supply old_supply, new_supply;
 	int ret;
 
 	if (unlikely(!target_freq)) {
@@ -634,17 +633,12 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		return ret;
 	}
 
-	if (IS_ERR(old_opp)) {
-		old_u_volt = 0;
-	} else {
-		old_u_volt = old_opp->supply.u_volt;
-		old_u_volt_min = old_opp->supply.u_volt_min;
-		old_u_volt_max = old_opp->supply.u_volt_max;
-	}
+	if (IS_ERR(old_opp))
+		old_supply.u_volt = 0;
+	else
+		memcpy(&old_supply, &old_opp->supply, sizeof(old_supply));
 
-	u_volt = opp->supply.u_volt;
-	u_volt_min = opp->supply.u_volt_min;
-	u_volt_max = opp->supply.u_volt_max;
+	memcpy(&new_supply, &opp->supply, sizeof(new_supply));
 
 	reg = opp_table->regulator;
 
@@ -652,8 +646,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Scaling up? Scale voltage before frequency */
 	if (freq > old_freq) {
-		ret = _set_opp_voltage(dev, reg, u_volt, u_volt_min,
-				       u_volt_max);
+		ret = _set_opp_voltage(dev, reg, &new_supply);
 		if (ret)
 			goto restore_voltage;
 	}
@@ -672,8 +665,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Scaling down? Scale voltage after frequency */
 	if (freq < old_freq) {
-		ret = _set_opp_voltage(dev, reg, u_volt, u_volt_min,
-				       u_volt_max);
+		ret = _set_opp_voltage(dev, reg, &new_supply);
 		if (ret)
 			goto restore_freq;
 	}
@@ -686,10 +678,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			__func__, old_freq);
 restore_voltage:
 	/* This shouldn't harm even if the voltages weren't updated earlier */
-	if (old_u_volt) {
-		_set_opp_voltage(dev, reg, old_u_volt, old_u_volt_min,
-				 old_u_volt_max);
-	}
+	if (old_supply.u_volt)
+		_set_opp_voltage(dev, reg, &old_supply);
 
 	return ret;
 }
-- 
2.7.1.410.g6faf27b

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V6 07/10] PM / OPP: Separate out _generic_set_opp()
Date: Wed, 30 Nov 2016 10:44:10 +0530
Message-ID: <53f11c6335e6100e7dfea34b538a4fd54a55d84c.1480481312.git.viresh.kumar@linaro.org>
References: <cover.1480481312.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36353 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753023AbcK3FOv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 00:14:51 -0500
Received: by mail-pg0-f41.google.com with SMTP id f188so77462287pgc.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Nov 2016 21:14:51 -0800 (PST)
In-Reply-To: <cover.1480481312.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1480481312.git.viresh.kumar@linaro.org>
References: <cover.1480481312.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Later patches would add support for custom set_opp() callbacks. This
patch separates out the code for _generic_set_opp() handler in order to
prepare for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Dave Gerlach <d-gerlach@ti.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

---
V4->V5:
- Make 'dev' part of struct dev_pm_set_opp_data
- Fix commit log: s/opp_set_rate/set_opp
- Same in a comment as well
---
 drivers/base/power/opp/core.c | 181 +++++++++++++++++++++++++++++-------------
 drivers/base/power/opp/opp.h  |   3 +
 include/linux/pm_opp.h        |  35 ++++++++
 3 files changed, 166 insertions(+), 53 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index f0dd0bd29ce8..0a53ae132d7f 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -610,6 +610,69 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 	return ret;
 }
 
+static inline int
+_generic_set_opp_clk_only(struct device *dev, struct clk *clk,
+			  unsigned long old_freq, unsigned long freq)
+{
+	int ret;
+
+	ret = clk_set_rate(clk, freq);
+	if (ret) {
+		dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
+			ret);
+	}
+
+	return ret;
+}
+
+static int _generic_set_opp(struct dev_pm_set_opp_data *data)
+{
+	struct dev_pm_opp_supply *old_supply = data->old_opp.supplies;
+	struct dev_pm_opp_supply *new_supply = data->new_opp.supplies;
+	unsigned long old_freq = data->old_opp.rate, freq = data->new_opp.rate;
+	struct regulator *reg = data->regulators[0];
+	struct device *dev= data->dev;
+	int ret;
+
+	/* This function only supports single regulator per device */
+	if (WARN_ON(data->regulator_count > 1)) {
+		dev_err(dev, "multiple regulators are not supported\n");
+		return -EINVAL;
+	}
+
+	/* Scaling up? Scale voltage before frequency */
+	if (freq > old_freq) {
+		ret = _set_opp_voltage(dev, reg, new_supply);
+		if (ret)
+			goto restore_voltage;
+	}
+
+	/* Change frequency */
+	ret = _generic_set_opp_clk_only(dev, data->clk, old_freq, freq);
+	if (ret)
+		goto restore_voltage;
+
+	/* Scaling down? Scale voltage after frequency */
+	if (freq < old_freq) {
+		ret = _set_opp_voltage(dev, reg, new_supply);
+		if (ret)
+			goto restore_freq;
+	}
+
+	return 0;
+
+restore_freq:
+	if (_generic_set_opp_clk_only(dev, data->clk, freq, old_freq))
+		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
+			__func__, old_freq);
+restore_voltage:
+	/* This shouldn't harm even if the voltages weren't updated earlier */
+	if (old_supply->u_volt)
+		_set_opp_voltage(dev, reg, old_supply);
+
+	return ret;
+}
+
 /**
  * dev_pm_opp_set_rate() - Configure new OPP based on frequency
  * @dev:	 device for which we do this operation
@@ -623,12 +686,12 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	struct opp_table *opp_table;
+	unsigned long freq, old_freq;
 	struct dev_pm_opp *old_opp, *opp;
-	struct regulator *reg = ERR_PTR(-ENXIO);
+	struct regulator **regulators;
+	struct dev_pm_set_opp_data *data;
 	struct clk *clk;
-	unsigned long freq, old_freq;
-	struct dev_pm_opp_supply old_supply, new_supply;
-	int ret;
+	int ret, size;
 
 	if (unlikely(!target_freq)) {
 		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
@@ -677,64 +740,36 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		return ret;
 	}
 
-	if (opp_table->regulators) {
-		/* This function only supports single regulator per device */
-		if (WARN_ON(opp_table->regulator_count > 1)) {
-			dev_err(dev, "multiple regulators not supported\n");
-			rcu_read_unlock();
-			return -EINVAL;
-		}
+	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
+		old_freq, freq);
 
-		reg = opp_table->regulators[0];
+	regulators = opp_table->regulators;
+
+	/* Only frequency scaling */
+	if (!regulators) {
+		rcu_read_unlock();
+		return _generic_set_opp_clk_only(dev, clk, old_freq, freq);
 	}
 
+	data = opp_table->set_opp_data;
+	data->regulators = regulators;
+	data->regulator_count = opp_table->regulator_count;
+	data->clk = clk;
+	data->dev = dev;
+
+	data->old_opp.rate = old_freq;
+	size = sizeof(*opp->supplies) * opp_table->regulator_count;
 	if (IS_ERR(old_opp))
-		old_supply.u_volt = 0;
+		memset(data->old_opp.supplies, 0, size);
 	else
-		memcpy(&old_supply, old_opp->supplies, sizeof(old_supply));
+		memcpy(data->old_opp.supplies, old_opp->supplies, size);
 
-	memcpy(&new_supply, opp->supplies, sizeof(new_supply));
+	data->new_opp.rate = freq;
+	memcpy(data->new_opp.supplies, opp->supplies, size);
 
 	rcu_read_unlock();
 
-	/* Scaling up? Scale voltage before frequency */
-	if (freq > old_freq) {
-		ret = _set_opp_voltage(dev, reg, &new_supply);
-		if (ret)
-			goto restore_voltage;
-	}
-
-	/* Change frequency */
-
-	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n",
-		__func__, old_freq, freq);
-
-	ret = clk_set_rate(clk, freq);
-	if (ret) {
-		dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
-			ret);
-		goto restore_voltage;
-	}
-
-	/* Scaling down? Scale voltage after frequency */
-	if (freq < old_freq) {
-		ret = _set_opp_voltage(dev, reg, &new_supply);
-		if (ret)
-			goto restore_freq;
-	}
-
-	return 0;
-
-restore_freq:
-	if (clk_set_rate(clk, old_freq))
-		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
-			__func__, old_freq);
-restore_voltage:
-	/* This shouldn't harm even if the voltages weren't updated earlier */
-	if (old_supply.u_volt)
-		_set_opp_voltage(dev, reg, &old_supply);
-
-	return ret;
+	return _generic_set_opp(data);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
 
@@ -1368,6 +1403,38 @@ void dev_pm_opp_put_prop_name(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
 
+static int _allocate_set_opp_data(struct opp_table *opp_table)
+{
+	struct dev_pm_set_opp_data *data;
+	int len, count = opp_table->regulator_count;
+
+	if (WARN_ON(!count))
+		return -EINVAL;
+
+	/* space for set_opp_data */
+	len = sizeof(*data);
+
+	/* space for old_opp.supplies and new_opp.supplies */
+	len += 2 * sizeof(struct dev_pm_opp_supply) * count;
+
+	data = kzalloc(len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->old_opp.supplies = (void *)(data + 1);
+	data->new_opp.supplies = data->old_opp.supplies + count;
+
+	opp_table->set_opp_data = data;
+
+	return 0;
+}
+
+static void _free_set_opp_data(struct opp_table *opp_table)
+{
+	kfree(opp_table->set_opp_data);
+	opp_table->set_opp_data = NULL;
+}
+
 /**
  * dev_pm_opp_set_regulators() - Set regulator names for the device
  * @dev: Device for which regulator name is being set.
@@ -1437,6 +1504,11 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 
 	opp_table->regulator_count = count;
 
+	/* Allocate block only once to pass to set_opp() routines */
+	ret = _allocate_set_opp_data(opp_table);
+	if (ret)
+		goto free_regulators;
+
 	mutex_unlock(&opp_table_lock);
 	return opp_table;
 
@@ -1446,6 +1518,7 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 
 	kfree(opp_table->regulators);
 	opp_table->regulators = NULL;
+	opp_table->regulator_count = 0;
 err:
 	_remove_opp_table(opp_table);
 unlock:
@@ -1482,6 +1555,8 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 	for (i = opp_table->regulator_count - 1; i >= 0; i--)
 		regulator_put(opp_table->regulators[i]);
 
+	_free_set_opp_data(opp_table);
+
 	kfree(opp_table->regulators);
 	opp_table->regulators = NULL;
 	opp_table->regulator_count = 0;
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 5b0f7e53bede..a05e43912c6b 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -141,6 +141,7 @@ enum opp_table_access {
  * @clk: Device's clock handle
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators
+ * @set_opp_data: Data to be passed to set_opp callback
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -178,6 +179,8 @@ struct opp_table {
 	struct regulator **regulators;
 	unsigned int regulator_count;
 
+	struct dev_pm_set_opp_data *set_opp_data;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	char dentry_name[NAME_MAX];
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 9a825ae78653..779b40a9287d 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -17,6 +17,8 @@
 #include <linux/err.h>
 #include <linux/notifier.h>
 
+struct clk;
+struct regulator;
 struct dev_pm_opp;
 struct device;
 struct opp_table;
@@ -41,6 +43,39 @@ struct dev_pm_opp_supply {
 	unsigned long u_amp;
 };
 
+/**
+ * struct dev_pm_opp_info - OPP freq/voltage/current values
+ * @rate:	Target clk rate in hz
+ * @supplies:	Array of voltage/current values for all power supplies
+ *
+ * This structure stores the freq/voltage/current values for a single OPP.
+ */
+struct dev_pm_opp_info {
+	unsigned long rate;
+	struct dev_pm_opp_supply *supplies;
+};
+
+/**
+ * struct dev_pm_set_opp_data - Set OPP data
+ * @old_opp:	Old OPP info
+ * @new_opp:	New OPP info
+ * @regulators:	Array of regulator pointers
+ * @regulator_count: Number of regulators
+ * @clk:	Pointer to clk
+ * @dev:	Pointer to the struct device
+ *
+ * This structure contains all information required for setting an OPP.
+ */
+struct dev_pm_set_opp_data {
+	struct dev_pm_opp_info old_opp;
+	struct dev_pm_opp_info new_opp;
+
+	struct regulator **regulators;
+	unsigned int regulator_count;
+	struct clk *clk;
+	struct device *dev;
+};
+
 #if defined(CONFIG_PM_OPP)
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
-- 
2.7.1.410.g6faf27b


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 7/8] PM / OPP: Allow platform specific custom opp_set_rate() callbacks
Date: Tue,  4 Oct 2016 17:26:49 +0530
Message-ID: <f774c37de292f89053f22e9a2ac0f51c73c8dd89.1475581665.git.viresh.kumar@linaro.org>
References: <cover.1475581665.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1475581665.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1475581665.git.viresh.kumar@linaro.org>
References: <cover.1475581665.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The generic opp_set_rate() handler isn't sufficient for platforms with
complex DVFS.  For example, some TI platforms have multiple regulators
for a CPU device. The order in which various supplies need to be
programmed is only known to the platform code and its best to leave it
to it.

This patch implements APIs to register platform specific opp_set_rate()
callback.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 114 +++++++++++++++++++++++++++++++++++++++++-
 drivers/base/power/opp/opp.h  |   1 +
 include/linux/pm_opp.h        |  10 ++++
 3 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 96f04392daef..f7c4ef194aac 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -677,6 +677,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	struct opp_table *opp_table;
 	unsigned long freq, old_freq;
+	int (*set_rate)(struct device *dev, struct dev_pm_set_rate_data *data);
 	struct dev_pm_opp *old_opp, *opp;
 	struct regulator **regulators;
 	struct dev_pm_set_rate_data *data;
@@ -738,6 +739,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		return _generic_opp_set_rate_clk_only(dev, clk, old_freq, freq);
 	}
 
+	if (opp_table->set_rate)
+		set_rate = opp_table->set_rate;
+	else
+		set_rate = _generic_opp_set_rate;
+
 	data = opp_table->set_rate_data;
 	data->regulators = regulators;
 	data->regulator_count = opp_table->regulator_count;
@@ -755,7 +761,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	rcu_read_unlock();
 
-	return _generic_opp_set_rate(dev, data);
+	return set_rate(dev, data);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
 
@@ -889,6 +895,9 @@ static void _remove_opp_table(struct opp_table *opp_table)
 	if (opp_table->regulators)
 		return;
 
+	if (opp_table->set_rate)
+		return;
+
 	/* Release clk */
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
@@ -1562,6 +1571,109 @@ void dev_pm_opp_put_regulators(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulators);
 
 /**
+ * dev_pm_opp_register_set_rate_helper() - Register custom OPP set rate helper
+ * @dev: Device for which the helper is getting registered.
+ * @set_rate: Custom OPP set rate helper.
+ *
+ * This is useful to support complex platforms (like platforms with multiple
+ * regulators per device), instead of the generic OPP set rate helper.
+ *
+ * This must be called before any OPPs are initialized for the device.
+ *
+ * Locking: The internal opp_table and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+int dev_pm_opp_register_set_rate_helper(struct device *dev,
+	int (*set_rate)(struct device *dev, struct dev_pm_set_rate_data *data))
+{
+	struct opp_table *opp_table;
+	int ret;
+
+	if (!set_rate)
+		return -EINVAL;
+
+	mutex_lock(&opp_table_lock);
+
+	opp_table = _add_opp_table(dev);
+	if (!opp_table) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	/* This should be called before OPPs are initialized */
+	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	/* Already have custom set_rate helper */
+	if (WARN_ON(opp_table->set_rate)) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	opp_table->set_rate = set_rate;
+
+	mutex_unlock(&opp_table_lock);
+	return 0;
+
+err:
+	_remove_opp_table(opp_table);
+unlock:
+	mutex_unlock(&opp_table_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_register_set_rate_helper);
+
+/**
+ * dev_pm_opp_register_put_rate_helper() - Releases resources blocked for
+ *					   set_rate helper
+ * @dev: Device for which custom set_rate helper has to be cleared.
+ *
+ * Locking: The internal opp_table and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+void dev_pm_opp_register_put_rate_helper(struct device *dev)
+{
+	struct opp_table *opp_table;
+
+	mutex_lock(&opp_table_lock);
+
+	/* Check for existing table for 'dev' first */
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "Failed to find opp_table: %ld\n",
+			PTR_ERR(opp_table));
+		goto unlock;
+	}
+
+	if (!opp_table->set_rate) {
+		dev_err(dev, "%s: Doesn't have custom set_rate helper set\n",
+			__func__);
+		goto unlock;
+	}
+
+	/* Make sure there are no concurrent readers while updating opp_table */
+	WARN_ON(!list_empty(&opp_table->opp_list));
+
+	opp_table->set_rate = NULL;
+
+	/* Try freeing opp_table if this was the last blocking resource */
+	_remove_opp_table(opp_table);
+
+unlock:
+	mutex_unlock(&opp_table_lock);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_register_put_rate_helper);
+
+/**
  * dev_pm_opp_add()  - Add an OPP table from a table definitions
  * @dev:	device for which we do this operation
  * @freq:	Frequency in Hz for this OPP
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 28011d6da345..38d97a59d762 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -194,6 +194,7 @@ struct opp_table {
 	struct regulator **regulators;
 	unsigned int regulator_count;
 
+	int (*set_rate)(struct device *dev, struct dev_pm_set_rate_data *data);
 	struct dev_pm_set_rate_data *set_rate_data;
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 630f0fd6065c..ef882ed24b0e 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -79,6 +79,8 @@ int dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct device *dev);
 int dev_pm_opp_set_regulators(struct device *dev, const char *names[], unsigned int count);
 void dev_pm_opp_put_regulators(struct device *dev);
+int dev_pm_opp_register_set_rate_helper(struct device *dev, int (*set_rate)(struct device *dev, struct dev_pm_set_rate_data *data));
+void dev_pm_opp_register_put_rate_helper(struct device *dev);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -178,6 +180,14 @@ static inline int dev_pm_opp_set_supported_hw(struct device *dev,
 
 static inline void dev_pm_opp_put_supported_hw(struct device *dev) {}
 
+int dev_pm_opp_register_set_rate_helper(struct device *dev,
+	int (*set_rate)(struct device *dev, struct dev_pm_set_rate_data *data))
+{
+	return -ENOTSUPP;
+}
+
+static inline void dev_pm_opp_register_put_rate_helper(struct device *dev) {}
+
 static inline int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
 	return -ENOTSUPP;
-- 
2.7.1.410.g6faf27b

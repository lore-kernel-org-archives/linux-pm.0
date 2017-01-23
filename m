From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 03/12] PM / OPP: Return opp_table from dev_pm_opp_set_*() routines
Date: Mon, 23 Jan 2017 10:11:43 +0530
Message-ID: <82ace2a9075930f713aa3cf943ae26a8a755bed9.1485146406.git.viresh.kumar@linaro.org>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1485146406.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1485146406.git.viresh.kumar@linaro.org>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Patrice Chotard <patrice.chotard@st.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: linux-pm@vger.kernel.org

Now that we have proper kernel reference infrastructure in place for OPP
tables, use it to guarantee that the OPP table isn't freed while being
used by the callers of dev_pm_opp_set_*() APIs.

Make them all return the pointer to the OPP table after taking its
reference and put the reference back with dev_pm_opp_put_*() APIs.

Now that the OPP table wouldn't get freed while these routines are
executing after dev_pm_opp_get_opp_table() is called, there is no need
to take opp_table_lock. Drop them as well.

Remove the rcu specific comments from these routines as they aren't
relevant anymore.

Note that prototypes of dev_pm_opp_{set|put}_regulators() were already
updated by another patch.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 243 +++++++++---------------------------------
 drivers/cpufreq/sti-cpufreq.c |  13 +--
 include/linux/pm_opp.h        |  35 +++---
 3 files changed, 74 insertions(+), 217 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index ccc0d8913fd0..1af349ab630e 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -974,18 +974,6 @@ static void _remove_opp_table(struct opp_table *opp_table)
 	if (!list_empty(&opp_table->opp_list))
 		return;
 
-	if (opp_table->supported_hw)
-		return;
-
-	if (opp_table->prop_name)
-		return;
-
-	if (opp_table->regulators)
-		return;
-
-	if (opp_table->set_opp)
-		return;
-
 	dev_pm_opp_put_opp_table_unlocked(opp_table);
 }
 
@@ -1277,27 +1265,16 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
  * specify the hierarchy of versions it supports. OPP layer will then enable
  * OPPs, which are available for those versions, based on its 'opp-supported-hw'
  * property.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
-int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
-				unsigned int count)
+struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
+			const u32 *versions, unsigned int count)
 {
 	struct opp_table *opp_table;
-	int ret = 0;
-
-	/* Hold our table modification lock here */
-	mutex_lock(&opp_table_lock);
+	int ret;
 
-	opp_table = _add_opp_table(dev);
-	if (!opp_table) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return ERR_PTR(-ENOMEM);
 
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
@@ -1318,65 +1295,40 @@ int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
 	}
 
 	opp_table->supported_hw_count = count;
-	mutex_unlock(&opp_table_lock);
-	return 0;
+
+	return opp_table;
 
 err:
-	_remove_opp_table(opp_table);
-unlock:
-	mutex_unlock(&opp_table_lock);
+	dev_pm_opp_put_opp_table(opp_table);
 
-	return ret;
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_supported_hw);
 
 /**
  * dev_pm_opp_put_supported_hw() - Releases resources blocked for supported hw
- * @dev: Device for which supported-hw has to be put.
+ * @opp_table: OPP table returned by dev_pm_opp_set_supported_hw().
  *
  * This is required only for the V2 bindings, and is called for a matching
  * dev_pm_opp_set_supported_hw(). Until this is called, the opp_table structure
  * will not be freed.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
-void dev_pm_opp_put_supported_hw(struct device *dev)
+void dev_pm_opp_put_supported_hw(struct opp_table *opp_table)
 {
-	struct opp_table *opp_table;
-
-	/* Hold our table modification lock here */
-	mutex_lock(&opp_table_lock);
-
-	/* Check for existing table for 'dev' first */
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		dev_err(dev, "Failed to find opp_table: %ld\n",
-			PTR_ERR(opp_table));
-		goto unlock;
-	}
-
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
 	if (!opp_table->supported_hw) {
-		dev_err(dev, "%s: Doesn't have supported hardware list\n",
-			__func__);
-		goto unlock;
+		pr_err("%s: Doesn't have supported hardware list\n",
+		       __func__);
+		return;
 	}
 
 	kfree(opp_table->supported_hw);
 	opp_table->supported_hw = NULL;
 	opp_table->supported_hw_count = 0;
 
-	/* Try freeing opp_table if this was the last blocking resource */
-	_remove_opp_table(opp_table);
-
-unlock:
-	mutex_unlock(&opp_table_lock);
+	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
 
@@ -1389,26 +1341,15 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
  * specify the extn to be used for certain property names. The properties to
  * which the extension will apply are opp-microvolt and opp-microamp. OPP core
  * should postfix the property name with -<name> while looking for them.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
-int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
+struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
 	struct opp_table *opp_table;
-	int ret = 0;
-
-	/* Hold our table modification lock here */
-	mutex_lock(&opp_table_lock);
+	int ret;
 
-	opp_table = _add_opp_table(dev);
-	if (!opp_table) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return ERR_PTR(-ENOMEM);
 
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
@@ -1427,63 +1368,37 @@ int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 		goto err;
 	}
 
-	mutex_unlock(&opp_table_lock);
-	return 0;
+	return opp_table;
 
 err:
-	_remove_opp_table(opp_table);
-unlock:
-	mutex_unlock(&opp_table_lock);
+	dev_pm_opp_put_opp_table(opp_table);
 
-	return ret;
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
 
 /**
  * dev_pm_opp_put_prop_name() - Releases resources blocked for prop-name
- * @dev: Device for which the prop-name has to be put.
+ * @opp_table: OPP table returned by dev_pm_opp_set_prop_name().
  *
  * This is required only for the V2 bindings, and is called for a matching
  * dev_pm_opp_set_prop_name(). Until this is called, the opp_table structure
  * will not be freed.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
-void dev_pm_opp_put_prop_name(struct device *dev)
+void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
 {
-	struct opp_table *opp_table;
-
-	/* Hold our table modification lock here */
-	mutex_lock(&opp_table_lock);
-
-	/* Check for existing table for 'dev' first */
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		dev_err(dev, "Failed to find opp_table: %ld\n",
-			PTR_ERR(opp_table));
-		goto unlock;
-	}
-
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
 	if (!opp_table->prop_name) {
-		dev_err(dev, "%s: Doesn't have a prop-name\n", __func__);
-		goto unlock;
+		pr_err("%s: Doesn't have a prop-name\n", __func__);
+		return;
 	}
 
 	kfree(opp_table->prop_name);
 	opp_table->prop_name = NULL;
 
-	/* Try freeing opp_table if this was the last blocking resource */
-	_remove_opp_table(opp_table);
-
-unlock:
-	mutex_unlock(&opp_table_lock);
+	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
 
@@ -1530,12 +1445,6 @@ static void _free_set_opp_data(struct opp_table *opp_table)
  * well.
  *
  * This must be called before any OPPs are initialized for the device.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 					    const char * const names[],
@@ -1545,13 +1454,9 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	struct regulator *reg;
 	int ret, i;
 
-	mutex_lock(&opp_table_lock);
-
-	opp_table = _add_opp_table(dev);
-	if (!opp_table) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return ERR_PTR(-ENOMEM);
 
 	/* This should be called before OPPs are initialized */
 	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
@@ -1593,7 +1498,6 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	if (ret)
 		goto free_regulators;
 
-	mutex_unlock(&opp_table_lock);
 	return opp_table;
 
 free_regulators:
@@ -1604,9 +1508,7 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	opp_table->regulators = NULL;
 	opp_table->regulator_count = 0;
 err:
-	_remove_opp_table(opp_table);
-unlock:
-	mutex_unlock(&opp_table_lock);
+	dev_pm_opp_put_opp_table(opp_table);
 
 	return ERR_PTR(ret);
 }
@@ -1615,22 +1517,14 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulators);
 /**
  * dev_pm_opp_put_regulators() - Releases resources blocked for regulator
  * @opp_table: OPP table returned from dev_pm_opp_set_regulators().
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
 void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 {
 	int i;
 
-	mutex_lock(&opp_table_lock);
-
 	if (!opp_table->regulators) {
 		pr_err("%s: Doesn't have regulators set\n", __func__);
-		goto unlock;
+		return;
 	}
 
 	/* Make sure there are no concurrent readers while updating opp_table */
@@ -1645,11 +1539,7 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 	opp_table->regulators = NULL;
 	opp_table->regulator_count = 0;
 
-	/* Try freeing opp_table if this was the last blocking resource */
-	_remove_opp_table(opp_table);
-
-unlock:
-	mutex_unlock(&opp_table_lock);
+	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulators);
 
@@ -1662,29 +1552,19 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulators);
  * regulators per device), instead of the generic OPP set rate helper.
  *
  * This must be called before any OPPs are initialized for the device.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
-int dev_pm_opp_register_set_opp_helper(struct device *dev,
+struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 			int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
 	struct opp_table *opp_table;
 	int ret;
 
 	if (!set_opp)
-		return -EINVAL;
-
-	mutex_lock(&opp_table_lock);
+		return ERR_PTR(-EINVAL);
 
-	opp_table = _add_opp_table(dev);
-	if (!opp_table) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return ERR_PTR(-ENOMEM);
 
 	/* This should be called before OPPs are initialized */
 	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
@@ -1700,47 +1580,28 @@ int dev_pm_opp_register_set_opp_helper(struct device *dev,
 
 	opp_table->set_opp = set_opp;
 
-	mutex_unlock(&opp_table_lock);
-	return 0;
+	return opp_table;
 
 err:
-	_remove_opp_table(opp_table);
-unlock:
-	mutex_unlock(&opp_table_lock);
+	dev_pm_opp_put_opp_table(opp_table);
 
-	return ret;
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_register_set_opp_helper);
 
 /**
  * dev_pm_opp_register_put_opp_helper() - Releases resources blocked for
  *					   set_opp helper
- * @dev: Device for which custom set_opp helper has to be cleared.
+ * @opp_table: OPP table returned from dev_pm_opp_register_set_opp_helper().
  *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
+ * Release resources blocked for platform specific set_opp helper.
  */
-void dev_pm_opp_register_put_opp_helper(struct device *dev)
+void dev_pm_opp_register_put_opp_helper(struct opp_table *opp_table)
 {
-	struct opp_table *opp_table;
-
-	mutex_lock(&opp_table_lock);
-
-	/* Check for existing table for 'dev' first */
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		dev_err(dev, "Failed to find opp_table: %ld\n",
-			PTR_ERR(opp_table));
-		goto unlock;
-	}
-
 	if (!opp_table->set_opp) {
-		dev_err(dev, "%s: Doesn't have custom set_opp helper set\n",
-			__func__);
-		goto unlock;
+		pr_err("%s: Doesn't have custom set_opp helper set\n",
+		       __func__);
+		return;
 	}
 
 	/* Make sure there are no concurrent readers while updating opp_table */
@@ -1748,11 +1609,7 @@ void dev_pm_opp_register_put_opp_helper(struct device *dev)
 
 	opp_table->set_opp = NULL;
 
-	/* Try freeing opp_table if this was the last blocking resource */
-	_remove_opp_table(opp_table);
-
-unlock:
-	mutex_unlock(&opp_table_lock);
+	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_register_put_opp_helper);
 
diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index b366e6d830ea..a7db9011d5fe 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -160,6 +160,7 @@ static int sti_cpufreq_set_opp_info(void)
 	int pcode, substrate, major, minor;
 	int ret;
 	char name[MAX_PCODE_NAME_LEN];
+	struct opp_table *opp_table;
 
 	reg_fields = sti_cpufreq_match();
 	if (!reg_fields) {
@@ -211,20 +212,20 @@ static int sti_cpufreq_set_opp_info(void)
 
 	snprintf(name, MAX_PCODE_NAME_LEN, "pcode%d", pcode);
 
-	ret = dev_pm_opp_set_prop_name(dev, name);
-	if (ret) {
+	opp_table = dev_pm_opp_set_prop_name(dev, name);
+	if (IS_ERR(opp_table)) {
 		dev_err(dev, "Failed to set prop name\n");
-		return ret;
+		return PTR_ERR(opp_table);
 	}
 
 	version[0] = BIT(major);
 	version[1] = BIT(minor);
 	version[2] = BIT(substrate);
 
-	ret = dev_pm_opp_set_supported_hw(dev, version, VERSION_ELEMENTS);
-	if (ret) {
+	opp_table = dev_pm_opp_set_supported_hw(dev, version, VERSION_ELEMENTS);
+	if (IS_ERR(opp_table)) {
 		dev_err(dev, "Failed to set supported hardware\n");
-		return ret;
+		return PTR_ERR(opp_table);
 	}
 
 	dev_dbg(dev, "pcode: %d major: %d minor: %d substrate: %d\n",
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index d867c6b25f9a..99787cbcaab2 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -114,15 +114,14 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
 
-int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
-				unsigned int count);
-void dev_pm_opp_put_supported_hw(struct device *dev);
-int dev_pm_opp_set_prop_name(struct device *dev, const char *name);
-void dev_pm_opp_put_prop_name(struct device *dev);
+struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
+void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
+struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
+void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
-int dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
-void dev_pm_opp_register_put_opp_helper(struct device *dev);
+struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
+void dev_pm_opp_register_put_opp_helper(struct opp_table *opp_table);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -224,29 +223,29 @@ static inline int dev_pm_opp_unregister_notifier(struct device *dev, struct noti
 	return -ENOTSUPP;
 }
 
-static inline int dev_pm_opp_set_supported_hw(struct device *dev,
-					      const u32 *versions,
-					      unsigned int count)
+static inline struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
+							    const u32 *versions,
+							    unsigned int count)
 {
-	return -ENOTSUPP;
+	return ERR_PTR(-ENOTSUPP);
 }
 
-static inline void dev_pm_opp_put_supported_hw(struct device *dev) {}
+static inline void dev_pm_opp_put_supported_hw(struct opp_table *opp_table) {}
 
-static inline int dev_pm_opp_register_set_opp_helper(struct device *dev,
+static inline struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 			int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
-	return -ENOTSUPP;
+	return ERR_PTR(-ENOTSUPP);
 }
 
-static inline void dev_pm_opp_register_put_opp_helper(struct device *dev) {}
+static inline void dev_pm_opp_register_put_opp_helper(struct opp_table *opp_table) {}
 
-static inline int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
+static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
-	return -ENOTSUPP;
+	return ERR_PTR(-ENOTSUPP);
 }
 
-static inline void dev_pm_opp_put_prop_name(struct device *dev) {}
+static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
 
 static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count)
 {
-- 
2.7.1.410.g6faf27b

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/12] PM / OPP: Move away from RCU locking
Date: Wed,  7 Dec 2016 16:07:47 +0530
Message-ID: <2141b49d888d7b60ff317256a559ab78c1448a03.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36034 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752481AbcLGKmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 05:42:35 -0500
Received: by mail-pf0-f180.google.com with SMTP id 189so76915411pfz.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2016 02:41:43 -0800 (PST)
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

The RCU locking isn't well suited for the OPP core. The RCU locking fits
better for reader heavy stuff, while the OPP core have at max one or two
readers only at a time.

Over that, it was getting very confusing the way RCU locking was used
with the OPP core. The individual OPPs are mostly well handled, i.e. for
an update a new structure was created and then that replaced the older
one. But the OPP tables were updated directly all the time from various
parts of the core. Though they were mostly used from within RCU locked
region, they didn't had much to do with RCU and were governed by the
mutex instead.

And that mixed with the 'opp_table_lock' has made the core even more
confusing.

Now that we are already managing the OPPs and the OPP tables with kernel
reference infrastructure, we can get rid of RCU locking completely and
simplify the code a lot.

Remove all RCU references from code and comments.

Acquire opp_table->lock while parsing the list of OPPs though.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 294 +++++++++++-------------------------------
 drivers/base/power/opp/cpu.c  |  18 ---
 drivers/base/power/opp/of.c   |  40 +-----
 drivers/base/power/opp/opp.h  |  22 +---
 4 files changed, 80 insertions(+), 294 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 2b689fc73596..b5e9600058c2 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -32,14 +32,6 @@ LIST_HEAD(opp_tables);
 /* Lock to allow exclusive modification to the device and opp lists */
 DEFINE_MUTEX(opp_table_lock);
 
-#define opp_rcu_lockdep_assert()					\
-do {									\
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
-			 !lockdep_is_held(&opp_table_lock),		\
-			 "Missing rcu_read_lock() or "			\
-			 "opp_table_lock protection");			\
-} while (0)
-
 static void dev_pm_opp_get(struct dev_pm_opp *opp);
 
 static struct opp_device *_find_opp_dev(const struct device *dev,
@@ -73,8 +65,7 @@ struct opp_table *_find_opp_table_unlocked(struct device *dev)
  * _find_opp_table() - find opp_table struct using device pointer
  * @dev:	device pointer used to lookup OPP table
  *
- * Search OPP table for one containing matching device. Does a RCU reader
- * operation to grab the pointer needed.
+ * Search OPP table for one containing matching device.
  *
  * Return: pointer to 'struct opp_table' if found, otherwise -ENODEV or
  * -EINVAL based on type of error.
@@ -108,19 +99,12 @@ struct opp_table *_find_opp_table(struct device *dev)
  */
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
-	struct dev_pm_opp *tmp_opp;
-	unsigned long v = 0;
-
-	rcu_read_lock();
-
-	tmp_opp = rcu_dereference(opp);
-	if (IS_ERR_OR_NULL(tmp_opp))
+	if (IS_ERR_OR_NULL(opp)) {
 		pr_err("%s: Invalid parameters\n", __func__);
-	else
-		v = tmp_opp->supplies[0].u_volt;
+		return 0;
+	}
 
-	rcu_read_unlock();
-	return v;
+	return opp->supplies[0].u_volt;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
 
@@ -133,19 +117,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
  */
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 {
-	struct dev_pm_opp *tmp_opp;
-	unsigned long f = 0;
-
-	rcu_read_lock();
-
-	tmp_opp = rcu_dereference(opp);
-	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available)
+	if (IS_ERR_OR_NULL(opp) || !opp->available) {
 		pr_err("%s: Invalid parameters\n", __func__);
-	else
-		f = tmp_opp->rate;
+		return 0;
+	}
 
-	rcu_read_unlock();
-	return f;
+	return opp->rate;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
@@ -161,21 +138,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
  */
 bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
 {
-	struct dev_pm_opp *tmp_opp;
-	bool turbo;
-
-	rcu_read_lock();
-
-	tmp_opp = rcu_dereference(opp);
-	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available) {
+	if (IS_ERR_OR_NULL(opp) || !opp->available) {
 		pr_err("%s: Invalid parameters\n", __func__);
 		return false;
 	}
 
-	turbo = tmp_opp->turbo;
-
-	rcu_read_unlock();
-	return turbo;
+	return opp->turbo;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_is_turbo);
 
@@ -223,8 +191,6 @@ static int _get_regulator_count(struct device *dev)
  * @dev: device for which we do this operation
  *
  * Return: This function returns the max voltage latency in nanoseconds.
- *
- * Locking: This function takes rcu_read_lock().
  */
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 {
@@ -256,15 +222,15 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 	if (IS_ERR(opp_table))
 		goto free_uV;
 
-	rcu_read_lock();
-
 	memcpy(regulators, opp_table->regulators, count * sizeof(*regulators));
 
+	mutex_lock(&opp_table->lock);
+
 	for (i = 0; i < count; i++) {
 		uV[i].min = ~0;
 		uV[i].max = 0;
 
-		list_for_each_entry_rcu(opp, &opp_table->opp_list, node) {
+		list_for_each_entry(opp, &opp_table->opp_list, node) {
 			if (!opp->available)
 				continue;
 
@@ -275,7 +241,7 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 		}
 	}
 
-	rcu_read_unlock();
+	mutex_unlock(&opp_table->lock);
 	dev_pm_opp_put_opp_table(opp_table);
 
 	/*
@@ -304,8 +270,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_volt_latency);
  *
  * Return: This function returns the max transition latency, in nanoseconds, to
  * switch from one OPP to other.
- *
- * Locking: This function takes rcu_read_lock().
  */
 unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev)
 {
@@ -345,8 +309,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
  *
  * Return: This function returns the number of available opps if there are any,
  * else returns 0 if none or the corresponding error value.
- *
- * Locking: This function takes rcu_read_lock().
  */
 int dev_pm_opp_get_opp_count(struct device *dev)
 {
@@ -362,14 +324,14 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 		return count;
 	}
 
-	rcu_read_lock();
+	mutex_lock(&opp_table->lock);
 
-	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available)
 			count++;
 	}
 
-	rcu_read_unlock();
+	mutex_unlock(&opp_table->lock);
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return count;
@@ -414,9 +376,9 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 		return ERR_PTR(r);
 	}
 
-	rcu_read_lock();
+	mutex_lock(&opp_table->lock);
 
-	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available == available &&
 				temp_opp->rate == freq) {
 			opp = temp_opp;
@@ -427,7 +389,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 		}
 	}
 
-	rcu_read_unlock();
+	mutex_unlock(&opp_table->lock);
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return opp;
@@ -439,7 +401,9 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 {
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
-	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available && temp_opp->rate >= *freq) {
 			opp = temp_opp;
 			*freq = opp->rate;
@@ -450,6 +414,8 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 		}
 	}
 
+	mutex_unlock(&opp_table->lock);
+
 	return opp;
 }
 
@@ -486,11 +452,8 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 	if (IS_ERR(opp_table))
 		return ERR_CAST(opp_table);
 
-	rcu_read_lock();
-
 	opp = _find_freq_ceil(opp_table, freq);
 
-	rcu_read_unlock();
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return opp;
@@ -530,9 +493,9 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	if (IS_ERR(opp_table))
 		return ERR_CAST(opp_table);
 
-	rcu_read_lock();
+	mutex_lock(&opp_table->lock);
 
-	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available) {
 			/* go to the next node, before choosing prev */
 			if (temp_opp->rate > *freq)
@@ -545,7 +508,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	/* Increment the reference count of OPP */
 	if (!IS_ERR(opp))
 		dev_pm_opp_get(opp);
-	rcu_read_unlock();
+	mutex_unlock(&opp_table->lock);
 	dev_pm_opp_put_opp_table(opp_table);
 
 	if (!IS_ERR(opp))
@@ -555,30 +518,6 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
-/*
- * The caller needs to ensure that opp_table (and hence the clk) isn't freed,
- * while clk returned here is used.
- */
-static struct clk *_get_opp_clk(struct device *dev)
-{
-	struct opp_table *opp_table;
-	struct clk *clk;
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
-		return ERR_CAST(opp_table);
-	}
-
-	clk = opp_table->clk;
-	if (IS_ERR(clk))
-		dev_err(dev, "%s: No clock available for the device\n",
-			__func__);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return clk;
-}
-
 static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 			    struct dev_pm_opp_supply *supply)
 {
@@ -674,8 +613,6 @@ static int _generic_set_opp(struct dev_pm_set_opp_data *data)
  *
  * This configures the power-supplies and clock source to the levels specified
  * by the OPP corresponding to the target_freq.
- *
- * Locking: This function takes rcu_read_lock().
  */
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
@@ -694,9 +631,19 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		return -EINVAL;
 	}
 
-	clk = _get_opp_clk(dev);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
+		return PTR_ERR(opp_table);
+	}
+
+	clk = opp_table->clk;
+	if (IS_ERR(clk)) {
+		dev_err(dev, "%s: No clock available for the device\n",
+			__func__);
+		ret = PTR_ERR(clk);
+		goto put_opp_table;
+	}
 
 	freq = clk_round_rate(clk, target_freq);
 	if ((long)freq <= 0)
@@ -708,17 +655,10 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	if (old_freq == freq) {
 		dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",
 			__func__, freq);
-		return 0;
-	}
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
-		return PTR_ERR(opp_table);
+		ret = 0;
+		goto put_opp_table;
 	}
 
-	rcu_read_lock();
-
 	old_opp = _find_freq_ceil(opp_table, &old_freq);
 	if (IS_ERR(old_opp)) {
 		dev_err(dev, "%s: failed to find current OPP for freq %lu (%ld)\n",
@@ -730,11 +670,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		ret = PTR_ERR(opp);
 		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
 			__func__, freq, ret);
-		if (!IS_ERR(old_opp))
-			dev_pm_opp_put(old_opp);
-		rcu_read_unlock();
-		dev_pm_opp_put_opp_table(opp_table);
-		return ret;
+		goto put_old_opp;
 	}
 
 	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
@@ -744,12 +680,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Only frequency scaling */
 	if (!regulators) {
-		dev_pm_opp_put(opp);
-		if (!IS_ERR(old_opp))
-			dev_pm_opp_put(old_opp);
-		rcu_read_unlock();
-		dev_pm_opp_put_opp_table(opp_table);
-		return _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+		goto put_opps;
 	}
 
 	if (opp_table->set_opp)
@@ -773,32 +705,26 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	data->new_opp.rate = freq;
 	memcpy(data->new_opp.supplies, opp->supplies, size);
 
+	ret = set_opp(data);
+
+put_opps:
 	dev_pm_opp_put(opp);
+put_old_opp:
 	if (!IS_ERR(old_opp))
 		dev_pm_opp_put(old_opp);
-	rcu_read_unlock();
+put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
-
-	return set_opp(data);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
 
 /* OPP-dev Helpers */
-static void _kfree_opp_dev_rcu(struct rcu_head *head)
-{
-	struct opp_device *opp_dev;
-
-	opp_dev = container_of(head, struct opp_device, rcu_head);
-	kfree_rcu(opp_dev, rcu_head);
-}
-
 static void _remove_opp_dev(struct opp_device *opp_dev,
 			    struct opp_table *opp_table)
 {
 	opp_debug_unregister(opp_dev, opp_table);
 	list_del(&opp_dev->node);
-	call_srcu(&opp_table->srcu_head.srcu, &opp_dev->rcu_head,
-		  _kfree_opp_dev_rcu);
+	kfree(opp_dev);
 }
 
 struct opp_device *_add_opp_dev(const struct device *dev,
@@ -813,7 +739,7 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 
 	/* Initialize opp-dev */
 	opp_dev->dev = dev;
-	list_add_rcu(&opp_dev->node, &opp_table->dev_list);
+	list_add(&opp_dev->node, &opp_table->dev_list);
 
 	/* Create debugfs entries for the opp_table */
 	ret = opp_debug_register(opp_dev, opp_table);
@@ -857,28 +783,16 @@ static struct opp_table *_allocate_opp_table(struct device *dev)
 				ret);
 	}
 
-	srcu_init_notifier_head(&opp_table->srcu_head);
+	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
 	mutex_init(&opp_table->lock);
 	kref_init(&opp_table->kref);
 
 	/* Secure the device table modification */
-	list_add_rcu(&opp_table->node, &opp_tables);
+	list_add(&opp_table->node, &opp_tables);
 	return opp_table;
 }
 
-/**
- * _kfree_device_rcu() - Free opp_table RCU handler
- * @head:	RCU head
- */
-static void _kfree_device_rcu(struct rcu_head *head)
-{
-	struct opp_table *opp_table = container_of(head, struct opp_table,
-						   rcu_head);
-
-	kfree_rcu(opp_table, rcu_head);
-}
-
 void _get_opp_table_kref(struct opp_table *opp_table)
 {
 	kref_get(&opp_table->kref);
@@ -922,9 +836,8 @@ static void _opp_table_kref_release(struct kref *kref)
 	WARN_ON(!list_empty(&opp_table->dev_list));
 
 	mutex_destroy(&opp_table->lock);
-	list_del_rcu(&opp_table->node);
-	call_srcu(&opp_table->srcu_head.srcu, &opp_table->rcu_head,
-		  _kfree_device_rcu);
+	list_del(&opp_table->node);
+	kfree(opp_table);
 
 	mutex_unlock(&opp_table_lock);
 }
@@ -941,17 +854,6 @@ void _opp_free(struct dev_pm_opp *opp)
 	kfree(opp);
 }
 
-/**
- * _kfree_opp_rcu() - Free OPP RCU handler
- * @head:	RCU head
- */
-static void _kfree_opp_rcu(struct rcu_head *head)
-{
-	struct dev_pm_opp *opp = container_of(head, struct dev_pm_opp, rcu_head);
-
-	kfree_rcu(opp, rcu_head);
-}
-
 static void _opp_kref_release(struct kref *kref)
 {
 	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
@@ -961,10 +863,10 @@ static void _opp_kref_release(struct kref *kref)
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
 	 */
-	srcu_notifier_call_chain(&opp_table->srcu_head, OPP_EVENT_REMOVE, opp);
+	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_REMOVE, opp);
 	opp_debug_remove_one(opp);
-	list_del_rcu(&opp->node);
-	call_srcu(&opp_table->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
+	list_del(&opp->node);
+	kfree(opp);
 
 	mutex_unlock(&opp_table->lock);
 	dev_pm_opp_put_opp_table(opp_table);
@@ -987,12 +889,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put);
  * @freq:	OPP to remove with matching 'freq'
  *
  * This function removes an opp from the opp table.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
 void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 {
@@ -1098,7 +994,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	mutex_lock(&opp_table->lock);
 	head = &opp_table->opp_list;
 
-	list_for_each_entry_rcu(opp, &opp_table->opp_list, node) {
+	list_for_each_entry(opp, &opp_table->opp_list, node) {
 		if (new_opp->rate > opp->rate) {
 			head = &opp->node;
 			continue;
@@ -1121,7 +1017,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 		return ret;
 	}
 
-	list_add_rcu(&new_opp->node, head);
+	list_add(&new_opp->node, head);
 	mutex_unlock(&opp_table->lock);
 
 	new_opp->opp_table = opp_table;
@@ -1159,12 +1055,6 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
  * NOTE: "dynamic" parameter impacts OPPs added by the dev_pm_opp_of_add_table
  * and freed by dev_pm_opp_of_remove_table.
  *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
- *
  * Return:
  * 0		On success OR
  *		Duplicate OPPs (both freq and volt are same) and opp->available
@@ -1204,7 +1094,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
 	 */
-	srcu_notifier_call_chain(&opp_table->srcu_head, OPP_EVENT_ADD, new_opp);
+	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ADD, new_opp);
 	return 0;
 
 free_opp:
@@ -1581,12 +1471,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_register_put_opp_helper);
  * The opp is made available by default and it can be controlled using
  * dev_pm_opp_enable/disable functions.
  *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
- *
  * Return:
  * 0		On success OR
  *		Duplicate OPPs (both freq and volt are same) and opp->available
@@ -1616,18 +1500,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_add);
  * @freq:		OPP frequency to modify availability
  * @availability_req:	availability status requested for this opp
  *
- * Set the availability of an OPP with an RCU operation, opp_{enable,disable}
- * share a common logic which is isolated here.
+ * Set the availability of an OPP, opp_{enable,disable} share a common logic
+ * which is isolated here.
  *
  * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
  * copy operation, returns 0 if no modification was done OR modification was
  * successful.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks to
- * keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex locking or synchronize_rcu() blocking calls cannot be used.
  */
 static int _opp_set_availability(struct device *dev, unsigned long freq,
 				 bool availability_req)
@@ -1673,16 +1551,16 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 	/* plug in new node */
 	new_opp->available = availability_req;
 
-	list_replace_rcu(&opp->node, &new_opp->node);
-	call_srcu(&opp_table->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
+	list_replace(&opp->node, &new_opp->node);
+	kfree(opp);
 
 	/* Notify the change of the OPP availability */
 	if (availability_req)
-		srcu_notifier_call_chain(&opp_table->srcu_head,
-					 OPP_EVENT_ENABLE, new_opp);
+		blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ENABLE,
+					     new_opp);
 	else
-		srcu_notifier_call_chain(&opp_table->srcu_head,
-					 OPP_EVENT_DISABLE, new_opp);
+		blocking_notifier_call_chain(&opp_table->head,
+					     OPP_EVENT_DISABLE, new_opp);
 
 	mutex_unlock(&opp_table->lock);
 	dev_pm_opp_put_opp_table(opp_table);
@@ -1705,12 +1583,6 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
  * corresponding error value. It is meant to be used for users an OPP available
  * after being temporarily made unavailable with dev_pm_opp_disable.
  *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function indirectly uses RCU and mutex locks to keep the
- * integrity of the internal data structures. Callers should ensure that
- * this function is *NOT* called under RCU protection or in contexts where
- * mutex locking or synchronize_rcu() blocking calls cannot be used.
- *
  * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
  * copy operation, returns 0 if no modification was done OR modification was
  * successful.
@@ -1731,12 +1603,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_enable);
  * control by users to make this OPP not available until the circumstances are
  * right to make it available again (with a call to dev_pm_opp_enable).
  *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function indirectly uses RCU and mutex locks to keep the
- * integrity of the internal data structures. Callers should ensure that
- * this function is *NOT* called under RCU protection or in contexts where
- * mutex locking or synchronize_rcu() blocking calls cannot be used.
- *
  * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
  * copy operation, returns 0 if no modification was done OR modification was
  * successful.
@@ -1763,11 +1629,8 @@ int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
-	rcu_read_lock();
-
-	ret = srcu_notifier_chain_register(&opp_table->srcu_head, nb);
+	ret = blocking_notifier_chain_register(&opp_table->head, nb);
 
-	rcu_read_unlock();
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
@@ -1791,9 +1654,8 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
-	ret = srcu_notifier_chain_unregister(&opp_table->srcu_head, nb);
+	ret = blocking_notifier_chain_unregister(&opp_table->head, nb);
 
-	rcu_read_unlock();
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
@@ -1849,12 +1711,6 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all)
  *
  * Free both OPPs created using static entries present in DT and the
  * dynamically added entries.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function indirectly uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
 void dev_pm_opp_remove_table(struct device *dev)
 {
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index df29f08eecc4..2d87bc1adf38 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -137,12 +137,6 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
  * This removes the OPP tables for CPUs present in the @cpumask.
  * This should be used to remove all the OPPs entries associated with
  * the cpus in @cpumask.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask)
 {
@@ -159,12 +153,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_remove_table);
  * @cpumask.
  *
  * Returns -ENODEV if OPP table isn't already present.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev,
 				const struct cpumask *cpumask)
@@ -215,12 +203,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
  *
  * Returns -ENODEV if OPP table isn't already present and -EINVAL if the OPP
  * table's status is access-unknown.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index a789dc228a6a..f78b9aba587c 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -28,7 +28,7 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 
 	mutex_lock(&opp_table_lock);
 
-	list_for_each_entry_rcu(opp_table, &opp_tables, node) {
+	list_for_each_entry(opp_table, &opp_tables, node) {
 		if (opp_table->np == np) {
 			/*
 			 * Multiple devices can point to the same OPP table and
@@ -235,12 +235,6 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
  * @dev:	device pointer used to lookup OPP table.
  *
  * Free OPPs created using static entries present in DT.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function indirectly uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
 void dev_pm_opp_of_remove_table(struct device *dev)
 {
@@ -269,12 +263,6 @@ static struct device_node *_of_get_opp_desc_node(struct device *dev)
  * opp can be controlled using dev_pm_opp_enable/disable functions and may be
  * removed by dev_pm_opp_remove.
  *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
- *
  * Return:
  * 0		On success OR
  *		Duplicate OPPs (both freq and volt are same) and opp->available
@@ -358,7 +346,7 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
 	 */
-	srcu_notifier_call_chain(&opp_table->srcu_head, OPP_EVENT_ADD, new_opp);
+	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ADD, new_opp);
 	return 0;
 
 free_opp:
@@ -470,12 +458,6 @@ static int _of_add_opp_table_v1(struct device *dev)
  *
  * Register the initial OPP table with the OPP library for given device.
  *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function indirectly uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
- *
  * Return:
  * 0		On success OR
  *		Duplicate OPPs (both freq and volt are same) and opp->available
@@ -520,12 +502,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
  *
  * This removes the OPP tables for CPUs present in the @cpumask.
  * This should be used only to remove static entries created from DT.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
 {
@@ -538,12 +514,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
  * @cpumask:	cpumask for which OPP table needs to be added.
  *
  * This adds the OPP tables for CPUs present in the @cpumask.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
 int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 {
@@ -591,12 +561,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
  * This updates the @cpumask with CPUs that are sharing OPPs with @cpu_dev.
  *
  * Returns -ENOENT if operating-points-v2 isn't present for @cpu_dev.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
  */
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 				   struct cpumask *cpumask)
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index bd929ba6efaf..e7898afddef2 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -20,8 +20,7 @@
 #include <linux/list.h>
 #include <linux/limits.h>
 #include <linux/pm_opp.h>
-#include <linux/rculist.h>
-#include <linux/rcupdate.h>
+#include <linux/notifier.h>
 
 struct clk;
 struct regulator;
@@ -52,9 +51,6 @@ extern struct list_head opp_tables;
  * @node:	opp table node. The nodes are maintained throughout the lifetime
  *		of boot. It is expected only an optimal set of OPPs are
  *		added to the library by the SoC framework.
- *		RCU usage: opp table is traversed with RCU locks. node
- *		modification is possible realtime, hence the modifications
- *		are protected by the opp_table_lock for integrity.
  *		IMPORTANT: the opp nodes should be maintained in increasing
  *		order.
  * @kref:	for reference count of the OPP.
@@ -67,7 +63,6 @@ extern struct list_head opp_tables;
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
  *		frequency from any other OPP's frequency.
  * @opp_table:	points back to the opp_table struct this opp belongs to
- * @rcu_head:	RCU callback head used for deferred freeing
  * @np:		OPP's device node.
  * @dentry:	debugfs dentry pointer (per opp)
  *
@@ -88,7 +83,6 @@ struct dev_pm_opp {
 	unsigned long clock_latency_ns;
 
 	struct opp_table *opp_table;
-	struct rcu_head rcu_head;
 
 	struct device_node *np;
 
@@ -101,7 +95,6 @@ struct dev_pm_opp {
  * struct opp_device - devices managed by 'struct opp_table'
  * @node:	list node
  * @dev:	device to which the struct object belongs
- * @rcu_head:	RCU callback head used for deferred freeing
  * @dentry:	debugfs dentry pointer (per device)
  *
  * This is an internal data structure maintaining the devices that are managed
@@ -110,7 +103,6 @@ struct dev_pm_opp {
 struct opp_device {
 	struct list_head node;
 	const struct device *dev;
-	struct rcu_head rcu_head;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
@@ -128,10 +120,7 @@ enum opp_table_access {
  * @node:	table node - contains the devices with OPPs that
  *		have been registered. Nodes once added are not modified in this
  *		table.
- *		RCU usage: nodes are not modified in the table of opp_table,
- *		however addition is possible and is secured by opp_table_lock
- * @srcu_head:	notifier head to notify the OPP availability changes.
- * @rcu_head:	RCU callback head used for deferred freeing
+ * @head:	notifier head to notify the OPP availability changes.
  * @dev_list:	list of devices that share these OPPs
  * @opp_list:	table of opps
  * @kref:	for reference count of the table.
@@ -156,16 +145,11 @@ enum opp_table_access {
  * This is an internal data structure maintaining the link to opps attached to
  * a device. This structure is not meant to be shared to users as it is
  * meant for book keeping and private to OPP library.
- *
- * Because the opp structures can be used from both rcu and srcu readers, we
- * need to wait for the grace period of both of them before freeing any
- * resources. And so we have used kfree_rcu() from within call_srcu() handlers.
  */
 struct opp_table {
 	struct list_head node;
 
-	struct srcu_notifier_head srcu_head;
-	struct rcu_head rcu_head;
+	struct blocking_notifier_head head;
 	struct list_head dev_list;
 	struct list_head opp_list;
 	struct kref kref;
-- 
2.7.1.410.g6faf27b


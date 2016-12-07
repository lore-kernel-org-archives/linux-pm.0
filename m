From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/12] PM / OPP: Take kref from _find_opp_table()
Date: Wed,  7 Dec 2016 16:07:46 +0530
Message-ID: <88eef775e522f5addaca2059ae4d0815507d2ffe.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36342 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbcLGKmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 05:42:35 -0500
Received: by mail-pg0-f53.google.com with SMTP id f188so160284503pgc.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2016 02:41:38 -0800 (PST)
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

Take reference of the OPP table from within _find_opp_table(). Also
update the callers of _find_opp_table() to call
dev_pm_opp_put_opp_table() after they have used the OPP table.

Note that _find_opp_table() increments the reference under the
opp_table_lock.

Now that the OPP table wouldn't get freed until the callers of
_find_opp_table() call dev_pm_opp_put_opp_table(), there is no need to
take the opp_table_lock or rcu_read_lock() around it. Drop them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 191 +++++++++++++++++++-----------------------
 drivers/base/power/opp/cpu.c  |  26 ++----
 2 files changed, 95 insertions(+), 122 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d112b1846327..2b689fc73596 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -54,6 +54,21 @@ static struct opp_device *_find_opp_dev(const struct device *dev,
 	return NULL;
 }
 
+struct opp_table *_find_opp_table_unlocked(struct device *dev)
+{
+	struct opp_table *opp_table;
+
+	list_for_each_entry(opp_table, &opp_tables, node) {
+		if (_find_opp_dev(dev, opp_table)) {
+			_get_opp_table_kref(opp_table);
+
+			return opp_table;
+		}
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
 /**
  * _find_opp_table() - find opp_table struct using device pointer
  * @dev:	device pointer used to lookup OPP table
@@ -64,28 +79,22 @@ static struct opp_device *_find_opp_dev(const struct device *dev,
  * Return: pointer to 'struct opp_table' if found, otherwise -ENODEV or
  * -EINVAL based on type of error.
  *
- * Locking: For readers, this function must be called under rcu_read_lock().
- * opp_table is a RCU protected pointer, which means that opp_table is valid
- * as long as we are under RCU lock.
- *
- * For Writers, this function must be called with opp_table_lock held.
+ * The callers must call dev_pm_opp_put_opp_table() after the table is used.
  */
 struct opp_table *_find_opp_table(struct device *dev)
 {
 	struct opp_table *opp_table;
 
-	opp_rcu_lockdep_assert();
-
 	if (IS_ERR_OR_NULL(dev)) {
 		pr_err("%s: Invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 
-	list_for_each_entry_rcu(opp_table, &opp_tables, node)
-		if (_find_opp_dev(dev, opp_table))
-			return opp_table;
+	mutex_lock(&opp_table_lock);
+	opp_table = _find_opp_table_unlocked(dev);
+	mutex_unlock(&opp_table_lock);
 
-	return ERR_PTR(-ENODEV);
+	return opp_table;
 }
 
 /**
@@ -175,23 +184,20 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_is_turbo);
  * @dev:	device for which we do this operation
  *
  * Return: This function returns the max clock latency in nanoseconds.
- *
- * Locking: This function takes rcu_read_lock().
  */
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
 {
 	struct opp_table *opp_table;
 	unsigned long clock_latency_ns;
 
-	rcu_read_lock();
-
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
-		clock_latency_ns = 0;
-	else
-		clock_latency_ns = opp_table->clock_latency_ns_max;
+		return 0;
+
+	clock_latency_ns = opp_table->clock_latency_ns_max;
+
+	dev_pm_opp_put_opp_table(opp_table);
 
-	rcu_read_unlock();
 	return clock_latency_ns;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
@@ -201,15 +207,13 @@ static int _get_regulator_count(struct device *dev)
 	struct opp_table *opp_table;
 	int count;
 
-	rcu_read_lock();
-
 	opp_table = _find_opp_table(dev);
-	if (!IS_ERR(opp_table))
-		count = opp_table->regulator_count;
-	else
-		count = 0;
+	if (IS_ERR(opp_table))
+		return 0;
 
-	rcu_read_unlock();
+	count = opp_table->regulator_count;
+
+	dev_pm_opp_put_opp_table(opp_table);
 
 	return count;
 }
@@ -248,13 +252,11 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 	if (!uV)
 		goto free_regulators;
 
-	rcu_read_lock();
-
 	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		rcu_read_unlock();
+	if (IS_ERR(opp_table))
 		goto free_uV;
-	}
+
+	rcu_read_lock();
 
 	memcpy(regulators, opp_table->regulators, count * sizeof(*regulators));
 
@@ -274,6 +276,7 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 	}
 
 	rcu_read_unlock();
+	dev_pm_opp_put_opp_table(opp_table);
 
 	/*
 	 * The caller needs to ensure that opp_table (and hence the regulator)
@@ -323,17 +326,15 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 	struct opp_table *opp_table;
 	unsigned long freq = 0;
 
-	rcu_read_lock();
-
 	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table) || !opp_table->suspend_opp ||
-	    !opp_table->suspend_opp->available)
-		goto unlock;
+	if (IS_ERR(opp_table))
+		return 0;
 
-	freq = dev_pm_opp_get_freq(opp_table->suspend_opp);
+	if (opp_table->suspend_opp && opp_table->suspend_opp->available)
+		freq = dev_pm_opp_get_freq(opp_table->suspend_opp);
+
+	dev_pm_opp_put_opp_table(opp_table);
 
-unlock:
-	rcu_read_unlock();
 	return freq;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
@@ -353,23 +354,24 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 	struct dev_pm_opp *temp_opp;
 	int count = 0;
 
-	rcu_read_lock();
-
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		count = PTR_ERR(opp_table);
 		dev_err(dev, "%s: OPP table not found (%d)\n",
 			__func__, count);
-		goto out_unlock;
+		return count;
 	}
 
+	rcu_read_lock();
+
 	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available)
 			count++;
 	}
 
-out_unlock:
 	rcu_read_unlock();
+	dev_pm_opp_put_opp_table(opp_table);
+
 	return count;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
@@ -404,17 +406,16 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 	struct opp_table *opp_table;
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
-	rcu_read_lock();
-
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		int r = PTR_ERR(opp_table);
 
 		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
-		rcu_read_unlock();
 		return ERR_PTR(r);
 	}
 
+	rcu_read_lock();
+
 	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available == available &&
 				temp_opp->rate == freq) {
@@ -427,6 +428,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 	}
 
 	rcu_read_unlock();
+	dev_pm_opp_put_opp_table(opp_table);
 
 	return opp;
 }
@@ -480,17 +482,16 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
-	rcu_read_lock();
-
 	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		rcu_read_unlock();
+	if (IS_ERR(opp_table))
 		return ERR_CAST(opp_table);
-	}
+
+	rcu_read_lock();
 
 	opp = _find_freq_ceil(opp_table, freq);
 
 	rcu_read_unlock();
+	dev_pm_opp_put_opp_table(opp_table);
 
 	return opp;
 }
@@ -525,13 +526,11 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
-	rcu_read_lock();
-
 	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		rcu_read_unlock();
+	if (IS_ERR(opp_table))
 		return ERR_CAST(opp_table);
-	}
+
+	rcu_read_lock();
 
 	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available) {
@@ -547,6 +546,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	if (!IS_ERR(opp))
 		dev_pm_opp_get(opp);
 	rcu_read_unlock();
+	dev_pm_opp_put_opp_table(opp_table);
 
 	if (!IS_ERR(opp))
 		*freq = opp->rate;
@@ -564,22 +564,18 @@ static struct clk *_get_opp_clk(struct device *dev)
 	struct opp_table *opp_table;
 	struct clk *clk;
 
-	rcu_read_lock();
-
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
-		clk = ERR_CAST(opp_table);
-		goto unlock;
+		return ERR_CAST(opp_table);
 	}
 
 	clk = opp_table->clk;
 	if (IS_ERR(clk))
 		dev_err(dev, "%s: No clock available for the device\n",
 			__func__);
+	dev_pm_opp_put_opp_table(opp_table);
 
-unlock:
-	rcu_read_unlock();
 	return clk;
 }
 
@@ -715,15 +711,14 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		return 0;
 	}
 
-	rcu_read_lock();
-
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
-		rcu_read_unlock();
 		return PTR_ERR(opp_table);
 	}
 
+	rcu_read_lock();
+
 	old_opp = _find_freq_ceil(opp_table, &old_freq);
 	if (IS_ERR(old_opp)) {
 		dev_err(dev, "%s: failed to find current OPP for freq %lu (%ld)\n",
@@ -738,6 +733,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		if (!IS_ERR(old_opp))
 			dev_pm_opp_put(old_opp);
 		rcu_read_unlock();
+		dev_pm_opp_put_opp_table(opp_table);
 		return ret;
 	}
 
@@ -752,6 +748,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		if (!IS_ERR(old_opp))
 			dev_pm_opp_put(old_opp);
 		rcu_read_unlock();
+		dev_pm_opp_put_opp_table(opp_table);
 		return _generic_set_opp_clk_only(dev, clk, old_freq, freq);
 	}
 
@@ -780,6 +777,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	if (!IS_ERR(old_opp))
 		dev_pm_opp_put(old_opp);
 	rcu_read_unlock();
+	dev_pm_opp_put_opp_table(opp_table);
 
 	return set_opp(data);
 }
@@ -893,11 +891,9 @@ struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 	/* Hold our table modification lock here */
 	mutex_lock(&opp_table_lock);
 
-	opp_table = _find_opp_table(dev);
-	if (!IS_ERR(opp_table)) {
-		_get_opp_table_kref(opp_table);
+	opp_table = _find_opp_table_unlocked(dev);
+	if (!IS_ERR(opp_table))
 		goto unlock;
-	}
 
 	opp_table = _allocate_opp_table(dev);
 
@@ -1004,12 +1000,9 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 	struct opp_table *opp_table;
 	bool found = false;
 
-	/* Hold our table modification lock here */
-	mutex_lock(&opp_table_lock);
-
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
-		goto unlock;
+		return;
 
 	mutex_lock(&opp_table->lock);
 
@@ -1022,15 +1015,14 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 
 	mutex_unlock(&opp_table->lock);
 
-	if (!found) {
+	if (found) {
+		dev_pm_opp_put(opp);
+	} else {
 		dev_warn(dev, "%s: Couldn't find OPP with freq: %lu\n",
 			 __func__, freq);
-		goto unlock;
 	}
 
-	dev_pm_opp_put(opp);
-unlock:
-	mutex_unlock(&opp_table_lock);
+	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
@@ -1649,14 +1641,12 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 	if (!new_opp)
 		return -ENOMEM;
 
-	mutex_lock(&opp_table_lock);
-
 	/* Find the opp_table */
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		r = PTR_ERR(opp_table);
 		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
-		goto unlock;
+		goto free_opp;
 	}
 
 	mutex_lock(&opp_table->lock);
@@ -1669,8 +1659,6 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 		}
 	}
 
-	mutex_unlock(&opp_table->lock);
-
 	if (IS_ERR(opp)) {
 		r = PTR_ERR(opp);
 		goto unlock;
@@ -1686,7 +1674,6 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 	new_opp->available = availability_req;
 
 	list_replace_rcu(&opp->node, &new_opp->node);
-	mutex_unlock(&opp_table_lock);
 	call_srcu(&opp_table->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
 
 	/* Notify the change of the OPP availability */
@@ -1697,10 +1684,14 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 		srcu_notifier_call_chain(&opp_table->srcu_head,
 					 OPP_EVENT_DISABLE, new_opp);
 
+	mutex_unlock(&opp_table->lock);
+	dev_pm_opp_put_opp_table(opp_table);
 	return 0;
 
 unlock:
-	mutex_unlock(&opp_table_lock);
+	mutex_unlock(&opp_table->lock);
+	dev_pm_opp_put_opp_table(opp_table);
+free_opp:
 	kfree(new_opp);
 	return r;
 }
@@ -1768,18 +1759,16 @@ int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
 	struct opp_table *opp_table;
 	int ret;
 
-	rcu_read_lock();
-
 	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		ret = PTR_ERR(opp_table);
-		goto unlock;
-	}
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
+
+	rcu_read_lock();
 
 	ret = srcu_notifier_chain_register(&opp_table->srcu_head, nb);
 
-unlock:
 	rcu_read_unlock();
+	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
@@ -1798,18 +1787,14 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
 	struct opp_table *opp_table;
 	int ret;
 
-	rcu_read_lock();
-
 	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		ret = PTR_ERR(opp_table);
-		goto unlock;
-	}
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
 
 	ret = srcu_notifier_chain_unregister(&opp_table->srcu_head, nb);
 
-unlock:
 	rcu_read_unlock();
+	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
@@ -1840,9 +1825,6 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all)
 {
 	struct opp_table *opp_table;
 
-	/* Hold our table modification lock here */
-	mutex_lock(&opp_table_lock);
-
 	/* Check for existing table for 'dev' */
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
@@ -1853,13 +1835,12 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all)
 			     IS_ERR_OR_NULL(dev) ?
 					"Invalid device" : dev_name(dev),
 			     error);
-		goto unlock;
+		return;
 	}
 
 	_dev_pm_opp_remove_table(opp_table, dev, remove_all);
 
-unlock:
-	mutex_unlock(&opp_table_lock);
+	dev_pm_opp_put_opp_table(opp_table);
 }
 
 /**
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index adef788862d5..df29f08eecc4 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -174,13 +174,9 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev,
 	struct device *dev;
 	int cpu, ret = 0;
 
-	mutex_lock(&opp_table_lock);
-
 	opp_table = _find_opp_table(cpu_dev);
-	if (IS_ERR(opp_table)) {
-		ret = PTR_ERR(opp_table);
-		goto unlock;
-	}
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
 
 	for_each_cpu(cpu, cpumask) {
 		if (cpu == cpu_dev->id)
@@ -203,8 +199,8 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev,
 		/* Mark opp-table as multiple CPUs are sharing it now */
 		opp_table->shared_opp = OPP_TABLE_ACCESS_SHARED;
 	}
-unlock:
-	mutex_unlock(&opp_table_lock);
+
+	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
@@ -232,17 +228,13 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 	struct opp_table *opp_table;
 	int ret = 0;
 
-	mutex_lock(&opp_table_lock);
-
 	opp_table = _find_opp_table(cpu_dev);
-	if (IS_ERR(opp_table)) {
-		ret = PTR_ERR(opp_table);
-		goto unlock;
-	}
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
 
 	if (opp_table->shared_opp == OPP_TABLE_ACCESS_UNKNOWN) {
 		ret = -EINVAL;
-		goto unlock;
+		goto put_opp_table;
 	}
 
 	cpumask_clear(cpumask);
@@ -254,8 +246,8 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 		cpumask_set_cpu(cpu_dev->id, cpumask);
 	}
 
-unlock:
-	mutex_unlock(&opp_table_lock);
+put_opp_table:
+	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
-- 
2.7.1.410.g6faf27b


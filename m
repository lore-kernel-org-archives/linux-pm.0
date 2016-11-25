From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: Allow inactive opp_device to be present in dev list
Date: Fri, 25 Nov 2016 12:23:14 +0530
Message-ID: <2fe61813c867c173ddfcb0b9cabc00a65997a935.1480056714.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34803 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbcKYGx2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Nov 2016 01:53:28 -0500
Received: by mail-pg0-f51.google.com with SMTP id x23so26661603pgx.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Nov 2016 22:53:28 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, jy0922.shim@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Joonyoung Shim reported an interesting problem on his ARM octa-core
Odoroid-XU3 platform. During system suspend, dev_pm_opp_put_regulator()
was failing for a struct device for which dev_pm_opp_set_regulator() is
called earlier.

This happened because an earlier call to
dev_pm_opp_of_cpumask_remove_table() function (from cpufreq-dt.c file)
removed all the entries from opp_table->dev_list apart from the last CPU
device in the cpumask of CPUs sharing the OPP.

But both dev_pm_opp_set_regulator() and dev_pm_opp_put_regulator()
routines get CPU device for the first CPU in the cpumask. And so the OPP
core failed to find the OPP table for the struct device.

This patch attempts to fix this problem by adding another field in the
struct opp_device: inactive.

Instead of removing the entries from the list during
dev_pm_opp_of_cpumask_remove_table() function call, we mark them as
inactive. Such inactive devices will not be used by the core in most of
the cases, like before, but will be used only at special places which
need to take inactive devices into account.

All the devices are removed from the list together now and that happens
only when the opp_table gets destroyed.

This patch is tested on Dual A15, Exynos5250 platform by compiling the
cpufreq-dt driver as a module. The module is inserted/removed multiple
times with combinations of CPU offline/online steps.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c    | 156 ++++++++++++++++++++++++++-------------
 drivers/base/power/opp/cpu.c     |   4 +-
 drivers/base/power/opp/debugfs.c |   4 +-
 drivers/base/power/opp/of.c      |   2 +-
 drivers/base/power/opp/opp.h     |   6 +-
 5 files changed, 116 insertions(+), 56 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 4c7c6da7a989..df3c8b3a62ea 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -40,14 +40,30 @@ do {									\
 			 "opp_table_lock protection");			\
 } while (0)
 
+/**
+ * _find_opp_dev - Returns existing opp_dev for opp table
+ *
+ * @dev: Device for which opp_dev needs to be found
+ * @opp_table: OPP table.
+ * @active_only: If true: find only for active entries. If false, find for both
+ * active and inactive entries.
+ */
 static struct opp_device *_find_opp_dev(const struct device *dev,
-					struct opp_table *opp_table)
+					struct opp_table *opp_table,
+					bool active_only)
 {
 	struct opp_device *opp_dev;
 
-	list_for_each_entry(opp_dev, &opp_table->dev_list, node)
-		if (opp_dev->dev == dev)
-			return opp_dev;
+	list_for_each_entry(opp_dev, &opp_table->dev_list, node) {
+		if (opp_dev->dev != dev)
+			continue;
+
+		/* Only return active entries ? */
+		if (active_only && opp_dev->inactive)
+			return NULL;
+
+		return opp_dev;
+	}
 
 	return NULL;
 }
@@ -55,6 +71,8 @@ static struct opp_device *_find_opp_dev(const struct device *dev,
 /**
  * _find_opp_table() - find opp_table struct using device pointer
  * @dev:	device pointer used to lookup OPP table
+ * @active_only: If true: find only for active entries. If false, find for both
+ * active and inactive entries.
  *
  * Search OPP table for one containing matching device. Does a RCU reader
  * operation to grab the pointer needed.
@@ -68,7 +86,7 @@ static struct opp_device *_find_opp_dev(const struct device *dev,
  *
  * For Writers, this function must be called with opp_table_lock held.
  */
-struct opp_table *_find_opp_table(struct device *dev)
+struct opp_table *_find_opp_table(struct device *dev, bool active_only)
 {
 	struct opp_table *opp_table;
 
@@ -80,7 +98,7 @@ struct opp_table *_find_opp_table(struct device *dev)
 	}
 
 	list_for_each_entry_rcu(opp_table, &opp_tables, node)
-		if (_find_opp_dev(dev, opp_table))
+		if (_find_opp_dev(dev, opp_table, active_only))
 			return opp_table;
 
 	return ERR_PTR(-ENODEV);
@@ -199,7 +217,7 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
 
 	rcu_read_lock();
 
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, true);
 	if (IS_ERR(opp_table))
 		clock_latency_ns = 0;
 	else
@@ -229,7 +247,7 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 
 	rcu_read_lock();
 
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, true);
 	if (IS_ERR(opp_table)) {
 		rcu_read_unlock();
 		return 0;
@@ -302,7 +320,7 @@ struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev)
 
 	opp_rcu_lockdep_assert();
 
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, true);
 	if (IS_ERR(opp_table) || !opp_table->suspend_opp ||
 	    !opp_table->suspend_opp->available)
 		return NULL;
@@ -328,7 +346,7 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 
 	rcu_read_lock();
 
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, true);
 	if (IS_ERR(opp_table)) {
 		count = PTR_ERR(opp_table);
 		dev_err(dev, "%s: OPP table not found (%d)\n",
@@ -382,7 +400,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 
 	opp_rcu_lockdep_assert();
 
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, true);
 	if (IS_ERR(opp_table)) {
 		int r = PTR_ERR(opp_table);
 
@@ -451,7 +469,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, true);
 	if (IS_ERR(opp_table))
 		return ERR_CAST(opp_table);
 
@@ -493,7 +511,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, true);
 	if (IS_ERR(opp_table))
 		return ERR_CAST(opp_table);
 
@@ -524,7 +542,7 @@ static struct clk *_get_opp_clk(struct device *dev)
 
 	rcu_read_lock();
 
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, true);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
 		clk = ERR_CAST(opp_table);
@@ -611,7 +629,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	rcu_read_lock();
 
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, true);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
 		rcu_read_unlock();
@@ -694,21 +712,57 @@ static void _kfree_opp_dev_rcu(struct rcu_head *head)
 	kfree_rcu(opp_dev, rcu_head);
 }
 
-static void _remove_opp_dev(struct opp_device *opp_dev,
-			    struct opp_table *opp_table)
+static void _remove_opp_devices(struct opp_table *opp_table)
+{
+	struct opp_device *opp_dev, *tmp;
+
+	list_for_each_entry_safe(opp_dev, tmp, &opp_table->dev_list, node) {
+		list_del(&opp_dev->node);
+		call_srcu(&opp_table->srcu_head.srcu, &opp_dev->rcu_head,
+			  _kfree_opp_dev_rcu);
+	}
+}
+
+static void _deactivate_opp_dev(struct opp_device *opp_dev,
+				struct opp_table *opp_table)
 {
+	opp_table->active_dev_count--;
+	opp_dev->inactive = true;
 	opp_debug_unregister(opp_dev, opp_table);
-	list_del(&opp_dev->node);
-	call_srcu(&opp_table->srcu_head.srcu, &opp_dev->rcu_head,
-		  _kfree_opp_dev_rcu);
+}
+
+static void _activate_opp_dev(struct opp_device *opp_dev,
+			      struct opp_table *opp_table)
+{
+	int ret;
+
+	/* Create debugfs entries for the opp_table */
+	ret = opp_debug_register(opp_dev, opp_table);
+	if (ret)
+		dev_err(opp_dev->dev, "%s: Failed to register opp debugfs (%d)\n",
+			__func__, ret);
+
+	opp_dev->inactive = false;
+	opp_table->active_dev_count++;
 }
 
 struct opp_device *_add_opp_dev(const struct device *dev,
 				struct opp_table *opp_table)
 {
 	struct opp_device *opp_dev;
-	int ret;
 
+	/* Try to find an inactive entry first */
+	opp_dev = _find_opp_dev(dev, opp_table, false);
+	if (opp_dev) {
+		if (opp_dev->inactive)
+			goto activate;
+
+		/* Already active */
+		dev_err(opp_dev->dev, "%s: Entry already active\n", __func__);
+		return NULL;
+	}
+
+	/* Allocate new opp-dev */
 	opp_dev = kzalloc(sizeof(*opp_dev), GFP_KERNEL);
 	if (!opp_dev)
 		return NULL;
@@ -717,12 +771,8 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	opp_dev->dev = dev;
 	list_add_rcu(&opp_dev->node, &opp_table->dev_list);
 
-	/* Create debugfs entries for the opp_table */
-	ret = opp_debug_register(opp_dev, opp_table);
-	if (ret)
-		dev_err(dev, "%s: Failed to register opp debugfs (%d)\n",
-			__func__, ret);
-
+activate:
+	_activate_opp_dev(opp_dev, opp_table);
 	return opp_dev;
 }
 
@@ -742,7 +792,7 @@ static struct opp_table *_add_opp_table(struct device *dev)
 	int ret;
 
 	/* Check for existing table for 'dev' first */
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, false);
 	if (!IS_ERR(opp_table))
 		return opp_table;
 
@@ -804,8 +854,6 @@ static void _kfree_device_rcu(struct rcu_head *head)
  */
 static void _remove_opp_table(struct opp_table *opp_table)
 {
-	struct opp_device *opp_dev;
-
 	if (!list_empty(&opp_table->opp_list))
 		return;
 
@@ -822,10 +870,7 @@ static void _remove_opp_table(struct opp_table *opp_table)
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
 
-	opp_dev = list_first_entry(&opp_table->dev_list, struct opp_device,
-				   node);
-
-	_remove_opp_dev(opp_dev, opp_table);
+	_remove_opp_devices(opp_table);
 
 	/* dev_list must be empty now */
 	WARN_ON(!list_empty(&opp_table->dev_list));
@@ -897,7 +942,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 	/* Hold our table modification lock here */
 	mutex_lock(&opp_table_lock);
 
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, true);
 	if (IS_ERR(opp_table))
 		goto unlock;
 
@@ -1165,7 +1210,7 @@ void dev_pm_opp_put_supported_hw(struct device *dev)
 	mutex_lock(&opp_table_lock);
 
 	/* Check for existing table for 'dev' first */
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, false);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "Failed to find opp_table: %ld\n",
 			PTR_ERR(opp_table));
@@ -1274,7 +1319,7 @@ void dev_pm_opp_put_prop_name(struct device *dev)
 	mutex_lock(&opp_table_lock);
 
 	/* Check for existing table for 'dev' first */
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, false);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "Failed to find opp_table: %ld\n",
 			PTR_ERR(opp_table));
@@ -1382,7 +1427,7 @@ void dev_pm_opp_put_regulator(struct device *dev)
 	mutex_lock(&opp_table_lock);
 
 	/* Check for existing table for 'dev' first */
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, false);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "Failed to find opp_table: %ld\n",
 			PTR_ERR(opp_table));
@@ -1471,7 +1516,7 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 	mutex_lock(&opp_table_lock);
 
 	/* Find the opp_table */
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, true);
 	if (IS_ERR(opp_table)) {
 		r = PTR_ERR(opp_table);
 		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
@@ -1586,7 +1631,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
  */
 struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev)
 {
-	struct opp_table *opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table = _find_opp_table(dev, true);
 
 	if (IS_ERR(opp_table))
 		return ERR_CAST(opp_table); /* matching type */
@@ -1603,12 +1648,13 @@ void _dev_pm_opp_remove_table(struct device *dev, bool remove_all)
 {
 	struct opp_table *opp_table;
 	struct dev_pm_opp *opp, *tmp;
+	struct opp_device *opp_dev;
 
 	/* Hold our table modification lock here */
 	mutex_lock(&opp_table_lock);
 
 	/* Check for existing table for 'dev' */
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, true);
 	if (IS_ERR(opp_table)) {
 		int error = PTR_ERR(opp_table);
 
@@ -1620,17 +1666,27 @@ void _dev_pm_opp_remove_table(struct device *dev, bool remove_all)
 		goto unlock;
 	}
 
-	/* Find if opp_table manages a single device */
-	if (list_is_singular(&opp_table->dev_list)) {
-		/* Free static OPPs */
-		list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
-			if (remove_all || !opp->dynamic)
-				_opp_remove(opp_table, opp, true);
-		}
-	} else {
-		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
+	opp_dev = _find_opp_dev(dev, opp_table, true);
+
+	/* Already inactive */
+	if (opp_dev->inactive) {
+		dev_err(opp_dev->dev, "%s: entry already inactive\n", __func__);
+		goto unlock;
 	}
 
+	/* Remove the OPPs only if the table has no active devices */
+	if (opp_table->active_dev_count > 1)
+		goto deactivate;
+
+	/* Free static OPPs */
+	list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
+		if (remove_all || !opp->dynamic)
+			_opp_remove(opp_table, opp, true);
+	}
+
+deactivate:
+	_deactivate_opp_dev(opp_dev, opp_table);
+
 unlock:
 	mutex_unlock(&opp_table_lock);
 }
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 8c3434bdb26d..203b5b79740a 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -186,7 +186,7 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev,
 
 	mutex_lock(&opp_table_lock);
 
-	opp_table = _find_opp_table(cpu_dev);
+	opp_table = _find_opp_table(cpu_dev, true);
 	if (IS_ERR(opp_table)) {
 		ret = PTR_ERR(opp_table);
 		goto unlock;
@@ -244,7 +244,7 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 
 	mutex_lock(&opp_table_lock);
 
-	opp_table = _find_opp_table(cpu_dev);
+	opp_table = _find_opp_table(cpu_dev, true);
 	if (IS_ERR(opp_table)) {
 		ret = PTR_ERR(opp_table);
 		goto unlock;
diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
index ef1ae6b52042..44ec0209947f 100644
--- a/drivers/base/power/opp/debugfs.c
+++ b/drivers/base/power/opp/debugfs.c
@@ -158,7 +158,7 @@ static void opp_migrate_dentry(struct opp_device *opp_dev,
 
 	/* Look for next opp-dev */
 	list_for_each_entry(new_dev, &opp_table->dev_list, node)
-		if (new_dev != opp_dev)
+		if (new_dev != opp_dev && !new_dev->inactive)
 			break;
 
 	/* new_dev is guaranteed to be valid here */
@@ -191,7 +191,7 @@ void opp_debug_unregister(struct opp_device *opp_dev,
 {
 	if (opp_dev->dentry == opp_table->dentry) {
 		/* Move the real dentry object under another device */
-		if (!list_is_singular(&opp_table->dev_list)) {
+		if (opp_table->active_dev_count) {
 			opp_migrate_dentry(opp_dev, opp_table);
 			goto out;
 		}
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 5b3755e49731..75b10159576e 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -358,7 +358,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 
 	mutex_lock(&opp_table_lock);
 
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table(dev, true);
 	if (WARN_ON(IS_ERR(opp_table))) {
 		ret = PTR_ERR(opp_table);
 		mutex_unlock(&opp_table_lock);
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 96cd30ac6c1d..6eb5aed7777b 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -104,6 +104,7 @@ struct dev_pm_opp {
  * @node:	list node
  * @dev:	device to which the struct object belongs
  * @rcu_head:	RCU callback head used for deferred freeing
+ * @inactive:	'fase' if the device is still using the opp table, else 'true'.
  * @dentry:	debugfs dentry pointer (per device)
  *
  * This is an internal data structure maintaining the devices that are managed
@@ -113,6 +114,7 @@ struct opp_device {
 	struct list_head node;
 	const struct device *dev;
 	struct rcu_head rcu_head;
+	bool inactive;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
@@ -136,6 +138,7 @@ enum opp_table_access {
  * @rcu_head:	RCU callback head used for deferred freeing
  * @dev_list:	list of devices that share these OPPs
  * @opp_list:	table of opps
+ * @active_dev_count: Count of active devices using this table.
  * @np:		struct device_node pointer for opp's DT node.
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @shared_opp: OPP is shared between multiple devices.
@@ -165,6 +168,7 @@ struct opp_table {
 	struct rcu_head rcu_head;
 	struct list_head dev_list;
 	struct list_head opp_list;
+	unsigned int active_dev_count;
 
 	struct device_node *np;
 	unsigned long clock_latency_ns_max;
@@ -188,7 +192,7 @@ struct opp_table {
 };
 
 /* Routines internal to opp core */
-struct opp_table *_find_opp_table(struct device *dev);
+struct opp_table *_find_opp_table(struct device *dev, bool active_only);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
 void _dev_pm_opp_remove_table(struct device *dev, bool remove_all);
 struct dev_pm_opp *_allocate_opp(struct device *dev, struct opp_table **opp_table);
-- 
2.7.1.410.g6faf27b


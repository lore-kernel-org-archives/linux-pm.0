From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/12] PM / OPP: Use dev_pm_opp_get_opp_table() instead of _add_opp_table()
Date: Wed,  7 Dec 2016 16:07:43 +0530
Message-ID: <50b18f15c09e7a42830c5b7b71a1b6f48b2f198a.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Migrate all users of _add_opp_table() to use dev_pm_opp_get_opp_table()
to guarantee that the OPP table doesn't get freed while being used.

Also update _managed_opp() to get the reference to the OPP table.

Now that the OPP table wouldn't get freed while these routines are
executing after dev_pm_opp_get_opp_table() is called, there is no need
to take opp_table_lock. Drop them as well.

Now that _add_opp_table(), _remove_opp_table() and the unlocked release
routines aren't used anymore, remove them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 63 ++++---------------------------------------
 drivers/base/power/opp/of.c   | 54 +++++++++++++++++--------------------
 drivers/base/power/opp/opp.h  |  1 -
 3 files changed, 29 insertions(+), 89 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index aacca85ebd20..ec833a8f7aa5 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -863,27 +863,6 @@ static struct opp_table *_allocate_opp_table(struct device *dev)
 }
 
 /**
- * _add_opp_table() - Find OPP table or allocate a new one
- * @dev:	device for which we do this operation
- *
- * It tries to find an existing table first, if it couldn't find one, it
- * allocates a new OPP table and returns that.
- *
- * Return: valid opp_table pointer if success, else NULL.
- */
-struct opp_table *_add_opp_table(struct device *dev)
-{
-	struct opp_table *opp_table;
-
-	/* Check for existing table for 'dev' first */
-	opp_table = _find_opp_table(dev);
-	if (!IS_ERR(opp_table))
-		return opp_table;
-
-	return _allocate_opp_table(dev);
-}
-
-/**
  * _kfree_device_rcu() - Free opp_table RCU handler
  * @head:	RCU head
  */
@@ -922,7 +901,7 @@ struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_table);
 
-static void _opp_table_kref_release_unlocked(struct kref *kref)
+static void _opp_table_kref_release(struct kref *kref)
 {
 	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
 	struct opp_device *opp_dev;
@@ -943,16 +922,7 @@ static void _opp_table_kref_release_unlocked(struct kref *kref)
 	list_del_rcu(&opp_table->node);
 	call_srcu(&opp_table->srcu_head.srcu, &opp_table->rcu_head,
 		  _kfree_device_rcu);
-}
 
-static void dev_pm_opp_put_opp_table_unlocked(struct opp_table *opp_table)
-{
-	kref_put(&opp_table->kref, _opp_table_kref_release_unlocked);
-}
-
-static void _opp_table_kref_release(struct kref *kref)
-{
-	_opp_table_kref_release_unlocked(kref);
 	mutex_unlock(&opp_table_lock);
 }
 
@@ -963,17 +933,6 @@ void dev_pm_opp_put_opp_table(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_opp_table);
 
-/**
- * _remove_opp_table() - Removes a OPP table
- * @opp_table: OPP table to be removed.
- *
- * Removes/frees OPP table if it doesn't contain any OPPs.
- */
-static void _remove_opp_table(struct opp_table *opp_table)
-{
-	dev_pm_opp_put_opp_table_unlocked(opp_table);
-}
-
 void _opp_free(struct dev_pm_opp *opp)
 {
 	kfree(opp);
@@ -1219,8 +1178,6 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	unsigned long tol;
 	int ret;
 
-	opp_rcu_lockdep_assert();
-
 	new_opp = _opp_allocate(dev, opp_table);
 	if (!new_opp)
 		return -ENOMEM;
@@ -1641,21 +1598,13 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	struct opp_table *opp_table;
 	int ret;
 
-	/* Hold our table modification lock here */
-	mutex_lock(&opp_table_lock);
-
-	opp_table = _add_opp_table(dev);
-	if (!opp_table) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return -ENOMEM;
 
 	ret = _opp_add_v1(opp_table, dev, freq, u_volt, true);
-	if (ret)
-		_remove_opp_table(opp_table);
 
-unlock:
-	mutex_unlock(&opp_table_lock);
+	dev_pm_opp_put_opp_table(opp_table);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_add);
@@ -1866,8 +1815,6 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
 {
 	struct dev_pm_opp *opp, *tmp;
 
-	opp_rcu_lockdep_assert();
-
 	/* Find if opp_table manages a single device */
 	if (list_is_singular(&opp_table->dev_list)) {
 		/* Free static OPPs */
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 38efc14d829c..a789dc228a6a 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -24,7 +24,9 @@
 
 static struct opp_table *_managed_opp(const struct device_node *np)
 {
-	struct opp_table *opp_table;
+	struct opp_table *opp_table, *managed_table = NULL;
+
+	mutex_lock(&opp_table_lock);
 
 	list_for_each_entry_rcu(opp_table, &opp_tables, node) {
 		if (opp_table->np == np) {
@@ -35,14 +37,18 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 			 * But the OPPs will be considered as shared only if the
 			 * OPP table contains a "opp-shared" property.
 			 */
-			if (opp_table->shared_opp == OPP_TABLE_ACCESS_SHARED)
-				return opp_table;
+			if (opp_table->shared_opp == OPP_TABLE_ACCESS_SHARED) {
+				_get_opp_table_kref(opp_table);
+				managed_table = opp_table;
+			}
 
-			return NULL;
+			break;
 		}
 	}
 
-	return NULL;
+	mutex_unlock(&opp_table_lock);
+
+	return managed_table;
 }
 
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev)
@@ -368,21 +374,17 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	struct opp_table *opp_table;
 	int ret = 0, count = 0;
 
-	mutex_lock(&opp_table_lock);
-
 	opp_table = _managed_opp(opp_np);
 	if (opp_table) {
 		/* OPPs are already managed */
 		if (!_add_opp_dev(dev, opp_table))
 			ret = -ENOMEM;
-		goto unlock;
+		goto put_opp_table;
 	}
 
-	opp_table = _add_opp_table(dev);
-	if (!opp_table) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return -ENOMEM;
 
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
@@ -392,14 +394,15 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
-			goto free_table;
+			_dev_pm_opp_remove_table(opp_table, dev, false);
+			goto put_opp_table;
 		}
 	}
 
 	/* There should be one of more OPP defined */
 	if (WARN_ON(!count)) {
 		ret = -ENOENT;
-		goto free_table;
+		goto put_opp_table;
 	}
 
 	opp_table->np = opp_np;
@@ -408,12 +411,8 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	else
 		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
 
-	goto unlock;
-
-free_table:
-	_dev_pm_opp_remove_table(opp_table, dev, false);
-unlock:
-	mutex_unlock(&opp_table_lock);
+put_opp_table:
+	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
@@ -442,13 +441,9 @@ static int _of_add_opp_table_v1(struct device *dev)
 		return -EINVAL;
 	}
 
-	mutex_lock(&opp_table_lock);
-
-	opp_table = _add_opp_table(dev);
-	if (!opp_table) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return -ENOMEM;
 
 	val = prop->value;
 	while (nr) {
@@ -465,8 +460,7 @@ static int _of_add_opp_table_v1(struct device *dev)
 		nr -= 2;
 	}
 
-unlock:
-	mutex_unlock(&opp_table_lock);
+	dev_pm_opp_put_opp_table(opp_table);
 	return ret;
 }
 
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 596f361fbe70..8435a0eb27be 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -196,7 +196,6 @@ struct opp_table {
 /* Routines internal to opp core */
 void _get_opp_table_kref(struct opp_table *opp_table);
 struct opp_table *_find_opp_table(struct device *dev);
-struct opp_table *_add_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
 void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev, bool remove_all);
 void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all);
-- 
2.7.1.410.g6faf27b

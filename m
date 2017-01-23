From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 02/12] PM / OPP: Add 'struct kref' to OPP table
Date: Mon, 23 Jan 2017 10:11:42 +0530
Message-ID: <2739c3b223b586377f6fb6b0570f74afa81848e4.1485146406.git.viresh.kumar@linaro.org>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1485146406.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1485146406.git.viresh.kumar@linaro.org>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Add kref to struct opp_table for easier accounting of the OPP table.

Note that the new routine dev_pm_opp_get_opp_table() takes the reference
from under the opp_table_lock, which guarantees that the OPP table
doesn't get freed unless dev_pm_opp_put_opp_table() is called for the
OPP table.

Two separate release mechanisms are added: locked and unlocked. In
unlocked version the routines aren't required to take/drop
opp_table_lock as the callers have already done that. This is required
to avoid breaking git bisect, otherwise we may get lockdeps between
commits. Once all the users of OPP table are updated the unlocked
version shall be removed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 51 +++++++++++++++++++++++++++++++++++++++++--
 drivers/base/power/opp/opp.h  |  3 +++
 include/linux/pm_opp.h        | 10 +++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index dcebd5efb6a1..ccc0d8913fd0 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -855,6 +855,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev)
 	srcu_init_notifier_head(&opp_table->srcu_head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
 	mutex_init(&opp_table->lock);
+	kref_init(&opp_table->kref);
 
 	/* Secure the device table modification */
 	list_add_rcu(&opp_table->node, &opp_tables);
@@ -894,8 +895,36 @@ static void _kfree_device_rcu(struct rcu_head *head)
 	kfree_rcu(opp_table, rcu_head);
 }
 
-static void _free_opp_table(struct opp_table *opp_table)
+void _get_opp_table_kref(struct opp_table *opp_table)
 {
+	kref_get(&opp_table->kref);
+}
+
+struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
+{
+	struct opp_table *opp_table;
+
+	/* Hold our table modification lock here */
+	mutex_lock(&opp_table_lock);
+
+	opp_table = _find_opp_table(dev);
+	if (!IS_ERR(opp_table)) {
+		_get_opp_table_kref(opp_table);
+		goto unlock;
+	}
+
+	opp_table = _allocate_opp_table(dev);
+
+unlock:
+	mutex_unlock(&opp_table_lock);
+
+	return opp_table;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_table);
+
+static void _opp_table_kref_release_unlocked(struct kref *kref)
+{
+	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
 	struct opp_device *opp_dev;
 
 	/* Release clk */
@@ -916,6 +945,24 @@ static void _free_opp_table(struct opp_table *opp_table)
 		  _kfree_device_rcu);
 }
 
+static void dev_pm_opp_put_opp_table_unlocked(struct opp_table *opp_table)
+{
+	kref_put(&opp_table->kref, _opp_table_kref_release_unlocked);
+}
+
+static void _opp_table_kref_release(struct kref *kref)
+{
+	_opp_table_kref_release_unlocked(kref);
+	mutex_unlock(&opp_table_lock);
+}
+
+void dev_pm_opp_put_opp_table(struct opp_table *opp_table)
+{
+	kref_put_mutex(&opp_table->kref, _opp_table_kref_release,
+		       &opp_table_lock);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_opp_table);
+
 /**
  * _remove_opp_table() - Removes a OPP table
  * @opp_table: OPP table to be removed.
@@ -939,7 +986,7 @@ static void _remove_opp_table(struct opp_table *opp_table)
 	if (opp_table->set_opp)
 		return;
 
-	_free_opp_table(opp_table);
+	dev_pm_opp_put_opp_table_unlocked(opp_table);
 }
 
 void _opp_free(struct dev_pm_opp *opp)
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 105243b06373..aae4d8f480ef 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -131,6 +131,7 @@ enum opp_table_access {
  * @rcu_head:	RCU callback head used for deferred freeing
  * @dev_list:	list of devices that share these OPPs
  * @opp_list:	table of opps
+ * @kref:	for reference count of the table.
  * @lock:	mutex protecting the opp_list.
  * @np:		struct device_node pointer for opp's DT node.
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
@@ -164,6 +165,7 @@ struct opp_table {
 	struct rcu_head rcu_head;
 	struct list_head dev_list;
 	struct list_head opp_list;
+	struct kref kref;
 	struct mutex lock;
 
 	struct device_node *np;
@@ -192,6 +194,7 @@ struct opp_table {
 };
 
 /* Routines internal to opp core */
+void _get_opp_table_kref(struct opp_table *opp_table);
 struct opp_table *_find_opp_table(struct device *dev);
 struct opp_table *_add_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 66a02deeb03f..d867c6b25f9a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -78,6 +78,9 @@ struct dev_pm_set_opp_data {
 
 #if defined(CONFIG_PM_OPP)
 
+struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
+void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
+
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
@@ -126,6 +129,13 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 void dev_pm_opp_remove_table(struct device *dev);
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 #else
+static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void dev_pm_opp_put_opp_table(struct opp_table *opp_table) {}
+
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
 	return 0;
-- 
2.7.1.410.g6faf27b

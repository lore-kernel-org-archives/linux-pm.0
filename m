From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/12] PM / OPP: Add per OPP table mutex
Date: Wed,  7 Dec 2016 16:07:39 +0530
Message-ID: <ff7f66786879636d5a7347af93c044013ff66976.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Add per OPP table lock to protect opp_table->opp_list.

Note that at few places opp_list is used under the rcu_read_lock() and
so a mutex can't be added there for now. This will be fixed by a later
patch.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 31 +++++++++++++++++++++++++++----
 drivers/base/power/opp/opp.h  |  2 ++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 6af371a55062..212b7dbecae2 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -854,6 +854,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev)
 
 	srcu_init_notifier_head(&opp_table->srcu_head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
+	mutex_init(&opp_table->lock);
 
 	/* Secure the device table modification */
 	list_add_rcu(&opp_table->node, &opp_tables);
@@ -909,6 +910,7 @@ static void _free_opp_table(struct opp_table *opp_table)
 	/* dev_list must be empty now */
 	WARN_ON(!list_empty(&opp_table->dev_list));
 
+	mutex_destroy(&opp_table->lock);
 	list_del_rcu(&opp_table->node);
 	call_srcu(&opp_table->srcu_head.srcu, &opp_table->rcu_head,
 		  _kfree_device_rcu);
@@ -969,6 +971,8 @@ static void _kfree_opp_rcu(struct rcu_head *head)
  */
 static void _opp_remove(struct opp_table *opp_table, struct dev_pm_opp *opp)
 {
+	mutex_lock(&opp_table->lock);
+
 	/*
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
@@ -978,6 +982,8 @@ static void _opp_remove(struct opp_table *opp_table, struct dev_pm_opp *opp)
 	list_del_rcu(&opp->node);
 	call_srcu(&opp_table->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
 
+	mutex_unlock(&opp_table->lock);
+
 	_remove_opp_table(opp_table);
 }
 
@@ -1007,6 +1013,8 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 	if (IS_ERR(opp_table))
 		goto unlock;
 
+	mutex_lock(&opp_table->lock);
+
 	list_for_each_entry(opp, &opp_table->opp_list, node) {
 		if (opp->rate == freq) {
 			found = true;
@@ -1014,6 +1022,8 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 		}
 	}
 
+	mutex_unlock(&opp_table->lock);
+
 	if (!found) {
 		dev_warn(dev, "%s: Couldn't find OPP with freq: %lu\n",
 			 __func__, freq);
@@ -1084,7 +1094,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	     struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp;
-	struct list_head *head = &opp_table->opp_list;
+	struct list_head *head;
 	int ret;
 
 	/*
@@ -1095,6 +1105,9 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	 * loop, don't replace it with head otherwise it will become an infinite
 	 * loop.
 	 */
+	mutex_lock(&opp_table->lock);
+	head = &opp_table->opp_list;
+
 	list_for_each_entry_rcu(opp, &opp_table->opp_list, node) {
 		if (new_opp->rate > opp->rate) {
 			head = &opp->node;
@@ -1111,12 +1124,17 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 			 new_opp->supplies[0].u_volt, new_opp->available);
 
 		/* Should we compare voltages for all regulators here ? */
-		return opp->available &&
-		       new_opp->supplies[0].u_volt == opp->supplies[0].u_volt ? -EBUSY : -EEXIST;
+		ret = opp->available &&
+		      new_opp->supplies[0].u_volt == opp->supplies[0].u_volt ? -EBUSY : -EEXIST;
+
+		mutex_unlock(&opp_table->lock);
+		return ret;
 	}
 
-	new_opp->opp_table = opp_table;
 	list_add_rcu(&new_opp->node, head);
+	mutex_unlock(&opp_table->lock);
+
+	new_opp->opp_table = opp_table;
 
 	ret = opp_debug_create_one(new_opp, opp_table);
 	if (ret)
@@ -1780,6 +1798,8 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 		goto unlock;
 	}
 
+	mutex_lock(&opp_table->lock);
+
 	/* Do we have the frequency? */
 	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
 		if (tmp_opp->rate == freq) {
@@ -1787,6 +1807,9 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 			break;
 		}
 	}
+
+	mutex_unlock(&opp_table->lock);
+
 	if (IS_ERR(opp)) {
 		r = PTR_ERR(opp);
 		goto unlock;
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index e32dc80ddc12..81eb6cee7295 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -131,6 +131,7 @@ enum opp_table_access {
  * @rcu_head:	RCU callback head used for deferred freeing
  * @dev_list:	list of devices that share these OPPs
  * @opp_list:	table of opps
+ * @lock:	mutex protecting the opp_list.
  * @np:		struct device_node pointer for opp's DT node.
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @shared_opp: OPP is shared between multiple devices.
@@ -163,6 +164,7 @@ struct opp_table {
 	struct rcu_head rcu_head;
 	struct list_head dev_list;
 	struct list_head opp_list;
+	struct mutex lock;
 
 	struct device_node *np;
 	unsigned long clock_latency_ns_max;
-- 
2.7.1.410.g6faf27b

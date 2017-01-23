From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 01/12] PM / OPP: Add per OPP table mutex
Date: Mon, 23 Jan 2017 10:11:41 +0530
Message-ID: <5d7193cfe9362d8601a2e25fd9c97ff1fdcaff49.1485146406.git.viresh.kumar@linaro.org>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36458 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbdAWEmO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2017 23:42:14 -0500
Received: by mail-pg0-f48.google.com with SMTP id t6so41346975pgt.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2017 20:42:14 -0800 (PST)
In-Reply-To: <cover.1485146406.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1485146406.git.viresh.kumar@linaro.org>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

Add per OPP table lock to protect opp_table->opp_list.

Note that at few places opp_list is used under the rcu_read_lock() and
so a mutex can't be added there for now. This will be fixed by a later
patch.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 31 +++++++++++++++++++++++++++----
 drivers/base/power/opp/opp.h  |  2 ++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 622dd32f8dda..dcebd5efb6a1 100644
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
@@ -1083,7 +1093,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	     struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp;
-	struct list_head *head = &opp_table->opp_list;
+	struct list_head *head;
 	int ret;
 
 	/*
@@ -1094,6 +1104,9 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	 * loop, don't replace it with head otherwise it will become an infinite
 	 * loop.
 	 */
+	mutex_lock(&opp_table->lock);
+	head = &opp_table->opp_list;
+
 	list_for_each_entry_rcu(opp, &opp_table->opp_list, node) {
 		if (new_opp->rate > opp->rate) {
 			head = &opp->node;
@@ -1110,12 +1123,17 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
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
@@ -1779,6 +1797,8 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 		goto unlock;
 	}
 
+	mutex_lock(&opp_table->lock);
+
 	/* Do we have the frequency? */
 	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
 		if (tmp_opp->rate == freq) {
@@ -1786,6 +1806,9 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
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
index 0a5eb4d1e8f7..105243b06373 100644
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


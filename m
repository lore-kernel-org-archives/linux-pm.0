From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/10] PM / OPP: Add light weight _opp_free() routine
Date: Tue,  6 Dec 2016 14:45:57 +0530
Message-ID: <ba6524b0b1561cd597ccb98977ad8e496b38fcec.1481015522.git.viresh.kumar@linaro.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36676 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbcLFJQv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 04:16:51 -0500
Received: by mail-pg0-f49.google.com with SMTP id f188so146917723pgc.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2016 01:16:30 -0800 (PST)
In-Reply-To: <cover.1481015522.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481015522.git.viresh.kumar@linaro.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

The OPPs which are never successfully added using _opp_add() are not
required to be freed with the _opp_remove() routine, as a simple kfree()
is enough for them.

Introduce a new light weight routine _opp_free(), which will do that.

That also helps us removing the 'notify' parameter to _opp_remove(),
which isn't required anymore.

Note that _opp_free() contains a call to _remove_opp_table() as the OPP
table might have been added for this very OPP only. The
_remove_opp_table() routine returns quickly if there are more OPPs in
the table. This will be simplified in later patches though.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 20 +++++++++++---------
 drivers/base/power/opp/of.c   |  2 +-
 drivers/base/power/opp/opp.h  |  2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 4e070d58d537..ee5fbbd6da93 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -942,6 +942,12 @@ static void _remove_opp_table(struct opp_table *opp_table)
 		  _kfree_device_rcu);
 }
 
+void _opp_free(struct dev_pm_opp *opp, struct opp_table *opp_table)
+{
+	kfree(opp);
+	_remove_opp_table(opp_table);
+}
+
 /**
  * _kfree_opp_rcu() - Free OPP RCU handler
  * @head:	RCU head
@@ -957,7 +963,6 @@ static void _kfree_opp_rcu(struct rcu_head *head)
  * _opp_remove()  - Remove an OPP from a table definition
  * @opp_table:	points back to the opp_table struct this opp belongs to
  * @opp:	pointer to the OPP to remove
- * @notify:	OPP_EVENT_REMOVE notification should be sent or not
  *
  * This function removes an opp definition from the opp table.
  *
@@ -965,16 +970,13 @@ static void _kfree_opp_rcu(struct rcu_head *head)
  * It is assumed that the caller holds required mutex for an RCU updater
  * strategy.
  */
-void _opp_remove(struct opp_table *opp_table, struct dev_pm_opp *opp,
-		 bool notify)
+static void _opp_remove(struct opp_table *opp_table, struct dev_pm_opp *opp)
 {
 	/*
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
 	 */
-	if (notify)
-		srcu_notifier_call_chain(&opp_table->srcu_head,
-					 OPP_EVENT_REMOVE, opp);
+	srcu_notifier_call_chain(&opp_table->srcu_head, OPP_EVENT_REMOVE, opp);
 	opp_debug_remove_one(opp);
 	list_del_rcu(&opp->node);
 	call_srcu(&opp_table->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
@@ -1021,7 +1023,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 		goto unlock;
 	}
 
-	_opp_remove(opp_table, opp, true);
+	_opp_remove(opp_table, opp);
 unlock:
 	mutex_unlock(&opp_table_lock);
 }
@@ -1209,7 +1211,7 @@ int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 	return 0;
 
 free_opp:
-	_opp_remove(opp_table, new_opp, false);
+	_opp_free(new_opp, opp_table);
 unlock:
 	mutex_unlock(&opp_table_lock);
 	return ret;
@@ -1921,7 +1923,7 @@ void _dev_pm_opp_remove_table(struct device *dev, bool remove_all)
 		/* Free static OPPs */
 		list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
 			if (remove_all || !opp->dynamic)
-				_opp_remove(opp_table, opp, true);
+				_opp_remove(opp_table, opp);
 		}
 	} else {
 		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index c8fe815774ff..67c9eeded4e1 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -362,7 +362,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	return 0;
 
 free_opp:
-	_opp_remove(opp_table, new_opp, false);
+	_opp_free(new_opp, opp_table);
 unlock:
 	mutex_unlock(&opp_table_lock);
 	return ret;
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 0f23a1059605..334f7570df32 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -194,8 +194,8 @@ struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
 void _dev_pm_opp_remove_table(struct device *dev, bool remove_all);
 struct dev_pm_opp *_opp_allocate(struct device *dev, struct opp_table **opp_table);
+void _opp_free(struct dev_pm_opp *opp, struct opp_table *opp_table);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table);
-void _opp_remove(struct opp_table *opp_table, struct dev_pm_opp *opp, bool notify);
 int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of);
 
-- 
2.7.1.410.g6faf27b


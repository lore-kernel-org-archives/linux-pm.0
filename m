From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 10/12] OPP: Use a single mechanism to free the OPP table
Date: Wed, 19 Sep 2018 15:20:29 -0700
Message-ID: <cdd6ed90cdb6c2fd982909501f0a109274147fb4.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently there are two separate ways to free the OPP table based on how
it is created in the first place.

We call _dev_pm_opp_remove_table() to free the static and/or dynamic
OPP, OPP list devices, etc. This is done for the case where the OPP
table is added while initializing the OPPs, like via the path
dev_pm_opp_of_add_table().

We also call dev_pm_opp_put_opp_table() in some cases which eventually
frees the OPP table structure once the reference count reaches 0. This
is used by the first case as well as other cases like
dev_pm_opp_set_regulators() where the OPPs aren't necessarily
initialized at this point.

This whole thing is a bit unclear and messy and obstruct any further
cleanup/fixup of OPP core.

This patch tries to streamline this by keeping a single path for OPP
table destruction, i.e. dev_pm_opp_put_opp_table().

All the cleanup happens in _opp_table_kref_release() now after the
reference count reaches 0. _dev_pm_opp_remove_table() is removed as it
isn't required anymore.

We don't drop the reference to the OPP table after creating it from
_of_add_opp_table_v{1|2}() anymore and the same is dropped only when we
try to remove them.

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 54 ++++++++++++++++--------------------------------------
 drivers/opp/of.c   | 32 ++++++++++++++++++--------------
 drivers/opp/opp.h  |  2 +-
 3 files changed, 35 insertions(+), 53 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2319ad4a0177..d3e33fd32694 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -867,23 +867,24 @@ struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev,
 static void _opp_table_kref_release(struct kref *kref)
 {
 	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
-	struct opp_device *opp_dev;
+	struct opp_device *opp_dev, *temp;
 
 	/* Release clk */
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
 
-	/*
-	 * No need to take opp_table->lock here as we are guaranteed that no
-	 * references to the OPP table are taken at this point.
-	 */
-	opp_dev = list_first_entry(&opp_table->dev_list, struct opp_device,
-				   node);
+	WARN_ON(!list_empty(&opp_table->opp_list));
 
-	_remove_opp_dev(opp_dev, opp_table);
+	list_for_each_entry_safe(opp_dev, temp, &opp_table->dev_list, node) {
+		/*
+		 * The OPP table is getting removed, drop the performance state
+		 * constraints.
+		 */
+		if (opp_table->genpd_performance_state)
+			dev_pm_genpd_set_performance_state((struct device *)(opp_dev->dev), 0);
 
-	/* dev_list must be empty now */
-	WARN_ON(!list_empty(&opp_table->dev_list));
+		_remove_opp_dev(opp_dev, opp_table);
+	}
 
 	mutex_destroy(&opp_table->lock);
 	list_del(&opp_table->node);
@@ -1758,33 +1759,6 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
 }
 EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
 
-/*
- * Free OPPs either created using static entries present in DT.
- */
-void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev)
-{
-	/* Protect dev_list */
-	mutex_lock(&opp_table->lock);
-
-	/* Find if opp_table manages a single device */
-	if (list_is_singular(&opp_table->dev_list)) {
-		/* Free static OPPs */
-		_put_opp_list_kref(opp_table);
-
-		/*
-		 * The OPP table is getting removed, drop the performance state
-		 * constraints.
-		 */
-		if (opp_table->genpd_performance_state)
-			dev_pm_genpd_set_performance_state(dev, 0);
-	} else {
-		_put_opp_list_kref(opp_table);
-		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
-	}
-
-	mutex_unlock(&opp_table->lock);
-}
-
 void _dev_pm_opp_find_and_remove_table(struct device *dev)
 {
 	struct opp_table *opp_table;
@@ -1802,8 +1776,12 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
 		return;
 	}
 
-	_dev_pm_opp_remove_table(opp_table, dev);
+	_put_opp_list_kref(opp_table);
+
+	/* Drop reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
 
+	/* Drop reference taken while the OPP table was added */
 	dev_pm_opp_put_opp_table(opp_table);
 }
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 861cc75de329..ae0436eaa911 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -407,14 +407,17 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 	opp_table = _managed_opp(opp_np);
 	if (opp_table) {
 		/* OPPs are already managed */
-		if (!_add_opp_dev(dev, opp_table))
+		if (!_add_opp_dev(dev, opp_table)) {
 			ret = -ENOMEM;
-		else if (!opp_table->parsed_static_opps)
-			goto initialize_static_opps;
-		else
+			goto put_opp_table;
+		}
+
+		if (opp_table->parsed_static_opps) {
 			kref_get(&opp_table->list_kref);
+			return 0;
+		}
 
-		goto put_opp_table;
+		goto initialize_static_opps;
 	}
 
 	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
@@ -432,17 +435,15 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
-			_dev_pm_opp_remove_table(opp_table, dev);
 			of_node_put(np);
-			goto put_opp_table;
+			goto put_list_kref;
 		}
 	}
 
 	/* There should be one of more OPP defined */
 	if (WARN_ON(!count)) {
 		ret = -ENOENT;
-		_put_opp_list_kref(opp_table);
-		goto put_opp_table;
+		goto put_list_kref;
 	}
 
 	list_for_each_entry(opp, &opp_table->opp_list, node)
@@ -453,8 +454,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
 		ret = -ENOENT;
-		_dev_pm_opp_remove_table(opp_table, dev);
-		goto put_opp_table;
+		goto put_list_kref;
 	}
 
 	if (pstate_count)
@@ -462,6 +462,10 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 
 	opp_table->parsed_static_opps = true;
 
+	return 0;
+
+put_list_kref:
+	_put_opp_list_kref(opp_table);
 put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
 
@@ -507,13 +511,13 @@ static int _of_add_opp_table_v1(struct device *dev)
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
 				__func__, freq, ret);
-			_dev_pm_opp_remove_table(opp_table, dev);
-			break;
+			_put_opp_list_kref(opp_table);
+			dev_pm_opp_put_opp_table(opp_table);
+			return ret;
 		}
 		nr -= 2;
 	}
 
-	dev_pm_opp_put_opp_table(opp_table);
 	return ret;
 }
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 98dd7d39e1ad..f9fbb7553fc4 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -190,11 +190,11 @@ struct opp_table {
 
 /* Routines internal to opp core */
 void dev_pm_opp_get(struct dev_pm_opp *opp);
+void _opp_remove_all_static(struct opp_table *opp_table);
 void _get_opp_table_kref(struct opp_table *opp_table);
 int _get_opp_count(struct opp_table *opp_table);
 struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
-void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev);
 void _dev_pm_opp_find_and_remove_table(struct device *dev);
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
-- 
2.14.1

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/11] OPP: Prevent creating multiple OPP tables for devices sharing OPP nodes
Date: Wed, 12 Sep 2018 13:58:49 +0530
Message-ID: <79af9cf4c4e8e4d6dd8288d013900939ab4d5855.1536736872.git.viresh.kumar@linaro.org>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: niklas.cassel@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When two or more devices are sharing their clock and voltage rails, they
share the same OPP table. But there are some corner cases where the OPP
core incorrectly creates separate OPP tables for them.

For example, CPU 0 and 1 share clock/voltage rails. The platform
specific code calls dev_pm_opp_set_regulators() for CPU0 and the OPP
core creates an OPP table for it (the individual OPPs aren't initialized
as of now). The same is repeated for CPU1 then. Because
_opp_get_opp_table() doesn't compare DT node pointers currently, it
fails to find the link between CPU0 and CPU1 and so creates a new OPP
table.

Fix this by calling _managed_opp() from _opp_get_opp_table().
_managed_opp() gain an additional argument (index) to get the right node
pointer. This resulted in simplifying code in _of_add_opp_table_v2() as
well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 25 ++++++++++++++++++++++---
 drivers/opp/of.c   | 35 +++++++++++++----------------------
 drivers/opp/opp.h  |  2 ++
 3 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d3e33fd32694..aaef20cf4df2 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -759,8 +759,8 @@ static void _remove_opp_dev(struct opp_device *opp_dev,
 	kfree(opp_dev);
 }
 
-struct opp_device *_add_opp_dev(const struct device *dev,
-				struct opp_table *opp_table)
+struct opp_device *_add_opp_dev_unlocked(const struct device *dev,
+					 struct opp_table *opp_table)
 {
 	struct opp_device *opp_dev;
 	int ret;
@@ -772,7 +772,6 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	/* Initialize opp-dev */
 	opp_dev->dev = dev;
 
-	mutex_lock(&opp_table->lock);
 	list_add(&opp_dev->node, &opp_table->dev_list);
 
 	/* Create debugfs entries for the opp_table */
@@ -780,6 +779,17 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	if (ret)
 		dev_err(dev, "%s: Failed to register opp debugfs (%d)\n",
 			__func__, ret);
+
+	return opp_dev;
+}
+
+struct opp_device *_add_opp_dev(const struct device *dev,
+				struct opp_table *opp_table)
+{
+	struct opp_device *opp_dev;
+
+	mutex_lock(&opp_table->lock);
+	opp_dev = _add_opp_dev_unlocked(dev, opp_table);
 	mutex_unlock(&opp_table->lock);
 
 	return opp_dev;
@@ -844,6 +854,15 @@ static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
 	if (!IS_ERR(opp_table))
 		goto unlock;
 
+	opp_table = _managed_opp(dev, index);
+	if (opp_table) {
+		if (!_add_opp_dev_unlocked(dev, opp_table)) {
+			dev_pm_opp_put_opp_table(opp_table);
+			opp_table = NULL;
+		}
+		goto unlock;
+	}
+
 	opp_table = _allocate_opp_table(dev, index);
 
 unlock:
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index a5cba0234220..db3e4d2b969e 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -41,11 +41,14 @@ struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
 
-static struct opp_table *_managed_opp(const struct device_node *np)
+struct opp_table *_managed_opp(struct device *dev, int index)
 {
 	struct opp_table *opp_table, *managed_table = NULL;
+	struct device_node *np;
 
-	mutex_lock(&opp_table_lock);
+	np = _opp_of_get_opp_desc_node(dev->of_node, index);
+	if (!np)
+		return NULL;
 
 	list_for_each_entry(opp_table, &opp_tables, node) {
 		if (opp_table->np == np) {
@@ -65,7 +68,7 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 		}
 	}
 
-	mutex_unlock(&opp_table_lock);
+	of_node_put(np);
 
 	return managed_table;
 }
@@ -401,30 +404,19 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 {
 	struct device_node *np;
 	struct opp_table *opp_table;
-	int ret = 0, count = 0, pstate_count = 0;
+	int ret, count = 0, pstate_count = 0;
 	struct dev_pm_opp *opp;
 
-	opp_table = _managed_opp(opp_np);
-	if (opp_table) {
-		/* OPPs are already managed */
-		if (!_add_opp_dev(dev, opp_table)) {
-			ret = -ENOMEM;
-			goto put_opp_table;
-		}
-
-		if (opp_table->parsed_static_opps) {
-			kref_get(&opp_table->list_kref);
-			return 0;
-		}
-
-		goto initialize_static_opps;
-	}
-
 	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
 	if (!opp_table)
 		return -ENOMEM;
 
-initialize_static_opps:
+	/* OPP table is already initialized for the device */
+	if (opp_table->parsed_static_opps) {
+		kref_get(&opp_table->list_kref);
+		return 0;
+	}
+
 	kref_init(&opp_table->list_kref);
 
 	/* We have opp-table node now, iterate over it and add OPPs */
@@ -466,7 +458,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 
 put_list_kref:
 	_put_opp_list_kref(opp_table);
-put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index b260fb7b307a..a7e9adab4cd3 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -206,8 +206,10 @@ void _put_opp_list_kref(struct opp_table *opp_table);
 
 #ifdef CONFIG_OF
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
+struct opp_table *_managed_opp(struct device *dev, int index);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
+static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL };
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.18.0.rc1.242.g61856ae69a2c

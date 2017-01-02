From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 10/10] PM / OPP: Split out part of _add_opp_table() and _remove_opp_table()
Date: Mon,  2 Jan 2017 14:41:04 +0530
Message-ID: <7d4e1b547d5a5e0519edf42cbb2e9ce6e609a901.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Split out parts of _add_opp_table() and _remove_opp_table() into
separate routines. This improves readability as well.

Should result in no functional changes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 76 +++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index f35effad60d1..622dd32f8dda 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -819,26 +819,12 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	return opp_dev;
 }
 
-/**
- * _add_opp_table() - Find OPP table or allocate a new one
- * @dev:	device for which we do this operation
- *
- * It tries to find an existing table first, if it couldn't find one, it
- * allocates a new OPP table and returns that.
- *
- * Return: valid opp_table pointer if success, else NULL.
- */
-struct opp_table *_add_opp_table(struct device *dev)
+static struct opp_table *_allocate_opp_table(struct device *dev)
 {
 	struct opp_table *opp_table;
 	struct opp_device *opp_dev;
 	int ret;
 
-	/* Check for existing table for 'dev' first */
-	opp_table = _find_opp_table(dev);
-	if (!IS_ERR(opp_table))
-		return opp_table;
-
 	/*
 	 * Allocate a new OPP table. In the infrequent case where a new
 	 * device is needed to be added, we pay this penalty.
@@ -875,6 +861,27 @@ struct opp_table *_add_opp_table(struct device *dev)
 }
 
 /**
+ * _add_opp_table() - Find OPP table or allocate a new one
+ * @dev:	device for which we do this operation
+ *
+ * It tries to find an existing table first, if it couldn't find one, it
+ * allocates a new OPP table and returns that.
+ *
+ * Return: valid opp_table pointer if success, else NULL.
+ */
+struct opp_table *_add_opp_table(struct device *dev)
+{
+	struct opp_table *opp_table;
+
+	/* Check for existing table for 'dev' first */
+	opp_table = _find_opp_table(dev);
+	if (!IS_ERR(opp_table))
+		return opp_table;
+
+	return _allocate_opp_table(dev);
+}
+
+/**
  * _kfree_device_rcu() - Free opp_table RCU handler
  * @head:	RCU head
  */
@@ -886,6 +893,27 @@ static void _kfree_device_rcu(struct rcu_head *head)
 	kfree_rcu(opp_table, rcu_head);
 }
 
+static void _free_opp_table(struct opp_table *opp_table)
+{
+	struct opp_device *opp_dev;
+
+	/* Release clk */
+	if (!IS_ERR(opp_table->clk))
+		clk_put(opp_table->clk);
+
+	opp_dev = list_first_entry(&opp_table->dev_list, struct opp_device,
+				   node);
+
+	_remove_opp_dev(opp_dev, opp_table);
+
+	/* dev_list must be empty now */
+	WARN_ON(!list_empty(&opp_table->dev_list));
+
+	list_del_rcu(&opp_table->node);
+	call_srcu(&opp_table->srcu_head.srcu, &opp_table->rcu_head,
+		  _kfree_device_rcu);
+}
+
 /**
  * _remove_opp_table() - Removes a OPP table
  * @opp_table: OPP table to be removed.
@@ -894,8 +922,6 @@ static void _kfree_device_rcu(struct rcu_head *head)
  */
 static void _remove_opp_table(struct opp_table *opp_table)
 {
-	struct opp_device *opp_dev;
-
 	if (!list_empty(&opp_table->opp_list))
 		return;
 
@@ -911,21 +937,7 @@ static void _remove_opp_table(struct opp_table *opp_table)
 	if (opp_table->set_opp)
 		return;
 
-	/* Release clk */
-	if (!IS_ERR(opp_table->clk))
-		clk_put(opp_table->clk);
-
-	opp_dev = list_first_entry(&opp_table->dev_list, struct opp_device,
-				   node);
-
-	_remove_opp_dev(opp_dev, opp_table);
-
-	/* dev_list must be empty now */
-	WARN_ON(!list_empty(&opp_table->dev_list));
-
-	list_del_rcu(&opp_table->node);
-	call_srcu(&opp_table->srcu_head.srcu, &opp_table->rcu_head,
-		  _kfree_device_rcu);
+	_free_opp_table(opp_table);
 }
 
 void _opp_free(struct dev_pm_opp *opp)
-- 
2.7.1.410.g6faf27b

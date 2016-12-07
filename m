From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 10/10] PM / OPP: Split out part of _add_opp_table() and _remove_opp_table()
Date: Wed,  7 Dec 2016 10:12:06 +0530
Message-ID: <d64524471cb4fdc581131d32209d17d794a0d5a1.1481085478.git.viresh.kumar@linaro.org>
References: <cover.1481085478.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33808 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbcLGEmp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 23:42:45 -0500
Received: by mail-pg0-f50.google.com with SMTP id x23so157298701pgx.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2016 20:42:45 -0800 (PST)
In-Reply-To: <cover.1481085478.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481085478.git.viresh.kumar@linaro.org>
References: <cover.1481085478.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

Split out parts of _add_opp_table() and _remove_opp_table() into
separate routines. This improves readability as well.

Should result in no functional changes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 76 +++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 074a42185819..7db672f632d9 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -832,26 +832,12 @@ struct opp_device *_add_opp_dev(const struct device *dev,
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
@@ -888,6 +874,27 @@ struct opp_table *_add_opp_table(struct device *dev)
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
@@ -899,6 +906,27 @@ static void _kfree_device_rcu(struct rcu_head *head)
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
@@ -907,8 +935,6 @@ static void _kfree_device_rcu(struct rcu_head *head)
  */
 static void _remove_opp_table(struct opp_table *opp_table)
 {
-	struct opp_device *opp_dev;
-
 	if (!list_empty(&opp_table->opp_list))
 		return;
 
@@ -924,21 +950,7 @@ static void _remove_opp_table(struct opp_table *opp_table)
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


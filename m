From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 04/12] PM / OPP: Take reference of the OPP table while adding/removing OPPs
Date: Mon, 23 Jan 2017 10:11:44 +0530
Message-ID: <b87f9b85799e3737b723ada054c108ac192095c2.1485146406.git.viresh.kumar@linaro.org>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1485146406.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1485146406.git.viresh.kumar@linaro.org>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Take reference of the OPP table while adding and removing OPPs, that
helps us remove special checks in _remove_opp_table().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 1af349ab630e..1a38b5d8dc54 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -971,9 +971,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_opp_table);
  */
 static void _remove_opp_table(struct opp_table *opp_table)
 {
-	if (!list_empty(&opp_table->opp_list))
-		return;
-
 	dev_pm_opp_put_opp_table_unlocked(opp_table);
 }
 
@@ -1018,8 +1015,7 @@ static void _opp_remove(struct opp_table *opp_table, struct dev_pm_opp *opp)
 	call_srcu(&opp_table->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
 
 	mutex_unlock(&opp_table->lock);
-
-	_remove_opp_table(opp_table);
+	dev_pm_opp_put_opp_table(opp_table);
 }
 
 /**
@@ -1170,6 +1166,9 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 
 	new_opp->opp_table = opp_table;
 
+	/* Get a reference to the OPP table */
+	_get_opp_table_kref(opp_table);
+
 	ret = opp_debug_create_one(new_opp, opp_table);
 	if (ret)
 		dev_err(dev, "%s: Failed to register opp to debugfs (%d)\n",
-- 
2.7.1.410.g6faf27b

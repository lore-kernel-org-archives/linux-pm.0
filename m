From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 10/12] PM / OPP: Simplify _opp_set_availability()
Date: Mon, 23 Jan 2017 10:11:50 +0530
Message-ID: <59507c403d7319f7ec1ac463e77f4dbfb36371d7.1485146406.git.viresh.kumar@linaro.org>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1485146406.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1485146406.git.viresh.kumar@linaro.org>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

As we don't use RCU locking anymore, there is no need to replace an
earlier OPP node with a new one. Just update the existing one.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index c40d9868bd97..f54ac2484723 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1510,20 +1510,15 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 				 bool availability_req)
 {
 	struct opp_table *opp_table;
-	struct dev_pm_opp *new_opp, *tmp_opp, *opp = ERR_PTR(-ENODEV);
+	struct dev_pm_opp *tmp_opp, *opp = ERR_PTR(-ENODEV);
 	int r = 0;
 
-	/* keep the node allocated */
-	new_opp = kmalloc(sizeof(*new_opp), GFP_KERNEL);
-	if (!new_opp)
-		return -ENOMEM;
-
 	/* Find the opp_table */
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		r = PTR_ERR(opp_table);
 		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
-		goto free_opp;
+		return r;
 	}
 
 	mutex_lock(&opp_table->lock);
@@ -1544,32 +1539,20 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 	/* Is update really needed? */
 	if (opp->available == availability_req)
 		goto unlock;
-	/* copy the old data over */
-	*new_opp = *opp;
-
-	/* plug in new node */
-	new_opp->available = availability_req;
 
-	list_replace(&opp->node, &new_opp->node);
-	kfree(opp);
+	opp->available = availability_req;
 
 	/* Notify the change of the OPP availability */
 	if (availability_req)
 		blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ENABLE,
-					     new_opp);
+					     opp);
 	else
 		blocking_notifier_call_chain(&opp_table->head,
-					     OPP_EVENT_DISABLE, new_opp);
-
-	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
-	return 0;
+					     OPP_EVENT_DISABLE, opp);
 
 unlock:
 	mutex_unlock(&opp_table->lock);
 	dev_pm_opp_put_opp_table(opp_table);
-free_opp:
-	kfree(new_opp);
 	return r;
 }
 
-- 
2.7.1.410.g6faf27b

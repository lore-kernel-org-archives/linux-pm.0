From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/12] PM / OPP: Simplify _opp_set_availability()
Date: Wed,  7 Dec 2016 16:07:48 +0530
Message-ID: <8ca1aa7a452c7ffe8d54ebac93c3139ad692f185.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:32998 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752581AbcLGKmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 05:42:35 -0500
Received: by mail-pg0-f47.google.com with SMTP id 3so160850660pgd.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2016 02:41:46 -0800 (PST)
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

As we don't use RCU locking anymore, there is no need to replace an
earlier OPP node with a new one. Just update the existing one.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index b5e9600058c2..6a1374fafe75 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1511,20 +1511,15 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
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
@@ -1545,32 +1540,20 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
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


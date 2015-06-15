From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/10] OPP: Create _remove_device_opp() for freeing dev_opp
Date: Mon, 15 Jun 2015 17:27:28 +0530
Message-ID: <fba1ec728e2ecf9303e13372a2557d886aa7e49c.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36278 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbbFOL6E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 07:58:04 -0400
Received: by pabqy3 with SMTP id qy3so64237469pab.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:58:03 -0700 (PDT)
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

This will be used from multiple places later. Lets create a separate
routine for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 8c3fd57975fb..7895fdd64192 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -449,6 +449,22 @@ static void _kfree_device_rcu(struct rcu_head *head)
 }
 
 /**
+ * _remove_device_opp() - Removes a device OPP table
+ * @dev_opp: device OPP table to be removed.
+ *
+ * Removes/frees device OPP table it it doesn't contain any OPPs.
+ */
+static void _remove_device_opp(struct device_opp *dev_opp)
+{
+	if (!list_empty(&dev_opp->opp_list))
+		return;
+
+	list_del_rcu(&dev_opp->node);
+	call_srcu(&dev_opp->srcu_head.srcu, &dev_opp->rcu_head,
+		  _kfree_device_rcu);
+}
+
+/**
  * _kfree_opp_rcu() - Free OPP RCU handler
  * @head:	RCU head
  */
@@ -481,11 +497,7 @@ static void _opp_remove(struct device_opp *dev_opp,
 	list_del_rcu(&opp->node);
 	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
 
-	if (list_empty(&dev_opp->opp_list)) {
-		list_del_rcu(&dev_opp->node);
-		call_srcu(&dev_opp->srcu_head.srcu, &dev_opp->rcu_head,
-			  _kfree_device_rcu);
-	}
+	_remove_device_opp(dev_opp);
 }
 
 /**
-- 
2.4.0


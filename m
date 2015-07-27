From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 03/11] OPP: Create _remove_device_opp() for freeing dev_opp
Date: Mon, 27 Jul 2015 10:32:33 +0530
Message-ID: <ab91ba59b946addcc9e2c072c5613f9394eed7cf.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

This will be used from multiple places later. Lets create a separate
routine for that.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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

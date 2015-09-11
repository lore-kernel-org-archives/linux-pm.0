From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 13/16] PM / OPP: Manage device clk as well
Date: Fri, 11 Sep 2015 17:32:09 +0530
Message-ID: <c9e1111fd9520d528bba850a68ed837cce0e839d.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

OPP core has got almost everything now to manage device's OPP
transitions, the only thing left is device's clk. Get that as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 9 +++++++++
 drivers/base/power/opp/opp.h  | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 9633f2fc3481..a04dcacb8a07 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -636,6 +636,11 @@ static struct device_opp *_add_device_opp(struct device *dev, int supply_count,
 	if (supply_count == 1)
 		*dev_opp->supply_names = dev_name(dev);
 
+	/* Find clk for the device */
+	dev_opp->clk = clk_get(dev, NULL);
+	if (IS_ERR(dev_opp->clk))
+		dev_dbg(dev, "%s: Couldn't find clock\n", __func__);
+
 	srcu_init_notifier_head(&dev_opp->srcu_head);
 	INIT_LIST_HEAD(&dev_opp->opp_list);
 
@@ -669,6 +674,10 @@ static void _remove_device_opp(struct device_opp *dev_opp)
 	if (!list_empty(&dev_opp->opp_list))
 		return;
 
+	/* Release clk */
+	if (!IS_ERR(dev_opp->clk))
+		clk_put(dev_opp->clk);
+
 	/* Release regulators */
 	for (count = dev_opp->supply_count - 1; count >= 0; count--)
 		regulator_put(dev_opp->regulators[count]);
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 55205cbe59dc..e36ee6296f1a 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -14,6 +14,7 @@
 #ifndef __DRIVER_OPP_H__
 #define __DRIVER_OPP_H__
 
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -135,6 +136,7 @@ struct device_list_opp {
  * @dev_list:	list of devices that share these OPPs
  * @opp_list:	list of opps
  * @np:		struct device_node pointer for opp's DT node.
+ * @clk:	struct clk pointer
  * @supply_count: Number of power-supplies
  * @regulators:	Array of regulators
  * @supply_names: Array of strings containing names of the power-supplies
@@ -163,6 +165,7 @@ struct device_opp {
 	struct device_node *np;
 	unsigned long clock_latency_ns_max;
 
+	struct clk *clk;
 	unsigned int supply_count;
 	struct regulator **regulators;
 	const char **supply_names;
-- 
2.4.0

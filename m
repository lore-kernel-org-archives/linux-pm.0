From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/16] PM / OPP: get/put regulators from OPP core
Date: Fri, 11 Sep 2015 17:32:04 +0530
Message-ID: <beb2a55362c5feee2970557b68b5f8d255368502.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33526 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbbIKMDe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 08:03:34 -0400
Received: by pacex6 with SMTP id ex6so73883239pac.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2015 05:03:34 -0700 (PDT)
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

When the 'supply_names' property is present, the OPP core can request
regulators for them. All the regulators from the 'supply_names' property
must be present, in order to move forward.

If an error occurs, undo all allocations and return the appropriate
error. This also helps in returning error on -EPROBE_DEFER case, where
the driver must try again at a later point of time.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 30 +++++++++++++++++++++++++++---
 drivers/base/power/opp/opp.h  |  3 +++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d6e945ec6467..42ea5a332ddc 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -509,8 +509,10 @@ static struct device_opp *_add_device_opp(struct device *dev, int supply_count)
 	if (!IS_ERR(dev_opp))
 		return dev_opp;
 
-	/* Allocate size for supply-names with dev_opp */
-	size = sizeof(*dev_opp) + supply_count * sizeof(*dev_opp->supply_names);
+	/* Allocate memory for supply-names & regulators with dev_opp */
+	size = sizeof(*dev_opp);
+	size += supply_count * sizeof(*dev_opp->supply_names);
+	size += supply_count * sizeof(*dev_opp->regulators);
 
 	/*
 	 * Allocate a new device OPP table. In the infrequent case where a new
@@ -521,7 +523,8 @@ static struct device_opp *_add_device_opp(struct device *dev, int supply_count)
 		return NULL;
 
 	dev_opp->supply_count = supply_count;
-	dev_opp->supply_names = (const char **)(dev_opp + 1);
+	dev_opp->regulators = (struct regulator **)(dev_opp + 1);
+	dev_opp->supply_names = (const char **)(dev_opp->regulators + supply_count);
 
 	INIT_LIST_HEAD(&dev_opp->dev_list);
 
@@ -566,10 +569,15 @@ static void _kfree_device_rcu(struct rcu_head *head)
 static void _remove_device_opp(struct device_opp *dev_opp)
 {
 	struct device_list_opp *list_dev;
+	int count;
 
 	if (!list_empty(&dev_opp->opp_list))
 		return;
 
+	/* Release regulators */
+	for (count = dev_opp->supply_count - 1; count >= 0; count--)
+		regulator_put(dev_opp->regulators[count]);
+
 	list_dev = list_first_entry(&dev_opp->dev_list, struct device_list_opp,
 				    node);
 
@@ -1293,6 +1301,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	const char **name;
 	int ret = 0, count, supply_count, string_count;
 	bool triplets;
+	struct regulator *reg;
 
 	dev_opp = _managed_opp(opp_np);
 	if (dev_opp) {
@@ -1334,6 +1343,21 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 		}
 	}
 
+	/* Get supply regulators */
+	name = dev_opp->supply_names;
+	for (count = 0; count < supply_count; count++, name++) {
+		/* Parse regulators */
+		reg = regulator_get_optional(dev, *name);
+		if (IS_ERR(reg)) {
+			ret = PTR_ERR(reg);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "%s: no regulator (%s) found: %d\n",
+					__func__, *name, ret);
+			goto free_table;
+		}
+		dev_opp->regulators[count] = reg;
+	}
+
 	/* We have opp-list node now, iterate over it and add OPPs */
 	count = 0;
 	for_each_available_child_of_node(opp_np, np) {
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 16575268f6ce..830c4b654a51 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -19,6 +19,7 @@
 #include <linux/list.h>
 #include <linux/limits.h>
 #include <linux/pm_opp.h>
+#include <linux/regulator/consumer.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 
@@ -135,6 +136,7 @@ struct device_list_opp {
  * @opp_list:	list of opps
  * @np:		struct device_node pointer for opp's DT node.
  * @supply_count: Number of power-supplies
+ * @regulators:	Array of regulators
  * @supply_names: Array of strings containing names of the power-supplies
  * @shared_opp: OPP is shared between multiple devices.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
@@ -160,6 +162,7 @@ struct device_opp {
 	unsigned long clock_latency_ns_max;
 
 	unsigned int supply_count;
+	struct regulator **regulators;
 	const char **supply_names;
 
 	bool shared_opp;
-- 
2.4.0


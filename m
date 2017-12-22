From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6/7] PM / OPP: Get performance state using genpd helper
Date: Fri, 22 Dec 2017 12:56:30 +0530
Message-ID: <e9bef639c041e506f1a9fd0c7c84896eee847a16.1513926033.git.viresh.kumar@linaro.org>
References: <cover.1513926033.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1513926033.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1513926033.git.viresh.kumar@linaro.org>
References: <cover.1513926033.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The genpd core provides an API now to retrieve the performance state
from DT, use that instead of the ->get_pstate() callback.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  3 ---
 drivers/opp/of.c   | 20 +++++++++++++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index bfcad8983fd1..6194219fb95f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1034,9 +1034,6 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 		return ret;
 	}
 
-	if (opp_table->get_pstate)
-		new_opp->pstate = opp_table->get_pstate(dev, new_opp->rate);
-
 	list_add(&new_opp->node, head);
 	mutex_unlock(&opp_table->lock);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 2d1bb348ae73..21265af55117 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/device.h>
 #include <linux/of_device.h>
+#include <linux/pm_domain.h>
 #include <linux/slab.h>
 #include <linux/export.h>
 
@@ -321,6 +322,8 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
 
+	new_opp->pstate = of_dev_pm_genpd_get_performance_state(dev, np);
+
 	ret = opp_parse_supplies(new_opp, dev, opp_table);
 	if (ret)
 		goto free_opp;
@@ -371,7 +374,8 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 {
 	struct device_node *np;
 	struct opp_table *opp_table;
-	int ret = 0, count = 0;
+	int ret = 0, count = 0, pstate_count = 0;
+	struct dev_pm_opp *opp;
 
 	opp_table = _managed_opp(opp_np);
 	if (opp_table) {
@@ -405,6 +409,20 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 		goto put_opp_table;
 	}
 
+	list_for_each_entry(opp, &opp_table->opp_list, node)
+		pstate_count += !!opp->pstate;
+
+	/* Either all or none of the nodes shall have performance state set */
+	if (pstate_count && pstate_count != count) {
+		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
+			count, pstate_count);
+		ret = -ENOENT;
+		goto put_opp_table;
+	}
+
+	if (pstate_count)
+		opp_table->genpd_performance_state = true;
+
 	opp_table->np = opp_np;
 	if (of_property_read_bool(opp_np, "opp-shared"))
 		opp_table->shared_opp = OPP_TABLE_ACCESS_SHARED;
-- 
2.15.0.194.g9af6a3dea062

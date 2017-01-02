From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 01/10] PM / OPP: Fix memory leak while adding duplicate OPPs
Date: Mon,  2 Jan 2017 14:40:55 +0530
Message-ID: <83cb1a5f9d4b8e957a6e875e2391d6349b158dae.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

There are two types of duplicate OPPs that get different behavior from
the core:
A) An earlier OPP is marked 'available' and has same freq/voltages as
   the new one.
B) An earlier OPP with same frequency, but is marked 'unavailable' OR
   doesn't have same voltages as the new one.

The OPP core returns 0 for the first one, but -EEXIST for the second.

While the OPP core returns 0 for the first case, its callers don't free
the newly allocated OPP structure which isn't used anymore. Fix that by
returning -EBUSY instead of 0, but make the callers return 0 eventually.

As this isn't a critical fix, its not getting marked for stable kernel.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 18 ++++++++++++++++--
 drivers/base/power/opp/of.c   |  6 +++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 35ff06283738..a8a5e01b7756 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1067,6 +1067,16 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
 	return true;
 }
 
+/*
+ * Returns:
+ * 0: On success. And appropriate error message for duplicate OPPs.
+ * -EBUSY: For OPP with same freq/volt and is available. The callers of
+ *  _opp_add() must return 0 if they receive -EBUSY from it. This is to make
+ *  sure we don't print error messages unnecessarily if different parts of
+ *  kernel try to initialize the OPP table.
+ * -EEXIST: For OPP with same freq but different volt or is unavailable. This
+ *  should be considered an error by the callers of _opp_add().
+ */
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	     struct opp_table *opp_table)
 {
@@ -1099,7 +1109,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 
 		/* Should we compare voltages for all regulators here ? */
 		return opp->available &&
-		       new_opp->supplies[0].u_volt == opp->supplies[0].u_volt ? 0 : -EEXIST;
+		       new_opp->supplies[0].u_volt == opp->supplies[0].u_volt ? -EBUSY : -EEXIST;
 	}
 
 	new_opp->opp_table = opp_table;
@@ -1173,8 +1183,12 @@ int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 	new_opp->dynamic = dynamic;
 
 	ret = _opp_add(dev, new_opp, opp_table);
-	if (ret)
+	if (ret) {
+		/* Don't return error for duplicate OPPs */
+		if (ret == -EBUSY)
+			ret = 0;
 		goto free_opp;
+	}
 
 	mutex_unlock(&opp_table_lock);
 
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 3f7d2591b173..356c75edd656 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -327,8 +327,12 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 		goto free_opp;
 
 	ret = _opp_add(dev, new_opp, opp_table);
-	if (ret)
+	if (ret) {
+		/* Don't return error for duplicate OPPs */
+		if (ret == -EBUSY)
+			ret = 0;
 		goto free_opp;
+	}
 
 	/* OPP to select on device suspend */
 	if (of_property_read_bool(np, "opp-suspend")) {
-- 
2.7.1.410.g6faf27b

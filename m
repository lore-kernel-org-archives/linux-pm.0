From: ahaslam@baylibre.com
Subject: [RFC v3 2/7] PM / Domains: select deepest state
Date: Mon, 20 Apr 2015 17:02:03 +0200
Message-ID: <1429542128-21021-3-git-send-email-ahaslam@baylibre.com>
References: <1429542128-21021-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37981 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbbDTPCT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2015 11:02:19 -0400
Received: by wiun10 with SMTP id n10so95166221wiu.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2015 08:02:17 -0700 (PDT)
In-Reply-To: <1429542128-21021-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

now that the structures of genpd can support
multiple state definitions, add the logic in
the governor to select the deepest possible
state when powering down.

For this, create the new function power_down_ok_for_state
which will test if a particular state will not violate
the devices and sub-domains constraints.

default_power_down_ok is modified to try each
state starting from the deepest until a valid
state is found or there are no more states to test.

the resulting target state will be valid until
there are latency or constraint changes,
thus, we can avoid looping every power_down,
and use the cached results instead.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/base/power/domain_governor.c | 71 ++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 8630fce..ab7b925 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -97,33 +97,13 @@ static bool default_stop_ok(struct device *dev)
  *
  * This routine must be executed under the PM domain's lock.
  */
-static bool default_power_down_ok(struct dev_pm_domain *pd)
+static bool power_down_ok_for_state(struct dev_pm_domain *pd, int state)
 {
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct gpd_link *link;
 	struct pm_domain_data *pdd;
 	s64 min_off_time_ns;
 	s64 off_on_time_ns;
-	int state = 0;
-
-	if (genpd->max_off_time_changed) {
-		struct gpd_link *link;
-
-		/*
-		 * We have to invalidate the cached results for the masters, so
-		 * use the observation that default_power_down_ok() is not
-		 * going to be called for any master until this instance
-		 * returns.
-		 */
-		list_for_each_entry(link, &genpd->slave_links, slave_node)
-			link->master->max_off_time_changed = true;
-
-		genpd->max_off_time_changed = false;
-		genpd->cached_power_down_ok = false;
-		genpd->max_off_time_ns = -1;
-	} else {
-		return genpd->cached_power_down_ok;
-	}
 
 	off_on_time_ns = genpd->states[state].power_off_latency_ns +
 			genpd->states[state].power_on_latency_ns;
@@ -202,8 +182,6 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 			min_off_time_ns = constraint_ns;
 	}
 
-	genpd->cached_power_down_ok = true;
-
 	/*
 	 * If the computed minimum device off time is negative, there are no
 	 * latency constraints, so the domain can spend arbitrary time in the
@@ -222,6 +200,53 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	return true;
 }
 
+/*
+ * Loop into all the possible low power states
+ * and find the deepest state that does not violate any
+ * constraints. If device constraints did not change,
+ * we can return the cached value and use the target_state
+ * calculated previously.
+ */
+static bool default_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	int last_state_idx = genpd->state_count - 1;
+	struct gpd_link *link;
+	bool retval = false;
+	int i;
+
+	/*
+	 * if there was no change on max_off_time, we can return the
+	 * cached value and we dont need to find a new target_state
+	 */
+	if (!genpd->max_off_time_changed)
+		return genpd->cached_power_down_ok;
+
+	/*
+	 * We have to invalidate the cached results for the masters, so
+	 * use the observation that default_power_down_ok() is not
+	 * going to be called for any master until this instance
+	 * returns.
+	 */
+	list_for_each_entry(link, &genpd->slave_links, slave_node)
+		link->master->max_off_time_changed = true;
+
+	genpd->max_off_time_ns = -1;
+	genpd->max_off_time_changed = false;
+
+	/* find a state to power down to, starting from the deepest */
+	for (i = 0; i < genpd->state_count; i++) {
+		if (power_down_ok_for_state(pd, last_state_idx - i)) {
+			genpd->target_state = last_state_idx - i;
+			retval = true;
+			break;
+		}
+	}
+
+	genpd->cached_power_down_ok = retval;
+	return retval;
+}
+
 static bool always_on_power_down_ok(struct dev_pm_domain *domain)
 {
 	return false;
-- 
1.9.1


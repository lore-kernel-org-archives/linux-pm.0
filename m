From: ahaslam@baylibre.com
Subject: [RFC v5 2/8] PM / Domains: select deepest state
Date: Fri, 24 Apr 2015 19:35:18 +0200
Message-ID: <1429896924-21540-3-git-send-email-ahaslam@baylibre.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36500 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966362AbbDXRfo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 13:35:44 -0400
Received: by wizk4 with SMTP id k4so30404912wiz.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2015 10:35:43 -0700 (PDT)
In-Reply-To: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net
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

the resulting state will be valid until
there are latency or constraint changes,
thus, we can avoid looping every power_down,
and use the cached results instead.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/base/power/domain_governor.c | 77 ++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 9d74885..061c711 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -97,7 +97,7 @@ static bool default_stop_ok(struct device *dev)
  *
  * This routine must be executed under the PM domain's lock.
  */
-static bool default_power_down_ok(struct dev_pm_domain *pd)
+static bool power_down_ok_for_state(struct dev_pm_domain *pd, int state)
 {
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct gpd_link *link;
@@ -105,31 +105,12 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	s64 min_off_time_ns;
 	s64 off_on_time_ns;
 
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
-
 	if (genpd->state_count == 0)
 		off_on_time_ns = genpd->power_off_latency_ns +
 			genpd->power_on_latency_ns;
 	else
-		off_on_time_ns = genpd->states[0].power_off_latency_ns +
-			genpd->states[0].power_on_latency_ns;
+		off_on_time_ns = genpd->states[state].power_off_latency_ns +
+			genpd->states[state].power_on_latency_ns;
 	/*
 	 * It doesn't make sense to remove power from the domain if saving
 	 * the state of all devices in it and the power off/power on operations
@@ -205,8 +186,6 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 			min_off_time_ns = constraint_ns;
 	}
 
-	genpd->cached_power_down_ok = true;
-
 	/*
 	 * If the computed minimum device off time is negative, there are no
 	 * latency constraints, so the domain can spend arbitrary time in the
@@ -225,10 +204,58 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 			min_off_time_ns - genpd->power_on_latency_ns;
 	else
 		genpd->max_off_time_ns = min_off_time_ns -
-			genpd->states[0].power_on_latency_ns;
+			genpd->states[state].power_on_latency_ns;
 	return true;
 }
 
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
+	if (genpd->state_count == 0) {
+		/*
+		 * there are no states. power_down_ok_for_state will use
+		 * the stateless values, and ignore the state argument.
+		 */
+		retval = power_down_ok_for_state(pd, 0);
+	} else {
+		for (i = 0; i < genpd->state_count; i++) {
+			if (power_down_ok_for_state(pd, last_state_idx - i)) {
+				genpd->state_idx = last_state_idx - i;
+				retval = true;
+				break;
+			}
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


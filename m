From: ahaslam@baylibre.com
Subject: [PATCH v7 3/5] PM / Domains: make governor select deepest state
Date: Thu, 30 Apr 2015 12:55:33 +0200
Message-ID: <1430391335-7588-4-git-send-email-ahaslam@baylibre.com>
References: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34266 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbbD3K5E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 06:57:04 -0400
Received: by wicmx19 with SMTP id mx19so10165436wic.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2015 03:57:03 -0700 (PDT)
In-Reply-To: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

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

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 drivers/base/power/domain_governor.c | 76 +++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 5e63a84..8139c01 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -97,7 +97,8 @@ static bool default_stop_ok(struct device *dev)
  *
  * This routine must be executed under the PM domain's lock.
  */
-static bool default_power_down_ok(struct dev_pm_domain *pd)
+static bool power_down_ok_for_state(struct dev_pm_domain *pd,
+				     unsigned int state)
 {
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct gpd_link *link;
@@ -105,31 +106,8 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
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
-	/*
-	 * Use the only available state, until multiple state support is added
-	 * to the governor.
-	 */
-	off_on_time_ns = genpd->states[0].power_off_latency_ns +
-				genpd->states[0].power_on_latency_ns;
+	off_on_time_ns = genpd->states[state].power_off_latency_ns +
+		genpd->states[state].power_on_latency_ns;
 	/*
 	 * It doesn't make sense to remove power from the domain if saving
 	 * the state of all devices in it and the power off/power on operations
@@ -205,8 +183,6 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 			min_off_time_ns = constraint_ns;
 	}
 
-	genpd->cached_power_down_ok = true;
-
 	/*
 	 * If the computed minimum device off time is negative, there are no
 	 * latency constraints, so the domain can spend arbitrary time in the
@@ -219,14 +195,52 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	 * The difference between the computed minimum subdomain or device off
 	 * time and the time needed to turn the domain on is the maximum
 	 * theoretical time this domain can spend in the "off" state.
-	 * Use the only available state, until multiple state support is added
-	 * to the governor.
 	 */
 	genpd->max_off_time_ns = min_off_time_ns -
-		genpd->states[0].power_on_latency_ns;
+			genpd->states[state].power_on_latency_ns;
 	return true;
 }
 
+static bool default_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	unsigned int last_state_idx = genpd->state_count - 1;
+	struct gpd_link *link;
+	bool retval = false;
+	unsigned int i;
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
+			genpd->state_idx = last_state_idx - i;
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


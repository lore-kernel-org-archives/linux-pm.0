From: ahaslam@baylibre.com
Subject: [PATCH 2/2] [RFC] PM / Domains: select deepest state
Date: Wed,  8 Apr 2015 17:42:05 +0200
Message-ID: <1428507725-12205-3-git-send-email-ahaslam@baylibre.com>
References: <1428507725-12205-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38022 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbbDHPm1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2015 11:42:27 -0400
Received: by wiun10 with SMTP id n10so63558177wiu.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2015 08:42:26 -0700 (PDT)
In-Reply-To: <1428507725-12205-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: bcousson@baylibre.com, Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

now that the structures of genpd can support
multiple state definitions, add the logic in
the governor to select the deepest possible
state when powering down.

For this, create the new function power_down_ok_for_state
which will test if a particular state will not violate
the devices and subdomains constraints.

default_power_down_ok is modified to try each
state starting from the deepest until a valid
state is found or there are no more states to test.

the resulting target state will be valid until
until there are latency or constraint changes,
thus, we can avoid looping every power_down,
and use the cached results instead.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/base/power/domain_governor.c | 65 +++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index deaaa76..a36c387 100644
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
 	struct generic_pm_domain_data *gpd_data;
@@ -105,26 +105,6 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
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
@@ -204,8 +184,6 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 			min_off_time_ns = constraint_ns;
 	}
 
-	genpd->cached_power_down_ok = true;
-
 	/*
 	 * If the computed minimum device off time is negative, there are no
 	 * latency constraints, so the domain can spend arbitrary time in the
@@ -224,6 +202,47 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
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
+	genpd->target_state = 0;
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


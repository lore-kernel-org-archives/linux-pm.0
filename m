From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 04/27] PM / Domains: make governor select deepest state
Date: Tue, 17 Nov 2015 15:37:28 -0700
Message-ID: <1447799871-56374-5-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35754 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932482AbbKQWiY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 17:38:24 -0500
Received: by pacej9 with SMTP id ej9so22066252pac.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 14:38:24 -0800 (PST)
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Now that the structures of genpd can support multiple state definitions,
add the logic in the governor to select the deepest possible state when
powering down.

For this, create the new function power_down_ok_for_state which will test
if a particular state will not violate the devices and sub-domains
constraints.

default_power_down_ok is modified to try each state starting from the
deepest until a valid state is found or there are no more states to test.

the resulting state will be valid until there are latency or constraint
changes, thus, we can avoid looping every power_down, and use the cached
results instead.

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 drivers/base/power/domain_governor.c | 75 +++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index b4984f5..ad69dc0 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -98,7 +98,8 @@ static bool default_stop_ok(struct device *dev)
  *
  * This routine must be executed under the PM domain's lock.
  */
-static bool default_power_down_ok(struct dev_pm_domain *pd)
+static bool power_down_ok_for_state(struct dev_pm_domain *pd,
+				     unsigned int state)
 {
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct gpd_link *link;
@@ -106,31 +107,9 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	s64 min_off_time_ns;
 	s64 off_on_time_ns;
 
-	if (genpd->max_off_time_changed) {
-		struct gpd_link *link;
+	off_on_time_ns = genpd->states[state].power_off_latency_ns +
+		genpd->states[state].power_on_latency_ns;
 
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
 
 	min_off_time_ns = -1;
 	/*
@@ -193,8 +172,6 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 			min_off_time_ns = constraint_ns;
 	}
 
-	genpd->cached_power_down_ok = true;
-
 	/*
 	 * If the computed minimum device off time is negative, there are no
 	 * latency constraints, so the domain can spend arbitrary time in the
@@ -207,14 +184,52 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
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
2.1.4


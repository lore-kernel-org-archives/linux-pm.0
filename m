From: ahaslam@baylibre.com
Subject: [RFC v5 8/8] PM / Domains: remove old power on/off callbacks.
Date: Fri, 24 Apr 2015 19:35:24 +0200
Message-ID: <1429896924-21540-9-git-send-email-ahaslam@baylibre.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36793 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966672AbbDXRf4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 13:35:56 -0400
Received: by wgen6 with SMTP id n6so57898457wge.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2015 10:35:54 -0700 (PDT)
In-Reply-To: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

Now that all known users have been converted to use the state
version of the callbacks, we can remove the default callbacks
without breaking compilation.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/base/power/domain.c          | 55 +++++++++++-------------------------
 drivers/base/power/domain_governor.c | 35 ++++++-----------------
 include/linux/pm_domain.h            |  2 --
 3 files changed, 26 insertions(+), 66 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b519926..2927763 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -147,11 +147,7 @@ static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
 	if (!genpd->cpuidle_data)
 		return;
 
-	if (genpd->state_count == 0)
-		usecs64 = genpd->power_on_latency_ns;
-	else
-		usecs64 = genpd->states[state_idx].power_on_latency_ns;
-
+	usecs64 = genpd->states[state_idx].power_on_latency_ns;
 	do_div(usecs64, NSEC_PER_USEC);
 	usecs64 += genpd->cpuidle_data->saved_exit_latency;
 	genpd->cpuidle_data->idle_state->exit_latency = usecs64;
@@ -173,15 +169,9 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-	if (genpd->state_count == 0) {
-		if (elapsed_ns <= genpd->power_on_latency_ns)
-			return ret;
-		genpd->power_on_latency_ns = elapsed_ns;
-	} else {
-		if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
-			return ret;
-		genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
-	}
+	if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
+		return ret;
+	genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
 
 	genpd->max_off_time_changed = true;
 	genpd_recalc_cpu_exit_latency(genpd);
@@ -207,15 +197,11 @@ static int genpd_power_off(struct generic_pm_domain *genpd)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-	if (genpd->state_count == 0) {
-		if (elapsed_ns <= genpd->power_off_latency_ns)
-			return ret;
-		genpd->power_off_latency_ns = elapsed_ns;
-	} else {
-		if (elapsed_ns <= genpd->states[state_idx].power_off_latency_ns)
-			return ret;
-		genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
-	}
+	if (elapsed_ns <= genpd->states[state_idx].power_off_latency_ns)
+		return ret;
+
+	genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
+
 	genpd->max_off_time_changed = true;
 	pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
 		genpd->name, "off", elapsed_ns);
@@ -1931,12 +1917,10 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	if (IS_ERR_OR_NULL(genpd))
 		return;
 
-	if (genpd->state_count > 0) {
-		/* Copy the state data to allocated memory */
-		genpd->states = genpd_alloc_states_data(genpd);
-		if (!genpd->states)
-			return;
-	}
+	/* Point the state data to allocated memory */
+	genpd->states = genpd_alloc_states_data(genpd);
+	if (!genpd->states)
+		return;
 
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
@@ -2338,15 +2322,10 @@ static int pm_genpd_summary_one(struct seq_file *s,
 
 	if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
 		goto exit;
-
-	if (genpd->state_count == 0)
-		seq_printf(s, "%-30s  %-15s  ",
-			genpd->name, status_lookup[genpd->status]);
-	else
-		seq_printf(s, "%-30s  %-15s  ", genpd->name,
-			(genpd->status == GPD_STATE_POWER_OFF) ?
-				genpd->states[state_idx].name :
-				status_lookup[genpd->status]);
+	seq_printf(s, "%-30s  %-15s  ", genpd->name,
+		(genpd->status == GPD_STATE_POWER_OFF) ?
+			genpd->states[state_idx].name :
+			status_lookup[genpd->status]);
 
 	/*
 	 * Modifications on the list require holding locks on both
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 061c711..b77f7c9 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -104,13 +104,8 @@ static bool power_down_ok_for_state(struct dev_pm_domain *pd, int state)
 	struct pm_domain_data *pdd;
 	s64 min_off_time_ns;
 	s64 off_on_time_ns;
-
-	if (genpd->state_count == 0)
-		off_on_time_ns = genpd->power_off_latency_ns +
-			genpd->power_on_latency_ns;
-	else
-		off_on_time_ns = genpd->states[state].power_off_latency_ns +
-			genpd->states[state].power_on_latency_ns;
+	off_on_time_ns = genpd->states[state].power_off_latency_ns +
+		genpd->states[state].power_on_latency_ns;
 	/*
 	 * It doesn't make sense to remove power from the domain if saving
 	 * the state of all devices in it and the power off/power on operations
@@ -199,12 +194,8 @@ static bool power_down_ok_for_state(struct dev_pm_domain *pd, int state)
 	 * time and the time needed to turn the domain on is the maximum
 	 * theoretical time this domain can spend in the "off" state.
 	 */
-	if (genpd->state_count == 0)
-		genpd->max_off_time_ns =
-			min_off_time_ns - genpd->power_on_latency_ns;
-	else
-		genpd->max_off_time_ns = min_off_time_ns -
-			genpd->states[state].power_on_latency_ns;
+	genpd->max_off_time_ns = min_off_time_ns -
+		genpd->states[state].power_on_latency_ns;
 	return true;
 }
 
@@ -236,19 +227,11 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	genpd->max_off_time_changed = false;
 
 	/* find a state to power down to, starting from the deepest */
-	if (genpd->state_count == 0) {
-		/*
-		 * there are no states. power_down_ok_for_state will use
-		 * the stateless values, and ignore the state argument.
-		 */
-		retval = power_down_ok_for_state(pd, 0);
-	} else {
-		for (i = 0; i < genpd->state_count; i++) {
-			if (power_down_ok_for_state(pd, last_state_idx - i)) {
-				genpd->state_idx = last_state_idx - i;
-				retval = true;
-				break;
-			}
+	for (i = 0; i < genpd->state_count; i++) {
+		if (power_down_ok_for_state(pd, last_state_idx - i)) {
+			genpd->state_idx = last_state_idx - i;
+			retval = true;
+			break;
 		}
 	}
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 25082f6..38339f4 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -73,9 +73,7 @@ struct generic_pm_domain {
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	bool suspend_power_off;	/* Power status before system suspend */
 	int (*power_off)(struct generic_pm_domain *domain);
-	s64 power_off_latency_ns;
 	int (*power_on)(struct generic_pm_domain *domain);
-	s64 power_on_latency_ns;
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
-- 
1.9.1


From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Fix validation of latency constraints in genpd governor
Date: Tue, 13 Oct 2015 16:10:28 +0200
Message-ID: <1444745428-4396-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33550 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbbJMOKq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 10:10:46 -0400
Received: by lbbk10 with SMTP id k10so21797048lbb.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 07:10:44 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Commit ba2bbfbf6307 ("PM / Domains: Remove intermediate states from the
power off sequence") changed the power off sequence in genpd. That also
required some updates regarding the validation of latency constraints in
the genpd governor. Unfortunate that wasn't covered, so let's fix this.

>From a runtime PM and latency point of view, we need to consider the worst
case scenario while validating latency constraints. That's typically when
a call to pm_runtime_get_sync() needs to wait for a ongoing runtime
suspend operation to be carried out, as it then also needs to wait for the
device to be runtime resumed again.

The above mentioned commit made the genpd governor's ->stop_ok() callback
responsible of validating genpd's device's runtime suspend/resume latency.
In other words, the constraint needs to be validated towards the relevant
latencies present in genpd's ->runtime_suspend|resume() callbacks.

Earlier, that included latencies from the ->stop|start() callbacks, but as
->save|restore_state() are now also being invoked from genpd's
->runtime_suspend|resume() and to comply with the worst case scenario,
let's take also those latencies into account.

Fixes: ba2bbfbf6307 ("PM / Domains: Remove intermediate states from the
power off sequence")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain_governor.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 2a4154a..85e17ba 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -77,13 +77,16 @@ static bool default_stop_ok(struct device *dev)
 				      dev_update_qos_constraint);
 
 	if (constraint_ns > 0) {
-		constraint_ns -= td->start_latency_ns;
+		constraint_ns -= td->save_state_latency_ns +
+				td->stop_latency_ns +
+				td->start_latency_ns +
+				td->restore_state_latency_ns;
 		if (constraint_ns == 0)
 			return false;
 	}
 	td->effective_constraint_ns = constraint_ns;
-	td->cached_stop_ok = constraint_ns > td->stop_latency_ns ||
-				constraint_ns == 0;
+	td->cached_stop_ok = constraint_ns >= 0;
+
 	/*
 	 * The children have been suspended already, so we don't need to take
 	 * their stop latencies into account here.
@@ -126,18 +129,6 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 
 	off_on_time_ns = genpd->power_off_latency_ns +
 				genpd->power_on_latency_ns;
-	/*
-	 * It doesn't make sense to remove power from the domain if saving
-	 * the state of all devices in it and the power off/power on operations
-	 * take too much time.
-	 *
-	 * All devices in this domain have been stopped already at this point.
-	 */
-	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
-		if (pdd->dev->driver)
-			off_on_time_ns +=
-				to_gpd_data(pdd)->td.save_state_latency_ns;
-	}
 
 	min_off_time_ns = -1;
 	/*
@@ -193,7 +184,6 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 		 * constraint_ns cannot be negative here, because the device has
 		 * been suspended.
 		 */
-		constraint_ns -= td->restore_state_latency_ns;
 		if (constraint_ns <= off_on_time_ns)
 			return false;
 
-- 
1.9.1


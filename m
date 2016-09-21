From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/4] PM / Domains: Don't measure latency of ->power_on|off() during system PM
Date: Wed, 21 Sep 2016 15:38:52 +0200
Message-ID: <1474465133-14865-4-git-send-email-ulf.hansson@linaro.org>
References: <1474465133-14865-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36246 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934109AbcIUNjG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2016 09:39:06 -0400
Received: by mail-lf0-f54.google.com with SMTP id g62so41155895lfe.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2016 06:39:05 -0700 (PDT)
In-Reply-To: <1474465133-14865-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>

Measure latency does by itself contribute to an increased latency, thus we
should avoid it when it isn't needed.

Currently genpd measures latencies in the system PM phase for the
->power_on|off() callbacks, except in the syscore case when it's not
allowed to use ktime_get() as timekeeping may be suspended.

Since there should be plenty of occasions during runtime PM to perform
these measurements, let's rely on that and drop them from system PM. This
will also make it consistent for how measurements are done of the runtime
PM callbacks (as those may be invoked during system PM).

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 661ac3a..d52709e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -619,7 +619,6 @@ static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,
 /**
  * pm_genpd_sync_poweroff - Synchronously power off a PM domain and its masters.
  * @genpd: PM domain to power off, if possible.
- * @timed: True if latency measurements are allowed.
  *
  * Check if the given PM domain can be powered off (during system suspend or
  * hibernation) and do that if so.  Also, in that case propagate to its masters.
@@ -629,8 +628,7 @@ static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,
  * executed sequentially, so it is guaranteed that it will never run twice in
  * parallel).
  */
-static void pm_genpd_sync_poweroff(struct generic_pm_domain *genpd,
-				   bool timed)
+static void pm_genpd_sync_poweroff(struct generic_pm_domain *genpd)
 {
 	struct gpd_link *link;
 
@@ -643,28 +641,26 @@ static void pm_genpd_sync_poweroff(struct generic_pm_domain *genpd,
 
 	/* Choose the deepest state when suspending */
 	genpd->state_idx = genpd->state_count - 1;
-	genpd_power_off(genpd, timed);
+	genpd_power_off(genpd, false);
 
 	genpd->status = GPD_STATE_POWER_OFF;
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
 		genpd_sd_counter_dec(link->master);
-		pm_genpd_sync_poweroff(link->master, timed);
+		pm_genpd_sync_poweroff(link->master);
 	}
 }
 
 /**
  * pm_genpd_sync_poweron - Synchronously power on a PM domain and its masters.
  * @genpd: PM domain to power on.
- * @timed: True if latency measurements are allowed.
  *
  * This function is only called in "noirq" and "syscore" stages of system power
  * transitions, so it need not acquire locks (all of the "noirq" callbacks are
  * executed sequentially, so it is guaranteed that it will never run twice in
  * parallel).
  */
-static void pm_genpd_sync_poweron(struct generic_pm_domain *genpd,
-				  bool timed)
+static void pm_genpd_sync_poweron(struct generic_pm_domain *genpd)
 {
 	struct gpd_link *link;
 
@@ -672,11 +668,11 @@ static void pm_genpd_sync_poweron(struct generic_pm_domain *genpd,
 		return;
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
-		pm_genpd_sync_poweron(link->master, timed);
+		pm_genpd_sync_poweron(link->master);
 		genpd_sd_counter_inc(link->master);
 	}
 
-	genpd_power_on(genpd, timed);
+	genpd_power_on(genpd, false);
 
 	genpd->status = GPD_STATE_ACTIVE;
 }
@@ -788,7 +784,7 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 	 * the same PM domain, so it is not necessary to use locking here.
 	 */
 	genpd->suspended_count++;
-	pm_genpd_sync_poweroff(genpd, true);
+	pm_genpd_sync_poweroff(genpd);
 
 	return 0;
 }
@@ -818,7 +814,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
 	 * guaranteed that this function will never run twice in parallel for
 	 * the same PM domain, so it is not necessary to use locking here.
 	 */
-	pm_genpd_sync_poweron(genpd, true);
+	pm_genpd_sync_poweron(genpd);
 	genpd->suspended_count--;
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start)
@@ -911,7 +907,7 @@ static int pm_genpd_restore_noirq(struct device *dev)
 		 */
 		genpd->status = GPD_STATE_POWER_OFF;
 
-	pm_genpd_sync_poweron(genpd, true);
+	pm_genpd_sync_poweron(genpd);
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start)
 		ret = pm_runtime_force_resume(dev);
@@ -966,9 +962,9 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
 
 	if (suspend) {
 		genpd->suspended_count++;
-		pm_genpd_sync_poweroff(genpd, false);
+		pm_genpd_sync_poweroff(genpd);
 	} else {
-		pm_genpd_sync_poweron(genpd, false);
+		pm_genpd_sync_poweron(genpd);
 		genpd->suspended_count--;
 	}
 }
-- 
1.9.1


From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RESEND PATCH 2/2] PM / Domains: Fix asynchronous execution of *noirq() callbacks
Date: Thu, 12 Jan 2017 18:17:43 +0100
Message-ID: <1484241463-28435-3-git-send-email-ulf.hansson@linaro.org>
References: <1484241463-28435-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33894 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdALRS3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2017 12:18:29 -0500
Received: by mail-lf0-f45.google.com with SMTP id v186so18161697lfa.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2017 09:18:02 -0800 (PST)
In-Reply-To: <1484241463-28435-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Brian Norris <briannorris@chromium.org>

As the PM core may invoke the *noirq() callbacks asynchronously, the
current lock-less approach in genpd doesn't work. The consequence is that
we may find concurrent operations racing to power on/off the PM domain.

As of now, no immediate errors has been reported, but it's probably only a
matter time. Therefor let's fix the problem now before this becomes a real
issue, by deploying the locking scheme to the relevant functions.

Reported-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 62 ++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index fd2e3e1..6b23d82 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -729,16 +729,17 @@ static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,
 /**
  * genpd_sync_power_off - Synchronously power off a PM domain and its masters.
  * @genpd: PM domain to power off, if possible.
+ * @depth: nesting count for lockdep.
  *
  * Check if the given PM domain can be powered off (during system suspend or
  * hibernation) and do that if so.  Also, in that case propagate to its masters.
  *
  * This function is only called in "noirq" and "syscore" stages of system power
- * transitions, so it need not acquire locks (all of the "noirq" callbacks are
- * executed sequentially, so it is guaranteed that it will never run twice in
- * parallel).
+ * transitions, but since the "noirq" callbacks may be executed asynchronously,
+ * the lock must be held.
  */
-static void genpd_sync_power_off(struct generic_pm_domain *genpd)
+static void genpd_sync_power_off(struct generic_pm_domain *genpd,
+				 unsigned int depth)
 {
 	struct gpd_link *link;
 
@@ -757,20 +758,24 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd)
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
 		genpd_sd_counter_dec(link->master);
-		genpd_sync_power_off(link->master);
+
+		genpd_lock_nested(link->master, depth + 1);
+		genpd_sync_power_off(link->master, depth + 1);
+		genpd_unlock(link->master);
 	}
 }
 
 /**
  * genpd_sync_power_on - Synchronously power on a PM domain and its masters.
  * @genpd: PM domain to power on.
+ * @depth: nesting count for lockdep.
  *
  * This function is only called in "noirq" and "syscore" stages of system power
- * transitions, so it need not acquire locks (all of the "noirq" callbacks are
- * executed sequentially, so it is guaranteed that it will never run twice in
- * parallel).
+ * transitions, but since the "noirq" callbacks may be executed asynchronously,
+ * the lock must be held.
  */
-static void genpd_sync_power_on(struct generic_pm_domain *genpd)
+static void genpd_sync_power_on(struct generic_pm_domain *genpd,
+				unsigned int depth)
 {
 	struct gpd_link *link;
 
@@ -778,8 +783,11 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd)
 		return;
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
-		genpd_sync_power_on(link->master);
 		genpd_sd_counter_inc(link->master);
+
+		genpd_lock_nested(link->master, depth + 1);
+		genpd_sync_power_on(link->master, depth + 1);
+		genpd_unlock(link->master);
 	}
 
 	_genpd_power_on(genpd, false);
@@ -888,13 +896,10 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 			return ret;
 	}
 
-	/*
-	 * Since all of the "noirq" callbacks are executed sequentially, it is
-	 * guaranteed that this function will never run twice in parallel for
-	 * the same PM domain, so it is not necessary to use locking here.
-	 */
+	genpd_lock(genpd);
 	genpd->suspended_count++;
-	genpd_sync_power_off(genpd);
+	genpd_sync_power_off(genpd, 0);
+	genpd_unlock(genpd);
 
 	return 0;
 }
@@ -919,13 +924,10 @@ static int pm_genpd_resume_noirq(struct device *dev)
 	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
 		return 0;
 
-	/*
-	 * Since all of the "noirq" callbacks are executed sequentially, it is
-	 * guaranteed that this function will never run twice in parallel for
-	 * the same PM domain, so it is not necessary to use locking here.
-	 */
-	genpd_sync_power_on(genpd);
+	genpd_lock(genpd);
+	genpd_sync_power_on(genpd, 0);
 	genpd->suspended_count--;
+	genpd_unlock(genpd);
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start)
 		ret = pm_runtime_force_resume(dev);
@@ -1002,13 +1004,10 @@ static int pm_genpd_restore_noirq(struct device *dev)
 		return -EINVAL;
 
 	/*
-	 * Since all of the "noirq" callbacks are executed sequentially, it is
-	 * guaranteed that this function will never run twice in parallel for
-	 * the same PM domain, so it is not necessary to use locking here.
-	 *
 	 * At this point suspended_count == 0 means we are being run for the
 	 * first time for the given domain in the present cycle.
 	 */
+	genpd_lock(genpd);
 	if (genpd->suspended_count++ == 0)
 		/*
 		 * The boot kernel might put the domain into arbitrary state,
@@ -1017,7 +1016,8 @@ static int pm_genpd_restore_noirq(struct device *dev)
 		 */
 		genpd->status = GPD_STATE_POWER_OFF;
 
-	genpd_sync_power_on(genpd);
+	genpd_sync_power_on(genpd, 0);
+	genpd_unlock(genpd);
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start)
 		ret = pm_runtime_force_resume(dev);
@@ -1070,13 +1070,17 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
 	if (!pm_genpd_present(genpd))
 		return;
 
+	genpd_lock(genpd);
+
 	if (suspend) {
 		genpd->suspended_count++;
-		genpd_sync_power_off(genpd);
+		genpd_sync_power_off(genpd, 0);
 	} else {
-		genpd_sync_power_on(genpd);
+		genpd_sync_power_on(genpd, 0);
 		genpd->suspended_count--;
 	}
+
+	genpd_unlock(genpd);
 }
 
 void pm_genpd_syscore_poweroff(struct device *dev)
-- 
1.9.1


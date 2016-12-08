From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] PM / Domains: Rename functions in genpd for power on/off
Date: Thu,  8 Dec 2016 14:45:20 +0100
Message-ID: <1481204721-11431-2-git-send-email-ulf.hansson@linaro.org>
References: <1481204721-11431-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37498 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbcLHNy3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2016 08:54:29 -0500
Received: by mail-wm0-f53.google.com with SMTP id t79so26495131wmt.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Dec 2016 05:54:29 -0800 (PST)
In-Reply-To: <1481204721-11431-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Brian Norris <briannorris@chromium.org>

Currently the mix of genpd_poweron(), genpd_power_on(),
genpd_sync_poweron() and the ->power_on() callback, makes a bit difficult
to follow the path of execution. The similar applies to the functions
dealing with power off.

In a way to improve this understanding, let's do the following renaming:

genpd_power_on() ->  _genpd_power_on()
genpd_poweron() -> genpd_power_on()
genpd_sync_poweron() -> genpd_sync_power_on()

genpd_power_off() -> _genpd_power_off()
genpd_poweroff() -> genpd_power_off()
genpd_sync_poweroff() -> genpd_sync_power_off()
genpd_poweroff_unused() -> genpd_power_off_unused()

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 72 ++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5711708..abca652 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -201,7 +201,7 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
 	smp_mb__after_atomic();
 }
 
-static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
+static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
 	ktime_t time_start;
@@ -231,7 +231,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	return ret;
 }
 
-static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
+static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
 	ktime_t time_start;
@@ -262,10 +262,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 }
 
 /**
- * genpd_queue_power_off_work - Queue up the execution of genpd_poweroff().
+ * genpd_queue_power_off_work - Queue up the execution of genpd_power_off().
  * @genpd: PM domain to power off.
  *
- * Queue up the execution of genpd_poweroff() unless it's already been done
+ * Queue up the execution of genpd_power_off() unless it's already been done
  * before.
  */
 static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
@@ -274,14 +274,14 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 }
 
 /**
- * genpd_poweron - Restore power to a given PM domain and its masters.
+ * genpd_power_on - Restore power to a given PM domain and its masters.
  * @genpd: PM domain to power up.
  * @depth: nesting count for lockdep.
  *
  * Restore power to @genpd and all of its masters so that it is possible to
  * resume a device belonging to it.
  */
-static int genpd_poweron(struct generic_pm_domain *genpd, unsigned int depth)
+static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 {
 	struct gpd_link *link;
 	int ret = 0;
@@ -300,7 +300,7 @@ static int genpd_poweron(struct generic_pm_domain *genpd, unsigned int depth)
 		genpd_sd_counter_inc(master);
 
 		genpd_lock_nested(master, depth + 1);
-		ret = genpd_poweron(master, depth + 1);
+		ret = genpd_power_on(master, depth + 1);
 		genpd_unlock(master);
 
 		if (ret) {
@@ -309,7 +309,7 @@ static int genpd_poweron(struct generic_pm_domain *genpd, unsigned int depth)
 		}
 	}
 
-	ret = genpd_power_on(genpd, true);
+	ret = _genpd_power_on(genpd, true);
 	if (ret)
 		goto err;
 
@@ -368,14 +368,14 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 }
 
 /**
- * genpd_poweroff - Remove power from a given PM domain.
+ * genpd_power_off - Remove power from a given PM domain.
  * @genpd: PM domain to power down.
  * @is_async: PM domain is powered down from a scheduled work
  *
  * If all of the @genpd's devices have been suspended and all of its subdomains
  * have been powered down, remove power from @genpd.
  */
-static int genpd_poweroff(struct generic_pm_domain *genpd, bool is_async)
+static int genpd_power_off(struct generic_pm_domain *genpd, bool is_async)
 {
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
@@ -427,13 +427,13 @@ static int genpd_poweroff(struct generic_pm_domain *genpd, bool is_async)
 
 		/*
 		 * If sd_count > 0 at this point, one of the subdomains hasn't
-		 * managed to call genpd_poweron() for the master yet after
-		 * incrementing it.  In that case genpd_poweron() will wait
+		 * managed to call genpd_power_on() for the master yet after
+		 * incrementing it.  In that case genpd_power_on() will wait
 		 * for us to drop the lock, so we can call .power_off() and let
-		 * the genpd_poweron() restore power for us (this shouldn't
+		 * the genpd_power_on() restore power for us (this shouldn't
 		 * happen very often).
 		 */
-		ret = genpd_power_off(genpd, true);
+		ret = _genpd_power_off(genpd, true);
 		if (ret)
 			return ret;
 	}
@@ -459,7 +459,7 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 	genpd = container_of(work, struct generic_pm_domain, power_off_work);
 
 	genpd_lock(genpd);
-	genpd_poweroff(genpd, true);
+	genpd_power_off(genpd, true);
 	genpd_unlock(genpd);
 }
 
@@ -577,7 +577,7 @@ static int genpd_runtime_suspend(struct device *dev)
 		return 0;
 
 	genpd_lock(genpd);
-	genpd_poweroff(genpd, false);
+	genpd_power_off(genpd, false);
 	genpd_unlock(genpd);
 
 	return 0;
@@ -617,7 +617,7 @@ static int genpd_runtime_resume(struct device *dev)
 	}
 
 	genpd_lock(genpd);
-	ret = genpd_poweron(genpd, 0);
+	ret = genpd_power_on(genpd, 0);
 	genpd_unlock(genpd);
 
 	if (ret)
@@ -656,7 +656,7 @@ static int genpd_runtime_resume(struct device *dev)
 	if (!pm_runtime_is_irq_safe(dev) ||
 		(pm_runtime_is_irq_safe(dev) && genpd_is_irq_safe(genpd))) {
 		genpd_lock(genpd);
-		genpd_poweroff(genpd, 0);
+		genpd_power_off(genpd, 0);
 		genpd_unlock(genpd);
 	}
 
@@ -672,9 +672,9 @@ static int __init pd_ignore_unused_setup(char *__unused)
 __setup("pd_ignore_unused", pd_ignore_unused_setup);
 
 /**
- * genpd_poweroff_unused - Power off all PM domains with no devices in use.
+ * genpd_power_off_unused - Power off all PM domains with no devices in use.
  */
-static int __init genpd_poweroff_unused(void)
+static int __init genpd_power_off_unused(void)
 {
 	struct generic_pm_domain *genpd;
 
@@ -692,7 +692,7 @@ static int __init genpd_poweroff_unused(void)
 
 	return 0;
 }
-late_initcall(genpd_poweroff_unused);
+late_initcall(genpd_power_off_unused);
 
 #if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_GENERIC_DOMAINS_OF)
 
@@ -725,7 +725,7 @@ static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,
 }
 
 /**
- * genpd_sync_poweroff - Synchronously power off a PM domain and its masters.
+ * genpd_sync_power_off - Synchronously power off a PM domain and its masters.
  * @genpd: PM domain to power off, if possible.
  *
  * Check if the given PM domain can be powered off (during system suspend or
@@ -736,7 +736,7 @@ static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,
  * executed sequentially, so it is guaranteed that it will never run twice in
  * parallel).
  */
-static void genpd_sync_poweroff(struct generic_pm_domain *genpd)
+static void genpd_sync_power_off(struct generic_pm_domain *genpd)
 {
 	struct gpd_link *link;
 
@@ -749,18 +749,18 @@ static void genpd_sync_poweroff(struct generic_pm_domain *genpd)
 
 	/* Choose the deepest state when suspending */
 	genpd->state_idx = genpd->state_count - 1;
-	genpd_power_off(genpd, false);
+	_genpd_power_off(genpd, false);
 
 	genpd->status = GPD_STATE_POWER_OFF;
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
 		genpd_sd_counter_dec(link->master);
-		genpd_sync_poweroff(link->master);
+		genpd_sync_power_off(link->master);
 	}
 }
 
 /**
- * genpd_sync_poweron - Synchronously power on a PM domain and its masters.
+ * genpd_sync_power_on - Synchronously power on a PM domain and its masters.
  * @genpd: PM domain to power on.
  *
  * This function is only called in "noirq" and "syscore" stages of system power
@@ -768,7 +768,7 @@ static void genpd_sync_poweroff(struct generic_pm_domain *genpd)
  * executed sequentially, so it is guaranteed that it will never run twice in
  * parallel).
  */
-static void genpd_sync_poweron(struct generic_pm_domain *genpd)
+static void genpd_sync_power_on(struct generic_pm_domain *genpd)
 {
 	struct gpd_link *link;
 
@@ -776,11 +776,11 @@ static void genpd_sync_poweron(struct generic_pm_domain *genpd)
 		return;
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
-		genpd_sync_poweron(link->master);
+		genpd_sync_power_on(link->master);
 		genpd_sd_counter_inc(link->master);
 	}
 
-	genpd_power_on(genpd, false);
+	_genpd_power_on(genpd, false);
 
 	genpd->status = GPD_STATE_ACTIVE;
 }
@@ -892,7 +892,7 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 	 * the same PM domain, so it is not necessary to use locking here.
 	 */
 	genpd->suspended_count++;
-	genpd_sync_poweroff(genpd);
+	genpd_sync_power_off(genpd);
 
 	return 0;
 }
@@ -922,7 +922,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
 	 * guaranteed that this function will never run twice in parallel for
 	 * the same PM domain, so it is not necessary to use locking here.
 	 */
-	genpd_sync_poweron(genpd);
+	genpd_sync_power_on(genpd);
 	genpd->suspended_count--;
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start)
@@ -1010,12 +1010,12 @@ static int pm_genpd_restore_noirq(struct device *dev)
 	if (genpd->suspended_count++ == 0)
 		/*
 		 * The boot kernel might put the domain into arbitrary state,
-		 * so make it appear as powered off to genpd_sync_poweron(),
+		 * so make it appear as powered off to genpd_sync_power_on(),
 		 * so that it tries to power it on in case it was really off.
 		 */
 		genpd->status = GPD_STATE_POWER_OFF;
 
-	genpd_sync_poweron(genpd);
+	genpd_sync_power_on(genpd);
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start)
 		ret = pm_runtime_force_resume(dev);
@@ -1070,9 +1070,9 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
 
 	if (suspend) {
 		genpd->suspended_count++;
-		genpd_sync_poweroff(genpd);
+		genpd_sync_power_off(genpd);
 	} else {
-		genpd_sync_poweron(genpd);
+		genpd_sync_power_on(genpd);
 		genpd->suspended_count--;
 	}
 }
@@ -2041,7 +2041,7 @@ int genpd_dev_pm_attach(struct device *dev)
 	dev->pm_domain->sync = genpd_dev_pm_sync;
 
 	genpd_lock(pd);
-	ret = genpd_poweron(pd, 0);
+	ret = genpd_power_on(pd, 0);
 	genpd_unlock(pd);
 out:
 	return ret ? -EPROBE_DEFER : 0;
-- 
1.9.1


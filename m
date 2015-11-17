From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Allow runtime PM callbacks to be re-used during system PM
Date: Tue, 17 Nov 2015 17:42:41 +0100
Message-ID: <1447778561-9767-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34458 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484AbbKQQmx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 11:42:53 -0500
Received: by lbbcs9 with SMTP id cs9so9110367lbb.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 08:42:52 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, Harunaga <nx-truong@jinso.co.jp>

Runtime PM centric subsystems/drivers may re-use their runtime PM
callbacks for system PM. Typically that's done via using the runtime PM
helpers, pm_runtime_force_suspend|resume().

To genpd, this means its runtime PM callbacks may be invoked even when
runtime PM has been disabled for the device. By checking this condition,
it allows genpd to skip latency validation and measurement in the system
PM path. That's needed to enable drivers/subsystems to re-use the runtime
PM callbacks for system PM.

Fixes: ba2bbfbf6307 ("PM / Domains: Remove intermediate states from the
power off sequence")
Reported-by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Reported-by: Harunaga <nx-truong@jinso.co.jp>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

This patch has only been quick tested on ux500, so further tests are
welcome and needed. It was reported [1] to point out a certain commit
causing the regression, but further analyze actually tells that the
problem been there longer.

So, I decided to point the fixes tag to a commit from where it actually
becomes quite simple to address the problem. Earlier than that, is just
not worth the effort.

[1]
https://lkml.org/lkml/2015/11/16/748

---
 drivers/base/power/domain.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e03b1ad..8f0c2a3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -390,6 +390,7 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	struct generic_pm_domain *genpd;
 	bool (*stop_ok)(struct device *__dev);
 	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	bool system_pm = !pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
@@ -400,12 +401,18 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
+	/*
+	 * A runtime PM centric subsystem/driver may re-use the runtime PM
+	 * callbacks for system PM. In these cases, don't validate or measure
+	 * latencies.
+	 */
 	stop_ok = genpd->gov ? genpd->gov->stop_ok : NULL;
-	if (stop_ok && !stop_ok(dev))
+	if (!system_pm && stop_ok && !stop_ok(dev))
 		return -EBUSY;
 
 	/* Measure suspend latency. */
-	time_start = ktime_get();
+	if (!system_pm)
+		time_start = ktime_get();
 
 	ret = genpd_save_dev(genpd, dev);
 	if (ret)
@@ -417,6 +424,10 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 		return ret;
 	}
 
+	/* Don't try poweroff in system PM as it's prevented anyway. */
+	if (system_pm)
+		return 0;
+
 	/* Update suspend latency value if the measured time exceeds it. */
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
 	if (elapsed_ns > td->suspend_latency_ns) {
@@ -453,6 +464,7 @@ static int pm_genpd_runtime_resume(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	bool system_pm = !pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
@@ -464,8 +476,8 @@ static int pm_genpd_runtime_resume(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	/* If power.irq_safe, the PM domain is never powered off. */
-	if (dev->power.irq_safe) {
+	/* If power.irq_safe or system PM, the PM domain remains powered. */
+	if (dev->power.irq_safe || system_pm) {
 		timed = false;
 		goto out;
 	}
-- 
1.9.1


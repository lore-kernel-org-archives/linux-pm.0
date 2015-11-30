From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2] PM / Domains: Allow runtime PM callbacks to be re-used during system PM
Date: Mon, 30 Nov 2015 16:21:38 +0100
Message-ID: <1448896898-27711-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36484 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbbK3PVt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 10:21:49 -0500
Received: by lfs39 with SMTP id 39so197306894lfs.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2015 07:21:47 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, Harunaga <nx-truong@jinso.co.jp>

A runtime PM centric subsystem/driver may typically use the runtime PM
helpers, pm_runtime_force_suspend|resume() in the system PM path. This
means the genpd's runtime PM callbacks might be invoked even when runtime
PM has been disabled for the device.

To properly cope with these and similar scenarios when these helper
functions are used, change genpd to skip validating and measuring the
device PM QOS latency.

This is needed because otherwise genpd may prevent the device to be put
into low power state. If this occurs during system PM, it causes the
sequence to be aborted as a device's system PM callback returns -EBUSY.

Fixes: ba2bbfbf6307 ("PM / Domains: Remove intermediate states from the
power off sequence")
Reported-by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Reported-by: Harunaga <nx-truong@jinso.co.jp>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Change variable name and update code to not be limited to only
	system PM, according to suggestion by Kevin.
	- Updated comments in code.
	- Updated change-log.

Notes in v2:
	- Version 1, got tested successfully by Cao Minh Hiep and Harunaga,
	although because of the changes in V2, another round of tests are
	needed to add their tested by tags.


It was reported [1] to point out a certain commitd causing the regression,
but further analyze actually tells that the problem been there longer.

So, I decided to point the fixes tag to a commit from where it actually
becomes quite simple to address the problem. Earlier than that, is just
not worth the effort.

[1]
https://lkml.org/lkml/2015/11/16/748

---
 drivers/base/power/domain.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e03b1ad..88a759b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -390,6 +390,7 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	struct generic_pm_domain *genpd;
 	bool (*stop_ok)(struct device *__dev);
 	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
@@ -400,12 +401,19 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
+	/*
+	 * A runtime PM centric subsystem/driver may re-use the runtime PM
+	 * callbacks for other purposes than runtime PM. In those scenarios
+	 * runtime PM is disabled. Under these circumstances, we shall skip
+	 * validating/measuring the PM QoS latency.
+	 */
 	stop_ok = genpd->gov ? genpd->gov->stop_ok : NULL;
-	if (stop_ok && !stop_ok(dev))
+	if (runtime_pm && stop_ok && !stop_ok(dev))
 		return -EBUSY;
 
 	/* Measure suspend latency. */
-	time_start = ktime_get();
+	if (runtime_pm)
+		time_start = ktime_get();
 
 	ret = genpd_save_dev(genpd, dev);
 	if (ret)
@@ -418,13 +426,15 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	}
 
 	/* Update suspend latency value if the measured time exceeds it. */
-	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-	if (elapsed_ns > td->suspend_latency_ns) {
-		td->suspend_latency_ns = elapsed_ns;
-		dev_dbg(dev, "suspend latency exceeded, %lld ns\n",
-			elapsed_ns);
-		genpd->max_off_time_changed = true;
-		td->constraint_changed = true;
+	if (runtime_pm) {
+		elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
+		if (elapsed_ns > td->suspend_latency_ns) {
+			td->suspend_latency_ns = elapsed_ns;
+			dev_dbg(dev, "suspend latency exceeded, %lld ns\n",
+				elapsed_ns);
+			genpd->max_off_time_changed = true;
+			td->constraint_changed = true;
+		}
 	}
 
 	/*
@@ -453,6 +463,7 @@ static int pm_genpd_runtime_resume(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
@@ -479,14 +490,14 @@ static int pm_genpd_runtime_resume(struct device *dev)
 
  out:
 	/* Measure resume latency. */
-	if (timed)
+	if (timed && runtime_pm)
 		time_start = ktime_get();
 
 	genpd_start_dev(genpd, dev);
 	genpd_restore_dev(genpd, dev);
 
 	/* Update resume latency value if the measured time exceeds it. */
-	if (timed) {
+	if (timed && runtime_pm) {
 		elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
 		if (elapsed_ns > td->resume_latency_ns) {
 			td->resume_latency_ns = elapsed_ns;
-- 
1.9.1


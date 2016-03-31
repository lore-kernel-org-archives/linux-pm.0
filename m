From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] PM / Domains: Rename stop_ok to suspend_ok for the genpd governor
Date: Thu, 31 Mar 2016 11:21:25 +0200
Message-ID: <1459416087-23519-2-git-send-email-ulf.hansson@linaro.org>
References: <1459416087-23519-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36419 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251AbcCaJVo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 05:21:44 -0400
Received: by mail-lf0-f54.google.com with SMTP id e133so55076386lfe.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2016 02:21:43 -0700 (PDT)
In-Reply-To: <1459416087-23519-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>

The genpd governor validates the latency constraints to find out whether
it's acceptable to runtime suspend a device. Earlier this validation was
made to know whether it was okay to invoke the ->stop() callback for the
device, hence the governor used the name "stop_ok" for the related
variables.

To clarify the code around this, let's rename these variables from
"stop_ok" to "suspend_ok".

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c          |  6 +++---
 drivers/base/power/domain_governor.c | 20 ++++++++++----------
 include/linux/pm_domain.h            |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 56705b5..c62687d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -382,7 +382,7 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 static int pm_genpd_runtime_suspend(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	bool (*stop_ok)(struct device *__dev);
+	bool (*suspend_ok)(struct device *__dev);
 	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
@@ -401,8 +401,8 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	 * runtime PM is disabled. Under these circumstances, we shall skip
 	 * validating/measuring the PM QoS latency.
 	 */
-	stop_ok = genpd->gov ? genpd->gov->stop_ok : NULL;
-	if (runtime_pm && stop_ok && !stop_ok(dev))
+	suspend_ok = genpd->gov ? genpd->gov->suspend_ok : NULL;
+	if (runtime_pm && suspend_ok && !suspend_ok(dev))
 		return -EBUSY;
 
 	/* Measure suspend latency. */
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 00a5436..2e0fce7 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -37,10 +37,10 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
 }
 
 /**
- * default_stop_ok - Default PM domain governor routine for stopping devices.
+ * default_suspend_ok - Default PM domain governor routine to suspend devices.
  * @dev: Device to check.
  */
-static bool default_stop_ok(struct device *dev)
+static bool default_suspend_ok(struct device *dev)
 {
 	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
 	unsigned long flags;
@@ -51,13 +51,13 @@ static bool default_stop_ok(struct device *dev)
 	spin_lock_irqsave(&dev->power.lock, flags);
 
 	if (!td->constraint_changed) {
-		bool ret = td->cached_stop_ok;
+		bool ret = td->cached_suspend_ok;
 
 		spin_unlock_irqrestore(&dev->power.lock, flags);
 		return ret;
 	}
 	td->constraint_changed = false;
-	td->cached_stop_ok = false;
+	td->cached_suspend_ok = false;
 	td->effective_constraint_ns = -1;
 	constraint_ns = __dev_pm_qos_read_value(dev);
 
@@ -83,13 +83,13 @@ static bool default_stop_ok(struct device *dev)
 			return false;
 	}
 	td->effective_constraint_ns = constraint_ns;
-	td->cached_stop_ok = constraint_ns >= 0;
+	td->cached_suspend_ok = constraint_ns >= 0;
 
 	/*
 	 * The children have been suspended already, so we don't need to take
-	 * their stop latencies into account here.
+	 * their suspend latencies into account here.
 	 */
-	return td->cached_stop_ok;
+	return td->cached_suspend_ok;
 }
 
 /**
@@ -150,7 +150,7 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 		 */
 		td = &to_gpd_data(pdd)->td;
 		constraint_ns = td->effective_constraint_ns;
-		/* default_stop_ok() need not be called before us. */
+		/* default_suspend_ok() need not be called before us. */
 		if (constraint_ns < 0) {
 			constraint_ns = dev_pm_qos_read_value(pdd->dev);
 			constraint_ns *= NSEC_PER_USEC;
@@ -227,7 +227,7 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
 }
 
 struct dev_power_governor simple_qos_governor = {
-	.stop_ok = default_stop_ok,
+	.suspend_ok = default_suspend_ok,
 	.power_down_ok = default_power_down_ok,
 };
 
@@ -236,5 +236,5 @@ struct dev_power_governor simple_qos_governor = {
  */
 struct dev_power_governor pm_domain_always_on_gov = {
 	.power_down_ok = always_on_power_down_ok,
-	.stop_ok = default_stop_ok,
+	.suspend_ok = default_suspend_ok,
 };
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 49cd889..e913939 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -28,7 +28,7 @@ enum gpd_status {
 
 struct dev_power_governor {
 	bool (*power_down_ok)(struct dev_pm_domain *domain);
-	bool (*stop_ok)(struct device *dev);
+	bool (*suspend_ok)(struct device *dev);
 };
 
 struct gpd_dev_ops {
@@ -94,7 +94,7 @@ struct gpd_timing_data {
 	s64 resume_latency_ns;
 	s64 effective_constraint_ns;
 	bool constraint_changed;
-	bool cached_stop_ok;
+	bool cached_suspend_ok;
 };
 
 struct pm_domain_data {
-- 
1.9.1


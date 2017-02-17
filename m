From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] PM / Domains: Move genpd_power_off() above genpd_power_on()
Date: Fri, 17 Feb 2017 10:55:23 +0100
Message-ID: <1487325325-18212-2-git-send-email-ulf.hansson@linaro.org>
References: <1487325325-18212-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35295 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933961AbdBQJzd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 04:55:33 -0500
Received: by mail-lf0-f41.google.com with SMTP id z127so20155491lfa.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2017 01:55:32 -0800 (PST)
In-Reply-To: <1487325325-18212-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Following changes in genpd_power_on() makes it invoke genpd_power_off().
To enable these changes and avoiding to declare genpd_power_off(), let's
move its implementation above genpd_power_on(). In this way, following
changes should become easier to review.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 162 ++++++++++++++++++++++----------------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3a75fb1..3dc44f2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -274,6 +274,87 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 }
 
 /**
+ * genpd_power_off - Remove power from a given PM domain.
+ * @genpd: PM domain to power down.
+ * @is_async: PM domain is powered down from a scheduled work
+ *
+ * If all of the @genpd's devices have been suspended and all of its subdomains
+ * have been powered down, remove power from @genpd.
+ */
+static int genpd_power_off(struct generic_pm_domain *genpd, bool is_async)
+{
+	struct pm_domain_data *pdd;
+	struct gpd_link *link;
+	unsigned int not_suspended = 0;
+
+	/*
+	 * Do not try to power off the domain in the following situations:
+	 * (1) The domain is already in the "power off" state.
+	 * (2) System suspend is in progress.
+	 */
+	if (genpd->status == GPD_STATE_POWER_OFF
+	    || genpd->prepared_count > 0)
+		return 0;
+
+	if (atomic_read(&genpd->sd_count) > 0)
+		return -EBUSY;
+
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		enum pm_qos_flags_status stat;
+
+		stat = dev_pm_qos_flags(pdd->dev,
+					PM_QOS_FLAG_NO_POWER_OFF
+						| PM_QOS_FLAG_REMOTE_WAKEUP);
+		if (stat > PM_QOS_FLAGS_NONE)
+			return -EBUSY;
+
+		/*
+		 * Do not allow PM domain to be powered off, when an IRQ safe
+		 * device is part of a non-IRQ safe domain.
+		 */
+		if (!pm_runtime_suspended(pdd->dev) ||
+			irq_safe_dev_in_no_sleep_domain(pdd->dev, genpd))
+			not_suspended++;
+	}
+
+	if (not_suspended > 1 || (not_suspended == 1 && is_async))
+		return -EBUSY;
+
+	if (genpd->gov && genpd->gov->power_down_ok) {
+		if (!genpd->gov->power_down_ok(&genpd->domain))
+			return -EAGAIN;
+	}
+
+	if (genpd->power_off) {
+		int ret;
+
+		if (atomic_read(&genpd->sd_count) > 0)
+			return -EBUSY;
+
+		/*
+		 * If sd_count > 0 at this point, one of the subdomains hasn't
+		 * managed to call genpd_power_on() for the master yet after
+		 * incrementing it.  In that case genpd_power_on() will wait
+		 * for us to drop the lock, so we can call .power_off() and let
+		 * the genpd_power_on() restore power for us (this shouldn't
+		 * happen very often).
+		 */
+		ret = _genpd_power_off(genpd, true);
+		if (ret)
+			return ret;
+	}
+
+	genpd->status = GPD_STATE_POWER_OFF;
+
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		genpd_sd_counter_dec(link->master);
+		genpd_queue_power_off_work(link->master);
+	}
+
+	return 0;
+}
+
+/**
  * genpd_power_on - Restore power to a given PM domain and its masters.
  * @genpd: PM domain to power up.
  * @depth: nesting count for lockdep.
@@ -368,87 +449,6 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 }
 
 /**
- * genpd_power_off - Remove power from a given PM domain.
- * @genpd: PM domain to power down.
- * @is_async: PM domain is powered down from a scheduled work
- *
- * If all of the @genpd's devices have been suspended and all of its subdomains
- * have been powered down, remove power from @genpd.
- */
-static int genpd_power_off(struct generic_pm_domain *genpd, bool is_async)
-{
-	struct pm_domain_data *pdd;
-	struct gpd_link *link;
-	unsigned int not_suspended = 0;
-
-	/*
-	 * Do not try to power off the domain in the following situations:
-	 * (1) The domain is already in the "power off" state.
-	 * (2) System suspend is in progress.
-	 */
-	if (genpd->status == GPD_STATE_POWER_OFF
-	    || genpd->prepared_count > 0)
-		return 0;
-
-	if (atomic_read(&genpd->sd_count) > 0)
-		return -EBUSY;
-
-	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
-		enum pm_qos_flags_status stat;
-
-		stat = dev_pm_qos_flags(pdd->dev,
-					PM_QOS_FLAG_NO_POWER_OFF
-						| PM_QOS_FLAG_REMOTE_WAKEUP);
-		if (stat > PM_QOS_FLAGS_NONE)
-			return -EBUSY;
-
-		/*
-		 * Do not allow PM domain to be powered off, when an IRQ safe
-		 * device is part of a non-IRQ safe domain.
-		 */
-		if (!pm_runtime_suspended(pdd->dev) ||
-			irq_safe_dev_in_no_sleep_domain(pdd->dev, genpd))
-			not_suspended++;
-	}
-
-	if (not_suspended > 1 || (not_suspended == 1 && is_async))
-		return -EBUSY;
-
-	if (genpd->gov && genpd->gov->power_down_ok) {
-		if (!genpd->gov->power_down_ok(&genpd->domain))
-			return -EAGAIN;
-	}
-
-	if (genpd->power_off) {
-		int ret;
-
-		if (atomic_read(&genpd->sd_count) > 0)
-			return -EBUSY;
-
-		/*
-		 * If sd_count > 0 at this point, one of the subdomains hasn't
-		 * managed to call genpd_power_on() for the master yet after
-		 * incrementing it.  In that case genpd_power_on() will wait
-		 * for us to drop the lock, so we can call .power_off() and let
-		 * the genpd_power_on() restore power for us (this shouldn't
-		 * happen very often).
-		 */
-		ret = _genpd_power_off(genpd, true);
-		if (ret)
-			return ret;
-	}
-
-	genpd->status = GPD_STATE_POWER_OFF;
-
-	list_for_each_entry(link, &genpd->slave_links, slave_node) {
-		genpd_sd_counter_dec(link->master);
-		genpd_queue_power_off_work(link->master);
-	}
-
-	return 0;
-}
-
-/**
  * genpd_power_off_work_fn - Power off PM domain whose subdomain count is 0.
  * @work: Work structure used for scheduling the execution of this function.
  */
-- 
1.9.1

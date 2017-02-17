From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] PM / Domains: Rename is_async to one_dev_on for genpd_power_off()
Date: Fri, 17 Feb 2017 10:55:24 +0100
Message-ID: <1487325325-18212-3-git-send-email-ulf.hansson@linaro.org>
References: <1487325325-18212-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33665 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933054AbdBQJzs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 04:55:48 -0500
Received: by mail-lf0-f48.google.com with SMTP id x1so20213625lff.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2017 01:55:33 -0800 (PST)
In-Reply-To: <1487325325-18212-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>

The parameter name is_async, for genpd_power_off() gives a poor description
of its purpose. To clarify, let's rename it to one_dev_on and update the
documentation of it in the function header.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3dc44f2..179bb26 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -276,12 +276,15 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 /**
  * genpd_power_off - Remove power from a given PM domain.
  * @genpd: PM domain to power down.
- * @is_async: PM domain is powered down from a scheduled work
+ * @one_dev_on: If invoked from genpd's ->runtime_suspend|resume() callback, the
+ * RPM status of the releated device is in an intermediate state, not yet turned
+ * into RPM_SUSPENDED. This means genpd_power_off() must allow one device to not
+ * be RPM_SUSPENDED, while it tries to power off the PM domain.
  *
  * If all of the @genpd's devices have been suspended and all of its subdomains
  * have been powered down, remove power from @genpd.
  */
-static int genpd_power_off(struct generic_pm_domain *genpd, bool is_async)
+static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on)
 {
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
@@ -317,7 +320,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool is_async)
 			not_suspended++;
 	}
 
-	if (not_suspended > 1 || (not_suspended == 1 && is_async))
+	if (not_suspended > 1 || (not_suspended == 1 && !one_dev_on))
 		return -EBUSY;
 
 	if (genpd->gov && genpd->gov->power_down_ok) {
@@ -459,7 +462,7 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 	genpd = container_of(work, struct generic_pm_domain, power_off_work);
 
 	genpd_lock(genpd);
-	genpd_power_off(genpd, true);
+	genpd_power_off(genpd, false);
 	genpd_unlock(genpd);
 }
 
@@ -578,7 +581,7 @@ static int genpd_runtime_suspend(struct device *dev)
 		return 0;
 
 	genpd_lock(genpd);
-	genpd_power_off(genpd, false);
+	genpd_power_off(genpd, true);
 	genpd_unlock(genpd);
 
 	return 0;
@@ -658,7 +661,7 @@ static int genpd_runtime_resume(struct device *dev)
 	if (!pm_runtime_is_irq_safe(dev) ||
 		(pm_runtime_is_irq_safe(dev) && genpd_is_irq_safe(genpd))) {
 		genpd_lock(genpd);
-		genpd_power_off(genpd, 0);
+		genpd_power_off(genpd, true);
 		genpd_unlock(genpd);
 	}
 
-- 
1.9.1

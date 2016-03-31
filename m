From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] PM / Domains: Rename pm_genpd_runtime_suspend|resume()
Date: Thu, 31 Mar 2016 11:21:26 +0200
Message-ID: <1459416087-23519-3-git-send-email-ulf.hansson@linaro.org>
References: <1459416087-23519-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36561 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075AbcCaJVq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 05:21:46 -0400
Received: by mail-lb0-f172.google.com with SMTP id qe11so48481606lbc.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2016 02:21:45 -0700 (PDT)
In-Reply-To: <1459416087-23519-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>

Follow genpd's rule for names of static functions, by renaming
pm_genpd_runtime_suspend|resume() to genpd_runtime_suspend|resume().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index c62687d..75b994a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -372,14 +372,14 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 }
 
 /**
- * pm_genpd_runtime_suspend - Suspend a device belonging to I/O PM domain.
+ * genpd_runtime_suspend - Suspend a device belonging to I/O PM domain.
  * @dev: Device to suspend.
  *
  * Carry out a runtime suspend of a device under the assumption that its
  * pm_domain field points to the domain member of an object of type
  * struct generic_pm_domain representing a PM domain consisting of I/O devices.
  */
-static int pm_genpd_runtime_suspend(struct device *dev)
+static int genpd_runtime_suspend(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	bool (*suspend_ok)(struct device *__dev);
@@ -446,14 +446,14 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 }
 
 /**
- * pm_genpd_runtime_resume - Resume a device belonging to I/O PM domain.
+ * genpd_runtime_resume - Resume a device belonging to I/O PM domain.
  * @dev: Device to resume.
  *
  * Carry out a runtime resume of a device under the assumption that its
  * pm_domain field points to the domain member of an object of type
  * struct generic_pm_domain representing a PM domain consisting of I/O devices.
  */
-static int pm_genpd_runtime_resume(struct device *dev)
+static int genpd_runtime_resume(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
@@ -1498,8 +1498,8 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->device_count = 0;
 	genpd->max_off_time_ns = -1;
 	genpd->max_off_time_changed = true;
-	genpd->domain.ops.runtime_suspend = pm_genpd_runtime_suspend;
-	genpd->domain.ops.runtime_resume = pm_genpd_runtime_resume;
+	genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
+	genpd->domain.ops.runtime_resume = genpd_runtime_resume;
 	genpd->domain.ops.prepare = pm_genpd_prepare;
 	genpd->domain.ops.suspend = pm_genpd_suspend;
 	genpd->domain.ops.suspend_late = pm_genpd_suspend_late;
-- 
1.9.1


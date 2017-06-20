From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2] PM / Domains: Call driver's noirq callbacks
Date: Tue, 20 Jun 2017 16:38:15 +0300
Message-ID: <1497965895-11486-1-git-send-email-mperttunen@nvidia.com>
References: <CAPDyKFpgXCwErOUBcXwOVycYpro6=-vxoQeGnTMwsn0ji8iXJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17595 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbdFTNiY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2017 09:38:24 -0400
In-Reply-To: <CAPDyKFpgXCwErOUBcXwOVycYpro6=-vxoQeGnTMwsn0ji8iXJQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>

Currently genpd installs its own suspend_noirq, resume_noirq,
and poweroff_noirq callbacks, but never calls down to the driver's
corresponding callbacks. Add these calls.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2:
- Moved pm_generic_suspend_noirq to before pm_runtime_force_suspend,
  and correspondingly pm_generic_resume_noirq after 
  pm_runtime_force_resume
- Added new pm_genpd_poweroff_noirq callback that is identical to
  pm_genpd_suspend_noirq but calls the appropriate driver callback

 drivers/base/power/domain.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d3f1d96f75e9..b070ee58186d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -919,6 +919,10 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
 		return 0;
 
+	ret = pm_generic_suspend_noirq(dev);
+	if (ret)
+		return ret;
+
 	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
 		ret = pm_runtime_force_suspend(dev);
 		if (ret)
@@ -961,6 +965,10 @@ static int pm_genpd_resume_noirq(struct device *dev)
 	if (genpd->dev_ops.stop && genpd->dev_ops.start)
 		ret = pm_runtime_force_resume(dev);
 
+	ret = pm_generic_resume_noirq(dev);
+	if (ret)
+		return ret;
+
 	return ret;
 }
 
@@ -1015,6 +1023,46 @@ static int pm_genpd_thaw_noirq(struct device *dev)
 }
 
 /**
+ * pm_genpd_poweroff_noirq - Completion of hibernation of device in an
+ *   I/O PM domain.
+ * @dev: Device to poweroff.
+ *
+ * Stop the device and remove power from the domain if all devices in it have
+ * been stopped.
+ */
+static int pm_genpd_poweroff_noirq(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+	int ret;
+
+	dev_dbg(dev, "%s()\n", __func__);
+
+	genpd = dev_to_genpd(dev);
+	if (IS_ERR(genpd))
+		return -EINVAL;
+
+	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
+		return 0;
+
+	ret = pm_generic_poweroff_noirq(dev);
+	if (ret)
+		return ret;
+
+	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
+		ret = pm_runtime_force_suspend(dev);
+		if (ret)
+			return ret;
+	}
+
+	genpd_lock(genpd);
+	genpd->suspended_count++;
+	genpd_sync_power_off(genpd, true, 0);
+	genpd_unlock(genpd);
+
+	return 0;
+}
+
+/**
  * pm_genpd_restore_noirq - Start of restore of device in an I/O PM domain.
  * @dev: Device to resume.
  *
@@ -1493,7 +1541,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->domain.ops.resume_noirq = pm_genpd_resume_noirq;
 	genpd->domain.ops.freeze_noirq = pm_genpd_freeze_noirq;
 	genpd->domain.ops.thaw_noirq = pm_genpd_thaw_noirq;
-	genpd->domain.ops.poweroff_noirq = pm_genpd_suspend_noirq;
+	genpd->domain.ops.poweroff_noirq = pm_genpd_poweroff_noirq;
 	genpd->domain.ops.restore_noirq = pm_genpd_restore_noirq;
 	genpd->domain.ops.complete = pm_genpd_complete;
 
-- 
2.1.4

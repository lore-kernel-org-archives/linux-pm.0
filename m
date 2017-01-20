From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2] PM / Domains: Keep the pd status during system PM phases
Date: Fri, 20 Jan 2017 10:21:33 +0800
Message-ID: <1484878893-25270-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.138]:34859 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754026AbdATCVO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2017 21:21:14 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: xf@rock-chips.com, heiko@sntech.de, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, pavel@ucw.cz, len.brown@intel.com
Cc: gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, huangtao@rock-chips.com, xxx@rock-chips.com, wxt@rock-chips.com, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Elaine Zhang <zhangqing@rock-chips.com>

If a PM domain is powered off before system suspend,
we hope do nothing in system runtime suspend noirq phase
and system runtime resume noirq phase.

This modify is to slove system resume issue for RK3399.
RK3399 SOC pd_gpu have voltage domain vdd_gpu,
so we must follow open vdd_gpu and power on pd_gpu,
power off pd_gpu and disable vdd_gpu.
Fix up in runtime resume noirq phase power on all PDs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/base/power/domain.c | 10 +++++++---
 include/linux/pm_domain.h   |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5711708532db..81351eec570f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -842,8 +842,10 @@ static int pm_genpd_prepare(struct device *dev)
 
 	genpd_lock(genpd);
 
-	if (genpd->prepared_count++ == 0)
+	if (genpd->prepared_count++ == 0) {
 		genpd->suspended_count = 0;
+		genpd->suspend_power_off = genpd->status == GPD_STATE_POWER_OFF;
+	}
 
 	genpd_unlock(genpd);
 
@@ -877,7 +879,8 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
+	if (genpd->suspend_power_off ||
+	    (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)))
 		return 0;
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
@@ -914,7 +917,8 @@ static int pm_genpd_resume_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
+	if (genpd->suspend_power_off ||
+	    (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)))
 		return 0;
 
 	/*
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 81ece61075df..9c0dc364f089 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -62,6 +62,7 @@ struct generic_pm_domain {
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
+	bool suspend_power_off;	/* Power status before system suspend */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
 	struct gpd_dev_ops dev_ops;
-- 
1.9.1



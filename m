From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 5/5] PM / Domains: Remove gpd_dev_ops.active_wakeup() callback
Date: Tue,  7 Nov 2017 13:48:15 +0100
Message-ID: <1510058895-21712-6-git-send-email-geert+renesas@glider.be>
References: <1510058895-21712-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:54478 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753087AbdKGMsX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2017 07:48:23 -0500
In-Reply-To: <1510058895-21712-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

There are no more users left of the gpd_dev_ops.active_wakeup()
callback.  All have been converted to GENPD_FLAG_ACTIVE_WAKEUP.
Hence remove the callback.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
v3:
  - Add Acked-by, Reviewed-by,
  - Drop RFC status,

v2:
  - New.
---
 drivers/base/power/domain.c | 14 +++-----------
 include/linux/pm_domain.h   |  1 -
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index c5172d70b742f288..8768e56ecf101203 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -864,14 +864,6 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
 
 #ifdef CONFIG_PM_SLEEP
 
-static bool genpd_dev_active_wakeup(const struct generic_pm_domain *genpd,
-				    struct device *dev)
-{
-	if (genpd_is_active_wakeup(genpd))
-		return true;
-	return GENPD_DEV_CALLBACK(genpd, bool, active_wakeup, dev);
-}
-
 /**
  * genpd_sync_power_off - Synchronously power off a PM domain and its masters.
  * @genpd: PM domain to power off, if possible.
@@ -976,7 +968,7 @@ static bool resume_needed(struct device *dev,
 	if (!device_can_wakeup(dev))
 		return false;
 
-	active_wakeup = genpd_dev_active_wakeup(genpd, dev);
+	active_wakeup = genpd_is_active_wakeup(genpd);
 	return device_may_wakeup(dev) ? active_wakeup : !active_wakeup;
 }
 
@@ -1045,7 +1037,7 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
+	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
 		return 0;
 
 	if (poweroff)
@@ -1100,7 +1092,7 @@ static int genpd_resume_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
+	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
 		return 0;
 
 	genpd_lock(genpd);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 28c24c58d479e3b4..04dbef9847d3ad3b 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -36,7 +36,6 @@ struct dev_power_governor {
 struct gpd_dev_ops {
 	int (*start)(struct device *dev);
 	int (*stop)(struct device *dev);
-	bool (*active_wakeup)(struct device *dev);
 };
 
 struct genpd_power_state {
-- 
2.7.4

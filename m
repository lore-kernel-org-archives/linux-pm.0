From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 5/5] [RFC] PM / Domains: Remove gpd_dev_ops.active_wakeup() callback
Date: Tue, 31 Oct 2017 19:11:34 +0100
Message-ID: <1509473494-19740-6-git-send-email-geert+renesas@glider.be>
References: <1509473494-19740-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509473494-19740-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

There are no more users left of the gpd_dev_ops.active_wakeup()
callback.  All have been converted to GENPD_FLAG_ACTIVE_WAKEUP.
Hence remove the callback.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This must not be applied before all users of active_wakup have been
converted, hence the "RFC".

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

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] PM / Domains: Take WAKEUP_POWERED driver flag into account
Date: Wed,  8 Nov 2017 16:15:34 +0100
Message-ID: <1510154134-1248-4-git-send-email-ulf.hansson@linaro.org>
References: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Make genpd to take the WAKEUP_POWERED driver flag into account during
system suspend/resume. More precisely, in case the WAKEUP_POWERED flag is
set, let's leave the device in full power state and prevent the PM domain
from being powered off.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 24e39ce..dc18f88 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1037,8 +1037,11 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
-		return 0;
+	if (dev->power.wakeup_path) {
+		if (dev_pm_test_driver_flags(dev, DPM_FLAG_WAKEUP_POWERED) ||
+		    genpd_is_active_wakeup(genpd))
+			return 0;
+	}
 
 	if (poweroff)
 		ret = pm_generic_poweroff_noirq(dev);
@@ -1092,8 +1095,11 @@ static int genpd_resume_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
-		return 0;
+	if (dev->power.wakeup_path) {
+		if (dev_pm_test_driver_flags(dev, DPM_FLAG_WAKEUP_POWERED) ||
+		    genpd_is_active_wakeup(genpd))
+			return 0;
+	}
 
 	genpd_lock(genpd);
 	genpd_sync_power_on(genpd, true, 0);
-- 
2.7.4

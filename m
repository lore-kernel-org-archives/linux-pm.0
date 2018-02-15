From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] power: supply: axp288_fuel_gauge: Fix full status reporting
Date: Thu, 15 Feb 2018 15:00:36 +0100
Message-ID: <20180215140037.6097-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032283AbeBOOAj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Feb 2018 09:00:39 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Commit 2b5a4b4bf222 ("power: supply: axp288_fuel_gauge: Rework
get_status()"), switched from 0A current detection to using the capacity
register for full detection.

It turns out this fixes full reporting on some devices which keep trickle
charging long after the capacity register reach 100%, but breaks it on
some other devices where the charger stops charging before the capacity
register reaches 100%. This commit fixes this by also checking for
0A current when the reported capacity is above 90%.

Fixes: 2b5a4b4bf222 ("psy: axp288_fuel_gauge: Rework get_status()")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 47 ++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 4cc6e038dfdd..e58aad011eb7 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -343,7 +343,7 @@ static inline void fuel_gauge_remove_debugfs(struct axp288_fg_info *info)
 
 static void fuel_gauge_get_status(struct axp288_fg_info *info)
 {
-	int pwr_stat, fg_res;
+	int pwr_stat, fg_res, curr, ret;
 
 	pwr_stat = fuel_gauge_reg_readb(info, AXP20X_PWR_INPUT_STATUS);
 	if (pwr_stat < 0) {
@@ -353,19 +353,42 @@ static void fuel_gauge_get_status(struct axp288_fg_info *info)
 	}
 
 	/* Report full if Vbus is valid and the reported capacity is 100% */
-	if (pwr_stat & PS_STAT_VBUS_VALID) {
-		fg_res = fuel_gauge_reg_readb(info, AXP20X_FG_RES);
-		if (fg_res < 0) {
-			dev_err(&info->pdev->dev,
-				"FG RES read failed: %d\n", fg_res);
-			return;
-		}
-		if (fg_res == (FG_REP_CAP_VALID | 100)) {
-			info->status = POWER_SUPPLY_STATUS_FULL;
-			return;
-		}
+	if (!(pwr_stat & PS_STAT_VBUS_VALID))
+		goto not_full;
+
+	fg_res = fuel_gauge_reg_readb(info, AXP20X_FG_RES);
+	if (fg_res < 0) {
+		dev_err(&info->pdev->dev, "FG RES read failed: %d\n", fg_res);
+		return;
+	}
+	if (!(fg_res & FG_REP_CAP_VALID))
+		goto not_full;
+
+	fg_res &= ~FG_REP_CAP_VALID;
+	if (fg_res == 100) {
+		info->status = POWER_SUPPLY_STATUS_FULL;
+		return;
+	}
+
+	/*
+	 * Sometimes the charger turns itself off before fg-res reaches 100%.
+	 * When this happens the AXP288 reports a not-charging status and
+	 * 0 mA discharge current.
+	 */
+	if (fg_res < 90 || (pwr_stat & PS_STAT_BAT_CHRG_DIR))
+		goto not_full;
+
+	ret = iio_read_channel_raw(info->iio_channel[BAT_D_CURR], &curr);
+	if (ret < 0) {
+		dev_err(&info->pdev->dev, "FG get current failed: %d\n", ret);
+		return;
+	}
+	if (curr == 0) {
+		info->status = POWER_SUPPLY_STATUS_FULL;
+		return;
 	}
 
+not_full:
 	if (pwr_stat & PS_STAT_BAT_CHRG_DIR)
 		info->status = POWER_SUPPLY_STATUS_CHARGING;
 	else
-- 
2.14.3

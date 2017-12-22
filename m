From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 15/16] power: supply: axp288_fuel_gauge: Fix FULL status reporting
Date: Fri, 22 Dec 2017 13:37:53 +0100
Message-ID: <20171222123754.9622-15-hdegoede@redhat.com>
References: <20171222123754.9622-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755901AbdLVMiR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Dec 2017 07:38:17 -0500
In-Reply-To: <20171222123754.9622-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Relying on the (dis)charge current reporting for reporting FULL back to
userspace does not work really well and often leads to the reported status
getting stuck at e.g. 98/99% (the fuelgauge is not perfect) for hours.

What happens is that when the battery is full the axp288 keeps charging it
with a very low current. Until it is really really full and once really
really full, some inaccuracies in the adc lead to it then sometimes
reporting a small discharging rate, even though an external pwr source is
used. So we end up with a status of "charging" for hours after the battery
is actually already full and sometimes this then flip-flops to discharging.

This commit fixes this by using the fuel-gauge to check if the battery is
approximately full and if it is then discount a (dis)charge current smaller
then 64mA.

If we encounter a 0 (dis)charge current when not full, then report this
as "not charging".

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 33 ++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 2fc144b1ec0a..5750b6caecd4 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -337,7 +337,8 @@ static inline void fuel_gauge_remove_debugfs(struct axp288_fg_info *info)
 
 static void fuel_gauge_get_status(struct axp288_fg_info *info)
 {
-	int ret, charge, discharge;
+	int ret, charge, discharge, charge_now_raw, threshold;
+	bool full;
 
 	ret = iio_read_channel_raw(info->iio_channel[BAT_CHRG_CURR], &charge);
 	if (ret < 0) {
@@ -352,12 +353,36 @@ static void fuel_gauge_get_status(struct axp288_fg_info *info)
 		return;
 	}
 
-	if (charge > 0)
+	ret = fuel_gauge_read_15bit_word(info, AXP288_FG_CC_MTR1_REG);
+	if (ret < 0) {
+		dev_err(&info->pdev->dev,
+			"ADC charge current read failed:%d\n", ret);
+		return;
+	}
+	charge_now_raw = ret;
+
+	/*
+	 * When the battery is full the axp288 keeps charging it with a
+	 * very low current. Until it is really really full and once really
+	 * really full, some inaccuracies in the adc lead to it then sometimes
+	 * reporting a small discharging rate, even though an external pwr
+	 * source is used.
+	 *
+	 * So when we the battery is (nearly) full we treat low (dis)charge
+	 * currents as 0.
+	 */
+
+	full = DIV_ROUND_UP(charge_now_raw * 100, info->charge_full_raw) >= 98;
+	threshold = full ? 64 : 0; /* mA */
+
+	if (charge > threshold)
 		info->status = POWER_SUPPLY_STATUS_CHARGING;
-	else if (discharge > 0)
+	else if (discharge > threshold)
 		info->status = POWER_SUPPLY_STATUS_DISCHARGING;
-	else
+	else if (full)
 		info->status = POWER_SUPPLY_STATUS_FULL;
+	else
+		info->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 }
 
 static int fuel_gauge_get_vbatt(struct axp288_fg_info *info, int *vbatt)
-- 
2.14.3

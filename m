From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 13/16] power: supply: axp288_fuel_gauge: Rework get_status()
Date: Tue, 26 Dec 2017 13:59:11 +0100
Message-ID: <20171226125914.10235-13-hdegoede@redhat.com>
References: <20171226125914.10235-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbdLZM7b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Dec 2017 07:59:31 -0500
In-Reply-To: <20171226125914.10235-1-hdegoede@redhat.com>
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

This commit fixes this by first checking if a valid Vbus is present and if
it is present using the fuel-gauge's reported percentage to check for a
full battery.

This commit also changes how get_status() determines if the battery is
charging or discharging when not reporting it as full. We still use the
current direction for this, but instead of reading 4 extra registers for
this (2 16 bit regs), simplify things by using the current-direction bit
in the power-status register, which already gets read anyways.

This also reduces the amount of i2c reads to 1 when on battery and 2
when a valid Vbus is present.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use pmic reported percentage instead of calculating this ourselves
-Drop adc readings, instead rely on the direction bit in the pwr_stat reg
---
 drivers/power/supply/axp288_fuel_gauge.c | 43 ++++++++++++++++----------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index eb60f75f00d7..c0b5e40b23e1 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -32,6 +32,12 @@
 #include <linux/seq_file.h>
 #include <asm/unaligned.h>
 
+#define PS_STAT_VBUS_TRIGGER		(1 << 0)
+#define PS_STAT_BAT_CHRG_DIR		(1 << 2)
+#define PS_STAT_VBAT_ABOVE_VHOLD	(1 << 3)
+#define PS_STAT_VBUS_VALID		(1 << 4)
+#define PS_STAT_VBUS_PRESENT		(1 << 5)
+
 #define CHRG_STAT_BAT_SAFE_MODE		(1 << 3)
 #define CHRG_STAT_BAT_VALID			(1 << 4)
 #define CHRG_STAT_BAT_PRESENT		(1 << 5)
@@ -336,8 +342,7 @@ static inline void fuel_gauge_remove_debugfs(struct axp288_fg_info *info)
 
 static void fuel_gauge_get_status(struct axp288_fg_info *info)
 {
-	int pwr_stat, ret;
-	int charge, discharge;
+	int pwr_stat, fg_res;
 
 	pwr_stat = fuel_gauge_reg_readb(info, AXP20X_PWR_INPUT_STATUS);
 	if (pwr_stat < 0) {
@@ -345,29 +350,25 @@ static void fuel_gauge_get_status(struct axp288_fg_info *info)
 			"PWR STAT read failed:%d\n", pwr_stat);
 		return;
 	}
-	ret = iio_read_channel_raw(info->iio_channel[BAT_CHRG_CURR], &charge);
-	if (ret < 0) {
-		dev_err(&info->pdev->dev,
-			"ADC charge current read failed:%d\n", ret);
-		return;
-	}
-	ret = iio_read_channel_raw(info->iio_channel[BAT_D_CURR], &discharge);
-	if (ret < 0) {
-		dev_err(&info->pdev->dev,
-			"ADC discharge current read failed:%d\n", ret);
-		return;
+
+	/* Report full if Vbus is valid and the reported capacity is 100% */
+	if (pwr_stat & PS_STAT_VBUS_VALID) {
+		fg_res = fuel_gauge_reg_readb(info, AXP20X_FG_RES);
+		if (fg_res < 0) {
+			dev_err(&info->pdev->dev,
+				"FG RES read failed: %d\n", fg_res);
+			return;
+		}
+		if (fg_res == (FG_REP_CAP_VALID | 100)) {
+			info->status = POWER_SUPPLY_STATUS_FULL;
+			return;
+		}
 	}
 
-	if (charge > 0)
+	if (pwr_stat & PS_STAT_BAT_CHRG_DIR)
 		info->status = POWER_SUPPLY_STATUS_CHARGING;
-	else if (discharge > 0)
+	else
 		info->status = POWER_SUPPLY_STATUS_DISCHARGING;
-	else {
-		if (pwr_stat & CHRG_STAT_BAT_PRESENT)
-			info->status = POWER_SUPPLY_STATUS_FULL;
-		else
-			info->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-	}
 }
 
 static int fuel_gauge_get_vbatt(struct axp288_fg_info *info, int *vbatt)
-- 
2.14.3

From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 14/16] power: supply: axp288_fuel_gauge: Remove bogus status reg check
Date: Fri, 22 Dec 2017 13:37:52 +0100
Message-ID: <20171222123754.9622-14-hdegoede@redhat.com>
References: <20171222123754.9622-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755761AbdLVMiQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Dec 2017 07:38:16 -0500
In-Reply-To: <20171222123754.9622-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Remove a bogus status reg check from fuel_gauge_get_status, the
register being read is the pwr-status reg, but the mask being used is
for the chgr-status reg.

The wrong mask checks for vbus-present, not valid but present, we could
change the check to use a proper mask definition for the vbus-valid mask,
but even then it makes no sense, if we don't have a valid vbus then we
must be running from battery and the discharge current thus must be non 0,
so we will then never reach the pwr_stat check.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 800abecef45c..2fc144b1ec0a 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -337,15 +337,8 @@ static inline void fuel_gauge_remove_debugfs(struct axp288_fg_info *info)
 
 static void fuel_gauge_get_status(struct axp288_fg_info *info)
 {
-	int pwr_stat, ret;
-	int charge, discharge;
+	int ret, charge, discharge;
 
-	pwr_stat = fuel_gauge_reg_readb(info, AXP20X_PWR_INPUT_STATUS);
-	if (pwr_stat < 0) {
-		dev_err(&info->pdev->dev,
-			"PWR STAT read failed:%d\n", pwr_stat);
-		return;
-	}
 	ret = iio_read_channel_raw(info->iio_channel[BAT_CHRG_CURR], &charge);
 	if (ret < 0) {
 		dev_err(&info->pdev->dev,
@@ -363,12 +356,8 @@ static void fuel_gauge_get_status(struct axp288_fg_info *info)
 		info->status = POWER_SUPPLY_STATUS_CHARGING;
 	else if (discharge > 0)
 		info->status = POWER_SUPPLY_STATUS_DISCHARGING;
-	else {
-		if (pwr_stat & CHRG_STAT_BAT_PRESENT)
-			info->status = POWER_SUPPLY_STATUS_FULL;
-		else
-			info->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-	}
+	else
+		info->status = POWER_SUPPLY_STATUS_FULL;
 }
 
 static int fuel_gauge_get_vbatt(struct axp288_fg_info *info, int *vbatt)
-- 
2.14.3

From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] power: supply: max17042_battery: Check battery current for status when supplied
Date: Sat, 20 Jan 2018 14:50:24 +0100
Message-ID: <20180120135024.15183-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbeATNu0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 20 Jan 2018 08:50:26 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org, James <kernel@madingley.org>

Even though the system is supplied, it may still be discharging if the
supply is e.g. only delivering 5V 0.5A. Check the avg battery current if
available for more accurate status reporting.

Cc: James <kernel@madingley.org>
Suggested-by: James <kernel@madingley.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/max17042_battery.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 5b556a13f517..102b3f71e9a4 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -123,6 +123,8 @@ static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
 static int max17042_get_status(struct max17042_chip *chip, int *status)
 {
 	int ret, charge_full, charge_now;
+	int avg_current;
+	u32 data;
 
 	ret = power_supply_am_i_supplied(chip->battery);
 	if (ret < 0) {
@@ -152,10 +154,31 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
 	if (ret < 0)
 		return ret;
 
-	if ((charge_full - charge_now) <= MAX17042_FULL_THRESHOLD)
+	if ((charge_full - charge_now) <= MAX17042_FULL_THRESHOLD) {
 		*status = POWER_SUPPLY_STATUS_FULL;
-	else
+		return 0;
+	}
+
+	/*
+	 * Even though we are supplied, we may still be discharging if the
+	 * supply is e.g. only delivering 5V 0.5A. Check current if available.
+	 */
+	if (!chip->pdata->enable_current_sense) {
+		*status = POWER_SUPPLY_STATUS_CHARGING;
+		return 0;
+	}
+
+	ret = regmap_read(chip->regmap, MAX17042_AvgCurrent, &data);
+	if (ret < 0)
+		return ret;
+
+	avg_current = sign_extend32(data, 15);
+	avg_current *= 1562500 / chip->pdata->r_sns;
+
+	if (avg_current > 0)
 		*status = POWER_SUPPLY_STATUS_CHARGING;
+	else
+		*status = POWER_SUPPLY_STATUS_DISCHARGING;
 
 	return 0;
 }
-- 
2.14.3

From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 14/16] power: supply: axp288_fuel_gauge: Optimize get_current()
Date: Tue, 26 Dec 2017 13:59:12 +0100
Message-ID: <20171226125914.10235-14-hdegoede@redhat.com>
References: <20171226125914.10235-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750953AbdLZM7c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Dec 2017 07:59:32 -0500
In-Reply-To: <20171226125914.10235-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

First check the discharge current, and when that is non 0 use that without
also checking the charge current (which will be 0 then). This makes
get_current() do only 1 i2c read instead of 2 when on battery.

This is esp. important given the pmic i2c bus mutex stuff used on boards
with an axp288 because the SoC's own punit also may access the axp288,
which makes i2c accesses more expensive then normal.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new patch in v2 of this patch-set
---
 drivers/power/supply/axp288_fuel_gauge.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index c0b5e40b23e1..e0f3965b6964 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -386,24 +386,19 @@ static int fuel_gauge_get_vbatt(struct axp288_fg_info *info, int *vbatt)
 
 static int fuel_gauge_get_current(struct axp288_fg_info *info, int *cur)
 {
-	int ret, value = 0;
-	int charge, discharge;
+	int ret, discharge;
 
-	ret = iio_read_channel_raw(info->iio_channel[BAT_CHRG_CURR], &charge);
-	if (ret < 0)
-		goto current_read_fail;
+	/* First check discharge current, so that we do only 1 read on bat. */
 	ret = iio_read_channel_raw(info->iio_channel[BAT_D_CURR], &discharge);
 	if (ret < 0)
-		goto current_read_fail;
+		return ret;
 
-	if (charge > 0)
-		value = charge;
-	else if (discharge > 0)
-		value = -1 * discharge;
+	if (discharge > 0) {
+		*cur = -1 * discharge;
+		return 0;
+	}
 
-	*cur = value;
-current_read_fail:
-	return ret;
+	return iio_read_channel_raw(info->iio_channel[BAT_CHRG_CURR], cur);
 }
 
 static int fuel_gauge_get_vocv(struct axp288_fg_info *info, int *vocv)
-- 
2.14.3

From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 13/16] power: supply: axp288_fuel_gauge: Cache charge_full value
Date: Fri, 22 Dec 2017 13:37:51 +0100
Message-ID: <20171222123754.9622-13-hdegoede@redhat.com>
References: <20171222123754.9622-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755761AbdLVMiO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Dec 2017 07:38:14 -0500
In-Reply-To: <20171222123754.9622-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

The charge_full value never changes on the axp288 (there is no
charge_full_design), so we can read it once and cache it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index eb60f75f00d7..800abecef45c 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -120,6 +120,7 @@ struct axp288_fg_info {
 	struct power_supply *bat;
 	struct mutex lock;
 	int status;
+	int charge_full_raw;
 	int max_volt;
 	struct delayed_work status_monitor;
 	struct dentry *debug_file;
@@ -504,11 +505,7 @@ static int fuel_gauge_get_property(struct power_supply *ps,
 		val->intval = ret * FG_DES_CAP_RES_LSB;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
-		ret = fuel_gauge_read_15bit_word(info, AXP288_FG_DES_CAP1_REG);
-		if (ret < 0)
-			goto fuel_gauge_read_err;
-
-		val->intval = ret * FG_DES_CAP_RES_LSB;
+		val->intval = info->charge_full_raw * FG_DES_CAP_RES_LSB;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 		val->intval = PROP_VOLT(info->max_volt);
@@ -732,15 +729,15 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP1_REG);
-	if (ret < 0)
-		goto out_free_iio_chan;
-
-	if (!(ret & FG_DES_CAP1_VALID)) {
-		dev_err(&pdev->dev, "axp288 not configured by firmware\n");
-		ret = -ENODEV;
+	ret = fuel_gauge_read_15bit_word(info, AXP288_FG_DES_CAP1_REG);
+	if (ret < 0) {
+		if (ret == -ENXIO) {
+			dev_err(&pdev->dev, "axp288 not configured by firmware\n");
+			ret = -ENODEV;
+		}
 		goto out_free_iio_chan;
 	}
+	info->charge_full_raw = ret;
 
 	ret = fuel_gauge_reg_readb(info, AXP20X_CHRG_CTRL1);
 	if (ret < 0)
-- 
2.14.3

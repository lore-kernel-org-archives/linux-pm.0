From: Marek Belisko <marek.belisko@open-nandra.com>
Subject: [RFC PATCH 5/5] power: generic-adc-battery: Add capacity handling
Date: Tue,  1 Aug 2017 22:55:26 +0200
Message-ID: <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, pavel@ucw.cz, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Marek Belisko <marek.belisko@gmail.com>

Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
---
 drivers/power/supply/generic-adc-battery.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 0d27b59..9ce51d2 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -24,6 +24,7 @@
 #include <linux/iio/types.h>
 #include <linux/power/generic-adc-battery.h>
 #include <linux/of_gpio.h>
+#include <linux/power/generic-fuel-gauge.h>
 
 #define JITTER_DEFAULT 10 /* hope 10ms is enough */
 
@@ -81,6 +82,7 @@ static const enum power_supply_property gab_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_CAPACITY,
 };
 
 /*
@@ -202,6 +204,18 @@ static int gab_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = bat_info->name;
 		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		{
+		int ret, curr, voltage;
+
+		ret = read_channel(adc_bat, POWER_SUPPLY_PROP_CURRENT_NOW, &curr);
+		ret |= read_channel(adc_bat, POWER_SUPPLY_PROP_VOLTAGE_NOW, &voltage);
+		if (ret < 0)
+			goto err;
+
+		val->intval = fuel_level_LiIon(voltage, curr, 10);
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.7.4

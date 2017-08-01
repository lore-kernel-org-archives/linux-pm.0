From: Marek Belisko <marek.belisko@open-nandra.com>
Subject: [RFC PATCH 3/5] power/generic-adc-battery: Add support for temperature and add check for charge from iio current channel
Date: Tue,  1 Aug 2017 22:55:24 +0200
Message-ID: <1501620926-22669-4-git-send-email-marek.belisko@open-nandra.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, pavel@ucw.cz, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Marek Belisko <marek.belisko@gmail.com>

Status reporting not working yet. During boot when workqueue is called status
is updated (by reading iio current channel but value is -705 (reason unknown as later
report correct value).

Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
---
 drivers/power/supply/generic-adc-battery.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index d4daa6a..0d27b59 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -31,6 +31,7 @@ enum gab_chan_type {
 	GAB_VOLTAGE = 0,
 	GAB_CURRENT,
 	GAB_POWER,
+	GAB_TEMPERATURE,
 	GAB_MAX_CHAN_TYPE
 };
 
@@ -41,7 +42,8 @@ enum gab_chan_type {
 static const char *const gab_chan_name[] = {
 	[GAB_VOLTAGE]	= "voltage",
 	[GAB_CURRENT]	= "current",
-	[GAB_POWER]		= "power",
+	[GAB_POWER]	= "power",
+	[GAB_TEMPERATURE] = "temperature",
 };
 
 struct gab {
@@ -78,6 +80,7 @@ static const enum power_supply_property gab_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
 	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_TEMP,
 };
 
 /*
@@ -123,6 +126,8 @@ static enum gab_chan_type gab_prop_to_chan(enum power_supply_property psp)
 		return GAB_VOLTAGE;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		return GAB_CURRENT;
+	case POWER_SUPPLY_PROP_TEMP:
+		return GAB_TEMPERATURE;
 	default:
 		WARN_ON(1);
 		break;
@@ -176,6 +181,7 @@ static int gab_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
+	case POWER_SUPPLY_PROP_TEMP:
 		ret = read_channel(adc_bat, psp, &result);
 		if (ret < 0)
 			goto err;
@@ -210,13 +216,19 @@ static void gab_work(struct work_struct *work)
 	struct delayed_work *delayed_work;
 	bool is_plugged;
 	int status;
+	int ret, iio_charge;
 
 	delayed_work = to_delayed_work(work);
 	adc_bat = container_of(delayed_work, struct gab, bat_work);
 	pdata = adc_bat->pdata;
 	status = adc_bat->status;
-
-	is_plugged = power_supply_am_i_supplied(adc_bat->psy);
+	ret = read_channel(adc_bat, POWER_SUPPLY_PROP_CURRENT_NOW, &iio_charge);
+	if (ret < 0) {
+		pr_info("Cannot read current channel, ret:%d\n", ret);
+		iio_charge = 0;
+	} else
+		pr_info("iio_charge:%d\n", iio_charge);
+	is_plugged = power_supply_am_i_supplied(adc_bat->psy) || (iio_charge > 0);
 	adc_bat->cable_plugged = is_plugged;
 
 	if (!is_plugged)
-- 
2.7.4

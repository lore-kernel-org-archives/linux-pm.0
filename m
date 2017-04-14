From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 06/14] power: max17042_battery: Add support for the STATUS property
Date: Fri, 14 Apr 2017 20:32:51 +0200
Message-ID: <20170414183259.24382-6-hdegoede@redhat.com>
References: <20170414183259.24382-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752912AbdDNSdJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 14:33:09 -0400
In-Reply-To: <20170414183259.24382-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

Userspace prefers the driver having a status property over having to guess
itself. Specifically this will properly make the GNOME3 UI (and likely
others) properly show discharging / charging / full status, instead
of always showing discharging as status.

Note that in the case there is no charger driver supplying the max17042,
then a status of unknown will get returned. At least upower treats
this the same as not having a status attribute, so in this case nothing
changes from a userspace pov.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Move MAX17042_FULL_THRESHOLD define to max17042.h
---
 drivers/power/supply/max17042_battery.c | 46 +++++++++++++++++++++++++++++++++
 include/linux/power/max17042_battery.h  |  3 +++
 2 files changed, 49 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 3249eb0..13909eb 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -76,6 +76,7 @@ struct max17042_chip {
 };
 
 static enum power_supply_property max17042_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX,
@@ -113,6 +114,46 @@ static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
 	return 0;
 }
 
+static int max17042_get_status(struct max17042_chip *chip, int *status)
+{
+	int ret, charge_full, charge_now;
+
+	ret = power_supply_am_i_supplied(chip->battery);
+	if (ret < 0) {
+		*status = POWER_SUPPLY_STATUS_UNKNOWN;
+		return 0;
+	}
+	if (ret == 0) {
+		*status = POWER_SUPPLY_STATUS_DISCHARGING;
+		return 0;
+	}
+
+	/*
+	 * The MAX170xx has builtin end-of-charge detection and will update
+	 * FullCAP to match RepCap when it detects end of charging.
+	 *
+	 * When this cycle the battery gets charged to a higher (calculated)
+	 * capacity then the previous cycle then FullCAP will get updated
+	 * contineously once end-of-charge detection kicks in, so allow the
+	 * 2 to differ a bit.
+	 */
+
+	ret = regmap_read(chip->regmap, MAX17042_FullCAP, &charge_full);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(chip->regmap, MAX17042_RepCap, &charge_now);
+	if (ret < 0)
+		return ret;
+
+	if ((charge_full - charge_now) <= MAX17042_FULL_THRESHOLD)
+		*status = POWER_SUPPLY_STATUS_FULL;
+	else
+		*status = POWER_SUPPLY_STATUS_CHARGING;
+
+	return 0;
+}
+
 static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 {
 	int temp, vavg, vbatt, ret;
@@ -182,6 +223,11 @@ static int max17042_get_property(struct power_supply *psy,
 		return -EAGAIN;
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = max17042_get_status(chip, &val->intval);
+		if (ret < 0)
+			return ret;
+		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		ret = regmap_read(map, MAX17042_STATUS, &data);
 		if (ret < 0)
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 3489fb0..a7ed29b 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -31,6 +31,9 @@
 #define MAX17042_DEFAULT_TEMP_MIN	(0)    /* For sys without temp sensor */
 #define MAX17042_DEFAULT_TEMP_MAX	(700)  /* 70 degrees Celcius */
 
+/* Consider RepCap which is less then 10 units below FullCAP full */
+#define MAX17042_FULL_THRESHOLD		10
+
 #define MAX17042_CHARACTERIZATION_DATA_SIZE 48
 
 enum max17042_register {
-- 
2.9.3

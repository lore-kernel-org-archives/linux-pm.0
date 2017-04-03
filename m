From: David Lechner <david@lechnology.com>
Subject: [PATCH] power: supply: sysfs: parse string as enum when writing property
Date: Mon,  3 Apr 2017 14:52:57 -0500
Message-ID: <1491249177-8945-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This fixes the TODO to parse strings and convert them to enum values
when writing to a power_supply class property sysfs attribute.

There is at least one driver that has a writable enum property that
previously could only be written as an integer, so a fallback to writing
enums as integers instead of strings is provided so we don't break existing
userspace programs.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/power/supply/power_supply_sysfs.c | 124 ++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 39 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bcde8d1..b2002b4 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -40,35 +40,42 @@
 
 static struct device_attribute power_supply_attrs[];
 
+static const char * const power_supply_type_text[] = {
+	"Unknown", "Battery", "UPS", "Mains", "USB",
+	"USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
+	"USB_PD", "USB_PD_DRP"
+};
+
+static const char * const power_supply_status_text[] = {
+	"Unknown", "Charging", "Discharging", "Not charging", "Full"
+};
+
+static const char * const power_supply_charge_type_text[] = {
+	"Unknown", "N/A", "Trickle", "Fast"
+};
+
+static const char * const power_supply_health_text[] = {
+	"Unknown", "Good", "Overheat", "Dead", "Over voltage",
+	"Unspecified failure", "Cold", "Watchdog timer expire",
+	"Safety timer expire"
+};
+
+static const char * const power_supply_technology_text[] = {
+	"Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe", "NiCd",
+	"LiMn"
+};
+
+static const char * const power_supply_capacity_level_text[] = {
+	"Unknown", "Critical", "Low", "Normal", "High", "Full"
+};
+
+static const char * const power_supply_scope_text[] = {
+	"Unknown", "System", "Device"
+};
+
 static ssize_t power_supply_show_property(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf) {
-	static char *type_text[] = {
-		"Unknown", "Battery", "UPS", "Mains", "USB",
-		"USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
-		"USB_PD", "USB_PD_DRP"
-	};
-	static char *status_text[] = {
-		"Unknown", "Charging", "Discharging", "Not charging", "Full"
-	};
-	static char *charge_type[] = {
-		"Unknown", "N/A", "Trickle", "Fast"
-	};
-	static char *health_text[] = {
-		"Unknown", "Good", "Overheat", "Dead", "Over voltage",
-		"Unspecified failure", "Cold", "Watchdog timer expire",
-		"Safety timer expire"
-	};
-	static char *technology_text[] = {
-		"Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe", "NiCd",
-		"LiMn"
-	};
-	static char *capacity_level_text[] = {
-		"Unknown", "Critical", "Low", "Normal", "High", "Full"
-	};
-	static char *scope_text[] = {
-		"Unknown", "System", "Device"
-	};
 	ssize_t ret = 0;
 	struct power_supply *psy = dev_get_drvdata(dev);
 	const ptrdiff_t off = attr - power_supply_attrs;
@@ -91,19 +98,26 @@ static ssize_t power_supply_show_property(struct device *dev,
 	}
 
 	if (off == POWER_SUPPLY_PROP_STATUS)
-		return sprintf(buf, "%s\n", status_text[value.intval]);
+		return sprintf(buf, "%s\n",
+			       power_supply_status_text[value.intval]);
 	else if (off == POWER_SUPPLY_PROP_CHARGE_TYPE)
-		return sprintf(buf, "%s\n", charge_type[value.intval]);
+		return sprintf(buf, "%s\n",
+			       power_supply_charge_type_text[value.intval]);
 	else if (off == POWER_SUPPLY_PROP_HEALTH)
-		return sprintf(buf, "%s\n", health_text[value.intval]);
+		return sprintf(buf, "%s\n",
+			       power_supply_health_text[value.intval]);
 	else if (off == POWER_SUPPLY_PROP_TECHNOLOGY)
-		return sprintf(buf, "%s\n", technology_text[value.intval]);
+		return sprintf(buf, "%s\n",
+			       power_supply_technology_text[value.intval]);
 	else if (off == POWER_SUPPLY_PROP_CAPACITY_LEVEL)
-		return sprintf(buf, "%s\n", capacity_level_text[value.intval]);
+		return sprintf(buf, "%s\n",
+			       power_supply_capacity_level_text[value.intval]);
 	else if (off == POWER_SUPPLY_PROP_TYPE)
-		return sprintf(buf, "%s\n", type_text[value.intval]);
+		return sprintf(buf, "%s\n",
+			       power_supply_type_text[value.intval]);
 	else if (off == POWER_SUPPLY_PROP_SCOPE)
-		return sprintf(buf, "%s\n", scope_text[value.intval]);
+		return sprintf(buf, "%s\n",
+			       power_supply_scope_text[value.intval]);
 	else if (off >= POWER_SUPPLY_PROP_MODEL_NAME)
 		return sprintf(buf, "%s\n", value.strval);
 
@@ -117,14 +131,46 @@ static ssize_t power_supply_store_property(struct device *dev,
 	struct power_supply *psy = dev_get_drvdata(dev);
 	const ptrdiff_t off = attr - power_supply_attrs;
 	union power_supply_propval value;
-	long long_val;
 
-	/* TODO: support other types than int */
-	ret = kstrtol(buf, 10, &long_val);
-	if (ret < 0)
-		return ret;
+	/* maybe it is a enum property? */
+	switch (off) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = sysfs_match_string(power_supply_status_text, buf);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		ret = sysfs_match_string(power_supply_charge_type_text, buf);
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret = sysfs_match_string(power_supply_health_text, buf);
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		ret = sysfs_match_string(power_supply_technology_text, buf);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+		ret = sysfs_match_string(power_supply_capacity_level_text, buf);
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		ret = sysfs_match_string(power_supply_scope_text, buf);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	/*
+	 * If no match was found, then check to see if it is an integer.
+	 * Integer values are valid for enums in addition to the text value.
+	 */
+	if (ret < 0) {
+		long long_val;
+
+		ret = kstrtol(buf, 10, &long_val);
+		if (ret < 0)
+			return ret;
+
+		ret = long_val;
+	}
 
-	value.intval = long_val;
+	value.intval = ret;
 
 	ret = power_supply_set_property(psy, off, &value);
 	if (ret < 0)
-- 
2.7.4

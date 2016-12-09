From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 03/11] power: supply: axp20x_usb_power: set min voltage and max current from sysfs
Date: Fri,  9 Dec 2016 12:04:11 +0100
Message-ID: <20161209110419.28981-4-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com
List-Id: linux-pm@vger.kernel.org

AXP20X and AXP22X PMICs allow setting the min voltage and max current of
VBUS power supply. This adds entries in sysfs to allow to do so.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v2:
 - moving defines from header mfd/axp20x.h to the driver,
 - adding two functions to reduce indentation in axp20x_usb_power_set_property,
 - adding new define for VBUS register VHOLD bits offset,
 - switching return values in case of invalid value from 0 to -EINVAL,

 drivers/power/supply/axp20x_usb_power.c | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 8985646..9e3f4ae 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -31,6 +31,8 @@
 #define AXP20X_USB_STATUS_VBUS_VALID	BIT(2)
 
 #define AXP20X_VBUS_VHOLD_uV(b)		(4000000 + (((b) >> 3) & 7) * 100000)
+#define AXP20X_VBUS_VHOLD_MASK		GENMASK(5, 3)
+#define AXP20X_VBUS_VHOLD_OFFSET	3
 #define AXP20X_VBUS_CLIMIT_MASK		3
 #define AXP20X_VBUC_CLIMIT_900mA	0
 #define AXP20X_VBUC_CLIMIT_500mA	1
@@ -155,6 +157,81 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
+					    int intval)
+{
+	int val;
+
+	switch (intval) {
+	case 4000000:
+	case 4100000:
+	case 4200000:
+	case 4300000:
+	case 4400000:
+	case 4500000:
+	case 4600000:
+	case 4700000:
+		val = (intval - 4000000) / 100000;
+		return regmap_update_bits(power->regmap,
+					  AXP20X_VBUS_IPSOUT_MGMT,
+					  AXP20X_VBUS_VHOLD_MASK,
+					  val << AXP20X_VBUS_VHOLD_OFFSET);
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int axp20x_usb_power_set_current_max(struct axp20x_usb_power *power,
+					    int intval)
+{
+	int val;
+
+	switch (intval) {
+	case 100000:
+		if (power->axp20x_id == AXP221_ID)
+			return -EINVAL;
+	case 500000:
+	case 900000:
+		val = (900000 - intval) / 400000;
+		return regmap_update_bits(power->regmap,
+					  AXP20X_VBUS_IPSOUT_MGMT,
+					  AXP20X_VBUS_CLIMIT_MASK, val);
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int axp20x_usb_power_set_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 const union power_supply_propval *val)
+{
+	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		return axp20x_usb_power_set_voltage_min(power, val->intval);
+
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		return axp20x_usb_power_set_current_max(power, val->intval);
+
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
+					   enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
+	       psp == POWER_SUPPLY_PROP_CURRENT_MAX;
+}
+
 static enum power_supply_property axp20x_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -178,7 +255,9 @@ static const struct power_supply_desc axp20x_usb_power_desc = {
 	.type = POWER_SUPPLY_TYPE_USB,
 	.properties = axp20x_usb_power_properties,
 	.num_properties = ARRAY_SIZE(axp20x_usb_power_properties),
+	.property_is_writeable = axp20x_usb_power_prop_writeable,
 	.get_property = axp20x_usb_power_get_property,
+	.set_property = axp20x_usb_power_set_property,
 };
 
 static const struct power_supply_desc axp22x_usb_power_desc = {
@@ -186,7 +265,9 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
 	.type = POWER_SUPPLY_TYPE_USB,
 	.properties = axp22x_usb_power_properties,
 	.num_properties = ARRAY_SIZE(axp22x_usb_power_properties),
+	.property_is_writeable = axp20x_usb_power_prop_writeable,
 	.get_property = axp20x_usb_power_get_property,
+	.set_property = axp20x_usb_power_set_property,
 };
 
 static int axp20x_usb_power_probe(struct platform_device *pdev)
-- 
2.9.3

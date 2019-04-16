From: Chen-Yu Tsai <wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 5/7] power: supply: axp20x_usb_power: add
 support for AXP813
Date: Tue, 16 Apr 2019 14:40:22 +0800
Message-ID: <20190416064024.20414-6-wens@kernel.org>
References: <20190416064024.20414-1-wens@kernel.org>
Reply-To: wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBY7R2XSQKGQEPUACMIQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190416064024.20414-1-wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>

This adds support for AXP813 PMIC. It is almost the same as AXP22X but
has a different current limit.

Signed-off-by: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 drivers/power/supply/axp20x_usb_power.c | 66 ++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 04c2cafbe8e6..d2b1255ee1cc 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -42,6 +42,11 @@
 #define AXP20X_VBUS_CLIMIT_100mA	2
 #define AXP20X_VBUS_CLIMIT_NONE		3
 
+#define AXP813_VBUS_CLIMIT_900mA	0
+#define AXP813_VBUS_CLIMIT_1500mA	1
+#define AXP813_VBUS_CLIMIT_2000mA	2
+#define AXP813_VBUS_CLIMIT_2500mA	3
+
 #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
 #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
 
@@ -131,6 +136,31 @@ static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
 	return 0;
 }
 
+static int axp813_get_current_max(struct axp20x_usb_power *power, int *val)
+{
+	unsigned int v;
+	int ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
+
+	if (ret)
+		return ret;
+
+	switch (v & AXP20X_VBUS_CLIMIT_MASK) {
+	case AXP813_VBUS_CLIMIT_900mA:
+		*val = 900000;
+		break;
+	case AXP813_VBUS_CLIMIT_1500mA:
+		*val = 1500000;
+		break;
+	case AXP813_VBUS_CLIMIT_2000mA:
+		*val = 2000000;
+		break;
+	case AXP813_VBUS_CLIMIT_2500mA:
+		*val = 2500000;
+		break;
+	}
+	return 0;
+}
+
 static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -169,6 +199,8 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		val->intval = ret * 1700; /* 1 step = 1.7 mV */
 		return 0;
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		if (power->axp20x_id == AXP813_ID)
+			return axp813_get_current_max(power, &val->intval);
 		return axp20x_get_current_max(power, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
@@ -260,6 +292,31 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 	return -EINVAL;
 }
 
+static int axp813_usb_power_set_current_max(struct axp20x_usb_power *power,
+					    int intval)
+{
+	int val;
+
+	switch (intval) {
+	case 900000:
+		return regmap_update_bits(power->regmap,
+					  AXP20X_VBUS_IPSOUT_MGMT,
+					  AXP20X_VBUS_CLIMIT_MASK,
+					  AXP813_VBUS_CLIMIT_900mA);
+	case 1500000:
+	case 2000000:
+	case 2500000:
+		val = (intval - 1000000) / 500000;
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
 static int axp20x_usb_power_set_current_max(struct axp20x_usb_power *power,
 					    int intval)
 {
@@ -294,6 +351,9 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 		return axp20x_usb_power_set_voltage_min(power, val->intval);
 
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		if (power->axp20x_id == AXP813_ID)
+			return axp813_usb_power_set_current_max(power,
+								val->intval);
 		return axp20x_usb_power_set_current_max(power, val->intval);
 
 	default:
@@ -429,7 +489,8 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		usb_power_desc = &axp20x_usb_power_desc;
 		irq_names = axp20x_irq_names;
 	} else if (power->axp20x_id == AXP221_ID ||
-		   power->axp20x_id == AXP223_ID) {
+		   power->axp20x_id == AXP223_ID ||
+		   power->axp20x_id == AXP813_ID) {
 		usb_power_desc = &axp22x_usb_power_desc;
 		irq_names = axp22x_irq_names;
 	} else {
@@ -488,6 +549,9 @@ static const struct of_device_id axp20x_usb_power_match[] = {
 	}, {
 		.compatible = "x-powers,axp223-usb-power-supply",
 		.data = (void *)AXP223_ID,
+	}, {
+		.compatible = "x-powers,axp813-usb-power-supply",
+		.data = (void *)AXP813_ID,
 	}, { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
-- 
2.20.1

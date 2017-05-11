From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 4/4] power: supply: axp20x_battery: add DT
 support for battery max constant charge current
Date: Thu, 11 May 2017 15:42:20 +0200
Message-ID: <20170511134221.5569-5-quentin.schulz@free-electrons.com>
References: <20170511134221.5569-1-quentin.schulz@free-electrons.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBUOU2HEAKGQEMUBGPBI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170511134221.5569-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This adds the ability to set the maximum constant charge current,
supported by the battery, delivered by this battery power supply to the
battery.

The maximum constant charge current set in DT will also set the default
constant charge current supplied by this supply.

The actual user can modify the constant charge current within the range
of 0 to maximum constant charge current via sysfs.
The user can also modify the maximum constant charge current to widen
the range of possible constant charge current. While this seems quite
risky, a message is printed on the console to warn the user this might
damage the battery. The reason for letting the user change the maximum
constant charge current is for letting users change the battery and
thus, let them adjust the maximum constant charge current according to
what the battery can support.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/power/supply/axp20x_battery.c | 78 +++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 66f530541735..7494f0f0eadb 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -60,6 +60,8 @@ struct axp20x_batt_ps {
 	struct iio_channel *batt_chrg_i;
 	struct iio_channel *batt_dischrg_i;
 	struct iio_channel *batt_v;
+	/* Maximum constant charge current */
+	unsigned int max_ccc;
 	u8 axp_id;
 };
 
@@ -129,6 +131,14 @@ static void raw_to_constant_charge_current(struct axp20x_batt_ps *axp, int *val)
 		*val = *val * 150000 + 300000;
 }
 
+static void constant_charge_current_to_raw(struct axp20x_batt_ps *axp, int *val)
+{
+	if (axp->axp_id == AXP209_ID)
+		*val = (*val - 300000) / 100000;
+	else
+		*val = (*val - 300000) / 150000;
+}
+
 static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
 					      int *val)
 {
@@ -221,9 +231,7 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
-		val->intval = AXP20X_CHRG_CTRL1_TGT_CURR;
-		raw_to_constant_charge_current(axp20x_batt, &val->intval);
-
+		val->intval = axp20x_batt->max_ccc;
 		break;
 
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
@@ -340,10 +348,10 @@ static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
 					      int charge_current)
 {
-	if (axp_batt->axp_id == AXP209_ID)
-		charge_current = (charge_current - 300000) / 100000;
-	else
-		charge_current = (charge_current - 300000) / 150000;
+	if (charge_current > axp_batt->max_ccc)
+		return -EINVAL;
+
+	constant_charge_current_to_raw(axp_batt, &charge_current);
 
 	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
 		return -EINVAL;
@@ -352,6 +360,36 @@ static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
 				  AXP20X_CHRG_CTRL1_TGT_CURR, charge_current);
 }
 
+static int axp20x_set_max_constant_charge_current(struct axp20x_batt_ps *axp,
+						  int charge_current)
+{
+	bool lower_max = false;
+
+	constant_charge_current_to_raw(axp, &charge_current);
+
+	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
+		return -EINVAL;
+
+	raw_to_constant_charge_current(axp, &charge_current);
+
+	if (charge_current > axp->max_ccc)
+		dev_warn(axp->dev,
+			 "Setting max constant charge current higher than previously defined. Note that increasing the constant charge current may damage your battery.\n");
+	else
+		lower_max = true;
+
+	axp->max_ccc = charge_current;
+
+	if (lower_max) {
+		int current_cc;
+
+		axp20x_get_constant_charge_current(axp, &current_cc);
+		if (current_cc > charge_current)
+			axp20x_set_constant_charge_current(axp, charge_current);
+	}
+
+	return 0;
+}
 static int axp20x_set_voltage_min_design(struct axp20x_batt_ps *axp_batt,
 					 int min_voltage)
 {
@@ -380,6 +418,9 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		return axp20x_set_constant_charge_current(axp20x_batt,
 							  val->intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		return axp20x_set_max_constant_charge_current(axp20x_batt,
+							      val->intval);
 
 	default:
 		return -EINVAL;
@@ -405,7 +446,8 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
 {
 	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
 	       psp == POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
-	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT;
+	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT ||
+	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
 }
 
 static const struct power_supply_desc axp20x_batt_ps_desc = {
@@ -487,13 +529,33 @@ static int axp20x_power_probe(struct platform_device *pdev)
 
 	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
 		int vmin = info.voltage_min_design_uv;
+		int ccc = info.constant_charge_current_max_ua;
 
 		if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
 							      vmin))
 			dev_err(&pdev->dev,
 				"couldn't set voltage_min_design\n");
+
+		/* Set max to unverified value to be able to set CCC */
+		axp20x_batt->max_ccc = ccc;
+
+		if (ccc <= 0 || axp20x_set_constant_charge_current(axp20x_batt,
+								   ccc)) {
+			dev_err(&pdev->dev,
+				"couldn't set constant charge current from DT: fallback to minimum value\n");
+			ccc = 300000;
+			axp20x_batt->max_ccc = ccc;
+			axp20x_set_constant_charge_current(axp20x_batt, ccc);
+		}
 	}
 
+	/*
+	 * Update max CCC to a valid value if battery info is present or set it
+	 * to current register value by default.
+	 */
+	axp20x_get_constant_charge_current(axp20x_batt,
+					   &axp20x_batt->max_ccc);
+
 	return 0;
 }
 
-- 
2.11.0

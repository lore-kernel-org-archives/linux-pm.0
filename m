From: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v5 3/6] power: supply: axp20x_battery: use data
 struct for variant specific code
Date: Wed, 28 Feb 2018 11:35:58 +0100
Message-ID: <c157320cf4c443e6904346c9072f46e713498161.1519813976.git-series.quentin.schulz@bootlin.com>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
Reply-To: quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBQMM3LKAKGQEKPR2H4Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
In-Reply-To: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
Cc: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.petazzoni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

We used to use IDs to select a function or a feature depending on the
variant. It's easier to maintain the code by adding data structure
storing the few differences between variants so that we don't add a pile
of if conditions.

Let's use this data structure and update the code to use it.

Signed-off-by: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 drivers/power/supply/axp20x_battery.c | 100 +++++++++++++++++----------
 1 file changed, 66 insertions(+), 34 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 7494f0f..04a0d91 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -53,6 +53,16 @@
 
 #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
 
+struct axp20x_batt_ps;
+
+struct axp_data {
+	int	ccc_scale;
+	int	ccc_offset;
+	bool	has_fg_valid;
+	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
+	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
+};
+
 struct axp20x_batt_ps {
 	struct regmap *regmap;
 	struct power_supply *batt;
@@ -62,7 +72,7 @@ struct axp20x_batt_ps {
 	struct iio_channel *batt_v;
 	/* Maximum constant charge current */
 	unsigned int max_ccc;
-	u8 axp_id;
+	const struct axp_data	*data;
 };
 
 static int axp20x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
@@ -123,22 +133,6 @@ static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 	return 0;
 }
 
-static void raw_to_constant_charge_current(struct axp20x_batt_ps *axp, int *val)
-{
-	if (axp->axp_id == AXP209_ID)
-		*val = *val * 100000 + 300000;
-	else
-		*val = *val * 150000 + 300000;
-}
-
-static void constant_charge_current_to_raw(struct axp20x_batt_ps *axp, int *val)
-{
-	if (axp->axp_id == AXP209_ID)
-		*val = (*val - 300000) / 100000;
-	else
-		*val = (*val - 300000) / 150000;
-}
-
 static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
 					      int *val)
 {
@@ -150,7 +144,7 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
 
 	*val &= AXP20X_CHRG_CTRL1_TGT_CURR;
 
-	raw_to_constant_charge_current(axp, val);
+	*val = *val * axp->data->ccc_scale + axp->data->ccc_offset;
 
 	return 0;
 }
@@ -269,8 +263,7 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 		if (ret)
 			return ret;
 
-		if (axp20x_batt->axp_id == AXP221_ID &&
-		    !(reg & AXP22X_FG_VALID))
+		if (axp20x_batt->data->has_fg_valid && !(reg & AXP22X_FG_VALID))
 			return -EINVAL;
 
 		/*
@@ -281,11 +274,8 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
-		if (axp20x_batt->axp_id == AXP209_ID)
-			return axp20x_battery_get_max_voltage(axp20x_batt,
-							      &val->intval);
-		return axp22x_battery_get_max_voltage(axp20x_batt,
-						      &val->intval);
+		return axp20x_batt->data->get_max_voltage(axp20x_batt,
+							  &val->intval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		ret = regmap_read(axp20x_batt->regmap, AXP20X_V_OFF, &reg);
@@ -312,6 +302,32 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 	return 0;
 }
 
+static int axp22x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
+					  int val)
+{
+	switch (val) {
+	case 4100000:
+		val = AXP20X_CHRG_CTRL1_TGT_4_1V;
+		break;
+
+	case 4200000:
+		val = AXP20X_CHRG_CTRL1_TGT_4_2V;
+		break;
+
+	default:
+		/*
+		 * AXP20x max voltage can be set to 4.36V and AXP22X max voltage
+		 * can be set to 4.22V and 4.24V, but these voltages are too
+		 * high for Lithium based batteries (AXP PMICs are supposed to
+		 * be used with these kinds of battery).
+		 */
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
+				  AXP20X_CHRG_CTRL1_TGT_VOLT, val);
+}
+
 static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 					  int val)
 {
@@ -321,9 +337,6 @@ static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 		break;
 
 	case 4150000:
-		if (axp20x_batt->axp_id == AXP221_ID)
-			return -EINVAL;
-
 		val = AXP20X_CHRG_CTRL1_TGT_4_15V;
 		break;
 
@@ -351,7 +364,8 @@ static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
 	if (charge_current > axp_batt->max_ccc)
 		return -EINVAL;
 
-	constant_charge_current_to_raw(axp_batt, &charge_current);
+	charge_current = (charge_current - axp_batt->data->ccc_offset) /
+		axp_batt->data->ccc_scale;
 
 	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
 		return -EINVAL;
@@ -365,12 +379,14 @@ static int axp20x_set_max_constant_charge_current(struct axp20x_batt_ps *axp,
 {
 	bool lower_max = false;
 
-	constant_charge_current_to_raw(axp, &charge_current);
+	charge_current = (charge_current - axp->data->ccc_offset) /
+		axp->data->ccc_scale;
 
 	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
 		return -EINVAL;
 
-	raw_to_constant_charge_current(axp, &charge_current);
+	charge_current = charge_current * axp->data->ccc_scale +
+		axp->data->ccc_offset;
 
 	if (charge_current > axp->max_ccc)
 		dev_warn(axp->dev,
@@ -460,13 +476,28 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
 	.set_property = axp20x_battery_set_prop,
 };
 
+static const struct axp_data axp209_data = {
+	.ccc_scale = 100000,
+	.ccc_offset = 300000,
+	.get_max_voltage = axp20x_battery_get_max_voltage,
+	.set_max_voltage = axp20x_battery_set_max_voltage,
+};
+
+static const struct axp_data axp221_data = {
+	.ccc_scale = 150000,
+	.ccc_offset = 300000,
+	.has_fg_valid = true,
+	.get_max_voltage = axp22x_battery_get_max_voltage,
+	.set_max_voltage = axp22x_battery_set_max_voltage,
+};
+
 static const struct of_device_id axp20x_battery_ps_id[] = {
 	{
 		.compatible = "x-powers,axp209-battery-power-supply",
-		.data = (void *)AXP209_ID,
+		.data = (void *)&axp209_data,
 	}, {
 		.compatible = "x-powers,axp221-battery-power-supply",
-		.data = (void *)AXP221_ID,
+		.data = (void *)&axp221_data,
 	}, { /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
@@ -476,6 +507,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	struct axp20x_batt_ps *axp20x_batt;
 	struct power_supply_config psy_cfg = {};
 	struct power_supply_battery_info info;
+	struct device *dev = &pdev->dev;
 
 	if (!of_device_is_available(pdev->dev.of_node))
 		return -ENODEV;
@@ -516,7 +548,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	psy_cfg.drv_data = axp20x_batt;
 	psy_cfg.of_node = pdev->dev.of_node;
 
-	axp20x_batt->axp_id = (uintptr_t)of_device_get_match_data(&pdev->dev);
+	axp20x_batt->data = (struct axp_data *)of_device_get_match_data(dev);
 
 	axp20x_batt->batt = devm_power_supply_register(&pdev->dev,
 						       &axp20x_batt_ps_desc,
-- 
git-series 0.9.1

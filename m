From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 10/16] power: supply: axp20x_battery: use
 data structure instead of ID for
Date: Mon, 15 Jan 2018 11:33:44 +0100
Message-ID: <c4129842e1254289ebb3ad1755879a3722bac1cf.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBXUH6LJAKGQEFZRY4HQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
In-Reply-To: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

variant specific code

We used to use IDs to select a function or a feature depending on the
variant. It's easier to maintain the code by adding data structure
storing the few differences between variants so that we don't add a pile
of if conditions.

Let's use this data structure and update the code to use it.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/power/supply/axp20x_battery.c | 100 +++++++++++++++++----------
 1 file changed, 66 insertions(+), 34 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 7494f0f..d73c78f 100644
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
+	struct axp_data	*data;
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
 
+struct axp_data axp209_data = {
+	.ccc_scale = 100000,
+	.ccc_offset = 300000,
+	.get_max_voltage = axp20x_battery_get_max_voltage,
+	.set_max_voltage = axp20x_battery_set_max_voltage,
+};
+
+struct axp_data axp221_data = {
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

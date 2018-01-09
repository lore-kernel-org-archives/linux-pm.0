From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 13/16] power: supply: axp20x_battery: add
 support for AXP813
Date: Tue,  9 Jan 2018 10:33:44 +0100
Message-ID: <a1c061eb50edfd3519ece6c8177085b55d7aefc6.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBT4Z2LJAKGQEFKNICPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The X-Powers AXP813 PMIC has got some slight differences from
AXP20X/AXP22X PMICs:
 - the maximum voltage supplied by the PMIC is 4.35 instead of 4.36/4.24
 for AXP20X/AXP22X,
 - the constant charge current formula is different,

It also has a bit to tell whether the battery percentage returned by the
PMIC is valid.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/power/supply/axp20x_battery.c | 42 ++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index d73c78f..dad72a5 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -46,6 +46,8 @@
 #define AXP20X_CHRG_CTRL1_TGT_4_2V	(2 << 5)
 #define AXP20X_CHRG_CTRL1_TGT_4_36V	(3 << 5)
 
+#define AXP813_CHRG_CTRL1_TGT_4_35V	(3 << 5)
+
 #define AXP22X_CHRG_CTRL1_TGT_4_22V	(1 << 5)
 #define AXP22X_CHRG_CTRL1_TGT_4_24V	(3 << 5)
 
@@ -133,6 +135,35 @@ static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 	return 0;
 }
 
+static int axp813_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
+					  int *val)
+{
+	int ret, reg;
+
+	ret = regmap_read(axp20x_batt->regmap, AXP20X_CHRG_CTRL1, &reg);
+	if (ret)
+		return ret;
+
+	switch (reg & AXP20X_CHRG_CTRL1_TGT_VOLT) {
+	case AXP20X_CHRG_CTRL1_TGT_4_1V:
+		*val = 4100000;
+		break;
+	case AXP20X_CHRG_CTRL1_TGT_4_15V:
+		*val = 4150000;
+		break;
+	case AXP20X_CHRG_CTRL1_TGT_4_2V:
+		*val = 4200000;
+		break;
+	case AXP813_CHRG_CTRL1_TGT_4_35V:
+		*val = 4350000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
 					      int *val)
 {
@@ -491,6 +522,14 @@ struct axp_data axp221_data = {
 	.set_max_voltage = axp22x_battery_set_max_voltage,
 };
 
+struct axp_data axp813_data = {
+	.ccc_scale = 200000,
+	.ccc_offset = 200000,
+	.has_fg_valid = true,
+	.get_max_voltage = axp813_battery_get_max_voltage,
+	.set_max_voltage = axp20x_battery_set_max_voltage,
+};
+
 static const struct of_device_id axp20x_battery_ps_id[] = {
 	{
 		.compatible = "x-powers,axp209-battery-power-supply",
@@ -498,6 +537,9 @@ static const struct of_device_id axp20x_battery_ps_id[] = {
 	}, {
 		.compatible = "x-powers,axp221-battery-power-supply",
 		.data = (void *)&axp221_data,
+	}, {
+		.compatible = "x-powers,axp813-battery-power-supply",
+		.data = (void *)&axp813_data,
 	}, { /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
-- 
git-series 0.9.1

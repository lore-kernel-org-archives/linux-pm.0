From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: [PATCH v5 2/2] power: qcom_smbb: Add otg regulator for control of vbus
Date: Mon, 17 Oct 2016 17:42:51 -0700
Message-ID: <20161018004251.28733-3-stephen.boyd@linaro.org>
References: <20161018004251.28733-1-stephen.boyd@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20161018004251.28733-1-stephen.boyd@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Bird, Tim" <Tim.Bird@sonymobile.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, Tim Bird <tim.bird@sonymobile.com>
List-Id: linux-pm@vger.kernel.org

From: "Bird, Tim" <Tim.Bird@sonymobile.com>

Add a regulator to control the OTG chargepath switch.  This
is used by USB code to control VBUS direction - out for host mode
on the OTG port, and in for charging mode.

Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
[stephen.boyd@linaro.org: Fix supply name, constify ops, drop
machine.h and of_regulator.h includes]
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/power/supply/qcom_smbb.c | 70 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
index b5896ba2a602..5bdde6108c12 100644
--- a/drivers/power/supply/qcom_smbb.c
+++ b/drivers/power/supply/qcom_smbb.c
@@ -35,6 +35,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/extcon.h>
+#include <linux/regulator/driver.h>
 
 #define SMBB_CHG_VMAX		0x040
 #define SMBB_CHG_VSAFE		0x041
@@ -72,6 +73,8 @@
 #define BTC_CTRL_HOT_EXT_N	BIT(0)
 
 #define SMBB_USB_IMAX		0x344
+#define SMBB_USB_OTG_CTL	0x348
+#define OTG_CTL_EN		BIT(0)
 #define SMBB_USB_ENUM_TIMER_STOP 0x34e
 #define ENUM_TIMER_STOP		BIT(0)
 #define SMBB_USB_SEC_ACCESS	0x3d0
@@ -125,6 +128,9 @@ struct smbb_charger {
 	struct power_supply *dc_psy;
 	struct power_supply *bat_psy;
 	struct regmap *regmap;
+
+	struct regulator_desc otg_rdesc;
+	struct regulator_dev *otg_reg;
 };
 
 static const unsigned int smbb_usb_extcon_cable[] = {
@@ -787,12 +793,56 @@ static const struct power_supply_desc dc_psy_desc = {
 	.property_is_writeable = smbb_charger_writable_property,
 };
 
+static int smbb_chg_otg_enable(struct regulator_dev *rdev)
+{
+	struct smbb_charger *chg = rdev_get_drvdata(rdev);
+	int rc;
+
+	rc = regmap_update_bits(chg->regmap, chg->addr + SMBB_USB_OTG_CTL,
+				OTG_CTL_EN, OTG_CTL_EN);
+	if (rc)
+		dev_err(chg->dev, "failed to update OTG_CTL\n");
+	return rc;
+}
+
+static int smbb_chg_otg_disable(struct regulator_dev *rdev)
+{
+	struct smbb_charger *chg = rdev_get_drvdata(rdev);
+	int rc;
+
+	rc = regmap_update_bits(chg->regmap, chg->addr + SMBB_USB_OTG_CTL,
+				OTG_CTL_EN, 0);
+	if (rc)
+		dev_err(chg->dev, "failed to update OTG_CTL\n");
+	return rc;
+}
+
+static int smbb_chg_otg_is_enabled(struct regulator_dev *rdev)
+{
+	struct smbb_charger *chg = rdev_get_drvdata(rdev);
+	unsigned int value = 0;
+	int rc;
+
+	rc = regmap_read(chg->regmap, chg->addr + SMBB_USB_OTG_CTL, &value);
+	if (rc)
+		dev_err(chg->dev, "failed to read OTG_CTL\n");
+
+	return !!(value & OTG_CTL_EN);
+}
+
+static const struct regulator_ops smbb_chg_otg_ops = {
+	.enable = smbb_chg_otg_enable,
+	.disable = smbb_chg_otg_disable,
+	.is_enabled = smbb_chg_otg_is_enabled,
+};
+
 static int smbb_charger_probe(struct platform_device *pdev)
 {
 	struct power_supply_config bat_cfg = {};
 	struct power_supply_config usb_cfg = {};
 	struct power_supply_config dc_cfg = {};
 	struct smbb_charger *chg;
+	struct regulator_config config = { };
 	int rc, i;
 
 	chg = devm_kzalloc(&pdev->dev, sizeof(*chg), GFP_KERNEL);
@@ -905,6 +955,26 @@ static int smbb_charger_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * otg regulator is used to control VBUS voltage direction
+	 * when USB switches between host and gadget mode
+	 */
+	chg->otg_rdesc.id = -1;
+	chg->otg_rdesc.name = "otg-vbus";
+	chg->otg_rdesc.ops = &smbb_chg_otg_ops;
+	chg->otg_rdesc.owner = THIS_MODULE;
+	chg->otg_rdesc.type = REGULATOR_VOLTAGE;
+	chg->otg_rdesc.supply_name = "usb-otg-in";
+	chg->otg_rdesc.of_match = "otg-vbus";
+
+	config.dev = &pdev->dev;
+	config.driver_data = chg;
+
+	chg->otg_reg = devm_regulator_register(&pdev->dev, &chg->otg_rdesc,
+					       &config);
+	if (IS_ERR(chg->otg_reg))
+		return PTR_ERR(chg->otg_reg);
+
 	chg->jeita_ext_temp = of_property_read_bool(pdev->dev.of_node,
 			"qcom,jeita-extended-temp-range");
 
-- 
2.10.0.297.gf6727b0

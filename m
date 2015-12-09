From: Tim Bird <tim.bird@sonymobile.com>
Subject: [PATCH v2 2/3] power: qcom_smbb: Add otg regulator for control of vbus
Date: Tue, 8 Dec 2015 16:40:17 -0800
Message-ID: <1449621618-11900-2-git-send-email-tim.bird@sonymobile.com>
References: <1449621618-11900-1-git-send-email-tim.bird@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449621618-11900-1-git-send-email-tim.bird@sonymobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, agross@codeaurora.org
Cc: Bjorn.Andersson@sonymobile.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, tbird20d@gmail.com, tim.bird@sonymobile.com
List-Id: linux-pm@vger.kernel.org

Add a regulator to control the OTG chargepath switch.  This
is used by USB code to control VBUS direction - out for host mode
on the OTG port, and in for charging mode.

Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
---
Changes since v1:
 - changed name of supply to remove underscores
---
 drivers/power/qcom_smbb.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/power/qcom_smbb.c b/drivers/power/qcom_smbb.c
index 5eb1e9e..2f1394c 100644
--- a/drivers/power/qcom_smbb.c
+++ b/drivers/power/qcom_smbb.c
@@ -34,6 +34,9 @@
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
 
 #define SMBB_CHG_VMAX		0x040
 #define SMBB_CHG_VSAFE		0x041
@@ -71,6 +74,8 @@
 #define BTC_CTRL_HOT_EXT_N	BIT(0)
 
 #define SMBB_USB_IMAX		0x344
+#define SMBB_USB_OTG_CTL	0x348
+#define OTG_CTL_EN		BIT(0)
 #define SMBB_USB_ENUM_TIMER_STOP 0x34e
 #define ENUM_TIMER_STOP		BIT(0)
 #define SMBB_USB_SEC_ACCESS	0x3d0
@@ -123,6 +128,9 @@ struct smbb_charger {
 	struct power_supply *dc_psy;
 	struct power_supply *bat_psy;
 	struct regmap *regmap;
+
+	struct regulator_desc otg_rdesc;
+	struct regulator_dev *otg_reg;
 };
 
 static int smbb_vbat_weak_fn(unsigned int index)
@@ -778,12 +786,56 @@ static const struct power_supply_desc dc_psy_desc = {
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
+static struct regulator_ops smbb_chg_otg_ops = {
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
@@ -884,6 +936,28 @@ static int smbb_charger_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * otg regulator is used to control VBUS voltage direction
+	 * when USB switches between host and gadget mode
+	 */
+	chg->otg_rdesc.id = -1;
+	chg->otg_rdesc.name = "otg";
+	chg->otg_rdesc.ops = &smbb_chg_otg_ops;
+	chg->otg_rdesc.owner = THIS_MODULE;
+	chg->otg_rdesc.type = REGULATOR_VOLTAGE;
+	chg->otg_rdesc.supply_name = "usb-otg-in";
+	chg->otg_rdesc.fixed_uV = 5000000;
+	chg->otg_rdesc.n_voltages = 1;
+	chg->otg_rdesc.of_match = "otg";
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
2.4.2

From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 4/4] regulator: axp20x: Add support for the (external) drivebus regulator
Date: Thu,  2 Jun 2016 19:18:56 +0200
Message-ID: <1464887936-17020-4-git-send-email-hdegoede@redhat.com>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48840 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932168AbcFBRTG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 Jun 2016 13:19:06 -0400
In-Reply-To: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

The axp20x pmics have 2 power inputs, one called ACIN which is intended
for to be supplied via a powerbarrel on the board and one called VBUS
which is intended to be supplied via an otg connector.

In the VBUS case the pmic needs to know if the board is supplying power
to the otg connector, because then it should not take any power from
its VBUS pin. The axp209 pmic has a N_VBUSEN input pin via which the
board can signal to the pmic whether the board is supplying power to the
otg connector or not.

On the axp221/axp223 this pin can alternatively be used as an output
which controls an external regulator which (optionally) supplies
power to the otg connector from the board. When the pin is used as
output it is called DRIVEVBUS in the datasheet.

This commit adds support for the DRIVEVBUS pin as an extra pmic
controlled regulator. Since this is optional a new x-powers,drivebus dt
property is added. When this is present the misc-control register is
written to change the N_VBUSEN input pin to DRIVEVBUS output pin mode and
the extra drivebus regulator is registered with the regulator subsystem.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Rename the dt property to drive-vbus-en
-s/drivebus/drivevbus/
-Add a line describing the drivevbus regulator to the table in
 Documentation/devicetree/bindings/mfd/axp20x.txt
-Set supply_name to drivevbus-supply
---
 Documentation/devicetree/bindings/mfd/axp20x.txt |  6 +++++
 drivers/regulator/axp20x-regulator.c             | 30 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index d20b103..6aca4fe 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -22,6 +22,11 @@ Optional properties:
 		      AXP152/20X: range:  750-1875, Default: 1.5 MHz
 		      AXP22X/80X: range: 1800-4050, Default: 3   MHz
 
+- x-powers,drive-vbus-en: axp221 / axp223 only boolean, set this when the
+                  N_VBUSEN pin is used as an output pin to control an external
+                  regulator to drive the OTG VBus, rather then as an input pin
+                  which signals whether the board is driving OTG VBus or not.
+
 - <input>-supply: a phandle to the regulator supply node. May be omitted if
 		  inputs are unregulated, such as using the IPSOUT output
 		  from the PMIC.
@@ -79,6 +84,7 @@ ELDO3		: LDO		: eldoin-supply		: shared supply
 LDO_IO0		: LDO		: ips-supply		: GPIO 0
 LDO_IO1		: LDO		: ips-supply		: GPIO 1
 RTC_LDO		: LDO		: ips-supply		: always on
+DRIVEVBUS	: Enable output	: drivevbus-supply	: external regulator
 
 AXP809 regulators, type, and corresponding input supply names:
 
diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 728be64..3f1bba4 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -36,6 +36,8 @@
 
 #define AXP20X_FREQ_DCDC_MASK		0x0f
 
+#define AXP22X_MISC_N_VBUSEN_FUNC	BIT(4)
+
 #define AXP_DESC_IO(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
 		    _vmask, _ereg, _emask, _enable_val, _disable_val)		\
 	[_family##_##_id] = {							\
@@ -230,6 +232,18 @@ static const struct regulator_desc axp22x_regulators[] = {
 	AXP_DESC_FIXED(AXP22X, RTC_LDO, "rtc_ldo", "ips", 3000),
 };
 
+static const struct regulator_desc axp22x_drivevbus_regulator = {
+	.name		= "drivevbus",
+	.supply_name	= "drivevbus-supply",
+	.of_match	= of_match_ptr("drivevbus"),
+	.regulators_node = of_match_ptr("regulators"),
+	.type		= REGULATOR_VOLTAGE,
+	.owner		= THIS_MODULE,
+	.enable_reg	= AXP20X_VBUS_IPSOUT_MGMT,
+	.enable_mask	= BIT(2),
+	.ops		= &axp20x_ops_sw,
+};
+
 static const struct regulator_linear_range axp809_dcdc4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x2f, 20000),
 	REGULATOR_LINEAR_RANGE(1800000, 0x30, 0x38, 100000),
@@ -411,6 +425,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	u32 workmode;
 	const char *dcdc1_name = axp22x_regulators[AXP22X_DCDC1].name;
 	const char *dcdc5_name = axp22x_regulators[AXP22X_DCDC5].name;
+	bool drivevbus = false;
 
 	switch (axp20x->variant) {
 	case AXP202_ID:
@@ -422,6 +437,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	case AXP223_ID:
 		regulators = axp22x_regulators;
 		nregulators = AXP22X_REG_ID_MAX;
+		drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
+						  "x-powers,drive-vbus-en");
 		break;
 	case AXP809_ID:
 		regulators = axp809_regulators;
@@ -500,6 +517,19 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 						&dcdc5_name);
 	}
 
+	if (drivevbus) {
+		/* Change N_VBUSEN sense pin to DRIVEVBUS output pin */
+		regmap_update_bits(axp20x->regmap, AXP20X_OVER_TMP,
+				   AXP22X_MISC_N_VBUSEN_FUNC, 0);
+		rdev = devm_regulator_register(&pdev->dev,
+					       &axp22x_drivevbus_regulator,
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "Failed to register drivevbus\n");
+			return PTR_ERR(rdev);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.7.4


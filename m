From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v8 06/11] power: act8945a_charger: Fix the power supply type
Date: Thu, 25 Aug 2016 15:19:54 +0800
Message-ID: <1472109599-21915-7-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>
List-Id: linux-pm@vger.kernel.org

The power supply type property is varying as the external power
supply changes. It is not a constant.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/power/supply/act8945a_charger.c | 48 ++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index e129255..48775f8 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -78,6 +78,7 @@ static const char *act8945a_charger_manufacturer = "Active-semi";
 
 struct act8945a_charger {
 	struct power_supply *psy;
+	struct power_supply_desc desc;
 	struct regmap *regmap;
 	struct work_struct work;
 
@@ -250,14 +251,6 @@ static int act8945a_charger_get_property(struct power_supply *psy,
 	return ret;
 }
 
-static const struct power_supply_desc act8945a_charger_desc = {
-	.name		= "act8945a-charger",
-	.type		= POWER_SUPPLY_TYPE_BATTERY,
-	.get_property	= act8945a_charger_get_property,
-	.properties	= act8945a_charger_props,
-	.num_properties	= ARRAY_SIZE(act8945a_charger_props),
-};
-
 static int act8945a_enable_interrupt(struct act8945a_charger *charger)
 {
 	struct regmap *regmap = charger->regmap;
@@ -281,11 +274,39 @@ static int act8945a_enable_interrupt(struct act8945a_charger *charger)
 	return 0;
 }
 
+static unsigned int act8945a_set_supply_type(struct act8945a_charger *charger,
+					     unsigned int *type)
+{
+	unsigned int status, state;
+	int ret;
+
+	ret = regmap_read(charger->regmap, ACT8945A_APCH_STATUS, &status);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(charger->regmap, ACT8945A_APCH_STATE, &state);
+	if (ret < 0)
+		return ret;
+
+	if (status & APCH_STATUS_INDAT) {
+		if (state & APCH_STATE_ACINSTAT)
+			*type = POWER_SUPPLY_TYPE_MAINS;
+		else
+			*type = POWER_SUPPLY_TYPE_USB;
+	} else {
+		*type = POWER_SUPPLY_TYPE_BATTERY;
+	}
+
+	return 0;
+}
+
 static void act8945a_work(struct work_struct *work)
 {
 	struct act8945a_charger *charger =
 			container_of(work, struct act8945a_charger, work);
 
+	act8945a_set_supply_type(charger, &charger->desc.type);
+
 	power_supply_changed(charger->psy);
 }
 
@@ -440,11 +461,20 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	charger->desc.name = "act8945a-charger";
+	charger->desc.get_property = act8945a_charger_get_property;
+	charger->desc.properties = act8945a_charger_props;
+	charger->desc.num_properties = ARRAY_SIZE(act8945a_charger_props);
+
+	ret = act8945a_set_supply_type(charger, &charger->desc.type);
+	if (ret)
+		return -EINVAL;
+
 	psy_cfg.of_node	= pdev->dev.of_node;
 	psy_cfg.drv_data = charger;
 
 	charger->psy = devm_power_supply_register(&pdev->dev,
-						  &act8945a_charger_desc,
+						  &charger->desc,
 						  &psy_cfg);
 	if (IS_ERR(charger->psy)) {
 		dev_err(&pdev->dev, "failed to register power supply\n");
-- 
2.7.4

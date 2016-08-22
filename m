From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 4/7] power: act8945a_charger: Fix the power supply type
Date: Mon, 22 Aug 2016 14:49:14 +0800
Message-ID: <1471848557-27278-5-git-send-email-wenyou.yang@atmel.com>
References: <1471848557-27278-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471848557-27278-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The power supply type property is varying as the external power
supply changes. It is not a constant.

Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/power/supply/act8945a_charger.c | 48 ++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index fd99739..3536b67 100644
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
 	psy_cfg.of_node	= pdev->dev.parent->of_node;
 	psy_cfg.drv_data = charger;
 
 	charger->psy = devm_power_supply_register(&pdev->dev,
-						  &act8945a_charger_desc,
+						  &charger->desc,
 						  &psy_cfg);
 	if (IS_ERR(charger->psy)) {
 		dev_err(&pdev->dev, "failed to register power supply\n");
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

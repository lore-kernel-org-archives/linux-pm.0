From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v5 1/7] power: act8945a_charger: Remove "battery_temperature"
Date: Tue, 16 Aug 2016 16:59:52 +0800
Message-ID: <1471337998-6467-2-git-send-email-wenyou.yang@atmel.com>
References: <1471337998-6467-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471337998-6467-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>
List-Id: linux-pm@vger.kernel.org

Remove "battery_temperature" member, it is redundant, it is the
hardware's responsibility to handle TH pin properly.
It is unnecessary to use the dt property to check if there is
a battery temperature monitor or not.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/power/supply/act8945a_charger.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index b5c00e4..72d39ba 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -76,7 +76,6 @@ static const char *act8945a_charger_manufacturer = "Active-semi";
 
 struct act8945a_charger {
 	struct regmap *regmap;
-	bool battery_temperature;
 };
 
 static int act8945a_get_charger_state(struct regmap *regmap, int *val)
@@ -138,8 +137,7 @@ static int act8945a_get_charge_type(struct regmap *regmap, int *val)
 	return 0;
 }
 
-static int act8945a_get_battery_health(struct act8945a_charger *charger,
-				       struct regmap *regmap, int *val)
+static int act8945a_get_battery_health(struct regmap *regmap, int *val)
 {
 	int ret;
 	unsigned int status;
@@ -148,7 +146,7 @@ static int act8945a_get_battery_health(struct act8945a_charger *charger,
 	if (ret < 0)
 		return ret;
 
-	if (charger->battery_temperature && !(status & APCH_STATUS_TEMPDAT))
+	if (status & APCH_STATUS_TEMPDAT)
 		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
 	else if (!(status & APCH_STATUS_INDAT))
 		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
@@ -188,8 +186,7 @@ static int act8945a_charger_get_property(struct power_supply *psy,
 		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
-		ret = act8945a_get_battery_health(charger,
-						  regmap, &val->intval);
+		ret = act8945a_get_battery_health(regmap, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = act8945a_charger_model;
@@ -235,9 +232,6 @@ static int act8945a_charger_config(struct device *dev,
 		return -EINVAL;
 	}
 
-	charger->battery_temperature = of_property_read_bool(np,
-				"active-semi,check-battery-temperature");
-
 	chglev_pin = of_get_named_gpio_flags(np,
 				"active-semi,chglev-gpios", 0, &flags);
 
-- 
2.7.4

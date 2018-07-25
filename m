From: "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 4/4] power: bq25890_charger.c: Read back the current battery voltage
Date: Wed, 25 Jul 2018 13:46:30 -0600
Message-ID: <20180725194630.10414-5-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725194630.10414-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Angus Ainslie (Purism)" <angus@akkea.ca>
List-Id: linux-pm@vger.kernel.org

The part has the capability of reading the current battery voltage

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/power/supply/bq25890_charger.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index f4cf2987996b..60ccd6c2b7ad 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -464,6 +464,20 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq25890_find_val(bq->init_data.iterm, TBL_ITERM);
 		break;
 
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (!state.online) {
+			val->intval = 0;
+			break;
+		}
+
+		ret = bq25890_field_read(bq, F_SYSV); /* read measured value */
+		if (ret < 0)
+			return ret;
+
+		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
+		val->intval = 2304000 + ret * 20000;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -672,6 +686,7 @@ static enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
 
 static char *bq25890_charger_supplied_to[] = {
-- 
2.17.1

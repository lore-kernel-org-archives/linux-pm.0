From: Chen-Yu Tsai <wens@kernel.org>
Subject: [PATCH v4 4/7] power: supply: axp20x_usb_power: add function to get max current
Date: Tue, 16 Apr 2019 14:40:21 +0800
Message-ID: <20190416064024.20414-5-wens@kernel.org>
References: <20190416064024.20414-1-wens@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416064024.20414-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>
Cc: Quentin Schulz <quentin.schulz@bootlin.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>
List-Id: linux-pm@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

To prepare for a new PMIC, factor out the code responsible of returning
the maximum current to axp20x_get_current_max.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_usb_power.c | 52 ++++++++++++++-----------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 290028aed230..04c2cafbe8e6 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -102,6 +102,35 @@ static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
 	return false;
 }
 
+static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
+{
+	unsigned int v;
+	int ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
+
+	if (ret)
+		return ret;
+
+	switch (v & AXP20X_VBUS_CLIMIT_MASK) {
+	case AXP20X_VBUS_CLIMIT_100mA:
+		if (power->axp20x_id == AXP221_ID)
+			*val = -1; /* No 100mA limit */
+		else
+			*val = 100000;
+		break;
+	case AXP20X_VBUS_CLIMIT_500mA:
+		*val = 500000;
+		break;
+	case AXP20X_VBUS_CLIMIT_900mA:
+		*val = 900000;
+		break;
+	case AXP20X_VBUS_CLIMIT_NONE:
+		*val = -1;
+		break;
+	}
+
+	return 0;
+}
+
 static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -140,28 +169,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		val->intval = ret * 1700; /* 1 step = 1.7 mV */
 		return 0;
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
-		if (ret)
-			return ret;
-
-		switch (v & AXP20X_VBUS_CLIMIT_MASK) {
-		case AXP20X_VBUS_CLIMIT_100mA:
-			if (power->axp20x_id == AXP221_ID)
-				val->intval = -1; /* No 100mA limit */
-			else
-				val->intval = 100000;
-			break;
-		case AXP20X_VBUS_CLIMIT_500mA:
-			val->intval = 500000;
-			break;
-		case AXP20X_VBUS_CLIMIT_900mA:
-			val->intval = 900000;
-			break;
-		case AXP20X_VBUS_CLIMIT_NONE:
-			val->intval = -1;
-			break;
-		}
-		return 0;
+		return axp20x_get_current_max(power, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
 			ret = iio_read_channel_processed(power->vbus_i,
-- 
2.20.1

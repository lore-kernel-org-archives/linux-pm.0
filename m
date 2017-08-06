From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 14/18] power: supply: bq24190_charger: Add input_current_limit
 property
Date: Sun,  6 Aug 2017 14:35:51 +0200
Message-ID: <20170806123555.5124-15-hdegoede@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170806123555.5124-1-hdegoede@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <liam@networkimprov.net>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Export the input current limit of the charger as a
POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT property on the charger
power_supply class device.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index f25ea9c4acca..d78e2c6dc127 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -982,6 +982,33 @@ static int bq24190_charger_set_voltage(struct bq24190_dev_info *bdi,
 			ARRAY_SIZE(bq24190_cvc_vreg_values), val->intval);
 }
 
+static int bq24190_charger_get_iinlimit(struct bq24190_dev_info *bdi,
+		union power_supply_propval *val)
+{
+	int iinlimit, ret;
+
+	ret = bq24190_get_field_val(bdi, BQ24190_REG_ISC,
+			BQ24190_REG_ISC_IINLIM_MASK,
+			BQ24190_REG_ISC_IINLIM_SHIFT,
+			bq24190_isc_iinlim_values,
+			ARRAY_SIZE(bq24190_isc_iinlim_values), &iinlimit);
+	if (ret < 0)
+		return ret;
+
+	val->intval = iinlimit;
+	return 0;
+}
+
+static int bq24190_charger_set_iinlimit(struct bq24190_dev_info *bdi,
+		const union power_supply_propval *val)
+{
+	return bq24190_set_field_val(bdi, BQ24190_REG_ISC,
+			BQ24190_REG_ISC_IINLIM_MASK,
+			BQ24190_REG_ISC_IINLIM_SHIFT,
+			bq24190_isc_iinlim_values,
+			ARRAY_SIZE(bq24190_isc_iinlim_values), val->intval);
+}
+
 static int bq24190_charger_get_property(struct power_supply *psy,
 		enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -1022,6 +1049,9 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
 		ret = bq24190_charger_get_voltage_max(bdi, val);
 		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = bq24190_charger_get_iinlimit(bdi, val);
+		break;
 	case POWER_SUPPLY_PROP_SCOPE:
 		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
 		ret = 0;
@@ -1073,6 +1103,9 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 		ret = bq24190_charger_set_voltage(bdi, val);
 		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = bq24190_charger_set_iinlimit(bdi, val);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -1094,6 +1127,7 @@ static int bq24190_charger_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		ret = 1;
 		break;
 	default:
@@ -1113,6 +1147,7 @@ static enum power_supply_property bq24190_charger_properties[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
-- 
2.13.3

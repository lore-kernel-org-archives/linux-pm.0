From: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 03/13] power: bq24257: Add basic support for bq24250/bq24251
Date: Mon, 31 Aug 2015 21:10:25 -0500
Message-ID: <1441073435-12349-4-git-send-email-dannenberg@ti.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441073435-12349-1-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch adds basic support for bq24250 and bq24251 which are very
similar to the bq24257 the driver was originally written for. Basic
support means the ability to select a device through Kconfig, DT and
ACPI, an instance variable allowing to check which chip is active, and
the reporting back of the selected device through the
POWER_SUPPLY_PROP_MODEL_NAME power supply sysfs property.

This patch by itself is not sufficient to actually use those two added
devices in a real-world setting due to some feature differences which
are addressed by other patches in this series.

Signed-off-by: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
---
 drivers/power/Kconfig           |  5 +++--
 drivers/power/bq24257_charger.c | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 08beeed..0a2b033 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -396,11 +396,12 @@ config CHARGER_BQ24190
 	  Say Y to enable support for the TI BQ24190 battery charger.
 
 config CHARGER_BQ24257
-	tristate "TI BQ24257 battery charger driver"
+	tristate "TI BQ24250/251/257 battery charger driver"
 	depends on I2C && GPIOLIB
 	depends on REGMAP_I2C
 	help
-	  Say Y to enable support for the TI BQ24257 battery charger.
+	  Say Y to enable support for the TI BQ24250, BQ24251, and BQ24257 battery
+	  chargers.
 
 config CHARGER_BQ24735
 	tristate "TI BQ24735 battery charger support"
diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index 0b34528..45232bd 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -13,6 +13,10 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
+ * Datasheets:
+ * http://www.ti.com/product/bq24250
+ * http://www.ti.com/product/bq24251
+ * http://www.ti.com/product/bq24257
  */
 
 #include <linux/module.h>
@@ -41,6 +45,12 @@
 
 #define BQ24257_ILIM_SET_DELAY		1000	/* msec */
 
+enum bq2425x_chip {
+	BQ24250,
+	BQ24251,
+	BQ24257,
+};
+
 enum bq24257_fields {
 	F_WD_FAULT, F_WD_EN, F_STAT, F_FAULT,			    /* REG 1 */
 	F_RESET, F_IILIMIT, F_EN_STAT, F_EN_TERM, F_CE, F_HZ_MODE,  /* REG 2 */
@@ -71,6 +81,9 @@ struct bq24257_device {
 	struct device *dev;
 	struct power_supply *charger;
 
+	enum bq2425x_chip chip;
+	char chip_name[I2C_NAME_SIZE];
+
 	struct regmap *rmap;
 	struct regmap_field *rmap_fields[F_MAX_FIELDS];
 
@@ -250,6 +263,10 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 		val->strval = BQ24257_MANUFACTURER;
 		break;
 
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = bq->chip_name;
+		break;
+
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = state.power_good;
 		break;
@@ -574,6 +591,7 @@ static int bq24257_hw_init(struct bq24257_device *bq)
 
 static enum power_supply_property bq24257_power_supply_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_HEALTH,
@@ -686,6 +704,8 @@ static int bq24257_probe(struct i2c_client *client,
 
 	bq->client = client;
 	bq->dev = dev;
+	bq->chip = (enum bq2425x_chip)id->driver_data;
+	strncpy(bq->chip_name, id->name, I2C_NAME_SIZE);
 
 	mutex_init(&bq->lock);
 
@@ -828,19 +848,27 @@ static const struct dev_pm_ops bq24257_pm = {
 };
 
 static const struct i2c_device_id bq24257_i2c_ids[] = {
-	{ "bq24257", 0 },
+	{ "bq24250", BQ24250 },
+	{ "bq24251", BQ24251 },
+	{ "bq24257", BQ24257 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq24257_i2c_ids);
 
 static const struct of_device_id bq24257_of_match[] = {
-	{ .compatible = "ti,bq24257", },
+	{
+		.compatible = "ti,bq24250",
+		.compatible = "ti,bq24251",
+		.compatible = "ti,bq24257",
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq24257_of_match);
 
 static const struct acpi_device_id bq24257_acpi_match[] = {
-	{"BQ242570", 0},
+	{ "BQ242500", BQ24250 },
+	{ "BQ242510", BQ24251 },
+	{ "BQ242570", BQ24257 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, bq24257_acpi_match);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

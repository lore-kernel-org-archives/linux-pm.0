From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: [PATCH v2] power: bq24735-charger: Request status GPIO with initial input setup
Date: Mon, 29 Aug 2016 20:15:03 +0200
Message-ID: <20160829181503.9590-1-contact@paulk.fr>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This requests the status GPIO with initial input setup. it is required
to read the GPIO status at probe time and thus correctly avoid sending
i2c messages when AC is not plugged.

When requesting the GPIO without initial input setup, it always reads 0
which causes probe to fail as it assumes the charger is connected, sends
i2c messages and fails.

While at it, this switches the driver over to devm and gpio consumer.

Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
---
 drivers/power/bq24735-charger.c       | 29 +++++++----------------------
 include/linux/power/bq24735-charger.h |  3 +--
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-charger.c
index dc460bb..5744a88 100644
--- a/drivers/power/bq24735-charger.c
+++ b/drivers/power/bq24735-charger.c
@@ -25,7 +25,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 
@@ -181,8 +182,8 @@ static bool bq24735_charger_is_present(struct bq24735 *charger)
 	int ret;
 
 	if (pdata->status_gpio_valid) {
-		ret = gpio_get_value_cansleep(pdata->status_gpio);
-		return ret ^= pdata->status_gpio_active_low == 0;
+		ret = gpiod_get_value_cansleep(pdata->status_gpio);
+		return ret ^= gpiod_is_active_low(pdata->status_gpio) == 0;
 	} else {
 		int ac = 0;
 
@@ -308,7 +309,6 @@ static struct bq24735_platform *bq24735_parse_dt_data(struct i2c_client *client)
 	struct device_node *np = client->dev.of_node;
 	u32 val;
 	int ret;
-	enum of_gpio_flags flags;
 
 	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
@@ -317,11 +317,9 @@ static struct bq24735_platform *bq24735_parse_dt_data(struct i2c_client *client)
 		return NULL;
 	}
 
-	pdata->status_gpio = of_get_named_gpio_flags(np, "ti,ac-detect-gpios",
-						     0, &flags);
-
-	if (flags & OF_GPIO_ACTIVE_LOW)
-		pdata->status_gpio_active_low = 1;
+	pdata->status_gpio = devm_gpiod_get(&client->dev, "ti,ac-detect",
+						GPIOD_IN);
+	pdata->status_gpio_valid = !IS_ERR(pdata->status_gpio);
 
 	ret = of_property_read_u32(np, "ti,charge-current", &val);
 	if (!ret)
@@ -396,19 +394,6 @@ static int bq24735_charger_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, charger);
 
-	if (gpio_is_valid(charger->pdata->status_gpio)) {
-		ret = devm_gpio_request(&client->dev,
-					charger->pdata->status_gpio,
-					name);
-		if (ret) {
-			dev_err(&client->dev,
-				"Failed GPIO request for GPIO %d: %d\n",
-				charger->pdata->status_gpio, ret);
-		}
-
-		charger->pdata->status_gpio_valid = !ret;
-	}
-
 	if (!charger->pdata->status_gpio_valid
 	    || bq24735_charger_is_present(charger)) {
 		ret = bq24735_read_word(client, BQ24735_MANUFACTURER_ID);
diff --git a/include/linux/power/bq24735-charger.h b/include/linux/power/bq24735-charger.h
index 6b750c1a..bbc284e 100644
--- a/include/linux/power/bq24735-charger.h
+++ b/include/linux/power/bq24735-charger.h
@@ -28,8 +28,7 @@ struct bq24735_platform {
 
 	const char *name;
 
-	int status_gpio;
-	int status_gpio_active_low;
+	struct gpio_desc *status_gpio;
 	bool status_gpio_valid;
 
 	bool ext_control;
-- 
2.9.3

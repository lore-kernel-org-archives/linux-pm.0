From: Jonathan Tinkham <sctincman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] power: bq24735-charger: fix failed i2c with ac-detect
Date: Tue,  2 Feb 2016 23:03:44 -0700
Message-ID: <1454479426-6437-2-git-send-email-sctincman@gmail.com>
References: <1454479426-6437-1-git-send-email-sctincman@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454479426-6437-1-git-send-email-sctincman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Jonathan Tinkham <sctincman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

When an ac-detect pin exists, but the charger is not plugged in,
the chip will not respond to i2c messages, causing the module to
fail when inserted.

Signed-off-by: Jonathan Tinkham <sctincman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/power/bq24735-charger.c | 45 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-charger.c
index eb2b368..f041c16 100644
--- a/drivers/power/bq24735-charger.c
+++ b/drivers/power/bq24735-charger.c
@@ -293,27 +293,6 @@ static int bq24735_charger_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, charger);
 
-	ret = bq24735_read_word(client, BQ24735_MANUFACTURER_ID);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to read manufacturer id : %d\n",
-			ret);
-		return ret;
-	} else if (ret != 0x0040) {
-		dev_err(&client->dev,
-			"manufacturer id mismatch. 0x0040 != 0x%04x\n", ret);
-		return -ENODEV;
-	}
-
-	ret = bq24735_read_word(client, BQ24735_DEVICE_ID);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to read device id : %d\n", ret);
-		return ret;
-	} else if (ret != 0x000B) {
-		dev_err(&client->dev,
-			"device id mismatch. 0x000b != 0x%04x\n", ret);
-		return -ENODEV;
-	}
-
 	if (gpio_is_valid(charger->pdata->status_gpio)) {
 		ret = devm_gpio_request(&client->dev,
 					charger->pdata->status_gpio,
@@ -327,6 +306,30 @@ static int bq24735_charger_probe(struct i2c_client *client,
 		charger->pdata->status_gpio_valid = !ret;
 	}
 
+	if (!charger->pdata->status_gpio_valid
+	    || bq24735_charger_is_present(charger)) {
+		ret = bq24735_read_word(client, BQ24735_MANUFACTURER_ID);
+		if (ret < 0) {
+			dev_err(&client->dev, "Failed to read manufacturer id : %d\n",
+				ret);
+			return ret;
+		} else if (ret != 0x0040) {
+			dev_err(&client->dev,
+				"manufacturer id mismatch. 0x0040 != 0x%04x\n", ret);
+			return -ENODEV;
+		}
+
+		ret = bq24735_read_word(client, BQ24735_DEVICE_ID);
+		if (ret < 0) {
+			dev_err(&client->dev, "Failed to read device id : %d\n", ret);
+			return ret;
+		} else if (ret != 0x000B) {
+			dev_err(&client->dev,
+				"device id mismatch. 0x000b != 0x%04x\n", ret);
+			return -ENODEV;
+		}
+	}
+
 	ret = bq24735_config_charger(charger);
 	if (ret < 0) {
 		dev_err(&client->dev, "failed in configuring charger");
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

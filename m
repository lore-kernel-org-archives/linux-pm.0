From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3/3] power: supply: sbs-message: fix some code style issues
Date: Sun, 29 Oct 2017 16:35:45 +0100
Message-ID: <20171029153545.3947-4-wsa@the-dreams.de>
References: <20171029153545.3947-1-wsa@the-dreams.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42738 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbdJ2Pf6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Oct 2017 11:35:58 -0400
In-Reply-To: <20171029153545.3947-1-wsa@the-dreams.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Phil Reid <preid@electromag.com.au>, sre@kernel.org, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Use 'unsigned int' and curly braces for 'else'.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/power/supply/sbs-manager.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
index 3e3ad09c5f11c3..ccb4217b963869 100644
--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -193,7 +193,7 @@ static int sbsm_select(struct i2c_mux_core *muxc, u32 chan)
 	return ret;
 }
 
-static int sbsm_gpio_get_value(struct gpio_chip *gc, unsigned off)
+static int sbsm_gpio_get_value(struct gpio_chip *gc, unsigned int off)
 {
 	struct sbsm_data *data = gpiochip_get_data(gc);
 	int ret;
@@ -209,7 +209,7 @@ static int sbsm_gpio_get_value(struct gpio_chip *gc, unsigned off)
  * This needs to be defined or the GPIO lib fails to register the pin.
  * But the 'gpio' is always an input.
  */
-static int sbsm_gpio_direction_input(struct gpio_chip *gc, unsigned off)
+static int sbsm_gpio_direction_input(struct gpio_chip *gc, unsigned int off)
 {
 	return 0;
 }
@@ -229,8 +229,9 @@ static int sbsm_do_alert(struct device *dev, void *d)
 			driver->alert(client, I2C_PROTOCOL_SMBUS_ALERT, 0);
 		else
 			dev_warn(&client->dev, "no driver alert()!\n");
-	} else
+	} else {
 		dev_dbg(&client->dev, "alert with no driver\n");
+	}
 	device_unlock(dev);
 
 	return -EBUSY;
-- 
2.11.0
